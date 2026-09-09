Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "review-task-profiles.ps1")
$script:Failed=0
function Assert-True($Condition,$Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name,[scriptblock]$Action) {
    try { &$Action; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $_" }
}
$repo=Split-Path $PSScriptRoot -Parent
Run-Test "Offline review uses same-run pricing, preserves profiles and writes decision provenance" {
    $root=Join-Path ([System.IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    foreach ($dir in @("config","data","reports")) { New-Item -ItemType Directory (Join-Path $root $dir) -Force | Out-Null }
    try {
        Copy-Item (Join-Path $repo "task-profiles.json") $root
        Copy-Item (Join-Path $repo "config\model-policy.json") (Join-Path $root "config")
        $policyBefore=Get-Content (Join-Path $root "config\model-policy.json") -Raw
        $cap=@{schemaVersion=2;generatedDate="2026-09-08";freshnessThresholdDays=60;models=@{
            one=@{asOf="2026-09-08";capabilitySource="test";vision=$true;visionSource="test fixture";supportedContexts=@("default","long_context");supportedEfforts=@("low","medium","high")}
        }}
        $cap | ConvertTo-Json -Depth 15 | Set-Content (Join-Path $root "config\model-capabilities.json")
        @{schemaVersion=2;aliases=@{one=@{artificialAnalysis=@{medium="one-medium";high="one-high";low="one-low"}}}} | ConvertTo-Json -Depth 10 | Set-Content (Join-Path $root "config\model-ranking-aliases.json")
        @{schemaVersion=1;aliases=@{one="Example One"}} | ConvertTo-Json | Set-Content (Join-Path $root "config\model-pricing-aliases.json")
        $before=Get-Content (Join-Path $root "task-profiles.json") -Raw | ConvertFrom-Json
        $capBefore=[Convert]::ToBase64String([System.IO.File]::ReadAllBytes((Join-Path $root "config\model-capabilities.json")))
        $sources=@{artificialAnalysis=@{status="ok";sourceUrl="https://example.test";sourceVersion="v1";sourceDate=$null;fetchedAtUtc="2026-09-08T00:00:00Z";models=@{
            "one-medium"=@{name="One medium";codingIndex=90;intelligenceIndex=90}
            "one-high"=@{name="One high";codingIndex=90;intelligenceIndex=90}
            "one-low"=@{name="One low";codingIndex=90;intelligenceIndex=90}
        }}}
        $fetch={param($url) @{status="ok";content='<table><tr><th>Model</th><th>Input</th><th>Output</th></tr><tr><td>Example One</td><td>$4</td><td>$20</td></tr></table>'}}
        $review=Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("one");verified=$true;source="fixture"} -Sources $sources -FetchPricing $fetch -ForceImmediateApply -NowUtc ([datetime]"2026-09-08Z")
        $after=Get-Content (Join-Path $root "task-profiles.json") -Raw | ConvertFrom-Json
        Assert-True ((Get-Content (Join-Path $root "config\model-policy.json") -Raw) -ceq $policyBefore) "Review rewrote fixed spending authorization"
        Assert-True (($after | Where-Object key -eq "default-development").model -eq "one") "Same-run price not used or approved hard budget blocked"
        Assert-True (($after | Where-Object key -eq "quick").model -eq ($before | Where-Object key -eq "quick").model) "Hard cap violated"
        foreach ($p in $after) {
            $old=$before | Where-Object key -eq $p.key
            $range=(Get-ModelPolicyConfig (Join-Path $root "config\model-policy.json")).selectionPolicy.profiles[$p.key].configurationSelection.allowedEfforts
            Assert-True ($p.model -and $p.effort -in $range -and $p.context -eq $old.context) "Profile left its authorized configuration range"
        }
        Assert-True ([Convert]::ToBase64String([System.IO.File]::ReadAllBytes((Join-Path $root "config\model-capabilities.json"))) -ceq $capBefore) "Capability bytes changed"
        $report=Get-Content (Join-Path $root "reports\task-profile-review.md") -Raw
        foreach ($term in @("value_balanced_choice","Budget: **hard**","retained","Pricing","reduced","one-medium")) { Assert-True ($report.Contains($term)) "Missing report evidence: $term" }
        foreach ($term in @("Strategy: **value_balanced**", "Candidate gap: **0 / 3**", "candidate **600 AIC**; incumbent **n/a AIC**", "Cost comparison unavailable:", "Incumbent evidence gap:")) {
            Assert-True ($report.Contains($term)) "Missing value decision explanation: $term"
        }
        Assert-True (($after | Where-Object key -eq "orchestrator").model -eq ($before | Where-Object key -eq "orchestrator").model) "Force bypassed Orchestrator's hard ceiling"
        $blocked = $review.results | Where-Object key -eq "orchestrator"
        $blocked.resolution.state.pending = @{model="previous-candidate";effort="medium";context="default";decidingSource="artificialAnalysis";count=1}
        $details = (Get-ProfileReviewReportLines $blocked) -join "`n"
        Assert-True ($details.Contains("observations for previous-candidate / medium / default (artificialAnalysis): 1 / 2")) "Frozen pending count was attributed to the blocked recommendation"
        Assert-True ([regex]::Matches($report, '<details>').Count -eq $after.Count + 1) "Coverage/profile evidence is not expandable"
        Assert-True ($report.Contains("## Coverage and exclusions")) "Missing grouped coverage"
        $coverage=Get-ModelReviewCoverage -Results $review.results
        foreach ($result in $review.results) {
            foreach ($diagnostic in $result.evidence.diagnostics) {
                Assert-True (@($coverage | Where-Object { $_.kind -eq "evidence gap" -and $_.message -eq $diagnostic -and $_.profiles -contains $result.key }).Count -eq 1) "Evidence gap omitted or duplicated"
            }
            foreach ($verdict in $result.verdicts) {
                foreach ($reason in $verdict.reasonCodes) {
                    Assert-True (@($coverage | Where-Object { $_.kind -eq "exclusion" -and $_.model -eq $verdict.modelId -and $_.effort -eq $verdict.effort -and $_.context -eq $verdict.context -and $_.message -eq $reason -and $_.profiles -contains $result.key }).Count -eq 1) "Exclusion omitted or duplicated"
                }
            }
        }
        Assert-True (Test-Path (Join-Path $root "data\model-pricing-snapshot.json")) "Pricing not persisted"
        $state=Get-Content (Join-Path $root "data\model-ranking-snapshot.json") -Raw | ConvertFrom-Json
        Assert-True ($state.schemaVersion -eq 3 -and $state.consensus.profiles.'default-development'.policyFingerprint) "State migration/provenance"
        foreach ($changedAliases in @(@{one="Reassigned Identity"},@{})) {
            @{schemaVersion=1;aliases=$changedAliases} | ConvertTo-Json | Set-Content (Join-Path $root "config\model-pricing-aliases.json")
            $aliasRun=Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("one");verified=$true;source="fixture"} -Sources $sources -FetchPricing {param($url) @{status="error";error="fixture outage"}} -ForceImmediateApply -NowUtc ([datetime]"2026-09-08Z")
            $verdict=($aliasRun.results | Where-Object key -eq "default-development").verdicts | Where-Object modelId -eq "one"
            Assert-True ($verdict.reasonCodes -contains "pricing_missing") "Removed or reassigned alias used cached identity"
        }
        @{schemaVersion=1;aliases=@{one="Example One"}} | ConvertTo-Json | Set-Content (Join-Path $root "config\model-pricing-aliases.json")
        $script:clockSource=$sources.artificialAnalysis
        function Get-ArtificialAnalysisIntelligenceIndexData {
            Start-Sleep -Milliseconds 20
            $source=$script:clockSource.Clone()
            $source.fetchedAtUtc=[datetime]::UtcNow.ToString("o")
            return $source
        }
        function Get-ArtificialAnalysisCodingAgentIndexData { return @{status="error";message="fixture unavailable"} }
        function Get-LiveBenchData { return @{status="error";message="fixture unavailable"} }
        $liveClock=Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("one");verified=$true;source="fixture"} -FetchPricing $fetch
        Assert-True (($liveClock.results | Where-Object key -eq "default-development").evidence.records.Count -gt 0) "Just-fetched data treated as future/stale"
    } finally {
        foreach ($file in @(Get-ChildItem -LiteralPath $root -File -Recurse)) { Remove-Item -LiteralPath $file.FullName }
        foreach ($dir in @("config","data","reports")) { Remove-Item -LiteralPath (Join-Path $root $dir) }
        Remove-Item -LiteralPath $root
    }
}
Run-Test "Workflow persists price updates and runs all new suites" {
    $workflow=Get-Content (Join-Path $repo ".github\workflows\monthly-task-profile-review.yml") -Raw
    Assert-True ($workflow -match 'data/model-pricing-snapshot.json') "Missing pricing PR path"
    $runner=Get-Content (Join-Path $PSScriptRoot "test-all.ps1") -Raw
    foreach ($file in @("test-model-pricing.ps1","test-model-evidence.ps1","test-model-selection.ps1","test-model-review.ps1")) {
        Assert-True ($runner.Contains($file)) "Runner omits $file"
    }
}
Run-Test "Report rows preserve missing values and escape external table content" {
    $row = Format-ModelReportRow @($null, 0, $false, "pipe|value")
    Assert-True ($row -eq "| n/a | 0 | False | pipe&#124;value |") "Report column shape changed"
    Assert-True ((Format-ModelReportNumber 2.700000000000003) -eq "2.7") "Floating-point noise obscures score gaps"
    Assert-True ((Format-ModelReportNumber $null) -eq "n/a" -and (Format-ModelReportNumber 0) -eq "0") "Unknown cost became zero"
}
Run-Test "Reports distinguish fixed authorization from informational incumbent cost increases" {
    $policy = Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
    $profile = @{key="review";model="gemini";effort="medium";context="default"}
    $verdicts = @(foreach ($model in @("gemini","opus","astra")) {
        $rate = @{gemini=0.75;opus=5;astra=10}[$model]
        [pscustomobject]@{modelId=$model;effort="medium";context="default";admissible=($model -ne "astra");
            reasonCodes=$(if ($model -eq "astra") { @("pricing_input_exceeds_ceiling","pricing_output_exceeds_ceiling") } else { @() });warningCodes=@();
            pricing=@{inputPerMillion=$rate;outputPerMillion=$rate*5;tier="default";verifiedAtUtc="2026-09-08"};
            capabilities=@{asOf="2026-09-08"}}
    })
    $records = @(foreach ($model in @("gemini","opus","astra")) {
        [pscustomobject]@{model=$model;score=@{gemini=46.8;opus=51;astra=54}[$model];source="artificialAnalysis";
            metric="intelligenceIndex";effort="medium";alias=$model;sourceVersion="v1";sourceDate=$null;
            publicationAgeUnknown=$true;cached=$false;harness="fixture"}
    })
    $selection = Get-ProfileSelection -Profile $profile -Evidence $records -Verdicts $verdicts -Policy $policy -Aliases @{}
    $resolution = Resolve-ProfileSelectionState -CurrentModel gemini -Selection $selection -ForceImmediateApply
    $result = @{key="review";selection=$selection;resolution=$resolution;requirement=$policy.profileRequirements.review;
        fallback=$null;verdicts=$verdicts;evidence=@{records=$records}}
    $report = (Get-ProfileReviewReportLines $result) -join "`n"
    foreach ($term in @("candidate **750 AIC**; incumbent **112.5 AIC**",
        "Candidate cost change: **566.666666667%**", "informational, not an incumbent-relative limit",
        "Fixed hard ceilings authorize spending; they never rise automatically",
        "authorized efforts: medium, high", "Matched incumbent score", "Budget: **hard**, input 5 / output 30")) {
        Assert-True ($report.Contains($term)) "Missing escalation explanation: $term"
    }
    Assert-True ($resolution.finalModel -eq "opus" -and $selection.qualityWinner.model -eq "astra") "Authorized candidate or excluded quality leader lost"
}
Run-Test "Agentic review confirms and applies the complete authorized pair, including forced runs" {
    $root=Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    foreach ($dir in @("config","data","reports")) { New-Item -ItemType Directory (Join-Path $root $dir) -Force | Out-Null }
    try {
        Copy-Item (Join-Path $repo "config\model-policy.json") (Join-Path $root "config")
        $profiles=@(
            @{key="agentic-implementation";model="one";effort="high";context="default";label="Preserve me"}
            @{key="review";model="one";effort="medium";context="default"}
            @{key="quick";model="one";effort="low";context="default"}
        )
        $profilePath=Join-Path $root "task-profiles.json"
        Write-ModelJsonAtomic $profilePath $profiles
        $caps=@{}
        foreach ($model in @("one","two","hidden")) {
            $caps[$model]=@{asOf="2026-09-09";capabilitySource="fixture";vision=$null;supportedContexts=@("default");supportedEfforts=@("low","medium","high","xhigh","max")}
        }
        Write-ModelJsonAtomic (Join-Path $root "config\model-capabilities.json") @{schemaVersion=2;models=$caps}
        $aliases=@{
            one=@{artificialAnalysisCodingAgents=@{high="One high"};artificialAnalysis=@{low="one-low";medium="one-medium"}}
            two=@{artificialAnalysisCodingAgents=@{high="Two high";xhigh="Two xhigh";max="Two max"}}
            hidden=@{artificialAnalysisCodingAgents=@{max="Hidden max"}}
        }
        Write-ModelJsonAtomic (Join-Path $root "config\model-ranking-aliases.json") @{schemaVersion=2;aliases=$aliases}
        Write-ModelJsonAtomic (Join-Path $root "config\model-pricing-aliases.json") @{schemaVersion=1;aliases=@{one="One";two="Two";hidden="Hidden"}}
        $sources=@{
            artificialAnalysisCodingAgents=@{status="ok";sourceVersion="agents-v1";sourceDate="2026-09-09";fetchedAtUtc="2026-09-09Z";sourceUrl="https://example.test/agents";models=@{
                "One high"=@{codingAgentIndex=0.64};"Two high"=@{codingAgentIndex=0.65}
                "Two xhigh"=@{codingAgentIndex=0.68};"Two max"=@{codingAgentIndex=0.67}
                "Hidden max"=@{codingAgentIndex=0.99}
            }}
            artificialAnalysis=@{status="ok";sourceVersion="aa-v1";sourceDate="2026-09-09";fetchedAtUtc="2026-09-09Z";sourceUrl="https://example.test/aa";models=@{
                "one-low"=@{codingIndex=80};"one-medium"=@{intelligenceIndex=80}
            }}
        }
        $fetch={param($u) @{status="ok";content='<table><tr><th>Model</th><th>Input</th><th>Output</th></tr><tr><td>One</td><td>$1</td><td>$5</td></tr><tr><td>Two</td><td>$1</td><td>$5</td></tr><tr><td>Hidden</td><td>$1</td><td>$5</td></tr></table>'}}
        $before=Get-Content -LiteralPath $profilePath -Raw
        foreach ($run in @(@{force=$false;version="agents-v1";apply=$false},@{force=$false;version="agents-v1";apply=$false},
            @{force=$false;version="agents-v2";apply=$true},@{force=$true;version="agents-v3";apply=$true})) {
            if ($run.force) { Write-ModelJsonAtomic $profilePath $profiles }
            $sources.artificialAnalysisCodingAgents.sourceVersion=$run.version
            $review=Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("one","two");verified=$true;source="fixture"} `
                -Sources $sources -FetchPricing $fetch -ForceImmediateApply:$run.force -NowUtc ([datetime]"2026-09-09Z")
            $agentic=$review.results | Where-Object key -eq "agentic-implementation"
            Assert-True ($agentic.selection.winner.model -eq "two" -and $agentic.selection.winner.effort -eq "xhigh") "Best measured supported pair not selected"
            Assert-True ($agentic.resolution.applied -eq $run.apply) "Authorized effort change ignored confirmation or force"
            if ($run.apply) {
                $saved=Get-Content -LiteralPath $profilePath -Raw | ConvertFrom-Json
                Assert-True ($saved[0].model -eq "two" -and $saved[0].effort -eq "xhigh" -and $saved[0].context -eq "default") "Model and effort did not persist together"
                Assert-True ($agentic.resolution.state.activeOverride.effort -eq "xhigh") "Active state lost effort"
            } else {
                Assert-True ((Get-Content -LiteralPath $profilePath -Raw) -ceq $before -and $agentic.resolution.state.pending.count -eq 1) "Unconfirmed configuration was applied or counted twice"
            }
            Assert-True (@($agentic.verdicts | Where-Object modelId -eq "two").Count -eq 3) "Configuration eligibility was flattened"
            $report=Get-Content (Join-Path $root "reports\task-profile-review.md") -Raw
            foreach ($term in @("one / high / default","two / xhigh / default","automatic bounded effort","task cost and latency are unknown","candidate **150 AIC**; incumbent **150 AIC**","0.03")) {
                Assert-True ($report.Contains($term)) "Report omitted configuration or cost uncertainty: $term"
            }
        }
        $adopted=Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("one","two");verified=$true;source="fixture"} `
            -Sources $sources -FetchPricing $fetch -ForceImmediateApply -NowUtc ([datetime]"2026-09-09Z")
        $agentic=$adopted.results | Where-Object key -eq "agentic-implementation"
        Assert-True ($agentic.finalConfiguration.model -eq "two" -and $agentic.finalConfiguration.effort -eq "xhigh" -and -not $agentic.resolution.applied) "Applied configuration churned on the next review"
        $after=Get-Content -LiteralPath $profilePath -Raw | ConvertFrom-Json
        Assert-True ($after[0].label -eq "Preserve me" -and $after[1].effort -eq "medium" -and $after[2].effort -eq "low") "Unrelated profile fields changed"
        $profiles[0].model="one";$profiles[0].effort="high"
        Write-ModelJsonAtomic $profilePath $profiles
        $beforeFailure=Get-Content -LiteralPath $profilePath -Raw
        $writer=(Get-Command Write-ModelJsonAtomic).ScriptBlock
        function Write-ModelJsonAtomic {
            param($SnapshotPath,$SnapshotObject)
            if ($SnapshotPath -eq $profilePath) { throw [IO.IOException]::new("Fixture profile write failure") }
            & $writer -SnapshotPath $SnapshotPath -SnapshotObject $SnapshotObject
        }
        $threw=$false
        try {
            Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("one","two");verified=$true;source="fixture"} `
                -Sources $sources -FetchPricing $fetch -ForceImmediateApply -NowUtc ([datetime]"2026-09-09Z") | Out-Null
        } catch [IO.IOException] { $threw=$_.Exception.Message -eq "Fixture profile write failure" }
        Assert-True ($threw -and (Get-Content -LiteralPath $profilePath -Raw) -ceq $beforeFailure) "Profile write failure was swallowed or left a partial pair"
    } finally {
        Get-ChildItem -LiteralPath $root -File -Recurse | Remove-Item
        foreach ($dir in @("config","data","reports")) { Remove-Item -LiteralPath (Join-Path $root $dir) }
        Remove-Item -LiteralPath $root
    }
}
Run-Test "Grouped exclusions distinguish configurations instead of merging model-level reasons" {
    $verdicts=@(foreach ($effort in @("high","xhigh")) {
        @{modelId="one";effort=$effort;context="default";reasonCodes=@("capabilities_stale");warningCodes=@()}
    })
    $coverage=@(Get-ModelReviewCoverage @(@{key="agentic-implementation";verdicts=$verdicts;evidence=@{diagnostics=@()}}))
    Assert-True ($coverage.Count -eq 2 -and @($coverage.effort | Select-Object -Unique).Count -eq 2) "Configuration exclusions were conflated"
}
if ($script:Failed) { exit 1 }
