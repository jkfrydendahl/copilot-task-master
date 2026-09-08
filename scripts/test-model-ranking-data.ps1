Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"
. (Join-Path $PSScriptRoot "model-data-common.ps1")
. (Join-Path $PSScriptRoot "model-artificial-analysis.ps1")
. (Join-Path $PSScriptRoot "model-livebench.ps1")
$fixtureRoot=Join-Path $PSScriptRoot "fixtures\model-ranking"
$script:Failed=0
function Assert-True($Condition,$Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name,[scriptblock]$Action) {
    try { &$Action; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $_" }
}
function Fixture($Name) { Get-Content (Join-Path $fixtureRoot $Name) -Raw }
Run-Test "AA API preserves numeric coding/intelligence and record provenance" {
    $data=ConvertFrom-JsonAsHashtableCompat (Fixture "aa-api-llms-models-valid.json")
    $result=Get-ArtificialAnalysisIntelligenceIndexData -FetchJson {param($u,$envVar) @{status="ok";value=$data}}
    Assert-True ($result.status -eq "ok") "AA parse"
    Assert-True ($result.models["gpt-5-6-sol"].intelligenceIndex -eq 57.5) "AA intelligence"
    Assert-True ($result.models["gpt-5-6-sol"].codingIndex -eq 71.5) "AA coding"
    Assert-True ($result.models["gpt-5-6-sol"].evaluations -and $result.sourceVersion) "Provenance"
}
Run-Test "Malformed AA and unrelated null evaluations are handled safely" {
    $bad=ConvertFrom-JsonAsHashtableCompat (Fixture "aa-api-llms-models-malformed.json")
    Assert-True ((Parse-ArtificialAnalysisLlmModelsFromApiResponse $bad).status -eq "unavailable") "Bad AA accepted"
    $valid=ConvertFrom-JsonAsHashtableCompat (Fixture "aa-api-llms-models-valid.json")
    Assert-True ((Parse-ArtificialAnalysisLlmModelsFromApiResponse $valid).status -eq "ok") "Unrelated nulls"
}
Run-Test "Missing AA key and rate limiting produce explicit errors" {
    $name="ARTIFICIAL_ANALYSIS_API_KEY_TEST_ONLY"
    $old=[Environment]::GetEnvironmentVariable($name,"Process")
    try {
        [Environment]::SetEnvironmentVariable($name,"","Process")
        $result=Invoke-ArtificialAnalysisApiFetch -Url "https://example.test" -ApiKeyEnvVarName $name
        Assert-True ($result.status -eq "error" -and $result.error.Contains($name)) "Missing key"
    } finally { [Environment]::SetEnvironmentVariable($name,$old,"Process") }
    $result=Get-ArtificialAnalysisIntelligenceIndexData -FetchJson {param($u,$envVar) @{status="error";error="rate limited";statusCode=429;retryAfterSeconds="120"}}
    Assert-True ($result.status -eq "error" -and $result.message.Contains("429")) "Rate limit"
}
Run-Test "Coding agent harness labels parse exactly and reject malformed HTML" {
    $valid=Parse-ArtificialAnalysisCodingAgentIndexFromHtml (Fixture "aa-coding-agents-valid.html")
    Assert-True ($valid.status -eq "ok" -and $valid.models.ContainsKey("Claude Code - Opus 5 (xhigh)")) "Harness identity"
    Assert-True ((Parse-ArtificialAnalysisCodingAgentIndexFromHtml (Fixture "aa-coding-agents-malformed.html")).status -eq "unavailable") "Bad harness accepted"
}
Run-Test "LiveBench categories and cost data remain separately usable" {
    $invalid = Parse-LiveBenchData -CsvText (Fixture "livebench-malformed.csv")
    Assert-True ($invalid.status -eq "unavailable") "Missing model column accepted"
    $p=Parse-LiveBenchData -CsvText (Fixture "livebench-valid.csv") -CategoriesJsonText (Fixture "livebench-categories-valid.json") -CostCsvText (Fixture "livebench-cost-valid.csv") -SourceDate "2026-06-25"
    Assert-True ($p.status -eq "ok" -and $p.costStatus -eq "ok") "Valid LB"
    Assert-True ($null -ne $p.models["claude-sonnet-5-xhigh-effort"].coding) "Coding category"
    foreach ($cost in @("", "model,wrong_column`none,1", "model,model`none,1", ((Fixture "livebench-cost-valid.csv") -replace '(?m)^(claude-sonnet-5-xhigh-effort,)[^,\r\n]+','${1}NaN'))) {
        $p=Parse-LiveBenchData -CsvText (Fixture "livebench-valid.csv") -CategoriesJsonText (Fixture "livebench-categories-valid.json") -CostCsvText $cost -SourceDate "2026-06-25"
        Assert-True ($p.status -eq "ok" -and $p.costStatus -ne "ok") "Costs gated quality"
    }
}
Run-Test "LiveBench missing or failed cost fetch does not discard benchmark data" {
    foreach ($includeCost in @($false,$true)) {
        $listing=@(
            @{name="table_2026_06_25.csv";download_url="table";html_url="https://example.test/lb";sha="table-sha"}
            @{name="categories_2026_06_25.json";download_url="categories"}
        )
        if ($includeCost) {$listing+=@{name="cost_2026_06_25.csv";download_url="cost"}}
        $p=Get-LiveBenchData -FetchJson {param($u) @{status="ok";value=$listing}} -FetchText {
            param($u)
            switch ($u) {
                "table" {@{status="ok";content=(Fixture "livebench-valid.csv")}}
                "categories" {@{status="ok";content=(Fixture "livebench-categories-valid.json")}}
                default {@{status="error";error="HTTP503"}}
            }
        }
        Assert-True ($p.status -eq "ok" -and $p.sourceVersion) "Cost feed froze quality"
        if ($includeCost) { Assert-True ($p.sourceVersion -eq $withoutCostVersion) "Cost-feed change became a quality observation" }
        else { $withoutCostVersion=$p.sourceVersion }
    }
}
if ($script:Failed) { exit 1 }
