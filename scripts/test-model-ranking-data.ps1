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
        [hashtable]$Costs,
        # Models listed here get a null `alias` on their Artificial Analysis
        # sub-objects, i.e. "no AA alias was ever configured" (configuration
        # gap) rather than "AA was asked and returned nothing" (data gap).
        [string[]]$AaAliasNotConfigured = @(),
        # Models listed here get no `alias` member at all, emulating a legacy
        # snapshot written before the field existed.
        [string[]]$OmitAaAliasMember = @(),
        # Relative by default so the LiveBench-only-fallback staleness gate is
        # exercised deterministically instead of drifting with the wall clock.
        [string]$LiveBenchSourceDate = ((Get-Date).ToUniversalTime().AddDays(-10).ToString("yyyy-MM-dd"))
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
        $aaEntry = [ordered]@{ agenticIndex = $AaScores[$m]; bucket = $aaBuckets[$m]; ordinalRank = $aaRanks[$m] }
        $aaCodingEntry = [ordered]@{ codingAgentIndex = $AaCodingScores[$m]; bucket = $aaCodingBuckets[$m]; ordinalRank = $aaCodingRanks[$m] }
        if ($OmitAaAliasMember -notcontains $m) {
            $aliasValue = if ($AaAliasNotConfigured -contains $m) { $null } else { "$m-aa-alias" }
            $aaEntry["alias"] = $aliasValue
            $aaCodingEntry["alias"] = $aliasValue
        }
        $models[$m] = [ordered]@{
            artificialAnalysis = $aaEntry
            artificialAnalysisCodingAgents = $aaCodingEntry
            liveBench = [ordered]@{
                alias = "$m-lb-alias"
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
            liveBench = [ordered]@{ status = "ok"; sourceDate = $LiveBenchSourceDate }
            liveBenchCost = [ordered]@{ status = "ok"; sourceDate = $LiveBenchSourceDate }
        }
        models = $models
        consensus = [ordered]@{ profiles = [ordered]@{} }
    }
}

Run-Test "1 Artificial Analysis agentic API parsing succeeds with expected shape" {
    $apiJson = ConvertFrom-JsonAsHashtableCompat -JsonText (Get-Content -Path (Join-Path $fixtureRoot "aa-api-llms-models-valid.json") -Raw)
    $parsed = Get-ArtificialAnalysisAgenticIndexData -FetchJson {
        param($u, $envVar)
        return [pscustomobject]@{ status = "ok"; value = $apiJson; error = $null }
    }
    Assert-Eq "ok" $parsed.status "Expected successful parse from mocked API payload."
    Assert-True ($parsed.models.ContainsKey("gpt-5-6-sol")) "Expected model map to be keyed by API slug."
    Assert-Eq "71.8" $parsed.models["gpt-5-6-sol"].agenticIndex "Expected parsed agentic index value."
    $aliases = Get-ModelRankingAliases -AliasesPath (Join-Path (Split-Path $PSScriptRoot -Parent) "config/model-ranking-aliases.json")
    foreach ($modelId in $aliases.Keys) {
        $entry = $aliases[$modelId]
        if ($null -ne $entry.artificialAnalysis) {
            Assert-True ($parsed.models.ContainsKey([string]$entry.artificialAnalysis)) "AA alias key mismatch for $modelId."
        }
    }
}

Run-Test "2 Coding Agents valid parsing" {
    $html = Get-Content -Path (Join-Path $fixtureRoot "aa-coding-agents-valid.html") -Raw
    $parsed = Parse-ArtificialAnalysisCodingAgentIndexFromHtml -Html $html
    Assert-Eq "ok" $parsed.status "Expected ok parse status."
    Assert-True ($parsed.models.ContainsKey("Claude Code - Opus 5 (xhigh)")) "Expected coding-agent label."
}

Run-Test "3 Coding Agents malformed parsing" {
    $html = Get-Content -Path (Join-Path $fixtureRoot "aa-coding-agents-malformed.html") -Raw
    $parsed = Parse-ArtificialAnalysisCodingAgentIndexFromHtml -Html $html
    Assert-Eq "unavailable" $parsed.status "Malformed should fail safe."
}

Run-Test "4 Missing/empty AA API key returns clean error status" {
    $envName = "ARTIFICIAL_ANALYSIS_API_KEY_TEST_ONLY"
    $prior = [Environment]::GetEnvironmentVariable($envName, "Process")
    try {
        [Environment]::SetEnvironmentVariable($envName, "", "Process")
        $f = Invoke-ArtificialAnalysisApiFetch -Url "https://artificialanalysis.ai/api/v2/data/llms/models" -ApiKeyEnvVarName $envName -TimeoutSec 5
        Assert-Eq "error" $f.status "Missing API key should be a normal error result."
        Assert-True ($f.error -like "*$envName*") "Error should identify the missing env var."
    } finally {
        [Environment]::SetEnvironmentVariable($envName, $prior, "Process")
    }
}

Run-Test "5 Malformed/unexpected AA API JSON is handled safely" {
    $apiJson = ConvertFrom-JsonAsHashtableCompat -JsonText (Get-Content -Path (Join-Path $fixtureRoot "aa-api-llms-models-malformed.json") -Raw)
    $parsed = Get-ArtificialAnalysisAgenticIndexData -FetchJson {
        param($u, $envVar)
        return [pscustomobject]@{ status = "ok"; value = $apiJson; error = $null }
    }
    Assert-Eq "unavailable" $parsed.status "Unexpected JSON shape must fail safe."
}

Run-Test "6 AA API 429/rate limit result is surfaced as error status" {
    $parsed = Get-ArtificialAnalysisAgenticIndexData -FetchJson {
        param($u, $envVar)
        return [pscustomobject]@{
            status = "error"
            value = $null
            error = "Too Many Requests"
            statusCode = 429
            retryAfterSeconds = "120"
        }
    }
    Assert-Eq "error" $parsed.status "Rate limiting should not crash parsing."
    Assert-True ($parsed.message -like "*429*") "Rate-limit message should mention HTTP 429."
}

Run-Test "7 LiveBench cost parsing and lower-is-better buckets" {
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

Run-Test "8 Baseline family-match helper (renamed, informational only) works across non-first families" {
    $valid = @("gpt-5.6-luna", "claude-haiku-4.5")
    Assert-True (Test-ModelMatchesProfileFamilyPolicy -ProfileKey "quick" -ModelId "gpt-5.6-luna" -ValidModels $valid) "Expected gpt-luna to match quick's baseline family list."
}

Run-Test "9 Challenger top+raw higher both qualifies (real capability/pricing admissibility applied)" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.1; "gpt-5.4" = 0.9 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-Eq "gpt-5.6-terra" $candidate.model "Expected challenger to qualify."
}

Run-Test "10 Top challenger losing one raw signal does not qualify" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 80; "gpt-5.6-terra" = 79; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = 80; "gpt-5.6-terra" = 79; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 90; "gpt-5.4" = 60 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.0; "gpt-5.4" = 0.9 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($null -eq $candidate) "Expected no qualifier when one raw signal loses."
}

Run-Test "11 Top challenger cannot replace an unscored incumbent" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60; "gpt-5.5" = 50 } -AaCodingScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60; "gpt-5.5" = 50 } -LbScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 90; "gpt-5.4" = 60; "gpt-5.5" = 50 } -Costs @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 0.85; "gpt-5.4" = 0.9; "gpt-5.5" = 0.8 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4","gpt-5.5") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($null -eq $candidate) "Missing incumbent benchmark coverage must not be treated as evidence that the challenger is better."
}

Run-Test "12 Rule 7: cost tie-break orders equal combinedRank challengers by lowest cost, not a hard gate" {
    # terra and luna tie on combinedRank (both aaRank=1,lbRank=1 -> combinedRank=2); terra costs more, so luna must win the tie-break.
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.6-luna" = 90 } -AaCodingScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.6-luna" = 90 } -LbScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.6-luna" = 90 } -Costs @{ "claude-haiku-4.5" = 1.0; "gpt-5.6-terra" = 5.0; "gpt-5.6-luna" = 0.5 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "quick" -ValidModels @("claude-haiku-4.5","gpt-5.6-terra","gpt-5.6-luna") -IncumbentModel "claude-haiku-4.5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:PermissiveRequirement -ProfileContextTier "default" -ProfileEffort "low"
    Assert-Eq "gpt-5.6-luna" $candidate.model "Expected lower-cost model to win the combinedRank tie."
}

Run-Test "13 Rule 7: a much higher-cost qualifying challenger is no longer blocked (cost-sensitive profile)" {
    # A third (non-candidate) filler model is included purely so bucket assignment (needs >=3 scored entries) puts gpt-5.6-terra in "top".
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -AaCodingScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -LbScores @{ "claude-haiku-4.5" = 50; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -Costs @{ "claude-haiku-4.5" = 0.1; "gpt-5.6-terra" = 500.0; "gpt-5.4" = 0.2 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "quick" -ValidModels @("claude-haiku-4.5","gpt-5.6-terra") -IncumbentModel "claude-haiku-4.5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:PermissiveRequirement -ProfileContextTier "default" -ProfileEffort "low"
    Assert-Eq "gpt-5.6-terra" $candidate.model "A cost-sensitive profile's much-higher-cost challenger must still qualify; cost no longer gates."
}

Run-Test "14 Rule 7: missing incumbent cost no longer required for qualification" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -AaCodingScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -LbScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 90; "gpt-5.4" = 10 } -Costs @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 999.0; "gpt-5.4" = 0.2 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-Eq "gpt-5.6-terra" $candidate.model "Missing incumbent cost combined with an unbounded challenger cost must not block qualification."
}

Run-Test "15 Rule 7: missing challenger cost no longer blocks qualification" {
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

Run-Test "32 Legacy override clears when it no longer beats the policy baseline under current rules" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-opus-5" = 90; "gpt-5.3-codex" = $null } -AaCodingScores @{ "claude-opus-5" = 90; "gpt-5.3-codex" = $null } -LbScores @{ "claude-opus-5" = 90; "gpt-5.3-codex" = $null } -Costs @{}
    Assert-True (-not (Test-ActiveOverrideQualitySupported -ActiveModel "claude-opus-5" -PolicyPreferredModel "gpt-5.3-codex" -IsFullFreshRun $true -ProfileKey "agentic-implementation" -Snapshot $snapshot)) "An override unsupported by current comparative evidence must clear."
}

Run-Test "33 Active override quality validation freezes on incomplete benchmark data" {
    Assert-True (Test-ActiveOverrideQualitySupported -ActiveModel "claude-opus-5" -PolicyPreferredModel "gpt-5.3-codex" -IsFullFreshRun $false -ProfileKey "agentic-implementation" -Snapshot $null) "Partial or fallback data must not revoke an active override."
}

Run-Test "34 Active override is evaluated individually rather than displaced by a better pending challenger" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 80; "gpt-5.6-sol" = 90 } -AaCodingScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 80; "gpt-5.6-sol" = 90 } -LbScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 80; "gpt-5.6-sol" = 90 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 0.8; "gpt-5.6-sol" = 0.9 }
    Assert-True (Test-ActiveOverrideQualitySupported -ActiveModel "gpt-5.6-terra" -PolicyPreferredModel "claude-sonnet-5" -IsFullFreshRun $true -ProfileKey "review" -Snapshot $snapshot) "The active override should retain its head-to-head win over the baseline while a better challenger follows normal consensus."
}

Run-Test "35 Grandfathered current model remains the effective benchmark incumbent" {
    Assert-Eq "claude-sonnet-5" (Get-EffectivePolicyBaselineModel -CurrentModel "claude-sonnet-5" -PolicyPreferredModel "claude-sonnet-4.6" -GrandfatherCurrent $true) "Unknown vision must not silently make Sonnet 4.6 the effective incumbent while Sonnet 5 remains configured."
    Assert-Eq "gpt-5.3-codex" (Get-EffectivePolicyBaselineModel -CurrentModel "claude-opus-5" -PolicyPreferredModel "gpt-5.3-codex" -GrandfatherCurrent $false) "Without grandfathering, the admissible policy baseline should be effective."
}

Run-Test "36 LiveBench-only fallback: AA missing for incumbent, candidate qualifies on LB alone" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 90; "gpt-5.4" = 50 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.0; "gpt-5.4" = 1.0 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-Eq "gpt-5.6-terra" $candidate.model "A missing incumbent AA score must no longer freeze the whole comparison when LiveBench alone qualifies a challenger."
    Assert-True ([bool]$candidate.aaFallbackUsed) "Expected the candidate to be flagged as having qualified via the LiveBench-only fallback."
}

Run-Test "37 LiveBench-only fallback: AA missing for incumbent but no challenger beats it on LB either" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 90; "gpt-5.6-terra" = 70; "gpt-5.4" = 50 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.0; "gpt-5.4" = 1.0 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($null -eq $candidate) "The LB-only fallback must still require an actual LiveBench win; it must not manufacture a qualifier."
}

Run-Test "38 Regression: both AA and LB present keeps the dual-source winsBoth behavior unchanged" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.1; "gpt-5.4" = 0.9 }
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-Eq "gpt-5.6-terra" $candidate.model "Expected the same qualifier as before when both AA and LB scores are present."
    Assert-True (-not [bool]$candidate.aaFallbackUsed) "A dual-source win must not be flagged as an AA fallback."
}

Run-Test "39 Test-ActiveOverrideQualitySupported falls back to LiveBench-only comparison when AA is missing on both sides" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-opus-5" = $null; "gpt-5.3-codex" = $null } -AaCodingScores @{ "claude-opus-5" = $null; "gpt-5.3-codex" = $null } -LbScores @{ "claude-opus-5" = 90; "gpt-5.3-codex" = 70 } -Costs @{}
    Assert-True (Test-ActiveOverrideQualitySupported -ActiveModel "claude-opus-5" -PolicyPreferredModel "gpt-5.3-codex" -IsFullFreshRun $true -ProfileKey "agentic-implementation" -Snapshot $snapshot) "AA missing on both sides should not freeze the check; the active override still wins on LiveBench alone."
}

Run-Test "40 AA alias never configured: incumbent is excluded from consensus entirely" {
    $snapshot = New-QualitySnapshot -AaScores @{ "gpt-5.4" = $null; "gpt-5.6-terra" = 80; "claude-sonnet-5" = 70 } -AaCodingScores @{ "gpt-5.4" = $null; "gpt-5.6-terra" = 80; "claude-sonnet-5" = 70 } -LbScores @{ "gpt-5.4" = 60; "gpt-5.6-terra" = 90; "claude-sonnet-5" = 70 } -Costs @{ "gpt-5.4" = 1.0; "gpt-5.6-terra" = 1.0; "claude-sonnet-5" = 1.0 } -AaAliasNotConfigured @("gpt-5.4")
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("gpt-5.4","gpt-5.6-terra","claude-sonnet-5") -IncumbentModel "gpt-5.4" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($null -eq $candidate) "An incumbent whose AA alias was never configured has no cross-source evidence and must not drive a LiveBench-only promotion."
}

Run-Test "41 AA alias never configured: challenger is skipped even though it would win on LiveBench alone" {
    # gpt-5.4 has the highest LiveBench score and shares the "top" bucket with
    # gpt-5.6-terra, but AA was never asked about it, so only gpt-5.6-terra
    # (configured alias, genuine AA data gap) may qualify via the fallback.
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = $null; "gpt-5.4" = $null; "gpt-5.6-terra" = $null; "gpt-5.4-mini" = $null } -AaCodingScores @{ "claude-sonnet-5" = $null; "gpt-5.4" = $null; "gpt-5.6-terra" = $null; "gpt-5.4-mini" = $null } -LbScores @{ "claude-sonnet-5" = 60; "gpt-5.4" = 95; "gpt-5.6-terra" = 90; "gpt-5.4-mini" = 40 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.4" = 1.0; "gpt-5.6-terra" = 1.0; "gpt-5.4-mini" = 1.0 } -AaAliasNotConfigured @("gpt-5.4")
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.4","gpt-5.6-terra","gpt-5.4-mini") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-Eq "gpt-5.6-terra" $candidate.model "A challenger with no configured AA alias must be skipped, not promoted on LiveBench alone."
}

Run-Test "42 Missing alias member (legacy snapshot shape) is treated as not configured" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = $null; "gpt-5.4" = $null; "gpt-5.4-mini" = $null } -AaCodingScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = $null; "gpt-5.4" = $null; "gpt-5.4-mini" = $null } -LbScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 95; "gpt-5.4" = 90; "gpt-5.4-mini" = 40 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.0; "gpt-5.4" = 1.0; "gpt-5.4-mini" = 1.0 } -OmitAaAliasMember @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4","gpt-5.4-mini")
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4","gpt-5.4-mini") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($null -eq $candidate) "A snapshot entry that cannot prove AA was consulted must fail safe rather than enable the fallback."
}

Run-Test "43 Get-ModelQualityDataForProfile reports AA alias configuration state" {
    $snapshot = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = $null; "gpt-5.4" = $null } -AaCodingScores @{ "claude-sonnet-5" = $null; "gpt-5.4" = $null } -LbScores @{ "claude-sonnet-5" = 60; "gpt-5.4" = 90 } -Costs @{} -AaAliasNotConfigured @("gpt-5.4")
    $configured = Get-ModelQualityDataForProfile -Snapshot $snapshot -ProfileKey "default-development" -ModelId "claude-sonnet-5"
    $notConfigured = Get-ModelQualityDataForProfile -Snapshot $snapshot -ProfileKey "default-development" -ModelId "gpt-5.4"
    Assert-True ([bool]$configured.aaAliasConfigured) "A non-null alias must be reported as configured."
    Assert-True (-not [bool]$notConfigured.aaAliasConfigured) "A null alias must be reported as not configured."
}

Run-Test "44 Stale LiveBench source data disqualifies the LiveBench-only fallback" {
    # Same data as test 36 (which promotes gpt-5.6-terra), only the LiveBench
    # source date is old -- so the only difference is the staleness gate.
    $stale = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = $null; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 60; "gpt-5.6-terra" = 90; "gpt-5.4" = 50 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.0; "gpt-5.4" = 1.0 } -LiveBenchSourceDate ((Get-Date).ToUniversalTime().AddDays(-200).ToString("yyyy-MM-dd"))
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $stale -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium" -LiveBenchOnlyFallbackMaxSourceAgeDays 90
    Assert-True ($null -eq $candidate) "Sole-evidence LiveBench data beyond the staleness threshold must not promote anything."
    Assert-True (-not (Test-LiveBenchOnlyFallbackSourceFresh -Snapshot $stale -MaxSourceAgeDays 90)) "Expected the 200-day-old LiveBench source to be judged stale."
}

Run-Test "45 Stale LiveBench source data does not gate the dual-source path" {
    $stale = New-QualitySnapshot -AaScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -AaCodingScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -LbScores @{ "claude-sonnet-5" = 70; "gpt-5.6-terra" = 80; "gpt-5.4" = 60 } -Costs @{ "claude-sonnet-5" = 1.0; "gpt-5.6-terra" = 1.1; "gpt-5.4" = 0.9 } -LiveBenchSourceDate ((Get-Date).ToUniversalTime().AddDays(-200).ToString("yyyy-MM-dd"))
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra","gpt-5.4") -IncumbentModel "claude-sonnet-5" -Snapshot $stale -AvailabilityVerified $true -Denylist $script:ModelDenylist -CapabilitiesCatalog $script:RealCapabilities -ProfileRequirement $script:DefaultDevRequirement -ProfileContextTier "default" -ProfileEffort "medium" -LiveBenchOnlyFallbackMaxSourceAgeDays 90
    Assert-Eq "gpt-5.6-terra" $candidate.model "Backward compatibility: the corroborated dual-source path must remain unaffected by the LiveBench staleness gate."
}

Run-Test "46 Active override whose AA alias was never configured is not quality-supported and clears" {
    $snapshot = New-QualitySnapshot -AaScores @{ "gpt-5.4" = $null; "claude-sonnet-5" = $null } -AaCodingScores @{ "gpt-5.4" = $null; "claude-sonnet-5" = $null } -LbScores @{ "gpt-5.4" = 90; "claude-sonnet-5" = 70 } -Costs @{} -AaAliasNotConfigured @("gpt-5.4")
    Assert-True (-not (Test-ActiveOverrideQualitySupported -ActiveModel "gpt-5.4" -PolicyPreferredModel "claude-sonnet-5" -IsFullFreshRun $true -ProfileKey "orchestrator" -Snapshot $snapshot)) "An override that was never cross-validated against AA must clear, even though it leads on LiveBench."
}

Run-Test "47 Active override backed by a genuine AA data gap is frozen, not revoked, when LiveBench is stale" {
    $stale = New-QualitySnapshot -AaScores @{ "gpt-5.6-terra" = $null; "claude-sonnet-5" = $null } -AaCodingScores @{ "gpt-5.6-terra" = $null; "claude-sonnet-5" = $null } -LbScores @{ "gpt-5.6-terra" = 60; "claude-sonnet-5" = 90 } -Costs @{} -LiveBenchSourceDate ((Get-Date).ToUniversalTime().AddDays(-200).ToString("yyyy-MM-dd"))
    Assert-True (Test-ActiveOverrideQualitySupported -ActiveModel "gpt-5.6-terra" -PolicyPreferredModel "claude-sonnet-5" -IsFullFreshRun $true -ProfileKey "orchestrator" -Snapshot $stale -LiveBenchOnlyFallbackMaxSourceAgeDays 90) "Transient upstream lag must freeze the check (preserve status quo), not revoke the override."
}

Run-Test "48 Production repro: a failed Artificial Analysis fetch makes only agentic-implementation full-fresh" {
    # Exactly the state of the merged runs 84c989e / 7aad2e4: the AA
    # agentic-index scrape returned nothing (all AA buckets n/a, blank source
    # date) while AA Coding Agents and LiveBench were fine.
    $snapshot = New-QualitySnapshot -AaScores @{ "gpt-5.4" = $null; "claude-sonnet-5" = $null } -AaCodingScores @{ "gpt-5.4" = $null; "claude-sonnet-5" = 80 } -LbScores @{ "gpt-5.4" = 70; "claude-sonnet-5" = 64 } -Costs @{}
    $snapshot.sourceStatus.artificialAnalysis.status = "unavailable"
    $snapshot.sourceStatus.artificialAnalysis.sourceDate = $null
    Assert-True (-not (Test-FullFreshConsensusRunForProfile -Snapshot $snapshot -ProfileKey "orchestrator")) "A failed AA agentic-index fetch must mark non-agentic profiles as not full-fresh."
    Assert-True (Test-FullFreshConsensusRunForProfile -Snapshot $snapshot -ProfileKey "agentic-implementation") "agentic-implementation scores against Coding Agents and must stay full-fresh."
}

Run-Test "49 Benchmark eligibility is derived from the real alias config, not from a snapshot" {
    $aliases = Get-ModelRankingAliases -AliasesPath (Join-Path $repoRoot "config/model-ranking-aliases.json")
    Assert-True (-not (Test-ProfileBenchmarkAliasConfigured -Aliases $aliases -ProfileKey "orchestrator" -ModelId "gpt-5.4")) "gpt-5.4 has artificialAnalysis=null in the shipped alias config."
    Assert-True (Test-ProfileBenchmarkAliasConfigured -Aliases $aliases -ProfileKey "orchestrator" -ModelId "claude-sonnet-5") "claude-sonnet-5 has a configured AA alias."
    Assert-True (-not (Test-ProfileBenchmarkAliasConfigured -Aliases $aliases -ProfileKey "orchestrator" -ModelId "gemini-3.7-flash")) "A model absent from the alias config must count as not configured."
    Assert-True (Test-ProfileBenchmarkAliasConfigured -Aliases $aliases -ProfileKey "agentic-implementation" -ModelId "gpt-5.6-sol") "agentic-implementation must resolve against the Coding Agents alias."
    Assert-True (-not (Test-ProfileBenchmarkAliasConfigured -Aliases $aliases -ProfileKey "agentic-implementation" -ModelId "claude-sonnet-5") ) "claude-sonnet-5 has no Coding Agents alias, so it is not eligible for that profile."
}

Run-Test "50 Regression (production bug): an ineligible override is revoked on a PARTIAL benchmark run, not just a full-fresh one" {
    # This is the case both merged CI runs hit and the previous fix missed:
    # $isFullFresh was false for orchestrator, so the eligibility check never
    # ran and gpt-5.4 survived. Config-derived gates must not be data-gated.
    $aliases = Get-ModelRankingAliases -AliasesPath (Join-Path $repoRoot "config/model-ranking-aliases.json")
    $snapshot = New-QualitySnapshot -AaScores @{ "gpt-5.4" = $null; "claude-sonnet-5" = $null } -AaCodingScores @{ "gpt-5.4" = $null; "claude-sonnet-5" = $null } -LbScores @{ "gpt-5.4" = 70; "claude-sonnet-5" = 64 } -Costs @{}
    $valid = Resolve-ActiveOverrideValidity -ActiveModel "gpt-5.4" -ProfileKey "orchestrator" -AdmissibilityValid $true `
        -AvailabilityVerified $true -IsFullFreshRun $false -EffectiveBaselineModel "claude-sonnet-5" `
        -Aliases $aliases -Snapshot $snapshot
    Assert-True (-not $valid) "An override with no configured AA alias must be revoked even when the benchmark run is partial."
}

Run-Test "51 Regression: a genuine AA data gap is still frozen (not revoked) on a partial run" {
    $aliases = Get-ModelRankingAliases -AliasesPath (Join-Path $repoRoot "config/model-ranking-aliases.json")
    $snapshot = New-QualitySnapshot -AaScores @{ "gpt-5.6-sol" = $null; "claude-sonnet-5" = $null } -AaCodingScores @{ "gpt-5.6-sol" = $null; "claude-sonnet-5" = $null } -LbScores @{ "gpt-5.6-sol" = 50; "claude-sonnet-5" = 90 } -Costs @{}
    # gpt-5.6-sol loses on LiveBench, but the run is partial, so no quality
    # judgement may be made and the override must survive untouched.
    $valid = Resolve-ActiveOverrideValidity -ActiveModel "gpt-5.6-sol" -ProfileKey "orchestrator" -AdmissibilityValid $true `
        -AvailabilityVerified $true -IsFullFreshRun $false -EffectiveBaselineModel "claude-sonnet-5" `
        -Aliases $aliases -Snapshot $snapshot
    Assert-True $valid "Partial data must never revoke an eligible override on quality grounds."
}

Run-Test "52 Rule 2 preserved: unverified availability freezes even the config-derived eligibility revocation" {
    $aliases = Get-ModelRankingAliases -AliasesPath (Join-Path $repoRoot "config/model-ranking-aliases.json")
    $valid = Resolve-ActiveOverrideValidity -ActiveModel "gpt-5.4" -ProfileKey "orchestrator" -AdmissibilityValid $true `
        -AvailabilityVerified $false -IsFullFreshRun $false -EffectiveBaselineModel "claude-sonnet-5" `
        -Aliases $aliases -Snapshot $null
    Assert-True $valid "Unverified availability discovery must not revoke overrides (rule 2)."
}

Run-Test "53 Regression: full-fresh quality revocation still works through the extracted resolver" {
    $aliases = Get-ModelRankingAliases -AliasesPath (Join-Path $repoRoot "config/model-ranking-aliases.json")
    $snapshot = New-QualitySnapshot -AaScores @{ "gpt-5.6-sol" = $null; "claude-sonnet-5" = $null } -AaCodingScores @{ "gpt-5.6-sol" = $null; "claude-sonnet-5" = $null } -LbScores @{ "gpt-5.6-sol" = 50; "claude-sonnet-5" = 90 } -Costs @{}
    $valid = Resolve-ActiveOverrideValidity -ActiveModel "gpt-5.6-sol" -ProfileKey "orchestrator" -AdmissibilityValid $true `
        -AvailabilityVerified $true -IsFullFreshRun $true -EffectiveBaselineModel "claude-sonnet-5" `
        -Aliases $aliases -Snapshot $snapshot -LiveBenchOnlyFallbackMaxSourceAgeDays 90
    Assert-True (-not $valid) "An eligible override that loses its head-to-head on a full fresh run must still clear."
    Assert-True (-not (Resolve-ActiveOverrideValidity -ActiveModel "gpt-5.4" -ProfileKey "orchestrator" -AdmissibilityValid $false -AvailabilityVerified $true -IsFullFreshRun $true -EffectiveBaselineModel "claude-sonnet-5" -Aliases $aliases -Snapshot $snapshot)) "An inadmissible override must still clear first."
}

Run-Test "54 Revocation on a partial run actually clears the persisted override state" {
    # Resolve-BenchmarkConsensusState returns early for non-full-fresh runs;
    # this pins that the clearing happens BEFORE that early return, so a
    # partial-run revocation really reaches the snapshot that gets written.
    $state = [ordered]@{ pending = $null; activeOverride = [ordered]@{ model = "gpt-5.4" } }
    $r = Resolve-BenchmarkConsensusState -ProfileKey "orchestrator" -PolicyPreferredModel "claude-sonnet-5" -IncumbentModel "claude-sonnet-5" -CurrentState $state -IsFullFreshRun $false -Candidate $null -SourceDates @{} -ActiveOverrideStillValid $false
    Assert-True ($r.activeCleared) "Expected the override to be cleared on a partial run."
    Assert-True ($null -eq $r.state.activeOverride) "Expected the persisted state to carry a null activeOverride."
    Assert-Eq "claude-sonnet-5" $r.finalModel "Expected the profile to fall back to the static baseline."
}

Run-Test "55 Alias-gap reporting inputs are config-derived and independent of any snapshot" {
    $aliases = Get-ModelRankingAliases -AliasesPath (Join-Path $repoRoot "config/model-ranking-aliases.json")
    Assert-True (Test-ModelBenchmarkable -Aliases $aliases -ModelId "gpt-5.4") "gpt-5.4 has a LiveBench alias, so it is otherwise comparable and must be named in the gap report."
    Assert-True (-not (Test-ModelBenchmarkable -Aliases $aliases -ModelId "claude-sonnet-4.5")) "A model with no LiveBench alias is not comparable and must not add noise to the gap report."
    Assert-True (-not (Test-ActiveOverrideBenchmarkEligible -Aliases $aliases -ProfileKey "orchestrator" -ActiveModel "gpt-5.4")) "gpt-5.4 must be reported ineligible for orchestrator with no snapshot involved at all."
    Assert-True (Test-ActiveOverrideBenchmarkEligible -Aliases $aliases -ProfileKey "orchestrator" -ActiveModel "") "An empty active model means there is nothing to revoke."
}

Write-Host ""
Write-Host "Tests passed: $script:Passed"
Write-Host "Tests failed: $script:Failed"
if ($script:Failed -gt 0) { exit 1 }
