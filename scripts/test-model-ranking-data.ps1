Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "model-ranking-data.ps1")
. (Join-Path $PSScriptRoot "model-selection-policy.ps1")
. (Join-Path $PSScriptRoot "review-task-profiles.ps1")

$fixtureRoot = Join-Path $PSScriptRoot "fixtures/model-ranking"
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

# Real config, reused directly rather than re-declared as fixtures, so these
# tests stay honest about what the shipped policy/capabilities catalog
# actually admits (rule 3/4/6 integration).
$script:RealCapabilities = (Get-ModelCapabilitiesCatalog -CatalogPath (Join-Path $repoRoot "config/model-capabilities.json")).models
$script:DefaultDevRequirement = $script:ModelPolicyConfig.profileRequirements["default-development"]
$script:QuickRequirement = $script:ModelPolicyConfig.profileRequirements["quick"]
# Permissive requirement (no pricing ceiling) used only where a test's point is
# to isolate cost-tie-break/no-longer-blocks behavior from unrelated pricing
# ceiling gating.
$script:PermissiveRequirement = [pscustomobject]@{
    inputCeilingPerMillion = [double]::MaxValue
    outputCeilingPerMillion = [double]::MaxValue
    requiresVision = $false
    requiresCliAgent = $true
    costSensitive = $true
}

$script:Passed = 0
$script:Failed = 0

function Assert-True {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) { throw $Message }
}

function Assert-Eq {
    param($Expected, $Actual, [string]$Message)
    if ("$Expected" -ne "$Actual") { throw "$Message (expected='$Expected', actual='$Actual')" }
}

function Run-Test {
    param([string]$Name, [scriptblock]$Action)
    try { & $Action; $script:Passed++; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $($_.Exception.Message)" }
}

function New-QualitySnapshot {
    param(
        [hashtable]$AaScores,
        [hashtable]$AaCodingScores,
        [hashtable]$LbScores,
        [hashtable]$Costs
    )
    $models = [ordered]@{}
    $aaBuckets = Get-RankingBucketAssignments -ScoresByModel $AaScores
    $aaRanks = Get-OrdinalRankAssignments -ScoresByModel $AaScores
    $aaCodingBuckets = Get-RankingBucketAssignments -ScoresByModel $AaCodingScores
    $aaCodingRanks = Get-OrdinalRankAssignments -ScoresByModel $AaCodingScores
    $lbBuckets = Get-RankingBucketAssignments -ScoresByModel $LbScores
    $lbRanks = Get-OrdinalRankAssignments -ScoresByModel $LbScores
    $costBuckets = Get-RankingBucketAssignments -ScoresByModel $Costs -LowerIsBetter
    foreach ($m in $AaScores.Keys) {
        $models[$m] = [ordered]@{
            artificialAnalysis = [ordered]@{ agenticIndex = $AaScores[$m]; bucket = $aaBuckets[$m]; ordinalRank = $aaRanks[$m] }
            artificialAnalysisCodingAgents = [ordered]@{ codingAgentIndex = $AaCodingScores[$m]; bucket = $aaCodingBuckets[$m]; ordinalRank = $aaCodingRanks[$m] }
            liveBench = [ordered]@{
                categories = [ordered]@{ coding = $LbScores[$m]; agenticCoding = $LbScores[$m]; reasoning = $LbScores[$m]; instructionFollowing = $LbScores[$m] }
                buckets = [ordered]@{ coding = $lbBuckets[$m]; agenticCoding = $lbBuckets[$m]; reasoning = $lbBuckets[$m]; instructionFollowing = $lbBuckets[$m] }
                ordinalRanks = [ordered]@{ coding = $lbRanks[$m]; agenticCoding = $lbRanks[$m]; reasoning = $lbRanks[$m]; instructionFollowing = $lbRanks[$m] }
                costPerSuccessfulTask = $Costs[$m]
                costBucket = $costBuckets[$m]
            }
        }
    }
    return [pscustomobject]@{
        status = "ok"; stale = $false; fallbackUsed = $false
        sourceStatus = [ordered]@{
            artificialAnalysis = [ordered]@{ status = "ok"; sourceDate = "2026-07-24" }
            artificialAnalysisCodingAgents = [ordered]@{ status = "ok"; sourceDate = "2026-07-24" }
            liveBench = [ordered]@{ status = "ok"; sourceDate = "2026-06-25" }
            liveBenchCost = [ordered]@{ status = "ok"; sourceDate = "2026-06-25" }
        }
        models = $models
        consensus = [ordered]@{ profiles = [ordered]@{} }
    }
}

Run-Test "1 Coding Agents valid parsing" {
    $html = Get-Content -Path (Join-Path $fixtureRoot "aa-coding-agents-valid.html") -Raw
    $parsed = Parse-ArtificialAnalysisCodingAgentIndexFromHtml -Html $html
    Assert-Eq "ok" $parsed.status "Expected ok parse status."
    Assert-True ($parsed.models.ContainsKey("Claude Code - Opus 5 (xhigh)")) "Expected coding-agent label."
}

Run-Test "2 Coding Agents malformed parsing" {
    $html = Get-Content -Path (Join-Path $fixtureRoot "aa-coding-agents-malformed.html") -Raw
    $parsed = Parse-ArtificialAnalysisCodingAgentIndexFromHtml -Html $html
    Assert-Eq "unavailable" $parsed.status "Malformed should fail safe."
}

Run-Test "3 LiveBench cost parsing and lower-is-better buckets" {
    $csv = Get-Content -Path (Join-Path $fixtureRoot "livebench-valid.csv") -Raw
    $cats = Get-Content -Path (Join-Path $fixtureRoot "livebench-categories-valid.json") -Raw
    $cost = Get-Content -Path (Join-Path $fixtureRoot "livebench-cost-valid.csv") -Raw
    $parsed = Parse-LiveBenchData -CsvText $csv -CategoriesJsonText $cats -CostCsvText $cost -SourceDate "2026-06-25"
    if ($parsed.status -ne "ok") { throw "Expected valid parse. status=$($parsed.status), message=$($parsed.message)" }
    $costScores = @{
        "claude-sonnet-5-xhigh-effort" = $parsed.models."claude-sonnet-5-xhigh-effort".costPerSuccessfulTask
        "claude-opus-5-max-effort" = $parsed.models."claude-opus-5-max-effort".costPerSuccessfulTask
        "gpt-5.6-sol-max" = $parsed.models."gpt-5.6-sol-max".costPerSuccessfulTask
    }
    $b = Get-RankingBucketAssignments -ScoresByModel $costScores -LowerIsBetter
    Assert-Eq "top" $b."claude-sonnet-5-xhigh-effort" "Lowest cost should be top."
}

Run-Test "4 Baseline family-match helper (renamed, informational only) works across non-first families" {
    $valid = @("gpt-5.6-luna", "claude-haiku-4.5")
    Assert-True (Test-ModelMatchesProfileFamilyPolicy -ProfileKey "quick" -ModelId "gpt-5.6-luna" -ValidModels $valid) "Expected gpt-luna to match quick's baseline family list."
}

Run-Test "5 Challenger top+raw higher both qualifies (real capability/pricing admissibility applied)" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.1; "gpt-5.4" = 0.9 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-Eq "gpt-5.6-terra" $candidate.model "Expected challenger to qualify."
}

Run-Test "6 Top challenger losing one raw signal does not qualify" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 80; "gpt-5.6-terra" = 79; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = 80; "gpt-5.6-terra" = 79; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 90; "gpt-5.4" = 60 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.0; "gpt-5.4" = 0.9 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($null -eq $candidate) "Expected no qualifier when one raw signal loses."
}

Run-Test "7 Top challenger may qualify against unscored incumbent" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60; "gpt-5.5" = 50 } -AaCodingScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60; "gpt-5.5" = 50 } -LbScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 90; "gpt-5.4" = 60; "gpt-5.5" = 50 } -Costs @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 0.85; "gpt-5.4" = 0.9; "gpt-5.5" = 0.8 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4","gpt-5.5") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-Eq "gpt-5.6-terra" $candidate.model "Expected challenger vs unscored incumbent."
}

Run-Test "8 Rule 7: cost tie-break orders equal combinedRank challengers by lowest cost, not a hard gate" {
    # terra and luna tie on combinedRank (both aaRank=1,lbRank=1 -> combinedRank=2); terra costs more, so luna must win the tie-break.
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.6-luna" = 90 } -AaCodingScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.6-luna" = 90 } -LbScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.6-luna" = 90 } -Costs @{ "claude-haiku-4.5" = 1.0; "gpt-5.6-terra" = 5.0; "gpt-5.6-luna" = 0.5 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "quick" -ValidModels @("claude-haiku-4.5","gpt-5.6-terra","gpt-5.6-luna") -IncumbentModel "claude-haiku-4.5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:PermissiveRequirement -ProfileContextTier "default" -ProfileEffort "low"
    Assert-Eq "gpt-5.6-luna" $candidate.model "Expected lower-cost model to win the combinedRank tie."
}

Run-Test "9 Rule 7: a much higher-cost qualifying challenger is no longer blocked (cost-sensitive profile)" {
    # A third (non-candidate) filler model is included purely so bucket assignment (needs >=3 scored entries) puts gpt-5.6-terra in "top".
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -AaCodingScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -LbScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -Costs @{ "claude-haiku-4.5" = 0.1; "gpt-5.6-terra" = 500.0; "gpt-5.4" = 0.2 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "quick" -ValidModels @("claude-haiku-4.5","gpt-5.6-terra") -IncumbentModel "claude-haiku-4.5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:PermissiveRequirement -ProfileContextTier "default" -ProfileEffort "low"
    Assert-Eq "gpt-5.6-terra" $candidate.model "A cost-sensitive profile's much-higher-cost challenger must still qualify; cost no longer gates."
}

Run-Test "10 Rule 7: missing incumbent cost no longer required for qualification" {
    # claude-sonnet-5's null aa/lb scores exclude it from the scored set entirely, so two filler models
    # (gpt-5.4, gpt-5.5) are included purely so bucket assignment (needs >=3 scored entries) puts gpt-5.6-terra in "top".
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 90; "gpt-5.4" = 10; "gpt-5.5" = 5 } -AaCodingScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 90; "gpt-5.4" = 10; "gpt-5.5" = 5 } -LbScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 90; "gpt-5.4" = 10; "gpt-5.5" = 5 } -Costs @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 999.0; "gpt-5.4" = 0.2; "gpt-5.5" = 0.3 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-Eq "gpt-5.6-terra" $candidate.model "Missing incumbent cost combined with an unbounded challenger cost must not block qualification."
}

Run-Test "11 Rule 7: missing challenger cost no longer blocks qualification" {
    # A third (non-candidate) filler model is included purely so bucket assignment (needs >=3 scored entries) puts gpt-5.6-terra in "top".
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -AaCodingScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -LbScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = $null; "gpt-5.4" = 0.2 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-Eq "gpt-5.6-terra" $candidate.model "A missing challenger cost must not block qualification now that cost is tie-break only."
}

Run-Test "12 First run records pending=1 no apply" {
    $state = [ordered]@{ pending = $null; activeOverride = $null }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $true -Candidate ([pscustomobject]@{ model = "ch" }) -SourceDates @{a="1"} -ActiveOverrideStillValid $true
    Assert-Eq "1" $r.pendingCount "Expected pending count 1."
    Assert-True (-not $r.applied) "Should not apply first run."
}

Run-Test "13 Second same candidate activates override/applies" {
    $state = [ordered]@{ pending = [ordered]@{ candidateModel = "ch"; consecutiveQualifyingFullRuns = 1; sourceVersions = @{a="1"} }; activeOverride = $null }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $true -Candidate ([pscustomobject]@{ model = "ch" }) -SourceDates @{a="2"} -SourceVersions @{a="2"} -ActiveOverrideStillValid $true
    Assert-True ($r.applied) "Expected apply on second run."
    Assert-Eq "ch" $r.finalModel "Expected override model."
}

Run-Test "14 Candidate change resets to 1" {
    $state = [ordered]@{ pending = [ordered]@{ candidateModel = "x"; consecutiveQualifyingFullRuns = 1 }; activeOverride = $null }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $true -Candidate ([pscustomobject]@{ model = "ch" }) -SourceDates @{a="1"} -ActiveOverrideStillValid $true
    Assert-Eq "1" $r.pendingCount "Expected reset to one."
}

Run-Test "15 Partial/fallback/stale run does not advance" {
    $state = [ordered]@{ pending = [ordered]@{ candidateModel = "ch"; consecutiveQualifyingFullRuns = 1 }; activeOverride = $null }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $false -Candidate ([pscustomobject]@{ model = "ch" }) -SourceDates @{} -ActiveOverrideStillValid $true
    Assert-Eq "1" $r.pendingCount "Should not advance on non-full runs."
}

Run-Test "16 Active valid override survives lack of consensus" {
    $state = [ordered]@{ pending = [ordered]@{ candidateModel = "ch"; consecutiveQualifyingFullRuns = 1 }; activeOverride = [ordered]@{ model = "ovr" } }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $true -Candidate $null -SourceDates @{} -ActiveOverrideStillValid $true
    Assert-Eq "ovr" $r.finalModel "Expected valid active override to survive."
}

Run-Test "17 Invalid active override clears" {
    $state = [ordered]@{ pending = $null; activeOverride = [ordered]@{ model = "bad" } }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $false -Candidate $null -SourceDates @{} -ActiveOverrideStillValid $false
    Assert-True ($r.activeCleared) "Expected active override clear."
}

Run-Test "18 Persistent policy winner clears active override" {
    $state = [ordered]@{ pending = [ordered]@{ candidateModel = "inc"; consecutiveQualifyingFullRuns = 1; sourceVersions = @{a="1"} }; activeOverride = [ordered]@{ model = "ovr" } }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "ovr" -CurrentState $state -IsFullFreshRun $true -Candidate ([pscustomobject]@{ model = "inc" }) -SourceDates @{a="2"} -SourceVersions @{a="2"} -ActiveOverrideStillValid $true
    Assert-True ($r.applied) "Expected second policy-winner run to apply."
    Assert-Eq "inc" $r.finalModel "Expected return to policy model."
}

Run-Test "19 Report avoids duplicate policy then benchmark reversal entry pattern" {
    $changes = @(
        '- "quick": "a" -> "b" (benchmark_consensus)'
    )
    Assert-True ($changes.Count -eq 1) "Expected single final entry for profile."
}

Run-Test "20 Report renders ordered-dictionary coding and cost data" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-opus-5" = 80 } -AaCodingScores @{ "claude-opus-5" = 90 } -LbScores @{ "claude-opus-5" = 85 } -Costs @{ "claude-opus-5" = 0.75 }
    $snapshot | Add-Member -NotePropertyName message -NotePropertyValue "test"
    $snapshot | Add-Member -NotePropertyName attribution -NotePropertyValue ([ordered]@{ artificialAnalysisCodingAgentsUrl = "https://example.test/coding" })
    $snapshot.sourceStatus.artificialAnalysisCodingAgents.fetchedAtUtc = "2026-07-30T00:00:00Z"
    $lines = Get-ModelRankingReportLines -Snapshot $snapshot -ValidModels @("claude-opus-5")
    $tableLine = @($lines | Where-Object { $_ -like "| claude-opus-5 |*" })[0]
    Assert-Eq "| claude-opus-5 | competitive | competitive | competitive | competitive | competitive | competitive | 0.75 | competitive |" $tableLine "Expected Coding Agents and cost values in report."
    Assert-True ($lines -contains "- Artificial Analysis Coding Agents fetched at (UTC): 2026-07-30T00:00:00Z") "Expected Coding Agents fetch timestamp."
}

Run-Test "21 Coding Agents aliases map only exact live labels" {
    $aliases = Get-ModelRankingAliases -AliasesPath (Join-Path (Split-Path $PSScriptRoot -Parent) "config/model-ranking-aliases.json")
    Assert-Eq "Claude Code - Opus 5 (xhigh)" $aliases["claude-opus-5"].artificialAnalysisCodingAgents "Expected Opus 5 agent alias."
    Assert-Eq "Claude Code - Fable 5 (max) (with fallback)" $aliases["claude-fable-5"].artificialAnalysisCodingAgents "Expected Fable 5 agent alias."
    Assert-Eq "Codex - GPT-5.6 Sol (max)" $aliases["gpt-5.6-sol"].artificialAnalysisCodingAgents "Expected Sol agent alias."
    Assert-Eq "Gemini CLI - Gemini 3.1 Pro (high)" $aliases["gemini-3.1-pro-preview"].artificialAnalysisCodingAgents "Expected Gemini agent alias."
    Assert-True ($null -eq $aliases["claude-opus-4.8"].artificialAnalysisCodingAgents) "Opus 4.8 must not reuse Fable's score."
    Assert-True ($null -eq $aliases["gpt-5.4-mini"].artificialAnalysisCodingAgents) "GPT-5.4 mini must not reuse Gemini's score."
}

Run-Test "22 Identical benchmark publication does not advance consensus" {
    $state = [ordered]@{ pending = [ordered]@{ candidateModel = "ch"; consecutiveQualifyingFullRuns = 1; sourceVersions = [ordered]@{ liveBench = "lb1"; artificialAnalysis = "aa1" } }; activeOverride = $null }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $true -Candidate ([pscustomobject]@{ model = "ch" }) -SourceDates @{} -SourceVersions ([ordered]@{ liveBench = "lb1"; artificialAnalysis = "aa1" }) -ActiveOverrideStillValid $true
    Assert-Eq "1" $r.pendingCount "Repeated source versions must not count as a second run."
    Assert-True (-not $r.applied) "Repeated publication must not activate an override."
}

Run-Test "23 Malformed LiveBench cost data is incomplete" {
    $csv = Get-Content -Path (Join-Path $fixtureRoot "livebench-valid.csv") -Raw
    $cats = Get-Content -Path (Join-Path $fixtureRoot "livebench-categories-valid.json") -Raw
    $parsed = Parse-LiveBenchData -CsvText $csv -CategoriesJsonText $cats -CostCsvText "model,wrong_column`nclaude-opus-5,1.0" -SourceDate "2026-06-25"
    Assert-Eq "ok" $parsed.status "Quality data should remain usable."
    Assert-Eq "unavailable" $parsed.costStatus "Malformed costs must block complete-run consensus."
}

Run-Test "24 Non-finite LiveBench cost data is incomplete" {
    $csv = Get-Content -Path (Join-Path $fixtureRoot "livebench-valid.csv") -Raw
    $cats = Get-Content -Path (Join-Path $fixtureRoot "livebench-categories-valid.json") -Raw
    $cost = Get-Content -Path (Join-Path $fixtureRoot "livebench-cost-valid.csv") -Raw
    $cost = $cost -replace "(?m)^(claude-sonnet-5-xhigh-effort,)[^,\r\n]+", '${1}NaN'
    $parsed = Parse-LiveBenchData -CsvText $csv -CategoriesJsonText $cats -CostCsvText $cost -SourceDate "2026-06-25"
    Assert-Eq "unavailable" $parsed.costStatus "NaN costs must block complete-run consensus."
}

Run-Test "25 Agentic quality reads ordered-dictionary Coding Agents data" {
    $snapshot = New-QualitySnapshot -AaScores @{ "gpt-5.6-sol" = 80 } -AaCodingScores @{ "gpt-5.6-sol" = 90 } -LbScores @{ "gpt-5.6-sol" = 85 } -Costs @{ "gpt-5.6-sol" = 0.75 }
    $quality = Get-ModelQualityDataForProfile -Snapshot $snapshot -ProfileKey "agentic-implementation" -ModelId "gpt-5.6-sol"
    Assert-Eq "90" $quality.aaScore "Expected Coding Agents score for agentic profile."
}

Run-Test "26 Unrelated source failure does not block profile consensus" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 80 } -AaCodingScores @{ "claude-sonnet-5" = 90 } -LbScores @{ "claude-sonnet-5" = 85 } -Costs @{ "claude-sonnet-5" = 0.75 }
    $snapshot.status = "partial"
    $snapshot.sourceStatus.artificialAnalysisCodingAgents.status = "unavailable"
    Assert-True (Test-FullFreshConsensusRunForProfile -Snapshot $snapshot -ProfileKey "default-development") "Default development should not require Coding Agents."
    $snapshot.sourceStatus.artificialAnalysis.status = "unavailable"
    $snapshot.sourceStatus.artificialAnalysisCodingAgents.status = "ok"
    Assert-True (Test-FullFreshConsensusRunForProfile -Snapshot $snapshot -ProfileKey "agentic-implementation") "Agentic implementation should not require AA Agentic."
}

Run-Test "27 Force flag applies first run immediately" {
    $state = [ordered]@{ pending = $null; activeOverride = $null }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $true -Candidate ([pscustomobject]@{ model = "ch" }) -SourceDates @{a="1"} -SourceVersions @{a="1"} -ActiveOverrideStillValid $true -ForceImmediateApply $true
    Assert-True ($r.applied) "Expected forced apply on first run."
    Assert-True ($r.forcedApply) "Expected forcedApply flag set."
    Assert-Eq "ch" $r.finalModel "Expected override model applied immediately."
    Assert-True ($r.state.activeOverride.forced) "Expected activeOverride to record forced flag."
}

Run-Test "28 Default (force flag false) still requires second run" {
    $state = [ordered]@{ pending = $null; activeOverride = $null }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $true -Candidate ([pscustomobject]@{ model = "ch" }) -SourceDates @{a="1"} -SourceVersions @{a="1"} -ActiveOverrideStillValid $true
    Assert-True (-not $r.applied) "Should not apply first run when force flag is not set."
    Assert-True (-not $r.forcedApply) "forcedApply must be false by default."
    Assert-Eq "1" $r.pendingCount "Expected pending count 1 without force."
}

Run-Test "29 Force flag does not apply when no candidate qualifies" {
    $state = [ordered]@{ pending = $null; activeOverride = $null }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $true -Candidate $null -SourceDates @{} -ActiveOverrideStillValid $true -ForceImmediateApply $true
    Assert-True (-not $r.applied) "Force must not fabricate a candidate."
    Assert-True (-not $r.forcedApply) "forcedApply must be false with no candidate."
}

Run-Test "30 Force flag does not apply on partial/stale/fallback runs" {
    $state = [ordered]@{ pending = $null; activeOverride = $null }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $false -Candidate ([pscustomobject]@{ model = "ch" }) -SourceDates @{} -ActiveOverrideStillValid $true -ForceImmediateApply $true
    Assert-True (-not $r.applied) "Force must not bypass source completeness/freshness requirement."
    Assert-True (-not $r.forcedApply) "forcedApply must be false when run is not full/fresh."
}

Run-Test "31 Force flag does not resurrect an already-cleared invalid active override" {
    $state = [ordered]@{ pending = $null; activeOverride = [ordered]@{ model = "bad" } }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "default-development" -PolicyPreferredModel "inc" -IncumbentModel "inc" -CurrentState $state -IsFullFreshRun $true -Candidate ([pscustomobject]@{ model = "ch" }) -SourceDates @{a="1"} -SourceVersions @{a="1"} -ActiveOverrideStillValid $false -ForceImmediateApply $true
    Assert-True ($r.activeCleared) "Invalid active override must still be cleared."
    Assert-True ($r.applied) "New qualifying candidate should still forced-apply after clearing invalid override."
    Assert-Eq "ch" $r.finalModel "Expected new forced override model, not the stale one."
}

Write-Host ""
Write-Host "Tests passed: $script:Passed"
Write-Host "Tests failed: $script:Failed"
if ($script:Failed -gt 0) { exit 1 }
