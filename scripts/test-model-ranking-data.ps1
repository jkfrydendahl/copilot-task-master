Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"
. (Join-Path $PSScriptRoot "model-data-common.ps1")
. (Join-Path $PSScriptRoot "model-artificial-analysis.ps1")
. (Join-Path $PSScriptRoot "model-livebench.ps1")
. (Join-Path $PSScriptRoot "fixtures\model-ranking\agent-fixture.ps1")
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
Run-Test "AA publication dates parse independently of absent or malformed dates" {
    foreach ($field in @("source_date", "sourceDate", "updated_at", "updatedAt", "last_updated", "lastUpdated", "generated_at", "generatedAt", "as_of_date", "asOfDate")) {
        $data=ConvertFrom-JsonAsHashtableCompat (Fixture "aa-api-llms-models-valid.json")
        $data[$field]="2026-09-09T01:30:00+02:00"
        $result=Get-ArtificialAnalysisIntelligenceIndexData -FetchJson {param($u,$envVar) @{status="ok";value=$data}}
        Assert-True ($result.status -eq "ok" -and $result.sourceDate -eq "2026-09-08") "Failed UTC date from $field"
    }
    Assert-True ($null -eq (Get-ArtificialAnalysisSourceDateFromApiResponse @{})) "Invented publication date"
    Assert-True ($null -eq (Get-ArtificialAnalysisSourceDateFromApiResponse @{updated_at="invalid"})) "Invalid publication accepted"
    Assert-True ((Get-ArtificialAnalysisSourceDateFromApiResponse @{source_date="invalid";updated_at="2026-09-09"}) -eq "2026-09-09") "Invalid field blocked valid alternate"
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
Run-Test "Structured coding agent records preserve identity and reject malformed HTML" {
    $valid=Parse-ArtificialAnalysisCodingAgentIndexFromHtml (Fixture "aa-coding-agents-valid.html")
    Assert-True ($valid.status -eq "ok" -and $valid.models["opus-xhigh"].label -eq "Claude Code - Opus 5 (xhigh)") "Harness identity"
    Assert-True ((Parse-ArtificialAnalysisCodingAgentIndexFromHtml (Fixture "aa-coding-agents-malformed.html")).status -eq "unavailable") "Bad harness accepted"
}
Run-Test "Agent parser includes non-highlighted variants, deduplicates rows and fingerprints identity" {
    $one=New-AgentFixtureRow one "GPT-one (high)" 0.6
    $two=New-AgentFixtureRow two "GPT-two (max)" 0.7
    $html=ConvertTo-AgentFixtureHtml @($one) @($one,$two)
    $result=Get-ArtificialAnalysisCodingAgentIndexData -FetchText {param($u) @{status="ok";content=$html}}
    Assert-True ($result.status -eq "ok" -and $result.models.Count -eq 2) "Full benchmark rows omitted or duplicate counted"
    $original=$result.sourceVersion
    $payload="x:" + (@{rows=@($one);benchmarkRows=@($two)} | ConvertTo-Json -Depth 15 -Compress)
    $cut=[int]($payload.Length / 2)
    $splitHtml='<script>self.__next_f.push([1,' + (ConvertTo-Json -InputObject $payload.Substring(0,$cut) -Compress) +
        ']);self.__next_f.push([1,' + (ConvertTo-Json -InputObject $payload.Substring($cut) -Compress) + '])</script>'
    Assert-True ((Parse-ArtificialAnalysisCodingAgentIndexFromHtml $splitHtml).models.Count -eq 2) "Split stream payload lost rows"
    $html=ConvertTo-AgentFixtureHtml @($two,$one)
    $reordered=Get-ArtificialAnalysisCodingAgentIndexData -FetchText {param($u) @{status="ok";content=$html}}
    Assert-True ($reordered.sourceVersion -eq $original) "Row order became an observation"
    foreach ($change in @(
        {param($r) $r.agentName='New harness'},
        {param($r) $r.versions.agent='2.0'},
        {param($r) $r.display.model='GPT-two (xhigh)'},
        {param($r) $r.id='new-variant'},
        {param($r) $r.indexScore=0.71}
    )) {
        $row=New-AgentFixtureRow two "GPT-two (max)" 0.7
        & $change $row
        $html=ConvertTo-AgentFixtureHtml @($one,$row)
        $changed=Get-ArtificialAnalysisCodingAgentIndexData -FetchText {param($u) @{status="ok";content=$html}}
        Assert-True ($changed.sourceVersion -ne $original) "Identity or score change ignored"
    }
}
Run-Test "Agent parser rejects incomplete, ambiguous and legacy evidence without inventing scores" {
    $valid=New-AgentFixtureRow one "GPT-one (high)" 0.6
    foreach ($change in @(
        {param($r) $r.evalCount=1},
        {param($r) $r.evals=$r.evals[0..0]},
        {param($r) $r.indexScore=$null},
        {param($r) $r.indexScore=-1},
        {param($r) $r.indexScore=1.1},
        {param($r) $r.indexScore="0.7"},
        {param($r) $r.isUnavailable=$true},
        {param($r) $r.display.Remove("model")},
        {param($r) $r.Remove("agentName")},
        {param($r) $r.evals[1].datasetIndexName="repository"},
        {param($r) $r.evals[1].weight=0},
        {param($r) $r.evals[1].mean.reward=$null}
    )) {
        $bad=New-AgentFixtureRow bad "GPT-bad (max)" 0.7
        & $change $bad
        $result=Parse-ArtificialAnalysisCodingAgentIndexFromHtml (ConvertTo-AgentFixtureHtml @($valid,$bad))
        Assert-True ($result.status -eq "ok" -and $result.models.Count -eq 1 -and $result.diagnostics.Count) "Invalid row admitted or valid evidence lost"
    }
    $duplicate=New-AgentFixtureRow one "GPT-one (high)" 0.9
    Assert-True ((Parse-ArtificialAnalysisCodingAgentIndexFromHtml (ConvertTo-AgentFixtureHtml @($valid,$duplicate))).status -eq "unavailable") "Conflicting IDs accepted"
    $other=New-AgentFixtureRow other "GPT-other (max)" 0.7
    $other.evals[0].refDatasetName="repo-v2"
    Assert-True ((Parse-ArtificialAnalysisCodingAgentIndexFromHtml (ConvertTo-AgentFixtureHtml @($valid,$other))).status -eq "unavailable") "Incompatible suites mixed"
    foreach ($html in @('', '<script>{"label":"one","codingAgentsIndex":0.9}</script>',
        '<script>self.__next_f.push([1,"x:{\"rows\":[{"]) </script>',
        '<script>self.__next_f.push([1,"x:{\"rows\":[invalid]}"])</script>')) {
        Assert-True ((Parse-ArtificialAnalysisCodingAgentIndexFromHtml $html).status -eq "unavailable") "Malformed/legacy data accepted"
    }
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
Run-Test "LiveBench handles missing, empty and single-column category mappings" {
    $csv="model,code_generation,code_completion,python,zebra_puzzle,paraphrase`none,80,60,70,50,60"
    foreach ($categories in @("", "{}", '{"Coding":[]}', '{"Coding":["code_generation"],"Agentic Coding":["python"],"Reasoning":["zebra_puzzle"],"IF":["paraphrase"]}')) {
        $result=Parse-LiveBenchData -CsvText $csv -CategoriesJsonText $categories
        $expectedCoding=if ($categories.Contains('["code_generation"]')) {80} else {70}
        Assert-True ($result.status -eq "ok" -and $result.models.one.coding -eq $expectedCoding) "Coding category failed for '$categories'"
        Assert-True ($result.models.one.agenticCoding -eq 70 -and $result.models.one.reasoning -eq 50 -and $result.models.one.instructionFollowing -eq 60) "Other category mappings failed"
    }
    $result=Get-LiveBenchData -FetchJson {param($u) @{
        status="ok";value=@(@{name="table_2026_09_09.csv";download_url="table";html_url="https://example.test/lb"})
    }} -FetchText {param($u) @{status="ok";content=$csv}}
    Assert-True ($result.status -eq "ok" -and $result.sourceVersion -and $result.models.one.coding -eq 70) "Missing categories file blocked the adapter"
}
if ($script:Failed) { exit 1 }
