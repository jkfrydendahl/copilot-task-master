Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "review-task-profiles.ps1")
. (Join-Path $PSScriptRoot "fixtures\model-ranking\agent-fixture.ps1")
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
        $cap.models.two=$cap.models.one.Clone()
        $cap | ConvertTo-Json -Depth 15 | Set-Content (Join-Path $root "config\model-capabilities.json")
        @{schemaVersion=2;aliases=@{
            one=@{artificialAnalysis=@{medium="one-medium";high="one-high";low="one-low"};liveBench=@{medium="one-medium";high="one-high";low="one-low"}}
            two=@{artificialAnalysis=@{medium="two-medium";high="two-high";low="two-low"};liveBench=@{medium="two-medium";high="two-high";low="two-low"}}
        }} | ConvertTo-Json -Depth 10 | Set-Content (Join-Path $root "config\model-ranking-aliases.json")
        @{schemaVersion=1;aliases=@{one="Example One";two="Example Two"}} | ConvertTo-Json | Set-Content (Join-Path $root "config\model-pricing-aliases.json")
        $before=Get-Content (Join-Path $root "task-profiles.json") -Raw | ConvertFrom-Json
        $capBefore=[Convert]::ToBase64String([System.IO.File]::ReadAllBytes((Join-Path $root "config\model-capabilities.json")))
        $sources=@{artificialAnalysis=@{status="ok";sourceUrl="https://example.test";sourceVersion="v1";sourceDate=$null;fetchedAtUtc="2026-09-08T00:00:00Z";models=@{
            "one-medium"=@{name="One medium";codingIndex=90;intelligenceIndex=90}
            "one-high"=@{name="One high";codingIndex=90;intelligenceIndex=90}
            "one-low"=@{name="One low";codingIndex=90;intelligenceIndex=90}
            "two-medium"=@{name="Two medium";codingIndex=85;intelligenceIndex=85}
            "two-high"=@{name="Two high";codingIndex=85;intelligenceIndex=85}
            "two-low"=@{name="Two low";codingIndex=85;intelligenceIndex=85}
        }}}
        $componentModels=@{}
        foreach ($model in @("one","two")) {
            foreach ($effort in @("low","medium","high")) {
                $score=if($model -eq "one"){0.9}else{0.8}
                $componentModels["$model-$effort"]=@{name=$model;effort=$effort;ifbench=$score;lcr=$score;mmmuPro=$score}
            }
        }
        $sources.artificialAnalysisComponents=@{status="ok";sourceDate=$null;fetchedAtUtc="2026-09-08Z";models=$componentModels}
        $sources.artificialAnalysisComponents.releases=@{
            "one-high"=@(@{date="2026-09-01";releaseId="one";effort="high"})
            "two-high"=@(@{date="2026-08-01";releaseId="two";effort="high"})
        }
        $sources.liveBench=@{status="ok";sourceDate=$null;fetchedAtUtc="2026-09-08Z";models=@{
            "one-medium"=@{coding=90;reasoning=90;instructionFollowing=90}
            "one-high"=@{coding=90;reasoning=90;instructionFollowing=90}
            "one-low"=@{coding=90;reasoning=90;instructionFollowing=90}
            "two-medium"=@{coding=85;reasoning=85;instructionFollowing=85}
            "two-high"=@{coding=85;reasoning=85;instructionFollowing=85}
            "two-low"=@{coding=85;reasoning=85;instructionFollowing=85}
        }}
        $fetch={param($url) @{status="ok";content='<table><tr><th>Model</th><th>Input</th><th>Output</th></tr><tr><td>Example One</td><td>$4</td><td>$20</td></tr><tr><td>Example Two</td><td>$4</td><td>$20</td></tr></table>'}}
        $review=Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("one","two");verified=$true;source="fixture"} -Sources $sources -FetchPricing $fetch -ForceImmediateApply -NowUtc ([datetime]"2026-09-08Z")
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
        Assert-True ([regex]::Matches($report, '<details>').Count -eq $after.Count + 2) "Onboarding/coverage/profile evidence is not expandable"
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
        Assert-True ($state.schemaVersion -eq 4 -and $state.consensus.profiles.'default-development'.policyFingerprint) "State migration/provenance"
        Assert-True (([datetime]$state.sources.artificialAnalysisComponents.releases.'one-high'[0].date).ToString("yyyy-MM-dd") -eq "2026-09-01") "Release metadata not persisted"
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
        function Get-AAComponentData { param($ModelSlugs) return @{status="error";message="fixture unavailable"} }
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
    Assert-True ($workflow -match 'run:\s*\.\\scripts\\review-task-profiles\.ps1 -RequireFreshDiscovery') "Action does not enforce discovery freshness"
    foreach($term in @("data/model-discovery-snapshot.json","npm ci","data/model-onboarding-snapshot.json",
        "config/model-capabilities.json","config/model-ranking-aliases.json","config/model-pricing-aliases.json")){
        Assert-True ($workflow.Contains($term)) "Missing onboarding workflow integration: $term"
    }
    Assert-True (-not $workflow.Contains("COPILOT_GITHUB_TOKEN") -and
        -not $workflow.Contains("npm install --global @github/copilot") -and
        $workflow -notmatch 'run:.*refresh-model-catalog') "Action performs local authentication/discovery"
    $generationIndex=$workflow.IndexOf('run: .\scripts\review-task-profiles.ps1')
    $publishIndex=$workflow.IndexOf('- name: Create/update PR')
    $postGeneration=$workflow.Substring($generationIndex, $publishIndex-$generationIndex)
    Assert-True ($postGeneration -match 'run:\s*\.\\scripts\\test-all\.ps1') "Generated catalogs are not validated before publication"
    $runner=Get-Content (Join-Path $PSScriptRoot "test-all.ps1") -Raw
    foreach ($file in @("test-model-pricing.ps1","test-model-evidence.ps1","test-model-selection.ps1","test-model-review.ps1","test-orchestration-evaluation.mjs")) {
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
    $incumbentScore=51 - $policy.selectionPolicy.profiles.review.qualityBands["liveBench.coding"] - 1
    $records = @(foreach ($model in @("gemini","opus","astra")) {
        [pscustomobject]@{model=$model;score=@{gemini=$incumbentScore;opus=51;astra=54}[$model];source="liveBench";
            metric="coding";effort="medium";alias=$model;sourceVersion="v1";sourceDate=$null;
            publicationAgeUnknown=$true;cached=$false;harness="fixture"}
    })
    foreach ($record in @($records)) {
        $reasoning=$record | Select-Object *;$reasoning.metric="reasoning";$reasoning.score=80
        $intelligence=$record | Select-Object *;$intelligence.source="artificialAnalysis";$intelligence.metric="intelligenceIndex";$intelligence.score=80
        $lcr=$record | Select-Object *;$lcr.source="artificialAnalysisComponents";$lcr.metric="lcr";$lcr.score=0.8
        $records+=@($reasoning,$intelligence,$lcr)
    }
    $selection = Get-ProfileSelection -Profile $profile -Evidence $records -Verdicts $verdicts -Policy $policy -Aliases @{}
    $resolution = Resolve-ProfileSelectionState -CurrentModel gemini -Selection $selection -ForceImmediateApply
    $result = @{key="review";selection=$selection;resolution=$resolution;requirement=$policy.profileRequirements.review;
        fallback=$null;verdicts=$verdicts;evidence=@{records=$records}}
    $report = (Get-ProfileReviewReportLines $result) -join "`n"
    foreach ($term in @("candidate **750 AIC**; incumbent **112.5 AIC**",
        "Candidate cost change: **566.666666667%**", "informational, not an incumbent-relative limit",
        "Fixed hard ceilings authorize spending; they never rise automatically",
        "authorized efforts: none, minimal, low, medium, high, xhigh, max", "Matched incumbent score", "Budget: **hard**, input 5 / output 30")) {
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
            @{key="agentic-implementation";model="gpt-one";effort="high";context="default";label="Preserve me"}
            @{key="review";model="gpt-one";effort="medium";context="default"}
            @{key="quick";model="gpt-one";effort="low";context="default"}
        )
        $profilePath=Join-Path $root "task-profiles.json"
        Write-ModelJsonAtomic $profilePath $profiles
        $caps=@{}
        foreach ($model in @("gpt-one","gpt-two","gpt-hidden")) {
            $caps[$model]=@{asOf="2026-09-09";capabilitySource="fixture";vision=$null;supportedContexts=@("default");supportedEfforts=@("low","medium","high","xhigh","max")}
        }
        Write-ModelJsonAtomic (Join-Path $root "config\model-capabilities.json") @{schemaVersion=2;models=$caps}
        $aliases=@{
            "gpt-one"=@{artificialAnalysis=@{low="one-low";medium="one-medium";high="one-high"};
                liveBench=@{low="one-low";medium="one-medium";high="one-high"}}
            "gpt-two"=@{liveBench=@{xhigh="two-xhigh";medium="two-medium";low="two-low"}}
        }
        Write-ModelJsonAtomic (Join-Path $root "config\model-ranking-aliases.json") @{schemaVersion=2;aliases=$aliases}
        Write-ModelJsonAtomic (Join-Path $root "config\model-pricing-aliases.json") @{schemaVersion=1;aliases=@{"gpt-one"="One";"gpt-two"="Two";"gpt-hidden"="Hidden"}}
        $sources=@{
            artificialAnalysisCodingAgents=@{status="ok";sourceVersion="agents-v1";sourceDate="2026-09-09";fetchedAtUtc="2026-09-09Z";sourceUrl="https://example.test/agents";models=@{
                "one-high"=(New-NormalizedAgentFixture one-high "GPT-one (high)" 0.64)
                "two-high"=(New-NormalizedAgentFixture two-high "GPT-two (high)" 0.65)
                "two-xhigh"=(New-NormalizedAgentFixture two-xhigh "GPT-two (xhigh)" 0.68)
                "two-max"=(New-NormalizedAgentFixture two-max "GPT-two (max)" 0.67)
                "hidden-max"=(New-NormalizedAgentFixture hidden-max "GPT-hidden (max)" 0.99)
            }}
            artificialAnalysis=@{status="ok";sourceVersion="aa-v1";sourceDate="2026-09-09";fetchedAtUtc="2026-09-09Z";sourceUrl="https://example.test/aa";models=@{
                "one-low"=@{intelligenceIndex=80};"one-medium"=@{intelligenceIndex=80};"one-high"=@{intelligenceIndex=80}
            }}
            liveBench=@{status="ok";sourceVersion="lb-v1";sourceDate="2026-09-09";fetchedAtUtc="2026-09-09Z";sourceUrl="https://example.test/lb";models=@{
                "one-low"=@{coding=80;reasoning=80};"one-medium"=@{coding=80;reasoning=80};"one-high"=@{coding=80;reasoning=80}
            }}
        }
        $fetch={param($u) @{status="ok";content='<table><tr><th>Model</th><th>Input</th><th>Output</th></tr><tr><td>One</td><td>$1</td><td>$5</td></tr><tr><td>Two</td><td>$1</td><td>$5</td></tr><tr><td>Hidden</td><td>$1</td><td>$5</td></tr></table>'}}
        $before=Get-Content -LiteralPath $profilePath -Raw
        foreach ($run in @(@{force=$false;version="agents-v1";apply=$false},@{force=$false;version="agents-v1";apply=$false},
            @{force=$false;version="agents-v2";apply=$true},@{force=$true;version="agents-v3";apply=$true})) {
            if ($run.force) { Write-ModelJsonAtomic $profilePath $profiles }
            $sources.artificialAnalysisCodingAgents.sourceVersion=$run.version
            if ($run.version -ne "agents-v1") { $sources.artificialAnalysisCodingAgents.models["two-xhigh"].codingAgentIndex=0.681 }
            $review=Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("gpt-one","gpt-two");verified=$true;source="fixture"} `
                -Sources $sources -FetchPricing $fetch -ForceImmediateApply:$run.force -NowUtc ([datetime]"2026-09-09Z")
            $agentic=$review.results | Where-Object key -eq "agentic-implementation"
            Assert-True ($agentic.selection.winner.model -eq "gpt-two" -and $agentic.selection.winner.effort -eq "xhigh") "Best measured supported pair not selected"
            Assert-True ($agentic.resolution.applied -eq $run.apply) "Authorized effort change ignored confirmation or force"
            if ($run.apply) {
                $saved=Get-Content -LiteralPath $profilePath -Raw | ConvertFrom-Json
                Assert-True ($saved[0].model -eq "gpt-two" -and $saved[0].effort -eq "xhigh" -and $saved[0].context -eq "default") "Model and effort did not persist together"
                Assert-True ($agentic.resolution.state.activeOverride.effort -eq "xhigh") "Active state lost effort"
            } else {
                Assert-True ((Get-Content -LiteralPath $profilePath -Raw) -ceq $before -and $agentic.resolution.state.pending.count -eq 1) "Unconfirmed configuration was applied or counted twice"
            }
            Assert-True (@($agentic.verdicts | Where-Object modelId -eq "gpt-two").Count -eq $caps["gpt-two"].supportedEfforts.Count) "Configuration eligibility was flattened or expanded beyond native support"
            $report=Get-Content (Join-Path $root "reports\task-profile-review.md") -Raw
            foreach ($term in @("gpt-one / high / default","gpt-two / xhigh / default","automatic bounded effort","task cost and latency are unknown","candidate **150 AIC**; incumbent **150 AIC**","0.03","informational only","variant two-xhigh")) {
                Assert-True ($report.Contains($term)) "Report omitted configuration or cost uncertainty: $term"
            }
        }
        $adopted=Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("gpt-one","gpt-two");verified=$true;source="fixture"} `
            -Sources $sources -FetchPricing $fetch -ForceImmediateApply -NowUtc ([datetime]"2026-09-09Z")
        $agentic=$adopted.results | Where-Object key -eq "agentic-implementation"
        Assert-True ($agentic.finalConfiguration.model -eq "gpt-two" -and $agentic.finalConfiguration.effort -eq "xhigh" -and -not $agentic.resolution.applied) "Applied configuration churned on the next review"
        $after=Get-Content -LiteralPath $profilePath -Raw | ConvertFrom-Json
        Assert-True ($after[0].label -eq "Preserve me" -and $after[1].effort -eq "medium" -and $after[2].effort -eq "low") "Unrelated profile fields changed"
        $originalAgents=$sources.artificialAnalysisCodingAgents
        $sources.artificialAnalysisCodingAgents=@{status="ok";sourceVersion="legacy";sourceDate="2026-09-09";fetchedAtUtc="2026-09-09Z";
            models=@{old=@{label="Fixture - GPT-two (xhigh)";codingAgentIndex=0.99}}}
        $sources.liveBench=@{status="ok";sourceVersion="lb-v1";sourceDate="2026-09-09";fetchedAtUtc="2026-09-09Z";
            models=@{"two-xhigh"=@{agenticCoding=70}}}
        foreach ($matched in @($false,$true)) {
            Write-ModelJsonAtomic $profilePath $profiles
            if ($matched) { $sources.liveBench.models["one-high"]=@{agenticCoding=60} }
            $fallbackRun=Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("gpt-one","gpt-two");verified=$true;source="fixture"} `
                -Sources $sources -FetchPricing $fetch -ForceImmediateApply -NowUtc ([datetime]"2026-09-09Z")
            $agentic=$fallbackRun.results | Where-Object key -eq "agentic-implementation"
            Assert-True ($agentic.resolution.applied -eq $matched) "Legacy/general coding or insufficient distinct-model coverage authorized fallback"
            if ($matched) { Assert-True ($agentic.selection.decidingSource -eq "liveBench") "Valid fallback not selected" }
            Assert-True ($agentic.evidence.diagnostics -match "identity_metadata_missing") "Legacy cache explanation lost"
            $text=Get-Content (Join-Path $root "reports\task-profile-review.md") -Raw
            if (-not $matched) { Assert-True ($text.Contains("insufficient_comparison_models") -and $text.Contains("not certified")) "Sparse fallback not explained" }
        }
        $sources.artificialAnalysisCodingAgents=$originalAgents
        $sources.Remove("liveBench")
        $profiles[0].model="gpt-one";$profiles[0].effort="high"
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
            Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("gpt-one","gpt-two");verified=$true;source="fixture"} `
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
Run-Test "Generic supporting scores are visible, configuration matched and clearly labelled" {
    $p = Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
    # Isolate informational formatting from the production Orchestrator's binding gates.
    $p.selectionPolicy.profiles.orchestrator.Remove("qualification")
    $p.selectionPolicy.profiles.orchestrator.supportingMetrics=@("artificialAnalysisComponents.lcr","liveBench.instructionFollowing")
    $profile = @{key="orchestrator";model="one";effort="high";context="default"}
    $verdict = @{modelId="one";effort="high";context="default";admissible=$true;reasonCodes=@();warningCodes=@();
        pricing=@{inputPerMillion=0.75;outputPerMillion=3.75};capabilities=@{}}
    $aa = @{model="one";effort="high";context="default";score=0.412;source="artificialAnalysisComponents";metric="automationBench";
        alias="one-high";sourceDate=$null;sourceVersion="aa-v1";publicationAgeUnknown=$true;cached=$false;harness="fixture"}
    $lb = @{model="one";effort="high";context="default";score=81.4125;source="liveBench";metric="instructionFollowing";
        alias="one-lb-high";sourceDate="2026-09-01";fetchedAtUtc="2026-09-14Z";sourceVersion="lb-v1";
        publicationAgeUnknown=$false;cached=$false;harness="fixture";sourceMetadata=@{reasoning=89.29325;instructionFollowing=81.4125}}
    $selection = Get-ProfileSelection -Profile $profile -Evidence @($aa,$lb) -Verdicts @($verdict) -Policy $p -Aliases @{}
    $result = @{key="orchestrator";selection=$selection;resolution=(Resolve-ProfileSelectionState -CurrentModel one -Selection $selection);
        requirement=$p.profileRequirements.orchestrator;fallback=$null;verdicts=@($verdict);evidence=@{records=@($aa,$lb)}}
    $report = (Get-ProfileReviewReportLines $result) -join "`n"
    Assert-True ($selection.decidingSource -eq "artificialAnalysisComponents" -and $selection.winner.score -eq 0.412) "LB replaced or blended with workflow evidence"
    foreach ($term in @("Supporting evidence","one / high / default","one-lb-high",
        "81.4125","2026-09-01","2026-09-14Z","not a blended ranking","not necessarily the applied configuration","AA-LCR","n/a (missing or invalid)")) {
        Assert-True ($report.Contains($term)) "Missing supporting evidence: $term"
    }
    Assert-True ($report.IndexOf("81.4125") -lt $report.IndexOf("<details>")) "Supporting scores hidden in collapsed details"
    $lb.cached=$true; $lb.sourceDate=$null
    $support = (Get-RoleSupportingEvidenceReportLines $result) -join "`n"
    Assert-True ($support.Contains("2026-09-14Z | True |") -and $support.Contains("Cached evidence cannot authorize")) "Provenance obscured"
    foreach ($value in @($null, "99", -1, 101, [double]::NaN, [double]::PositiveInfinity)) {
        $lb.score=$value
        $support = (Get-RoleSupportingEvidenceReportLines $result) -join "`n"
        $line=@($support -split "`n" | Where-Object { $_ -match '^\| LiveBench Instruction Following' })[0]
        Assert-True ($line.Contains("n/a (missing or invalid)")) "Invalid supporting score shown as valid"
    }
    $lb.score=0
    Assert-True (((Get-RoleSupportingEvidenceReportLines $result) -join "`n").Contains("| 0 |")) "Valid zero score lost"
    $lb.score=81.4125
    foreach ($field in @("model","effort","context")) {
        $original=$lb[$field]; $lb[$field]="different"
        $support = (Get-RoleSupportingEvidenceReportLines $result) -join "`n"
        Assert-True ($support.Contains("no usable, exact-configuration") -and -not $support.Contains("81.4125")) "Mismatched $field substituted"
        $lb[$field]=$original
    }
    $result.evidence.records=@($aa)
    Assert-True (((Get-RoleSupportingEvidenceReportLines $result) -join "`n").Contains("no usable, exact-configuration")) "Missing evidence hidden"
    $result.selection.winner=$null
    Assert-True (((Get-RoleSupportingEvidenceReportLines $result) -join "`n").Contains("no eligible recommendation")) "No-winner report failed"
}
Run-Test "Nine-role offline review writes the measured Xhigh pair and preserves binding confirmations and caches" {
    $root=Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    foreach($dir in @("config","data","reports")) { New-Item -ItemType Directory (Join-Path $root $dir) -Force | Out-Null }
    try {
        Copy-Item (Join-Path $repo "config\model-policy.json") (Join-Path $root "config")
        $p=Get-ModelPolicyConfig (Join-Path $root "config\model-policy.json")
        $profiles=@(foreach($key in $p.selectionPolicy.profiles.Keys) {
            @{key=$key;model="gpt-one";effort="high";context="default"}
        })
        Write-ModelJsonAtomic (Join-Path $root "task-profiles.json") $profiles
        $caps=@{};$aliases=@{};$aaModels=@{};$lbModels=@{};$componentModels=@{};$agentModels=@{}
        foreach($model in @("gpt-one","gpt-two")) {
            $caps[$model]=@{asOf="2026-09-22";capabilitySource="fixture";vision=$true;visionSource="fixture";
                supportedContexts=@("default");supportedEfforts=@("low","medium","high","xhigh")}
            $aliases[$model]=@{artificialAnalysis=@{};liveBench=@{}}
            foreach($effort in @("low","medium","high","xhigh")) {
                $slug="$model-$effort";$aliases[$model].artificialAnalysis[$effort]=$slug;$aliases[$model].liveBench[$effort]=$slug
                $score=if($model -eq "gpt-two"){0.9}else{0.7}
                if($model -eq "gpt-two" -and $effort -eq "xhigh") { $score=0.91 }
                $aaModels[$slug]=@{intelligenceIndex=$score*100}
                $lbModels[$slug]=@{coding=$score*100;reasoning=$score*100;instructionFollowing=$score*100;agenticCoding=$score*100}
                $componentModels[$slug]=@{name=$model;effort=$effort;automationBench=$score;enterpriseOpsGym=$score;
                    lcr=0.7;ifbench=0.8;mmmuPro=0.6}
                if($effort -in @("high","xhigh")) { $agentModels[$slug]=New-NormalizedAgentFixture $slug "$model ($effort)" $score }
            }
        }
        Write-ModelJsonAtomic (Join-Path $root "config\model-capabilities.json") @{schemaVersion=2;models=$caps}
        Write-ModelJsonAtomic (Join-Path $root "config\model-ranking-aliases.json") @{schemaVersion=2;aliases=$aliases}
        Write-ModelJsonAtomic (Join-Path $root "config\model-pricing-aliases.json") @{schemaVersion=1;aliases=@{"gpt-one"="One";"gpt-two"="Two"}}
        $sources=@{}
        foreach($entry in @(@("artificialAnalysis",$aaModels),@("liveBench",$lbModels),@("artificialAnalysisComponents",$componentModels),@("artificialAnalysisCodingAgents",$agentModels))) {
            $sources[$entry[0]]=@{status="ok";models=$entry[1];sourceVersion="whole-page-v1";sourceDate=$null;
                fetchedAtUtc="2026-09-22Z";sourceUrl="https://example.test"}
        }
        $fetch={param($u) @{status="ok";content='<table><tr><th>Model</th><th>Input</th><th>Output</th></tr><tr><td>One</td><td>$1</td><td>$5</td></tr><tr><td>Two</td><td>$1</td><td>$5</td></tr></table>'}}
        $options=@{RepoRoot=$root;Availability=@{models=@("gpt-one","gpt-two");verified=$true;source="fixture"};Sources=$sources;FetchPricing=$fetch;NowUtc=[datetime]"2026-09-22Z"}
        $first=Invoke-TaskProfileReview @options
        Assert-True ($first.results.Count -eq 9 -and @($first.results | Where-Object { $_.resolution.state.pending.count -eq 1 }).Count -eq 9) "Not all role contracts reached pending"
        foreach($row in $componentModels.Values) { $row.lcr=0.99 }
        $sources.artificialAnalysisComponents.sourceVersion="unrelated-page-change"
        $same=Invoke-TaskProfileReview @options
        $lcrRoles=@("deep-reasoning","review","orchestrator")
        Assert-True (@($same.results | Where-Object { $_.resolution.applied -and $_.key -in $lcrRoles }).Count -eq 3) "Binding long-context changes did not confirm"
        Assert-True (@($same.results | Where-Object { $_.key -notin $lcrRoles -and ($_.resolution.applied -or $_.resolution.state.pending.count -ne 1) }).Count -eq 0) "Informational churn confirmed a recommendation"
        foreach($slug in @($aaModels.Keys | Where-Object {$_ -like "gpt-two-*"})) {
            $score=if($slug -like "*-xhigh"){92}else{91}
            $aaModels[$slug].intelligenceIndex=$score
            $lbModels[$slug].coding=$score;$lbModels[$slug].reasoning=$score
            $componentModels[$slug].automationBench=$score/100
        }
        $agentModels["gpt-two-high"].codingAgentIndex=0.91
        $agentModels["gpt-two-xhigh"].codingAgentIndex=0.92
        $confirmed=Invoke-TaskProfileReview @options
        Assert-True (@($confirmed.results | Where-Object { $_.finalModel -eq "gpt-two" }).Count -eq 9 -and
            @($confirmed.results | Where-Object { $_.resolution.applied }).Count -eq 6) "Deciding changes failed to confirm remaining roles"
        $written=@(Get-Content -LiteralPath (Join-Path $root "task-profiles.json") -Raw | ConvertFrom-Json)
        Assert-True ($written.Count -eq 9 -and @($written | Where-Object { $_.model -ne "gpt-two" -or $_.effort -ne "xhigh" -or $_.context -ne "default" }).Count -eq 0) "Profile writer detached the measured effort from its selected model"
        $legacy=ConvertTo-CanonicalModelData $confirmed.snapshot
        $legacy.schemaVersion=3
        $legacy.sources.liveBench=@{status="ok";sourceDate="2026-06-25";fetchedAtUtc="2026-09-22Z";models=@{one=@{coding=99}}}
        Write-ModelJsonAtomic (Join-Path $root "data\model-ranking-snapshot.json") $legacy
        $sources.artificialAnalysisComponents=@{status="unavailable";message="malformed component observation"}
        $sources.artificialAnalysisCodingAgents=@{status="unavailable";message="incomplete agent observation"}
        $sources.liveBench=@{status="error";message="LiveBench HTTP403"}
        foreach($slug in @($aaModels.Keys | Where-Object {$_ -like "gpt-one-*"})) { $aaModels[$slug].intelligenceIndex=99; $lbModels[$slug].coding=99 }
        $outage=Invoke-TaskProfileReview @options -ForceImmediateApply
        $mechanical=$outage.results | Where-Object key -eq mechanical
        $orchestrator=$outage.results | Where-Object key -eq orchestrator
        Assert-True ($mechanical.resolution.status -eq "retained_cached_evidence" -and $mechanical.finalModel -eq "gpt-two") "General coding replaced required workflow evidence"
        Assert-True (-not $orchestrator.resolution.applied -and $orchestrator.resolution.status -eq "retained_cached_evidence") "Cached workflow evidence authorized promotion"
        Assert-True ($outage.snapshot.sources.artificialAnalysisComponents.status -eq "cached" -and
            $outage.snapshot.sources.artificialAnalysisComponents.models["gpt-two-high"].automationBench -eq 0.91) "Malformed observation overwrote good component cache"
        $agentCache=$outage.snapshot.sources.artificialAnalysisCodingAgents
        $expectedAgentCache=$confirmed.snapshot.sources.artificialAnalysisCodingAgents
        Assert-True ($agentCache.status -eq "cached" -and $agentCache.fetchedAtUtc -eq $expectedAgentCache.fetchedAtUtc -and
            $agentCache.sourceVersion -eq $expectedAgentCache.sourceVersion -and
            (Get-ModelDataFingerprint $agentCache.models) -eq (Get-ModelDataFingerprint $expectedAgentCache.models)) "Agent outage replaced cached records or refreshed their timestamp"
        Assert-True ($outage.snapshot.sources.liveBench.categoryCompletenessUnknown -and
            $null -eq $outage.snapshot.sources.liveBench.sourceDate -and $outage.snapshot.sources.liveBench.datasetVersion -eq "2026-06-25" -and
            $outage.snapshot.sources.liveBench.fetchedAtUtc -eq "2026-09-22Z") "Legacy LB cache silently upgraded its dates or category completeness"
        $report=Get-Content (Join-Path $root "reports\task-profile-review.md") -Raw
        Assert-True ($report.Contains("incomplete agent observation") -and $report.Contains("LiveBench HTTP403")) "Cached failures disappeared from the report"
        Assert-True ([regex]::Matches($report,'\*\*Supporting evidence\*\*').Count -eq 9) "Supporting report remained profile-specific"
        foreach($term in @("AutomationBench-AA","EnterpriseOps-Gym-AA","strict pass@1","interactive orchestration","Incumbent selection basis","Role qualification")) {
            Assert-True ($report.Contains($term)) "Missing role explanation: $term"
        }
    } finally {
        Get-ChildItem -LiteralPath $root -File -Recurse | Remove-Item
        foreach($dir in @("config","data","reports")) { Remove-Item -LiteralPath (Join-Path $root $dir) }
        Remove-Item -LiteralPath $root
    }
}
# Measured-cost end to end: AA page -> real parser -> captured source -> evidence -> selection -> report -> written profile.
# The cost workload is a pinned whole-suite proxy that is independent of the production constant, so drift in either copy fails here.
$script:E2EUsageTasks=[ordered]@{"aa-briefcase"=91;"automationbench-aa"=657;"terminalbench-4-0"=66;"frontiercode-2-0"=132;
    "omniscience"=3000;"gdp-pdf"=100;"hle-diamond"=1000;"critpt-v2-hard"=40;"terminal-bench-science"=70}
function New-E2EUsagePage {
    param([Parameter(Mandatory)][object[]]$Rows)
    $tasks=[long](($script:E2EUsageTasks.Values | Measure-Object -Sum).Sum)
    $models=@(foreach($row in $Rows) {
        $perTask=[long]$row.perTask
        $output=$perTask*$tasks
        @{
            slug=$row.slug;name=$row.name;effort=@{slug=$row.effort};release=@{slug=$row.release};releaseDate="2026-09-01";lcr=0.8
            canonicalIntelligenceIndexTokenCount=@{input=[long]$row.input;output=$output;answer=($output-[long]$row.reasoning);reasoning=[long]$row.reasoning}
            intelligenceIndexEvaluations=@(foreach($task in $script:E2EUsageTasks.Keys) {
                @{slug=$task;score=0.5;outputTokensPerTask=$perTask;costPerTask=1.5;timePerTask=10}
            })
        }
    })
    $json="x:"+(@{initialModels=$models} | ConvertTo-Json -Depth 20 -Compress)
    $cut=[int]($json.Length/2)
    return '<script>self.__next_f.push([1,'+(ConvertTo-Json -InputObject $json.Substring(0,$cut) -Compress)+
        ']);self.__next_f.push([1,'+(ConvertTo-Json -InputObject $json.Substring($cut) -Compress)+'])</script>'
}
function New-E2ECostRoot {
    param([string]$Model="alpha",[string]$Effort="max")
    $root=Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    foreach($dir in @("config","data","reports")) { New-Item -ItemType Directory (Join-Path $root $dir) -Force | Out-Null }
    Copy-Item (Join-Path $repo "config\model-policy.json") (Join-Path $root "config")
    Write-ModelJsonAtomic (Join-Path $root "task-profiles.json") @(
        @{key="quick";model=$Model;effort=$Effort;context="default";label="Preserve me"}
        @{key="review";model="beta";effort="high";context="default"}
    )
    $supported=@{alpha=@("xhigh","max");beta=@("high");gamma=@("high")}
    $caps=@{};$aliases=@{}
    foreach($name in $supported.Keys) {
        $caps[$name]=@{asOf="2026-09-22";capabilitySource="fixture";vision=$true;visionSource="fixture";supportedContexts=@("default");supportedEfforts=$supported[$name]}
        $aliases[$name]=@{artificialAnalysis=@{};liveBench=@{}}
        foreach($effort in $supported[$name]) {
            $aliases[$name].artificialAnalysis[$effort]="$name-$effort"
            $aliases[$name].liveBench[$effort]="$name-$effort"
        }
    }
    Write-ModelJsonAtomic (Join-Path $root "config\model-capabilities.json") @{schemaVersion=2;models=$caps}
    Write-ModelJsonAtomic (Join-Path $root "config\model-ranking-aliases.json") @{schemaVersion=2;aliases=$aliases}
    Write-ModelJsonAtomic (Join-Path $root "config\model-pricing-aliases.json") @{schemaVersion=1;aliases=@{alpha="Alpha";beta="Beta";gamma="Gamma"}}
    return $root
}
function Remove-E2ECostRoot($Root) {
    if (-not (Test-Path -LiteralPath $Root)) { return }
    Get-ChildItem -LiteralPath $Root -File -Recurse | Remove-Item
    foreach($dir in @("config","data","reports")) { if (Test-Path -LiteralPath (Join-Path $Root $dir)) { Remove-Item -LiteralPath (Join-Path $Root $dir) } }
    Remove-Item -LiteralPath $Root
}
function New-E2ECostSources {
    param([Parameter(Mandatory)][object[]]$UsageRows,[Parameter(Mandatory)][hashtable]$Coding)
    $script:e2eUsagePage=New-E2EUsagePage $UsageRows
    $components=Get-AAComponentData -ModelSlugs @($UsageRows[0].slug) -FetchText {param($u) @{status="ok";content=$script:e2eUsagePage}}
    $components.fetchedAtUtc="2026-09-22Z"
    $models=@{}
    foreach($slug in $Coding.Keys) { $models[$slug]=@{coding=$Coding[$slug]} }
    return @{
        artificialAnalysisComponents=$components
        liveBench=@{status="ok";sourceVersion="lb-v1";sourceDate="2026-09-22";fetchedAtUtc="2026-09-22Z";sourceUrl="https://example.test/lb";models=$models}
    }
}
function Get-E2EPendingCount($Result) {
    $pending=$Result.resolution.state.pending
    if ($null -eq $pending) { return 0 }
    return [int]$pending.count
}
function Get-E2EReportSection($Report,$Key) {
    $match=[regex]::Match($Report,"(?ms)^### $([regex]::Escape($Key))\r?\n.*?(?=^#{1,3} |\z)")
    if (-not $match.Success) { throw "The report has no section for $Key" }
    return $match.Value
}
$e2eRates='<table><tr><th>Model</th><th>Input</th><th>Output</th></tr><tr><td>Alpha</td><td>$1.50</td><td>$6.00</td></tr><tr><td>Beta</td><td>$1.50</td><td>$6.00</td></tr><tr><td>Gamma</td><td>$1.00</td><td>$4.00</td></tr></table>'
$e2eFetch={param($u) @{status="ok";content=$e2eRates}}
# xhigh: 1.0e9 input / 51.56e6 output (30e6 of it reasoning); max: 1.2e9 input / 103.12e6 output (80e6 of it reasoning).
$e2eAlphaRows=@(
    @{slug="alpha-xhigh";name="Alpha (xhigh)";effort="xhigh";release="alpha";input=1000000000;perTask=10000;reasoning=30000000}
    @{slug="alpha-max";name="Alpha (max)";effort="max";release="alpha";input=1200000000;perTask=20000;reasoning=80000000}
)
Run-Test "Review reads captured AA usage end to end: the lower-consumption effort is confirmed, forced and written to a temporary profile only" {
    $workspaceProfiles=Join-Path $repo "task-profiles.json"
    $workspaceHash=(Get-FileHash -LiteralPath $workspaceProfiles -Algorithm SHA256).Hash
    $roots=@()
    try {
        $root=New-E2ECostRoot -Model alpha -Effort max
        $roots+=$root
        $profilePath=Join-Path $root "task-profiles.json"
        $sources=New-E2ECostSources -UsageRows $e2eAlphaRows -Coding @{"alpha-xhigh"=80;"alpha-max"=82;"beta-high"=50}
        $options=@{RepoRoot=$root;Availability=@{models=@("alpha","beta");verified=$true;source="fixture"};Sources=$sources;FetchPricing=$e2eFetch;NowUtc=[datetime]"2026-09-22Z"}
        $before=Get-Content -LiteralPath $profilePath -Raw
        $first=Invoke-TaskProfileReview @options
        $quick=$first.results | Where-Object key -eq "quick"
        $basis=$quick.selection.costBasis
        Assert-True ($basis.mode -eq "measured_workload" -and $basis.workloadId -eq "aa-intelligence-index-canonical-v1" -and
            $basis.competitorCount -eq 2 -and $basis.unavailable.Count -eq 0) "The normal review did not use the captured usage (an unqualified model without usage must not disable it)"
        Assert-True ($quick.selection.winner.model -eq "alpha" -and $quick.selection.winner.effort -eq "xhigh" -and
            $quick.selection.qualityWinner.effort -eq "max") "Lower consumption did not beat the higher-scoring effort at one GitHub rate"
        Assert-True ($quick.selection.candidateReferenceAic -eq 180936d -and $quick.selection.incumbentReferenceAic -eq 241872d) "Wrong repriced benchmark-workload AIC: $($quick.selection.candidateReferenceAic) / $($quick.selection.incumbentReferenceAic)"
        Assert-True (-not $quick.resolution.applied -and (Get-E2EPendingCount $quick) -eq 1 -and (Get-Content -LiteralPath $profilePath -Raw) -ceq $before) "The first observation was applied or counted twice"
        $snapshot=Get-Content -LiteralPath (Join-Path $root "data\model-ranking-snapshot.json") -Raw | ConvertFrom-Json
        $captured=$snapshot.sources.artificialAnalysisComponents.usage.models.'alpha-xhigh'
        Assert-True ($captured.inputTokens -eq 1000000000 -and $captured.outputTokens -eq 51560000 -and $captured.reasoningTokens -eq 30000000 -and
            $captured.status -eq "verified") "Captured usage was not persisted with the source"
        $report=Get-Content (Join-Path $root "reports\task-profile-review.md") -Raw
        $section=Get-E2EReportSection $report "quick"
        Assert-True ($report.Contains("Measured-cost basis: enabled")) "The policy section omitted the measured-cost basis"
        foreach($term in @("**Cost basis: measured benchmark workload**","Benchmark-workload usage: candidate **180936 AIC**; incumbent **241872 AIC**.",
            "not predicted Copilot task spend","alpha / xhigh / default")) {
            Assert-True ($section.Contains($term)) "The quick section omitted the measured basis: $term"
        }
        Assert-True (-not $section.Contains("Reference usage: candidate")) "The quick profile reported the fixed basket while ranking on measured usage"
        $same=Invoke-TaskProfileReview @options
        Assert-True (-not (($same.results | Where-Object key -eq "quick").resolution.applied) -and (Get-E2EPendingCount ($same.results | Where-Object key -eq "quick")) -eq 1) "Retrieving the same usage again manufactured a confirmation"
        $sources.liveBench.models["beta-high"].coding=49
        $second=Invoke-TaskProfileReview @options
        $quick=$second.results | Where-Object key -eq "quick"
        Assert-True ($quick.resolution.applied -and $quick.selection.costBasis.mode -eq "measured_workload") "A distinct observation did not confirm the measured decision"
        $saved=@(Get-Content -LiteralPath $profilePath -Raw | ConvertFrom-Json)
        $savedQuick=$saved | Where-Object key -eq "quick"
        Assert-True ($savedQuick.model -eq "alpha" -and $savedQuick.effort -eq "xhigh" -and $savedQuick.context -eq "default" -and $savedQuick.label -eq "Preserve me" -and
            ($saved | Where-Object key -eq "review").model -eq "beta" -and ($saved | Where-Object key -eq "review").effort -eq "high") "The written task profile did not take the lower-consumption pair together"
        Assert-True ($quick.resolution.state.activeOverride.effort -eq "xhigh") "Active state lost the measured effort"
        $adopted=Invoke-TaskProfileReview @options
        $quick=$adopted.results | Where-Object key -eq "quick"
        Assert-True (-not $quick.resolution.applied -and $quick.finalConfiguration.effort -eq "xhigh" -and
            $quick.selection.candidateReferenceAic -eq 180936d -and $quick.selection.incumbentReferenceAic -eq 180936d) "The adopted measured configuration churned or compared unlike costs"
        $forcedRoot=New-E2ECostRoot -Model alpha -Effort max
        $roots+=$forcedRoot
        $forcedSources=New-E2ECostSources -UsageRows $e2eAlphaRows -Coding @{"alpha-xhigh"=80;"alpha-max"=82;"beta-high"=50}
        $forced=Invoke-TaskProfileReview -RepoRoot $forcedRoot -Availability @{models=@("alpha","beta");verified=$true;source="fixture"} -Sources $forcedSources `
            -FetchPricing $e2eFetch -ForceImmediateApply -NowUtc ([datetime]"2026-09-22Z")
        $forcedQuick=@(Get-Content -LiteralPath (Join-Path $forcedRoot "task-profiles.json") -Raw | ConvertFrom-Json) | Where-Object key -eq "quick"
        Assert-True (($forced.results | Where-Object key -eq "quick").resolution.applied -and $forcedQuick.model -eq "alpha" -and $forcedQuick.effort -eq "xhigh") "Approved force did not write the measured pair"
        Assert-True ((Get-FileHash -LiteralPath $workspaceProfiles -Algorithm SHA256).Hash -eq $workspaceHash) "The real workspace task-profiles.json was touched"
    } finally {
        foreach($created in $roots) { Remove-E2ECostRoot $created }
    }
}
Run-Test "Review falls back to the fixed basket for the whole profile when a qualified configuration has no captured usage" {
    $roots=@()
    try {
        $root=New-E2ECostRoot -Model alpha -Effort max
        $roots+=$root
        $sources=New-E2ECostSources -UsageRows $e2eAlphaRows -Coding @{"alpha-xhigh"=80;"alpha-max"=82;"beta-high"=50;"gamma-high"=81}
        $run=Invoke-TaskProfileReview -RepoRoot $root -Availability @{models=@("alpha","beta","gamma");verified=$true;source="fixture"} -Sources $sources `
            -FetchPricing $e2eFetch -ForceImmediateApply -NowUtc ([datetime]"2026-09-22Z")
        $quick=$run.results | Where-Object key -eq "quick"
        $basis=$quick.selection.costBasis
        Assert-True ($basis.mode -eq "fixed_basket" -and $basis.fallback -and $basis.reasons -contains "usage_missing" -and $basis.competitorCount -eq 3 -and
            $basis.unavailable.Count -eq 1 -and $basis.unavailable[0].model -eq "gamma") "A qualified configuration without usage was dropped instead of triggering the profile fallback"
        Assert-True ($quick.selection.winner.model -eq "gamma" -and $quick.selection.candidateReferenceAic -eq 140 -and $quick.selection.incumbentReferenceAic -eq 210) "The fixed basket did not rank the whole qualified pool"
        $saved=@(Get-Content -LiteralPath (Join-Path $root "task-profiles.json") -Raw | ConvertFrom-Json) | Where-Object key -eq "quick"
        Assert-True ($quick.resolution.applied -and $saved.model -eq "gamma" -and $saved.effort -eq "high") "The forced fixed-basket decision was not written"
        $section=Get-E2EReportSection (Get-Content (Join-Path $root "reports\task-profile-review.md") -Raw) "quick"
        foreach($term in @("**Cost basis: fixed reference basket (profile fallback).**","usage_missing","gamma / high / default (usage_missing)","never mixed","Reference usage: candidate **140 AIC**; incumbent **210 AIC**.")) {
            Assert-True ($section.Contains($term)) "The quick section omitted the fallback basis: $term"
        }
        Assert-True (-not $section.Contains("Benchmark-workload usage: candidate")) "A fallback profile reported measured costs"
    } finally {
        foreach($created in $roots) { Remove-E2ECostRoot $created }
    }
}
Run-Test "Cached usage is never measured evidence, and returning to the same fresh usage cannot manufacture a confirmation" {
    $roots=@()
    try {
        $root=New-E2ECostRoot -Model alpha -Effort max
        $roots+=$root
        $profilePath=Join-Path $root "task-profiles.json"
        $sources=New-E2ECostSources -UsageRows $e2eAlphaRows -Coding @{"alpha-xhigh"=80;"alpha-max"=82;"beta-high"=50}
        $options=@{RepoRoot=$root;Availability=@{models=@("alpha","beta");verified=$true;source="fixture"};FetchPricing=$e2eFetch;NowUtc=[datetime]"2026-09-22Z"}
        $before=Get-Content -LiteralPath $profilePath -Raw
        $measured=Invoke-TaskProfileReview @options -Sources $sources
        $quick=$measured.results | Where-Object key -eq "quick"
        Assert-True ($quick.selection.costBasis.mode -eq "measured_workload" -and $quick.selection.winner.effort -eq "xhigh" -and
            (Get-E2EPendingCount $quick) -eq 1) "Fixture should start with a measured xhigh candidate awaiting confirmation"
        $outageSources=@{artificialAnalysisComponents=@{status="error";message="AA HTTP503"};liveBench=$sources.liveBench}
        $outage=Invoke-TaskProfileReview @options -Sources $outageSources
        $quick=$outage.results | Where-Object key -eq "quick"
        Assert-True ($outage.snapshot.sources.artificialAnalysisComponents.status -eq "cached" -and
            $outage.snapshot.sources.artificialAnalysisComponents.usage.models["alpha-xhigh"].inputTokens -eq 1000000000) "The outage did not fall back to the cached component source"
        Assert-True ($quick.selection.costBasis.mode -eq "fixed_basket" -and $quick.selection.costBasis.fallback -and
            $quick.selection.costBasis.reasons -contains "usage_source_cached") "Cached usage was treated as fresh measured evidence"
        Assert-True ($quick.selection.winner.effort -eq "max" -and $quick.selection.candidateReferenceAic -eq 210 -and $quick.selection.incumbentReferenceAic -eq 210 -and
            -not $quick.resolution.applied -and (Get-E2EPendingCount $quick) -eq 0 -and (Get-Content -LiteralPath $profilePath -Raw) -ceq $before) "The fixed-basket fallback moved the profile or kept the measured pending decision"
        $restored=Invoke-TaskProfileReview @options -Sources $sources
        $quick=$restored.results | Where-Object key -eq "quick"
        Assert-True ($quick.selection.costBasis.mode -eq "measured_workload" -and $quick.selection.winner.effort -eq "xhigh" -and
            -not $quick.resolution.applied -and (Get-E2EPendingCount $quick) -eq 0) "Returning to the same fresh usage manufactured a distinct observation"
        $sources.liveBench.models["beta-high"].coding=49
        $distinct=Invoke-TaskProfileReview @options -Sources $sources
        $quick=$distinct.results | Where-Object key -eq "quick"
        Assert-True (-not $quick.resolution.applied -and (Get-E2EPendingCount $quick) -eq 1 -and (Get-Content -LiteralPath $profilePath -Raw) -ceq $before) "The first distinct observation after the fallback was applied or miscounted"
        $sources.liveBench.models["beta-high"].coding=48
        $confirmed=Invoke-TaskProfileReview @options -Sources $sources
        $quick=$confirmed.results | Where-Object key -eq "quick"
        $saved=@(Get-Content -LiteralPath $profilePath -Raw | ConvertFrom-Json) | Where-Object key -eq "quick"
        Assert-True ($quick.resolution.applied -and $quick.selection.costBasis.mode -eq "measured_workload" -and $saved.model -eq "alpha" -and $saved.effort -eq "xhigh") "The second distinct observation did not confirm the measured pair"
    } finally {
        foreach($created in $roots) { Remove-E2ECostRoot $created }
    }
}
if ($script:Failed) { exit 1 }
