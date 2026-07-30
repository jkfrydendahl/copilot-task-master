Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "model-ranking-data.ps1")
. (Join-Path $PSScriptRoot "model-selection-policy.ps1")

$script:ModelDenylist = @(
    "claude-fable-5"
)

$script:FallbackKnownModels = @(
    "claude-sonnet-5", "claude-sonnet-4.6", "claude-sonnet-4.5",
    "claude-haiku-4.5",
    "claude-opus-5", "claude-opus-4.8", "claude-opus-4.7", "claude-opus-4.6", "claude-opus-4.6-fast", "claude-opus-4.5",
    "claude-fable-5",
    "gpt-5.6-sol", "gpt-5.6-terra", "gpt-5.6-luna",
    "gpt-5.5", "gpt-5.4", "gpt-5.4-mini", "gpt-5.3-codex", "gpt-5.2-codex", "gpt-5.2", "gpt-5-mini",
    "gemini-3.1-pro-preview", "gemini-3.6-flash", "gemini-3.5-flash",
    "mai-code-1-flash-picker"
)

function Get-ValidModels {
    [OutputType([string[]])]
    param()

    $modelPattern = '"(claude-[\w.\-]+|gpt-[\w.\-]+|gemini-[\w.\-]+|mai-[\w.\-]+)"'
    if (Get-Command copilot -ErrorAction SilentlyContinue) {
        try {
            $helpText = (copilot help config 2>&1 | Out-String)
            $cliModels = @([regex]::Matches($helpText, $modelPattern) | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique | Where-Object { $script:ModelDenylist -notcontains $_ })
            if ($cliModels.Count -gt 0) { return $cliModels, "copilot help config" }
        } catch { }
    }
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        try {
            $helpText = (gh copilot help config 2>&1 | Out-String)
            $cliModels = @([regex]::Matches($helpText, $modelPattern) | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique | Where-Object { $script:ModelDenylist -notcontains $_ })
            if ($cliModels.Count -gt 0) { return $cliModels, "gh copilot help config" }
        } catch { }
    }
    return @($script:FallbackKnownModels | Where-Object { $script:ModelDenylist -notcontains $_ }), "hardcoded fallback (copilot help config not available on this runner)"
}

function Get-ProfileLiveBenchCategory {
    param([string]$ProfileKey)
    $map = @{
        "agentic-implementation" = "agenticCoding"
        "deep-reasoning" = "reasoning"
        "orchestrator" = "instructionFollowing"
        "triage" = "instructionFollowing"
        "default-development" = "coding"
        "review" = "reasoning"
        "visual-ui" = "coding"
        "quick" = "coding"
        "mechanical" = "coding"
    }
    if ($map.ContainsKey($ProfileKey)) { return $map[$ProfileKey] }
    return $null
}

function Test-FullFreshConsensusRunForProfile {
    param($Snapshot, [string]$ProfileKey)
    if ($null -eq $Snapshot -or [bool]$Snapshot.fallbackUsed -or [bool]$Snapshot.stale) { return $false }
    $lbOk = $Snapshot.sourceStatus.liveBench.status -eq "ok"
    $costOk = $Snapshot.sourceStatus.liveBenchCost.status -eq "ok"
    if (-not $lbOk -or -not $costOk) { return $false }
    if ($ProfileKey -eq "agentic-implementation") {
        return $Snapshot.sourceStatus.artificialAnalysisCodingAgents.status -eq "ok"
    }
    return $Snapshot.sourceStatus.artificialAnalysis.status -eq "ok"
}

function Get-RequiredSourceDatesForProfile {
    param($Snapshot, [string]$ProfileKey)
    $dates = [ordered]@{ liveBench = $Snapshot.sourceStatus.liveBench.sourceDate }
    if ($ProfileKey -eq "agentic-implementation") {
        $dates.artificialAnalysisCodingAgents = $Snapshot.sourceStatus.artificialAnalysisCodingAgents.sourceDate
    } else {
        $dates.artificialAnalysis = $Snapshot.sourceStatus.artificialAnalysis.sourceDate
    }
    return $dates
}

function Get-RequiredSourceVersionsForProfile {
    param($Snapshot, [string]$ProfileKey)
    $versions = [ordered]@{ liveBench = $Snapshot.sourceStatus.liveBench.sourceVersion }
    if ($ProfileKey -eq "agentic-implementation") {
        $versions.artificialAnalysisCodingAgents = $Snapshot.sourceStatus.artificialAnalysisCodingAgents.sourceVersion
    } else {
        $versions.artificialAnalysis = $Snapshot.sourceStatus.artificialAnalysis.sourceVersion
    }
    return $versions
}

function Test-SameSourceObservation {
    param($Left, $Right)
    if ($null -eq $Left -or $null -eq $Right) { return $false }
    return ($Left | ConvertTo-Json -Compress -Depth 5) -eq ($Right | ConvertTo-Json -Compress -Depth 5)
}

function Get-ModelSnapshotData {
    param($Snapshot, [string]$ModelId)
    if ($null -eq $Snapshot -or $null -eq $Snapshot.models) { return $null }
    if ($Snapshot.models -is [System.Collections.IDictionary]) {
        if ($Snapshot.models.Contains($ModelId)) { return $Snapshot.models[$ModelId] }
        return $null
    }
    if ($Snapshot.models.PSObject.Properties.Name -contains $ModelId) { return $Snapshot.models.PSObject.Properties[$ModelId].Value }
    return $null
}

function Get-ModelQualityDataForProfile {
    param($Snapshot, [string]$ProfileKey, [string]$ModelId)
    $entry = Get-ModelSnapshotData -Snapshot $Snapshot -ModelId $ModelId
    if ($null -eq $entry) { return $null }
    $lbCategory = Get-ProfileLiveBenchCategory -ProfileKey $ProfileKey
    if ([string]::IsNullOrWhiteSpace($lbCategory)) { return $null }
    $aaScore = $null
    $aaBucket = "n/a"
    $aaRank = $null
    if ($ProfileKey -eq "agentic-implementation") {
        $aaCodingData = Get-ObjectMemberValue -InputObject $entry -Name "artificialAnalysisCodingAgents"
        if ($aaCodingData) {
            $aaScore = $aaCodingData.codingAgentIndex
            $aaBucket = [string]$aaCodingData.bucket
            $aaRank = $aaCodingData.ordinalRank
        }
    } else {
        $aaScore = $entry.artificialAnalysis.agenticIndex
        $aaBucket = [string]$entry.artificialAnalysis.bucket
        $aaRank = $entry.artificialAnalysis.ordinalRank
    }
    $lbScore = $entry.liveBench.categories.$lbCategory
    $lbBucket = [string]$entry.liveBench.buckets.$lbCategory
    $lbRank = $entry.liveBench.ordinalRanks.$lbCategory
    return [pscustomobject]@{
        aaScore = $aaScore
        aaBucket = $aaBucket
        aaRank = $aaRank
        lbScore = $lbScore
        lbBucket = $lbBucket
        lbRank = $lbRank
        cost = $entry.liveBench.costPerSuccessfulTask
        costBucket = [string]$entry.liveBench.costBucket
    }
}

function Test-CostGuardrail {
    param(
        [string]$ProfileKey,
        $IncumbentQuality,
        $ChallengerQuality
    )
    if ($null -eq $ChallengerQuality -or $null -eq $ChallengerQuality.cost) { return $false }
    $costSensitive = @("quick", "mechanical", "triage")
    if ($null -ne $IncumbentQuality -and $null -ne $IncumbentQuality.cost) {
        $inc = [double]$IncumbentQuality.cost
        $chg = [double]$ChallengerQuality.cost
        if ($costSensitive -contains $ProfileKey) { return $chg -le $inc }
        return $chg -le ($inc * 1.5)
    }
    return @("top", "competitive") -contains [string]$ChallengerQuality.costBucket
}

function Get-BenchmarkConsensusCandidate {
    param(
        [string]$ProfileKey,
        [string[]]$ValidModels,
        [string]$IncumbentModel,
        $Snapshot
    )

    $incumbent = Get-ModelQualityDataForProfile -Snapshot $Snapshot -ProfileKey $ProfileKey -ModelId $IncumbentModel
    $qualifiers = New-Object System.Collections.Generic.List[object]
    foreach ($model in $ValidModels) {
        if ($model -eq $IncumbentModel) { continue }
        if (-not (Test-ModelEligibleForProfilePolicy -ProfileKey $ProfileKey -ModelId $model -ValidModels $ValidModels -ModelDenylist $script:ModelDenylist)) { continue }
        $candidate = Get-ModelQualityDataForProfile -Snapshot $Snapshot -ProfileKey $ProfileKey -ModelId $model
        if ($null -eq $candidate) { continue }
        if ($candidate.aaBucket -ne "top" -or $candidate.lbBucket -ne "top") { continue }
        if ($null -eq $candidate.aaScore -or $null -eq $candidate.lbScore) { continue }

        $winsBoth = $false
        if ($null -ne $incumbent -and $null -ne $incumbent.aaScore -and $null -ne $incumbent.lbScore) {
            $winsBoth = ([double]$candidate.aaScore -gt [double]$incumbent.aaScore) -and ([double]$candidate.lbScore -gt [double]$incumbent.lbScore)
        } else {
            $winsBoth = $true
        }
        if (-not $winsBoth) { continue }
        if (-not (Test-CostGuardrail -ProfileKey $ProfileKey -IncumbentQuality $incumbent -ChallengerQuality $candidate)) { continue }

        $combinedRank = ([int]$candidate.aaRank) + ([int]$candidate.lbRank)
        $qualifiers.Add([pscustomobject]@{
            model = $model
            combinedRank = $combinedRank
            cost = [double]$candidate.cost
        })
    }

    if ($qualifiers.Count -eq 0) { return $null }
    return @($qualifiers | Sort-Object -Property @{ Expression = { $_.combinedRank }; Descending = $false }, @{ Expression = { $_.cost }; Descending = $false }, @{ Expression = { $_.model }; Descending = $false })[0]
}

function Get-SnapshotConsensusProfilesMap {
    param($Snapshot)
    if ($Snapshot -is [System.Collections.IDictionary]) {
        if (-not $Snapshot.Contains("consensus") -or $null -eq $Snapshot["consensus"]) {
            $Snapshot["consensus"] = [ordered]@{}
        }
        $consensus = $Snapshot["consensus"]
    } else {
        if (-not (Test-ObjectMember -InputObject $Snapshot -Name "consensus") -or $null -eq $Snapshot.consensus) {
            $Snapshot | Add-Member -NotePropertyName consensus -NotePropertyValue ([ordered]@{}) -Force
        }
        $consensus = $Snapshot.consensus
    }

    if ($consensus -is [System.Collections.IDictionary]) {
        if (-not $consensus.Contains("profiles") -or $null -eq $consensus["profiles"]) {
            $consensus["profiles"] = [ordered]@{}
        }
        return $consensus["profiles"]
    }
    if (-not (Test-ObjectMember -InputObject $consensus -Name "profiles") -or $null -eq $consensus.profiles) {
        $consensus | Add-Member -NotePropertyName profiles -NotePropertyValue ([ordered]@{}) -Force
    }
    return $consensus.profiles
}

function Get-ActiveOverrideModel {
    param($Snapshot, [string]$ProfileKey)
    $profiles = Get-SnapshotConsensusProfilesMap -Snapshot $Snapshot
    $state = $null
    if ($profiles -is [System.Collections.IDictionary]) {
        if (-not $profiles.Contains($ProfileKey)) { return $null }
        $state = $profiles[$ProfileKey]
    } else {
        if (-not ((@($profiles.PSObject.Properties | Where-Object { $_.Name -eq $ProfileKey }).Count) -gt 0)) { return $null }
        $state = $profiles.$ProfileKey
    }
    if ($null -eq $state -or -not (Test-ObjectMember -InputObject $state -Name "activeOverride")) { return $null }
    if ($null -eq $state.activeOverride) { return $null }
    return [string]$state.activeOverride.model
}

function Set-ProfileConsensusState {
    param($Snapshot, [string]$ProfileKey, $State)
    $profiles = Get-SnapshotConsensusProfilesMap -Snapshot $Snapshot
    if ($profiles -is [System.Collections.IDictionary]) {
        $profiles[$ProfileKey] = $State
    } else {
        $profiles | Add-Member -NotePropertyName $ProfileKey -NotePropertyValue $State -Force
    }
}

function Resolve-BenchmarkConsensusState {
    param(
        [string]$ProfileKey,
        [string]$PolicyPreferredModel,
        [string]$IncumbentModel,
        $CurrentState,
        [bool]$IsFullFreshRun,
        $Candidate,
        $SourceDates,
        $SourceVersions = @{},
        [bool]$ActiveOverrideStillValid = $true
    )

    $state = if ($null -ne $CurrentState) { $CurrentState } else { [ordered]@{ pending = $null; activeOverride = $null } }
    if ($state -is [System.Collections.IDictionary]) {
        $state = [pscustomobject]@{
            pending = if ($state.Contains("pending")) { $state["pending"] } else { $null }
            activeOverride = if ($state.Contains("activeOverride")) { $state["activeOverride"] } else { $null }
        }
    }
    if (-not $state.PSObject.Properties.Name.Contains("pending")) { $state | Add-Member -NotePropertyName pending -NotePropertyValue $null -Force }
    if (-not $state.PSObject.Properties.Name.Contains("activeOverride")) { $state | Add-Member -NotePropertyName activeOverride -NotePropertyValue $null -Force }

    $activeCleared = $false
    if (-not $ActiveOverrideStillValid) {
        $state.activeOverride = $null
        $activeCleared = $true
    }

    if (-not $IsFullFreshRun) {
        return [pscustomobject]@{
            state = $state
            applied = $false
            pendingCount = if ($null -ne $state.pending) { [int]$state.pending.consecutiveQualifyingFullRuns } else { 0 }
            finalModel = if ($null -ne $state.activeOverride) { [string]$state.activeOverride.model } else { $IncumbentModel }
            activeCleared = $activeCleared
        }
    }

    if ($null -eq $Candidate) {
        $state.pending = $null
        return [pscustomobject]@{
            state = $state
            applied = $false
            pendingCount = 0
            finalModel = if ($null -ne $state.activeOverride) { [string]$state.activeOverride.model } else { $IncumbentModel }
            activeCleared = $activeCleared
        }
    }

    $count = 1
    if ($null -ne $state.pending -and [string]$state.pending.candidateModel -eq [string]$Candidate.model) {
        $priorVersions = Get-ObjectMemberValue -InputObject $state.pending -Name "sourceVersions"
        if (Test-SameSourceObservation -Left $priorVersions -Right $SourceVersions) {
            $count = [int]$state.pending.consecutiveQualifyingFullRuns
        } else {
            $count = [int]$state.pending.consecutiveQualifyingFullRuns + 1
        }
    }

    if ($count -ge 2) {
        if ([string]$Candidate.model -eq [string]$PolicyPreferredModel) {
            $state.activeOverride = $null
        } else {
            $state.activeOverride = [ordered]@{
                model = [string]$Candidate.model
                activatedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
                sourceDates = $SourceDates
                sourceVersions = $SourceVersions
            }
        }
        $state.pending = $null
        return [pscustomobject]@{
            state = $state
            applied = $true
            pendingCount = 0
            finalModel = if ($null -ne $state.activeOverride) { [string]$state.activeOverride.model } else { [string]$PolicyPreferredModel }
            activeCleared = $activeCleared
        }
    }

    $state.pending = [ordered]@{
        candidateModel = [string]$Candidate.model
        consecutiveQualifyingFullRuns = $count
        sourceDates = $SourceDates
        sourceVersions = $SourceVersions
        updatedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
    }
    return [pscustomobject]@{
        state = $state
        applied = $false
        pendingCount = $count
        finalModel = if ($null -ne $state.activeOverride) { [string]$state.activeOverride.model } else { $IncumbentModel }
        activeCleared = $activeCleared
    }
}

function Invoke-TaskProfileReview {
    $policy = Get-ModelSelectionPolicy
    $modelComparisonUrl = "https://docs.github.com/en/copilot/reference/ai-models/model-comparison"

    $repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
    $profilesPath = Join-Path $repoRoot "task-profiles.json"
    $reportDir = Join-Path $repoRoot "reports"
    $reportPath = Join-Path $reportDir "task-profile-review.md"
    $snapshotPath = Join-Path $repoRoot "data/model-ranking-snapshot.json"
    if (!(Test-Path $reportDir)) { New-Item -ItemType Directory -Path $reportDir -Force | Out-Null }

    $profiles = @((Get-Content $profilesPath -Raw | ConvertFrom-Json) | ForEach-Object { $_ })
    $validModels, $modelSource = Get-ValidModels
    $validModels = @($validModels)

    $priorSnapshot = Read-ModelRankingSnapshotFile -SnapshotPath $snapshotPath
    if ($null -eq $priorSnapshot) { $priorSnapshot = New-UnavailableModelRankingSnapshot }

    $decisions = @{}
    foreach ($profile in $profiles) {
        $profileKey = [string]$profile.key
        $currentModel = [string]$profile.model
        $policyPreferred = Get-PreferredModelForProfilePolicy -ProfileKey $profileKey -ValidModels $validModels -Policy $policy
        $activeOverride = Get-ActiveOverrideModel -Snapshot $priorSnapshot -ProfileKey $profileKey
        $overrideValid = $false
        if (-not [string]::IsNullOrWhiteSpace($activeOverride)) {
            $overrideValid = Test-ModelEligibleForProfilePolicy -ProfileKey $profileKey -ModelId $activeOverride -ValidModels $validModels -ModelDenylist $script:ModelDenylist -Policy $policy
        }
        $target = if ($overrideValid) { $activeOverride } elseif (-not [string]::IsNullOrWhiteSpace($policyPreferred)) { $policyPreferred } else { $currentModel }
        $type = if ($overrideValid) { "active_override" } elseif ($target -ne $currentModel) { "policy_preference" } else { "none" }
        $decisions[$profileKey] = [pscustomobject]@{
            currentModel = $currentModel
            policyPreferred = $policyPreferred
            incumbentAfterPolicy = $target
            finalModel = $target
            changeType = $type
            benchmarkApplied = $false
            pendingCount = 0
        }
    }

    $rankingSnapshot = Get-AdvisoryModelRankingSnapshot -RepoRoot $repoRoot -ValidModels $validModels -SnapshotPath $snapshotPath
    $consensusProfiles = Get-SnapshotConsensusProfilesMap -Snapshot $rankingSnapshot
    $profileKeys = @($profiles | ForEach-Object { [string]$_.key })
    if ($consensusProfiles -is [System.Collections.IDictionary]) {
        foreach ($key in @($consensusProfiles.Keys)) {
            if ($profileKeys -notcontains [string]$key) { $consensusProfiles.Remove($key) }
        }
    } else {
        foreach ($property in @($consensusProfiles.PSObject.Properties)) {
            if ($profileKeys -notcontains [string]$property.Name) { $consensusProfiles.PSObject.Properties.Remove($property.Name) }
        }
    }

    $benchmarkChanges = New-Object System.Collections.Generic.List[string]
    foreach ($profile in $profiles) {
        $profileKey = [string]$profile.key
        $d = $decisions[$profileKey]
        $incumbent = [string]$d.incumbentAfterPolicy
        $profileHasKey = if ($consensusProfiles -is [System.Collections.IDictionary]) { $consensusProfiles.Contains($profileKey) } else { (@($consensusProfiles.PSObject.Properties | Where-Object { $_.Name -eq $profileKey }).Count -gt 0) }
        $profileState = if ($profileHasKey) {
            if ($consensusProfiles -is [System.Collections.IDictionary]) { $consensusProfiles[$profileKey] } else { $consensusProfiles.$profileKey }
        } else { [ordered]@{ pending = $null; activeOverride = $null } }
        if (-not (Test-ObjectMember -InputObject $profileState -Name "pending")) {
            if ($profileState -is [System.Collections.IDictionary]) { $profileState["pending"] = $null } else { $profileState | Add-Member -NotePropertyName pending -NotePropertyValue $null -Force }
        }
        if (-not (Test-ObjectMember -InputObject $profileState -Name "activeOverride")) {
            if ($profileState -is [System.Collections.IDictionary]) { $profileState["activeOverride"] = $null } else { $profileState | Add-Member -NotePropertyName activeOverride -NotePropertyValue $null -Force }
        }

        $activeModel = if ($null -ne $profileState.activeOverride) { [string]$profileState.activeOverride.model } else { $null }
        $activeStillValid = $true
        if (-not [string]::IsNullOrWhiteSpace($activeModel)) {
            $activeStillValid = Test-ModelEligibleForProfilePolicy -ProfileKey $profileKey -ModelId $activeModel -ValidModels $validModels -ModelDenylist $script:ModelDenylist -Policy $policy
        }
        $isFullFresh = Test-FullFreshConsensusRunForProfile -Snapshot $rankingSnapshot -ProfileKey $profileKey
        $candidate = if ($isFullFresh) { Get-BenchmarkConsensusCandidate -ProfileKey $profileKey -ValidModels $validModels -IncumbentModel $incumbent -Snapshot $rankingSnapshot } else { $null }
        $sourceDates = if ($isFullFresh -and $null -ne $candidate) { Get-RequiredSourceDatesForProfile -Snapshot $rankingSnapshot -ProfileKey $profileKey } else { @{} }
        $sourceVersions = if ($isFullFresh -and $null -ne $candidate) { Get-RequiredSourceVersionsForProfile -Snapshot $rankingSnapshot -ProfileKey $profileKey } else { @{} }

        $resolved = Resolve-BenchmarkConsensusState -ProfileKey $profileKey -PolicyPreferredModel $d.policyPreferred -IncumbentModel $incumbent -CurrentState $profileState -IsFullFreshRun $isFullFresh -Candidate $candidate -SourceDates $sourceDates -SourceVersions $sourceVersions -ActiveOverrideStillValid $activeStillValid
        $profileState = $resolved.state
        $d.pendingCount = $resolved.pendingCount
        if ($resolved.activeCleared -and $d.changeType -eq "active_override") {
            $d.finalModel = if (-not [string]::IsNullOrWhiteSpace($d.policyPreferred)) { $d.policyPreferred } else { $d.currentModel }
            $d.changeType = "policy_preference"
        }
        if ($resolved.applied) {
            $d.finalModel = $resolved.finalModel
            $d.changeType = "benchmark_consensus"
            $d.benchmarkApplied = $true
            $benchmarkChanges.Add(('- "{0}": "{1}" -> "{2}" (benchmark_consensus)' -f $profileKey, $d.currentModel, $d.finalModel))
        } elseif ($d.changeType -eq "active_override") {
            $d.finalModel = if ($null -ne $profileState.activeOverride) { [string]$profileState.activeOverride.model } else { $d.finalModel }
        }
        Set-ProfileConsensusState -Snapshot $rankingSnapshot -ProfileKey $profileKey -State $profileState
    }

    $profilesUpdated = $false
    $appliedChanges = New-Object System.Collections.Generic.List[string]
    foreach ($profile in $profiles) {
        $profileKey = [string]$profile.key
        $d = $decisions[$profileKey]
        if ([string]$profile.model -ne [string]$d.finalModel) {
            $profile.model = $d.finalModel
            $profilesUpdated = $true
            $appliedChanges.Add(('- "{0}": "{1}" -> "{2}" ({3})' -f $profileKey, $d.currentModel, $d.finalModel, $d.changeType))
        }
    }
    if ($profilesUpdated) { Set-Content -Path $profilesPath -Value ($profiles | ConvertTo-Json -Depth 10) -Encoding UTF8 }
    $rankingSnapshot.schemaVersion = $script:ModelRankingSchemaVersion
    $snapshotToPersist = $rankingSnapshot
    $shouldPersistSnapshot = $true
    $fullRankingSnapshot = $rankingSnapshot.status -eq "ok" -and -not [bool]$rankingSnapshot.fallbackUsed -and -not [bool]$rankingSnapshot.stale
    if (-not $fullRankingSnapshot) {
        if (Test-ModelRankingSnapshotUsable -Snapshot $priorSnapshot) {
            if ($priorSnapshot -is [System.Collections.IDictionary]) {
                $priorSnapshot["schemaVersion"] = $script:ModelRankingSchemaVersion
                $priorSnapshot["consensus"] = $rankingSnapshot.consensus
            } else {
                $priorSnapshot.schemaVersion = $script:ModelRankingSchemaVersion
                $priorSnapshot.consensus = $rankingSnapshot.consensus
            }
            $snapshotToPersist = $priorSnapshot
        } else {
            $shouldPersistSnapshot = $false
        }
    }
    if ($shouldPersistSnapshot) {
        Write-ModelRankingSnapshotAtomic -SnapshotPath $snapshotPath -SnapshotObject $snapshotToPersist
    }

    $rankingReportLines = Get-ModelRankingReportLines -Snapshot $rankingSnapshot -ValidModels $validModels
    $pendingLines = New-Object System.Collections.Generic.List[string]
    $activeLines = New-Object System.Collections.Generic.List[string]
    foreach ($profile in $profiles) {
        $k = [string]$profile.key
        $hasState = if ($consensusProfiles -is [System.Collections.IDictionary]) { $consensusProfiles.Contains($k) } else { (@($consensusProfiles.PSObject.Properties | Where-Object { $_.Name -eq $k }).Count -gt 0) }
        $state = if ($hasState) {
            if ($consensusProfiles -is [System.Collections.IDictionary]) { $consensusProfiles[$k] } else { $consensusProfiles.$k }
        } else { $null }
        if ($null -ne $state -and $null -ne $state.pending) {
            $pendingLines.Add(('- "{0}": candidate "{1}", count={2}' -f $k, $state.pending.candidateModel, $state.pending.consecutiveQualifyingFullRuns))
        }
        if ($null -ne $state -and $null -ne $state.activeOverride) {
            $activeLines.Add(('- "{0}": "{1}"' -f $k, $state.activeOverride.model))
        }
    }

    $today = (Get-Date).ToString("yyyy-MM-dd")
    $lines = @()
    $lines += "# Monthly task profile review ($today)"
    $lines += ""
    $lines += "Reference: $modelComparisonUrl"
    $lines += ""
    $lines += "Model source: **$modelSource**"
    $lines += ""
    $lines += "## Current profiles"
    $lines += ""
    $lines += "| Key | Model | Effort | Context |"
    $lines += "|---|---|---|---|"
    foreach ($profile in $profiles) { $lines += "| $($profile.key) | $($profile.model) | $($profile.effort) | $($profile.context) |" }
    $lines += ""
    $lines += "## Applied profile changes in this run"
    if ($appliedChanges.Count -eq 0) { $lines += "- None." } else { $lines += @($appliedChanges) }
    $lines += ""
    $lines += "## Benchmark consensus pending"
    if ($pendingLines.Count -eq 0) { $lines += "- None." } else { $lines += @($pendingLines) }
    $lines += ""
    $lines += "## Active benchmark overrides"
    if ($activeLines.Count -eq 0) { $lines += "- None." } else { $lines += @($activeLines) }
    $lines += ""
    $lines += "## Benchmark consensus auto-applied changes"
    if ($benchmarkChanges.Count -eq 0) { $lines += "- None." } else { $lines += @($benchmarkChanges) }
    $lines += ""
    $lines += $rankingReportLines

    Set-Content -Path $reportPath -Value (($lines -join "`r`n").TrimEnd()) -Encoding UTF8
    Write-Host "Wrote $reportPath"
    if ($profilesUpdated) { Write-Host "Updated $profilesPath" }
}

if ($MyInvocation.InvocationName -ne '.') {
    Invoke-TaskProfileReview
}
