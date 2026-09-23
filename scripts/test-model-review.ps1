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
            one=@{artificialAnalysis=@{medium="one-medium";high="one-high";low="one-low"};liveBench=@{high="one-high"}}
            two=@{artificialAnalysis=@{medium="two-medium";high="two-high";low="two-low"};liveBench=@{high="two-high"}}
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
            "one-high"=@{instructionFollowing=90};"two-high"=@{instructionFollowing=85}
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
            metric="codingIndex";effort="medium";alias=$model;sourceVersion="v1";sourceDate=$null;
            publicationAgeUnknown=$true;cached=$false;harness="fixture"}
    })
    foreach ($record in @($records)) {
        $reasoning=$record | Select-Object *;$reasoning.metric="intelligenceIndex";$reasoning.score=80
        $lcr=$record | Select-Object *;$lcr.source="artificialAnalysisComponents";$lcr.metric="lcr";$lcr.score=0.8
        $records+=@($reasoning,$lcr)
    }
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
                liveBench=@{high="one-high"}}
            "gpt-two"=@{liveBench=@{xhigh="two-xhigh"}}
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
                "one-low"=@{codingIndex=80};"one-medium"=@{codingIndex=80};"one-high"=@{codingIndex=80}
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
            Assert-True (@($agentic.verdicts | Where-Object modelId -eq "gpt-two").Count -eq 3) "Configuration eligibility was flattened"
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
            Assert-True ($agentic.resolution.applied -eq $matched) "Legacy/general coding or unmatched incumbent authorized fallback"
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
Run-Test "Nine-role offline review confirms binding changes and preserves good component caches" {
    $root=Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    foreach($dir in @("config","data","reports")) { New-Item -ItemType Directory (Join-Path $root $dir) -Force | Out-Null }
    try {
        Copy-Item (Join-Path $repo "config\model-policy.json") (Join-Path $root "config")
        $p=Get-ModelPolicyConfig (Join-Path $root "config\model-policy.json")
        $profiles=@(foreach($key in $p.selectionPolicy.profiles.Keys) {
            @{key=$key;model="gpt-one";effort=$p.selectionPolicy.profiles[$key].configurationSelection.allowedEfforts[0];context="default"}
        })
        Write-ModelJsonAtomic (Join-Path $root "task-profiles.json") $profiles
        $caps=@{};$aliases=@{};$aaModels=@{};$componentModels=@{};$agentModels=@{}
        foreach($model in @("gpt-one","gpt-two")) {
            $caps[$model]=@{asOf="2026-09-22";capabilitySource="fixture";vision=$true;visionSource="fixture";
                supportedContexts=@("default");supportedEfforts=@("low","medium","high")}
            $aliases[$model]=@{artificialAnalysis=@{}}
            foreach($effort in @("low","medium","high")) {
                $slug="$model-$effort";$aliases[$model].artificialAnalysis[$effort]=$slug
                $score=if($model -eq "gpt-two"){0.9}else{0.7}
                $aaModels[$slug]=@{codingIndex=$score*100;intelligenceIndex=$score*100}
                $componentModels[$slug]=@{name=$model;effort=$effort;automationBench=$score;enterpriseOpsGym=$score;
                    lcr=0.7;ifbench=0.8;mmmuPro=0.6}
                if($effort -eq "high") { $agentModels[$slug]=New-NormalizedAgentFixture $slug "$model ($effort)" $score }
            }
        }
        Write-ModelJsonAtomic (Join-Path $root "config\model-capabilities.json") @{schemaVersion=2;models=$caps}
        Write-ModelJsonAtomic (Join-Path $root "config\model-ranking-aliases.json") @{schemaVersion=2;aliases=$aliases}
        Write-ModelJsonAtomic (Join-Path $root "config\model-pricing-aliases.json") @{schemaVersion=1;aliases=@{"gpt-one"="One";"gpt-two"="Two"}}
        $sources=@{}
        foreach($entry in @(@("artificialAnalysis",$aaModels),@("artificialAnalysisComponents",$componentModels),@("artificialAnalysisCodingAgents",$agentModels))) {
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
            $aaModels[$slug].codingIndex=91;$aaModels[$slug].intelligenceIndex=91
            $componentModels[$slug].automationBench=0.91
        }
        $agentModels["gpt-two-high"].codingAgentIndex=0.91
        $confirmed=Invoke-TaskProfileReview @options
        Assert-True (@($confirmed.results | Where-Object { $_.finalModel -eq "gpt-two" }).Count -eq 9 -and
            @($confirmed.results | Where-Object { $_.resolution.applied }).Count -eq 6) "Deciding changes failed to confirm remaining roles"
        $legacy=ConvertTo-CanonicalModelData $confirmed.snapshot
        $legacy.schemaVersion=3
        $legacy.sources.liveBench=@{status="ok";sourceDate="2026-06-25";fetchedAtUtc="2026-09-22Z";models=@{one=@{coding=99}}}
        Write-ModelJsonAtomic (Join-Path $root "data\model-ranking-snapshot.json") $legacy
        $sources.artificialAnalysisComponents=@{status="unavailable";message="malformed component observation"}
        foreach($slug in @($aaModels.Keys | Where-Object {$_ -like "gpt-one-*"})) { $aaModels[$slug].codingIndex=99 }
        $outage=Invoke-TaskProfileReview @options -ForceImmediateApply
        $mechanical=$outage.results | Where-Object key -eq mechanical
        $orchestrator=$outage.results | Where-Object key -eq orchestrator
        Assert-True ($mechanical.resolution.status -eq "retained_cached_evidence" -and $mechanical.finalModel -eq "gpt-two") "General coding replaced required workflow evidence"
        Assert-True (-not $orchestrator.resolution.applied -and $orchestrator.resolution.status -eq "retained_cached_evidence") "Cached workflow evidence authorized promotion"
        Assert-True ($outage.snapshot.sources.artificialAnalysisComponents.status -eq "cached" -and
            $outage.snapshot.sources.artificialAnalysisComponents.models["gpt-two-high"].automationBench -eq 0.91) "Malformed observation overwrote good component cache"
        Assert-True ($outage.snapshot.sources.liveBench.categoryCompletenessUnknown -and
            $null -eq $outage.snapshot.sources.liveBench.sourceDate -and $outage.snapshot.sources.liveBench.datasetVersion -eq "2026-06-25") "Legacy LB cache silently upgraded its dates or category completeness"
        $report=Get-Content (Join-Path $root "reports\task-profile-review.md") -Raw
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
if ($script:Failed) { exit 1 }
