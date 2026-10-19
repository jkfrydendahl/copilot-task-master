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
    Assert-True ($valid.models["opus-xhigh"].hostModelSlug -eq "anthropic_opus") "Published host metadata lost"
    Assert-True ((Parse-ArtificialAnalysisCodingAgentIndexFromHtml (Fixture "aa-coding-agents-malformed.html")).status -eq "unavailable") "Bad harness accepted"
}
Run-Test "Current AA coding agents retain exact identity without unpublished host metadata" {
    . (Join-Path $PSScriptRoot "model-agent-identity.ps1")
    $row=ConvertFrom-JsonAsHashtableCompat (Fixture "aa-coding-agent-2026-10-19.json")
    $result=Get-ArtificialAnalysisCodingAgentIndexData -FetchText {
        param($u) @{status="ok";content=(ConvertTo-AgentFixtureHtml @() @($row))}
    }
    Assert-True ($result.status -eq "ok" -and $result.models.Count -eq 1 -and $result.sourceVersion) "Current upstream record rejected"
    $record=$result.models[$row.id]
    Assert-True ($null -eq $record.hostModelSlug -and $record.provider -eq "openai" -and
        $record.publishedModel -eq "GPT-6.1 Sol (high)" -and $record.harness -eq "Codex") "Identity lost or host slug invented"
    Assert-True ($record.codingAgentIndex -eq $row.indexScore -and $record.components.Count -eq 3 -and
        $record.versions["terminal-bench-v4"].min.version -eq "0.154.0") "Score, component coverage or harness versions lost"
    $identity=Resolve-AgentModelIdentities -Records $result.models -KnownModels @("gpt-6.1-sol")
    Assert-True ($identity.records.Count -eq 1 -and $identity.records[0].model -eq "gpt-6.1-sol" -and
        $identity.records[0].effort -eq "high") "Exact model/effort resolution depended on optional host metadata"
    foreach ($change in @(
        {param($r) $r.display.Remove("model")},
        {param($r) $r.Remove("provider")},
        {param($r) $r.Remove("agentName")},
        {param($r) $r.evalCount=2},
        {param($r) $r.hostModelSlug=42},
        {param($r) $r.hostModelSlug=" "}
    )) {
        $bad=ConvertFrom-JsonAsHashtableCompat (Fixture "aa-coding-agent-2026-10-19.json")
        & $change $bad
        $invalid=Parse-ArtificialAnalysisCodingAgentIndexFromHtml (ConvertTo-AgentFixtureHtml @($bad))
        Assert-True ($invalid.status -eq "unavailable" -and $invalid.diagnostics.Count) "Missing identity, coverage or malformed host metadata accepted"
    }
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
Run-Test "LiveBench default GitHub catalog transport uses the Action token" {
    $oldToken=[Environment]::GetEnvironmentVariable("GH_TOKEN","Process")
    $script:liveBenchRequests=@()
    function Invoke-RestMethod {
        param([uri]$Uri,[int]$TimeoutSec,[hashtable]$Headers,[int]$MaximumRedirection)
        $script:liveBenchRequests+=@(@{uri=$Uri;headers=$Headers;redirects=$(if ($PSBoundParameters.ContainsKey("MaximumRedirection")) { $MaximumRedirection } else { $null })})
        return @(@{name="table_2026_06_25.csv";download_url="table";html_url="https://example.test/lb"})
    }
    try {
        [Environment]::SetEnvironmentVariable("GH_TOKEN","fixture-github-token","Process")
        $result=Get-LiveBenchData -FetchText {param($u) @{status="ok";content=(Fixture "livebench-valid.csv")}}
        Assert-True ($result.status -eq "ok" -and $script:liveBenchRequests.Count -eq 1) "Default catalog transport failed"
        foreach ($request in $script:liveBenchRequests) {
            Assert-True ($request.uri.Host -eq "api.github.com" -and $request.headers.Authorization -eq "Bearer fixture-github-token") "Action token not used"
            Assert-True ($request.uri.AbsolutePath -eq "/repos/LiveBench/livebench.github.io/contents/public") "Unavailable repository still used"
            Assert-True ($null -ne $request.redirects -and $request.redirects -eq 0) "Authenticated request permits redirects"
        }
    } finally { [Environment]::SetEnvironmentVariable("GH_TOKEN",$oldToken,"Process") }
}
Run-Test "LiveBench rejects untrusted API targets before sending credentials" {
    $oldToken=[Environment]::GetEnvironmentVariable("GH_TOKEN","Process")
    function Invoke-RestMethod { throw "Untrusted target reached the network" }
    try {
        [Environment]::SetEnvironmentVariable("GH_TOKEN","fixture-github-token","Process")
        foreach ($url in @("http://api.github.com/repos/one/two", "https://api.github.com.example.test/repos/one/two",
            "https://api.github.com:444/repos/one/two", "https://user:password@api.github.com/repos/one/two",
            "https://artificialanalysis.ai/models", "not a URL")) {
            $result=Invoke-LiveBenchJsonFetch -Url $url
            Assert-True ($result.status -eq "error" -and $result.error -match "https://api.github.com" -and
                $result.error -notmatch "reached the network") "Untrusted URL was fetched: $url"
        }
    } finally { [Environment]::SetEnvironmentVariable("GH_TOKEN",$oldToken,"Process") }
}
Run-Test "LiveBench supports public unauthenticated access and exposes sanitized failures without retrying" {
    $oldToken=[Environment]::GetEnvironmentVariable("GH_TOKEN","Process")
    $script:liveBenchRequests=@()
    $script:liveBenchFetchError=$null
    function Invoke-RestMethod {
        param([uri]$Uri,[int]$TimeoutSec,[hashtable]$Headers,[int]$MaximumRedirection)
        $script:liveBenchRequests+=@($Headers)
        if ($script:liveBenchFetchError) { throw $script:liveBenchFetchError }
        return @{ok=$true}
    }
    try {
        [Environment]::SetEnvironmentVariable("GH_TOKEN","","Process")
        $public=Invoke-LiveBenchJsonFetch -Url $script:LiveBenchContentsApiUrl
        Assert-True ($public.status -eq "ok" -and -not $script:liveBenchRequests[0].ContainsKey("Authorization")) "Local public access requires a token"
        [Environment]::SetEnvironmentVariable("GH_TOKEN","fixture-github-token","Process")
        foreach ($failure in @("HTTP401: fixture-github-token", "HTTP403: rate limit exceeded", "Redirect refused: fixture-github-token")) {
            $before=$script:liveBenchRequests.Count
            $script:liveBenchFetchError=$failure
            $result=Get-LiveBenchData
            Assert-True ($result.status -eq "error" -and $result.models.Count -eq 0 -and
                $result.message -match "LiveBench directory listing fetch failed") "Fetch failure became successful or fabricated data"
            Assert-True ($result.message -notmatch "fixture-github-token" -and
                $script:liveBenchRequests.Count -eq ($before+1)) "Token leaked or authenticated failure silently retried"
        }
    } finally { [Environment]::SetEnvironmentVariable("GH_TOKEN",$oldToken,"Process") }
}
Run-Test "Generic JSON and text transports never attach the GitHub token" {
    $oldToken=[Environment]::GetEnvironmentVariable("GH_TOKEN","Process")
    function Invoke-RestMethod {
        param($Uri,$TimeoutSec,$Headers)
        Assert-True (-not $Headers.ContainsKey("Authorization")) "GitHub token attached to generic JSON fetch"
        return @{ok=$true}
    }
    function Invoke-WebRequest {
        param($Uri,$TimeoutSec,$Headers)
        Assert-True (-not $Headers.ContainsKey("Authorization")) "GitHub token attached to generic text fetch"
        return @{Content="public data";Headers=@{"Last-Modified"="Sun, 18 Oct 2026 18:54:26 GMT"}}
    }
    try {
        [Environment]::SetEnvironmentVariable("GH_TOKEN","fixture-github-token","Process")
        Assert-True ((Invoke-JsonFetch -Url "https://example.test/data").status -eq "ok") "Generic JSON transport changed"
        $text=Invoke-TextFetch -Url "https://artificialanalysis.ai/agents/coding-agents"
        Assert-True ($text.status -eq "ok" -and $text.lastModified -eq "Sun, 18 Oct 2026 18:54:26 GMT") "Text content or artifact metadata lost"
    } finally { [Environment]::SetEnvironmentVariable("GH_TOKEN",$oldToken,"Process") }
}
Run-Test "LiveBench uses the published v1 files rather than stale repository copies or v2 scores" {
    $listing=@(
        @{name="table_2026_06_25.csv";download_url="https://example.test/stale-table";html_url="https://example.test/stale-table"}
        @{name="categories_2026_06_25.json";download_url="https://example.test/stale-categories"}
    )
    $script:liveBenchTextRequests=@()
    $result=Get-LiveBenchData -FetchJson {param($u) @{status="ok";value=$listing}} -FetchText {
        param($u)
        $script:liveBenchTextRequests+=@($u)
        switch ($u) {
            "https://livebench.ai/v1/table_2026_06_25.csv" {
                @{status="ok";content=(Fixture "livebench-valid.csv");lastModified="Sun, 18 Oct 2026 18:54:26 GMT"}
            }
            "https://livebench.ai/v1/categories_2026_06_25.json" {
                @{status="ok";content=(Fixture "livebench-categories-valid.json")}
            }
            "https://livebench.ai/v1/cost_2026_06_25.csv" { @{status="error";error="HTTP503"} }
            default { throw "Unexpected data URL: $u" }
        }
    }
    Assert-True ($result.status -eq "ok" -and $script:liveBenchTextRequests.Count -eq 3) "Published v1 acquisition failed"
    Assert-True ($result.sourceUrl -eq "https://livebench.ai/v1/table_2026_06_25.csv" -and
        $result.datasetVersion -eq "2026-06-25") "Actual data provenance or suite label lost"
    Assert-True ([datetime]$result.artifactPublishedAtUtc -eq [datetime]"2026-10-18T18:54:26Z" -and
        $null -eq $result.sourceDate -and $null -eq $result.artifactCommit) "Artifact update became evaluation publication or a fabricated Git commit"
    Assert-True ($result.costStatus -ne "ok" -and $result.sourceVersion) "Optional cost failure discarded quality evidence"
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
                "https://livebench.ai/v1/table_2026_06_25.csv" {@{status="ok";content=(Fixture "livebench-valid.csv")}}
                "https://livebench.ai/v1/categories_2026_06_25.json" {@{status="ok";content=(Fixture "livebench-categories-valid.json")}}
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
        if ($categories.Contains('["code_generation"]')) {
            Assert-True ($result.models.one.agenticCoding -eq 70 -and $result.models.one.reasoning -eq 50 -and $result.models.one.instructionFollowing -eq 60) "Explicit category mappings failed"
        } else {
            Assert-True ($null -eq $result.models.one.agenticCoding -and $null -eq $result.models.one.reasoning -and $null -eq $result.models.one.instructionFollowing) "Partial categories were silently averaged"
        }
    }
    $result=Get-LiveBenchData -FetchJson {param($u) @{
        status="ok";value=@(@{name="table_2026_09_09.csv";download_url="table";html_url="https://example.test/lb"})
    }} -FetchText {param($u) @{status="ok";content=$csv}}
    Assert-True ($result.status -eq "ok" -and $result.sourceVersion -and $result.models.one.coding -eq 70) "Missing categories file blocked the adapter"
}
function Component-Html($Data) {
    $json = "x:" + ($Data | ConvertTo-Json -Depth 20 -Compress)
    $cut = [int]($json.Length / 2)
    '<script>self.__next_f.push([1,' + (ConvertTo-Json -InputObject $json.Substring(0,$cut) -Compress) +
        ']);self.__next_f.push([1,' + (ConvertTo-Json -InputObject $json.Substring($cut) -Compress) + '])</script>'
}
Run-Test "AA components include current and bulk models without inventing missing scores" {
    . (Join-Path $PSScriptRoot "model-aa-component-data.ps1")
    $data=@{
        currentModel=@{slug="one-high";name="One (high)";automationBenchPartialScore=0;lcr=0.8;releaseDate="2026-09-22"}
        models=@(@{slug="two-high";name="Two (high)";automationBenchPartialScore=0.6;enterpriseOpsGym=0.4;ifbench=$null},
            @{slug="navigation-only";name="Navigation"})
    }
    $r=ConvertFrom-AAComponentPage (Component-Html $data)
    Assert-True ($r.status -eq "ok" -and $r.models.Count -eq 2) "Lost bulk/current records or included navigation"
    Assert-True ($r.models["one-high"].automationBench -eq 0 -and $r.models["one-high"].lcr -eq 0.8) "Zero/metric mapping lost"
    Assert-True ($null -eq $r.models["two-high"].ifbench -and $null -eq $r.sourceDate) "Missing score/publication invented"
}
Run-Test "AA component parsing rejects malformed, conflicting and invalid scores" {
    . (Join-Path $PSScriptRoot "model-aa-component-data.ps1")
    $one=@{slug="one-high";name="One (high)";automationBenchPartialScore=0.5}
    foreach($html in @("",'<script>self.__next_f.push([1,"x:{\"models\":[invalid]}"])</script>',
        (Component-Html @{models=@($one,@{slug="one-high";name="One (high)";automationBenchPartialScore=0.7})}))) {
        Assert-True ((ConvertFrom-AAComponentPage $html).status -eq "unavailable") "Invalid observation accepted"
    }
    foreach($bad in @("0.5",-0.1,1.01)) {
        $r=ConvertFrom-AAComponentPage (Component-Html @{models=@(@{slug="one-high";name="One (high)";automationBenchPartialScore=$bad;lcr=0.8})})
        Assert-True ($r.status -eq "ok" -and $null -eq $r.models["one-high"].automationBench -and $r.diagnostics.Count) "Invalid metric accepted or unrelated metric discarded"
    }
    $r=ConvertFrom-AAComponentPage (Component-Html @{models=@($one,$one)})
    Assert-True ($r.status -eq "ok" -and $r.models.Count -eq 1) "Identical duplicates became ambiguous"
}
Run-Test "AA component acquisition uses one deterministic anchor and stable metric observations" {
    . (Join-Path $PSScriptRoot "model-aa-components.ps1")
    $script:componentFetches=@()
    $data=@{models=@(@{slug="one-high";name="One (high)";automationBenchPartialScore=0.5;lcr=0.8})}
    $fetch={param($u) $script:componentFetches+=@($u); @{status="ok";content=(Component-Html $data)}}
    $first=Get-AAComponentData -ModelSlugs @("two-high","one-high") -FetchText $fetch
    Assert-True ($script:componentFetches.Count -eq 1 -and $script:componentFetches[0] -eq "https://artificialanalysis.ai/models/one-high") "Per-model fetching or preferred anchor"
    Assert-True ($first.status -eq "ok" -and $first.metricVersions.automationBench -and $null -eq $first.sourceDate) "Missing component provenance"
    $data.models[0].lcr=0.9
    $second=Get-AAComponentData -ModelSlugs @("one-high") -FetchText $fetch
    Assert-True ($first.metricVersions.automationBench -eq $second.metricVersions.automationBench -and $first.metricVersions.lcr -ne $second.metricVersions.lcr) "Supporting score confirmed deciding metric"
    $bad=Get-AAComponentData -ModelSlugs @() -FetchText {throw "Must not fetch"}
    Assert-True ($bad.status -eq "unavailable") "Missing anchor not explicit"
    $bad=Get-AAComponentData -ModelSlugs @("one-high") -FetchText {param($u) @{status="error";error="HTTP503"}}
    Assert-True ($bad.status -eq "error" -and $bad.message -match "HTTP503") "Fetch failure hidden"
}
Run-Test "LiveBench rejects incomplete or invalid category scores without dropping other categories" {
    foreach($bad in @("", "NaN", "-1", "101")) {
        $csv="model,code_generation,code_completion,python`none,80,$bad,70"
        $r=Parse-LiveBenchData -CsvText $csv -CategoriesJsonText '{"Coding":["code_generation","code_completion"],"Agentic Coding":["python"]}'
        Assert-True ($null -eq $r.models.one.coding -and $r.models.one.agenticCoding -eq 70 -and $r.diagnostics -match "coding") "Invalid/partial category accepted or unrelated category lost"
    }
}
Run-Test "LiveBench separates suite label, artifact publication and unknown row evaluation age" {
    $r=Get-LiveBenchData -FetchJson {
        param($u)
        @{status="ok";value=@(@{name="table_2026_06_25.csv";download_url="table";html_url="https://example.test/lb"})}
    } -FetchText {param($u) @{status="ok";content="model,code_generation,code_completion`none,80,60";lastModified="2026-09-22T05:38:00Z"}}
    Assert-True ($r.status -eq "ok" -and $r.datasetVersion -eq "2026-06-25" -and $null -eq $r.sourceDate) "Suite name treated as results publication"
    Assert-True ([datetime]$r.artifactPublishedAtUtc -eq [datetime]"2026-09-22T05:38:00Z" -and $null -eq $r.models.one.evaluationDate) "Artifact update falsely refreshed row evaluation"
    Assert-True (($r.categoryColumns.coding -join ",") -eq "code_generation,code_completion") "Category methodology not retained"
}
Run-Test "LiveBench missing or invalid artifact dates never become fresh evaluation dates" {
    foreach ($date in @($null,"not a date")) {
        $r=Get-LiveBenchData -FetchJson {
            param($u) @{status="ok";value=@(@{name="table_2026_06_25.csv"})}
        } -FetchText {param($u) @{status="ok";content="model,code_generation,code_completion`none,80,60";lastModified=$date}}
        Assert-True ($r.status -eq "ok" -and $null -eq $r.sourceDate -and $null -eq $r.artifactCommit) "Unknown evaluation date was fabricated"
        if ($null -eq $date) {
            Assert-True ($null -eq $r.artifactPublishedAtUtc -and $r.diagnostics -match "artifact_publication_unknown") "Missing header became the retrieval time"
        } else {
            Assert-True ($r.artifactPublishedAtUtc -eq $date -and $r.diagnostics -match "artifact_publication_invalid") "Invalid header became a valid timestamp"
        }
    }
}
Run-Test "Public component parser preserves effort and rejects fallback-served workflow scores" {
    . (Join-Path $PSScriptRoot "model-aa-component-data.ps1")
    $row=@{slug="one-high";name="One";effort=@{slug="high"};automationBenchPartialScore=0.8;lcr=0.7;
        automationBenchBreakdown=@{fallbackServedTurnCount=1}}
    $r=ConvertFrom-AAComponentPage (Component-Html @{currentModel=$row})
    Assert-True ($r.status -eq "ok" -and $r.models["one-high"].effort -eq "high") "Published effort lost"
    Assert-True ($null -eq $r.models["one-high"].automationBench -and $r.models["one-high"].lcr -eq 0.7 -and $r.diagnostics -match "fallback") "Composite workflow score used as a pure model score"
    $copy=@{slug="one-high";name="One";automationBenchPartialScore=0.8;lcr=0.7}
    $r=ConvertFrom-AAComponentPage (Component-Html @{currentModel=$row;models=@($copy)})
    Assert-True ($null -eq $r.models["one-high"].automationBench) "Comparison duplicate revived a known composite score"
}
Run-Test "LiveBench preserves native artifact timestamps under non-US cultures" {
    $culture=[Globalization.CultureInfo]::CurrentCulture
    try {
        [Globalization.CultureInfo]::CurrentCulture=[Globalization.CultureInfo]::GetCultureInfo("da-DK")
        $r=Get-LiveBenchData -FetchJson {
            param($u)
            @{status="ok";value=@(@{name="table_2026_06_25.csv";download_url="table";html_url="https://example.test/lb"})}
        } -FetchText {param($u) @{status="ok";content="model,code_generation,code_completion`none,80,60";lastModified=[datetime]"2026-09-22T05:38:00Z"}}
        Assert-True ($r.artifactPublishedAtUtc -match '^2026-09-22T05:38:00' -and $null -eq $r.artifactCommit) "Native UTC timestamp was lost to local date parsing"
    } finally { [Globalization.CultureInfo]::CurrentCulture=$culture }
}
Run-Test "Duplicate public rows cannot hide composite or unresolvable effort identities" {
    . (Join-Path $PSScriptRoot "model-aa-component-data.ps1")
    $plain=@{slug="one-high";name="One";lcr=0.8}
    foreach($uncertain in @(
        @{slug="one-high";name="One with fallback";lcr=0.8},
        @{slug="one-high";name="One";effort=@{level=40};lcr=0.8}
    )) {
        $r=ConvertFrom-AAComponentPage (Component-Html @{models=@($plain,$uncertain)})
        Assert-True ($r.status -eq "unavailable" -and $r.diagnostics -match "identity") "Duplicate row hid an ambiguous identity"
    }
}
if ($script:Failed) { exit 1 }
