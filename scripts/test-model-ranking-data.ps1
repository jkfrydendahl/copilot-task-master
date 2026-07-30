Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "model-ranking-data.ps1")
. (Join-Path $PSScriptRoot "model-selection-policy.ps1")
. (Join-Path $PSScriptRoot "review-task-profiles.ps1")

$fixtureRoot = Join-Path $PSScriptRoot "fixtures/model-ranking"

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

Run-Test "4 Shared family eligibility works across non-first families" {
    $valid = @("gpt-5.6-luna", "claude-haiku-4.5")
    Assert-True (Test-ModelEligibleForProfilePolicy -ProfileKey "quick" -ModelId "gpt-5.6-luna" -ValidModels $valid) "Expected gpt-luna eligible for quick."
}

Run-Test "5 Challenger top+raw higher both qualifies" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.1; "gpt-5.4" = 0.9 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot
    Assert-Eq "gpt-5.6-terra" $candidate.model "Expected challenger to qualify."
}

Run-Test "6 Top challenger losing one raw signal does not qualify" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 80; "gpt-5.6-terra" = 79; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = 80; "gpt-5.6-terra" = 79; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 90; "gpt-5.4" = 60 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.0; "gpt-5.4" = 0.9 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot
    Assert-True ($null -eq $candidate) "Expected no qualifier when one raw signal loses."
}

Run-Test "7 Top challenger may qualify against unscored incumbent" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60; "gpt-5.5" = 50 } -AaCodingScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60; "gpt-5.5" = 50 } -LbScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 90; "gpt-5.4" = 60; "gpt-5.5" = 50 } -Costs @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 0.85; "gpt-5.4" = 0.9; "gpt-5.5" = 0.8 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4","gpt-5.5") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot
    Assert-Eq "gpt-5.6-terra" $candidate.model "Expected challenger vs unscored incumbent."
}

Run-Test "8 Cost-sensitive threshold blocks higher cost" {
    $inc = [pscustomobject]@{ cost = 1.0; costBucket = "competitive" }
    $chg = [pscustomobject]@{ cost = 1.1; costBucket = "competitive" }
    Assert-True (-not (Test-CostGuardrail -ProfileKey "quick" -IncumbentQuality $inc -ChallengerQuality $chg)) "quick requires <= incumbent cost."
}

Run-Test "9 General threshold allows <=1.5x and blocks above" {
    $inc = [pscustomobject]@{ cost = 1.0; costBucket = "competitive" }
    $ok = [pscustomobject]@{ cost = 1.5; costBucket = "competitive" }
    $bad = [pscustomobject]@{ cost = 1.51; costBucket = "competitive" }
    Assert-True (Test-CostGuardrail -ProfileKey "default-development" -IncumbentQuality $inc -ChallengerQuality $ok) "1.5x should pass."
    Assert-True (-not (Test-CostGuardrail -ProfileKey "default-development" -IncumbentQuality $inc -ChallengerQuality $bad)) "Above 1.5x should fail."
}

Run-Test "10 Missing incumbent cost requires challenger not highest-cost third" {
    $inc = [pscustomobject]@{ cost = $null; costBucket = "n/a" }
    $good = [pscustomobject]@{ cost = 1.0; costBucket = "competitive" }
    $bad = [pscustomobject]@{ cost = 2.0; costBucket = "lagging" }
    Assert-True (Test-CostGuardrail -ProfileKey "default-development" -IncumbentQuality $inc -ChallengerQuality $good) "competitive should pass."
    Assert-True (-not (Test-CostGuardrail -ProfileKey "default-development" -IncumbentQuality $inc -ChallengerQuality $bad)) "lagging should fail."
}

Run-Test "11 Missing challenger cost blocks" {
    $inc = [pscustomobject]@{ cost = 1.0; costBucket = "top" }
    $chg = [pscustomobject]@{ cost = $null; costBucket = "top" }
    Assert-True (-not (Test-CostGuardrail -ProfileKey "default-development" -IncumbentQuality $inc -ChallengerQuality $chg)) "Missing challenger cost must block."
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

Write-Host ""
Write-Host "Tests passed: $script:Passed"
Write-Host "Tests failed: $script:Failed"
if ($script:Failed -gt 0) { exit 1 }
