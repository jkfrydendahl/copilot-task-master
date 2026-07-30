Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "model-ranking-data.ps1")
. (Join-Path $PSScriptRoot "model-selection-policy.ps1")
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
. (Join-Path $PSScriptRoot "model-availability.ps1")
. (Join-Path $PSScriptRoot "model-admissibility.ps1")
. (Join-Path $PSScriptRoot "model-review-report.ps1")

$script:ModelPolicyConfigPath = Join-Path (Join-Path $PSScriptRoot "..") "config/model-policy.json"
$script:ModelCapabilitiesConfigPath = Join-Path (Join-Path $PSScriptRoot "..") "config/model-capabilities.json"
$script:ModelPolicyConfig = Get-ModelPolicyConfig -PolicyPath $script:ModelPolicyConfigPath
$script:ModelDenylist = @($script:ModelPolicyConfig.denylist)

function Get-ValidModels {
    # Back-compat wrapper (models, source) tuple around Get-ModelAvailability,
    # for any callers still expecting the historical two-value return shape.
    [OutputType([System.Object[]])]
    param()

    $availability = Get-ModelAvailability -Denylist $script:ModelDenylist
    return $availability.models, $availability.source
}

function Get-ProfileLiveBenchCategory {
    param(
        [string]$ProfileKey,
        [hashtable]$Map = $script:ModelPolicyConfig.profileLiveBenchCategories
    )
    if ($Map.ContainsKey($ProfileKey)) { return $Map[$ProfileKey] }
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

function Get-BenchmarkConsensusCandidate {
    # Rule 3: family/task-family matching is baseline preference only and is
    # NOT an admissibility gate here anymore — candidates are gated by the
    # real admissibility engine (denylist, verified availability, capability
    # facts, and the profile's hard pricing ceilings).
    # Rule 7: LiveBench cost_per_successful_task no longer blocks a
    # qualifying challenger; it is retained only as a tie-break (see the
    # Sort-Object below, which already orders by cost after combinedRank).
    param(
        [string]$ProfileKey,
        [string[]]$ValidModels,
        [string]$IncumbentModel,
        $Snapshot,
        [bool]$AvailabilityVerified = $true,
        [string[]]$Denylist = $script:ModelDenylist,
        [hashtable]$CapabilitiesCatalog = @{},
        $ProfileRequirement = $null,
        [string]$ProfileContextTier = "default",
        [string]$ProfileEffort = "medium",
        [int]$CapabilityFreshnessDays = 60,
        [datetime]$NowUtc = ((Get-Date).ToUniversalTime())
    )

    if ($null -eq $ProfileRequirement) {
        $ProfileRequirement = [pscustomobject]@{
            inputCeilingPerMillion = [double]::MaxValue
            outputCeilingPerMillion = [double]::MaxValue
            requiresVision = $false
            requiresCliAgent = $false
            costSensitive = $false
        }
    }

    $incumbent = Get-ModelQualityDataForProfile -Snapshot $Snapshot -ProfileKey $ProfileKey -ModelId $IncumbentModel
    $qualifiers = New-Object System.Collections.Generic.List[object]
    foreach ($model in $ValidModels) {
        if ($model -eq $IncumbentModel) { continue }
        $capabilityRecord = if ($CapabilitiesCatalog.ContainsKey($model)) { $CapabilitiesCatalog[$model] } else { $null }
        $verdict = Get-ModelAdmissibilityVerdict -ModelId $model -ProfileKey $ProfileKey -AvailabilityVerified $AvailabilityVerified `
            -Denylist $Denylist -AvailableModels $ValidModels -CapabilityRecord $capabilityRecord `
            -ProfileRequirement $ProfileRequirement -ProfileContextTier $ProfileContextTier -ProfileEffort $ProfileEffort `
            -CapabilityFreshnessDays $CapabilityFreshnessDays -NowUtc $NowUtc
        if (-not $verdict.admissible) { continue }

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
        [bool]$ActiveOverrideStillValid = $true,
        [bool]$ForceImmediateApply = $false
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
            forcedApply = $false
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
            forcedApply = $false
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

    # Manual, one-time override: a candidate that already passed every other
    # gate (verified availability/capability/pricing admissibility, top-bucket/raw-score wins, cost
    # guardrail, source completeness/freshness via $IsFullFreshRun, and
    # active-override validity via $ActiveOverrideStillValid, all evaluated
    # by the caller before reaching this function) may apply on its first
    # qualifying run instead of waiting for a second distinct source
    # publication. This only shortens the consecutive-run counter; it does
    # not skip or relax any of those other checks.
    $forcedApply = $false
    if ($ForceImmediateApply -and $count -lt 2) {
        $count = 2
        $forcedApply = $true
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
                forced = $forcedApply
            }
        }
        $state.pending = $null
        return [pscustomobject]@{
            state = $state
            applied = $true
            pendingCount = 0
            finalModel = if ($null -ne $state.activeOverride) { [string]$state.activeOverride.model } else { [string]$PolicyPreferredModel }
            activeCleared = $activeCleared
            forcedApply = $forcedApply
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
        forcedApply = $false
    }
}

function Get-ForceBenchmarkConsensusFlag {
    # Manual one-time override, wired from the workflow_dispatch
    # `force_benchmark_consensus` input via the FORCE_BENCHMARK_CONSENSUS
    # environment variable. Scheduled runs never set this variable to a
    # truthy value, so they always behave as false.
    $raw = [string]$env:FORCE_BENCHMARK_CONSENSUS
    return $raw -match '^(?i:true|1)$'
}

function Get-ProfileAdmissibilityRequirement {
    # Resolves a profile's admissibility inputs: its pricing/capability
    # requirement (from config/model-policy.json), and its context tier /
    # effort (from task-profiles.json, the actual runtime values a model
    # would be asked to serve for this profile).
    param($ProfilesByKey, [string]$ProfileKey)
    if (-not $script:ModelPolicyConfig.profileRequirements.ContainsKey($ProfileKey)) {
        throw "No profileRequirements entry configured for profile key '$ProfileKey' in config/model-policy.json. Refusing to fall back to an unlimited/no-requirements default -- add the missing profile entry (profileRequirements, classPreferences, and profileLiveBenchCategories are all required per known profile key)."
    }
    $requirement = $script:ModelPolicyConfig.profileRequirements[$ProfileKey]
    $profile = $ProfilesByKey[$ProfileKey]
    $contextTier = if ($null -ne $profile) { [string]$profile.context } else { "default" }
    $effort = if ($null -ne $profile) { [string]$profile.effort } else { "medium" }
    return [pscustomobject]@{ requirement = $requirement; contextTier = $contextTier; effort = $effort }
}

function Invoke-TaskProfileReview {
    $policy = Get-ModelSelectionPolicy
    $modelComparisonUrl = "https://docs.github.com/en/copilot/reference/ai-models/model-comparison"
    $forceBenchmarkConsensus = Get-ForceBenchmarkConsensusFlag
    $capabilityFreshnessDays = [int]$script:ModelPolicyConfig.consensusPolicy.capabilityFreshnessDays

    $repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
    $profilesPath = Join-Path $repoRoot "task-profiles.json"
    $reportDir = Join-Path $repoRoot "reports"
    $reportPath = Join-Path $reportDir "task-profile-review.md"
    $snapshotPath = Join-Path $repoRoot "data/model-ranking-snapshot.json"
    if (!(Test-Path $reportDir)) { New-Item -ItemType Directory -Path $reportDir -Force | Out-Null }

    $profiles = @((Get-Content $profilesPath -Raw | ConvertFrom-Json) | ForEach-Object { $_ })
    $profilesByKey = @{}
    foreach ($p in $profiles) { $profilesByKey[[string]$p.key] = $p }

    # Rule 2/10: availability discovery drives both the usable model list and
    # whether this run's confidence is "verified" (real CLI/GHE discovery) or
    # "unverified" (hardcoded fallback). Unverified runs freeze benchmark
    # promotion below but must not revoke already-active overrides.
    $availability = Get-ModelAvailability -Denylist $script:ModelDenylist
    $validModels = @($availability.models)
    $modelSource = $availability.source
    $capabilitiesCatalog = (Get-ModelCapabilitiesCatalog -CatalogPath $script:ModelCapabilitiesConfigPath).models

    $priorSnapshot = Read-ModelRankingSnapshotFile -SnapshotPath $snapshotPath
    if ($null -eq $priorSnapshot) { $priorSnapshot = New-UnavailableModelRankingSnapshot }

    $decisions = @{}
    foreach ($profile in $profiles) {
        $profileKey = [string]$profile.key
        $currentModel = [string]$profile.model
        # Rule 1: family/class preference is the deterministic baseline
        # fallback ordering, but an automatic baseline change must never
        # select a family candidate that fails the same
        # availability/capability/pricing admissibility engine used
        # everywhere else for this profile. Computing $ctx up-front (once,
        # per profile) lets us build that filter here and reuse the same
        # $ctx for the override check, ledger, and benchmark candidate
        # search below instead of recomputing it three times.
        $ctx = Get-ProfileAdmissibilityRequirement -ProfilesByKey $profilesByKey -ProfileKey $profileKey
        $admissibleBaselineModels = @($validModels | Where-Object {
            $modelId = $_
            $verdict = Get-ModelAdmissibilityVerdict -ModelId $modelId -ProfileKey $profileKey -AvailabilityVerified $availability.verified `
                -Denylist $script:ModelDenylist -AvailableModels $validModels `
                -CapabilityRecord $(if ($capabilitiesCatalog.ContainsKey($modelId)) { $capabilitiesCatalog[$modelId] } else { $null }) `
                -ProfileRequirement $ctx.requirement -ProfileContextTier $ctx.contextTier -ProfileEffort $ctx.effort -CapabilityFreshnessDays $capabilityFreshnessDays
            [bool]$verdict.admissible
        })
        $policyPreferred = Get-PreferredModelForProfilePolicy -ProfileKey $profileKey -ValidModels $validModels -Policy $policy -AdmissibleModels $admissibleBaselineModels
        $currentVerdict = Get-ModelAdmissibilityVerdict -ModelId $currentModel -ProfileKey $profileKey -AvailabilityVerified $availability.verified `
            -Denylist $script:ModelDenylist -AvailableModels $validModels `
            -CapabilityRecord $(if ($capabilitiesCatalog.ContainsKey($currentModel)) { $capabilitiesCatalog[$currentModel] } else { $null }) `
            -ProfileRequirement $ctx.requirement -ProfileContextTier $ctx.contextTier -ProfileEffort $ctx.effort -CapabilityFreshnessDays $capabilityFreshnessDays
        $grandfatherCurrent = Test-ModelAdmissibilityGrandfatherable -Verdict $currentVerdict
        $activeOverride = Get-ActiveOverrideModel -Snapshot $priorSnapshot -ProfileKey $profileKey
        $overrideValid = $false
        if (-not [string]::IsNullOrWhiteSpace($activeOverride)) {
            $overrideValid = Test-ActiveOverrideAdmissible -ProfileKey $profileKey -ModelId $activeOverride `
                -AvailabilityVerified $availability.verified -Denylist $script:ModelDenylist -AvailableModels $validModels `
                -CapabilityRecord $(if ($capabilitiesCatalog.ContainsKey($activeOverride)) { $capabilitiesCatalog[$activeOverride] } else { $null }) `
                -ProfileRequirement $ctx.requirement -ProfileContextTier $ctx.contextTier -ProfileEffort $ctx.effort `
                -CapabilityFreshnessDays $capabilityFreshnessDays
        }
        # Rule 1 (grandfathering): if no admissible baseline exists
        # ($policyPreferred is null/empty), the existing current model is
        # kept unchanged rather than silently replaced -- this falls out of
        # the else-branch below with no special-casing needed.
        $target = if ($overrideValid) { $activeOverride } elseif ($grandfatherCurrent) { $currentModel } elseif (-not [string]::IsNullOrWhiteSpace($policyPreferred)) { $policyPreferred } else { $currentModel }
        $type = if ($overrideValid) { "active_override" } elseif ($target -ne $currentModel) { "policy_preference" } else { "none" }
        $decisions[$profileKey] = [pscustomobject]@{
            currentModel = $currentModel
            policyPreferred = $policyPreferred
            incumbentAfterPolicy = $target
            finalModel = $target
            changeType = $type
            benchmarkApplied = $false
            pendingCount = 0
            ctx = $ctx
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
    $profileAdmissibilityVerdicts = @{}
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
        $ctx = $d.ctx
        $activeStillValid = $true
        if (-not [string]::IsNullOrWhiteSpace($activeModel)) {
            $activeStillValid = Test-ActiveOverrideAdmissible -ProfileKey $profileKey -ModelId $activeModel `
                -AvailabilityVerified $availability.verified -Denylist $script:ModelDenylist -AvailableModels $validModels `
                -CapabilityRecord $(if ($capabilitiesCatalog.ContainsKey($activeModel)) { $capabilitiesCatalog[$activeModel] } else { $null }) `
                -ProfileRequirement $ctx.requirement -ProfileContextTier $ctx.contextTier -ProfileEffort $ctx.effort `
                -CapabilityFreshnessDays $capabilityFreshnessDays
        }
        # Rule 2: hardcoded fallback discovery (unverified) may still generate
        # baseline/report output, but must freeze benchmark promotion.
        $isFullFresh = (Test-FullFreshConsensusRunForProfile -Snapshot $rankingSnapshot -ProfileKey $profileKey) -and $availability.verified
        $candidate = if ($isFullFresh) {
            Get-BenchmarkConsensusCandidate -ProfileKey $profileKey -ValidModels $validModels -IncumbentModel $incumbent -Snapshot $rankingSnapshot `
                -AvailabilityVerified $availability.verified -Denylist $script:ModelDenylist -CapabilitiesCatalog $capabilitiesCatalog `
                -ProfileRequirement $ctx.requirement -ProfileContextTier $ctx.contextTier -ProfileEffort $ctx.effort -CapabilityFreshnessDays $capabilityFreshnessDays
        } else { $null }

        # Per-profile admissibility ledger for the review report (rule 9):
        # every discovered model other than the incumbent, with full reason
        # codes, regardless of whether it happens to also be a quality
        # challenger this run.
        $profileVerdicts = @($validModels | Where-Object { $_ -ne $incumbent } | ForEach-Object {
            $m = $_
            Get-ModelAdmissibilityVerdict -ModelId $m -ProfileKey $profileKey -AvailabilityVerified $availability.verified `
                -Denylist $script:ModelDenylist -AvailableModels $validModels `
                -CapabilityRecord $(if ($capabilitiesCatalog.ContainsKey($m)) { $capabilitiesCatalog[$m] } else { $null }) `
                -ProfileRequirement $ctx.requirement -ProfileContextTier $ctx.contextTier -ProfileEffort $ctx.effort -CapabilityFreshnessDays $capabilityFreshnessDays
        })
        # Rule 1: the incumbent/current model's own admissibility verdict is
        # always computed and carried into the ledger, even though it is
        # excluded from $profileVerdicts above -- this is what makes cases
        # like "current model is Sonnet 5 with unknown vision" visible in the
        # report instead of silently omitted.
        $incumbentVerdict = if (-not [string]::IsNullOrWhiteSpace($incumbent)) {
            Get-ModelAdmissibilityVerdict -ModelId $incumbent -ProfileKey $profileKey -AvailabilityVerified $availability.verified `
                -Denylist $script:ModelDenylist -AvailableModels $validModels `
                -CapabilityRecord $(if ($capabilitiesCatalog.ContainsKey($incumbent)) { $capabilitiesCatalog[$incumbent] } else { $null }) `
                -ProfileRequirement $ctx.requirement -ProfileContextTier $ctx.contextTier -ProfileEffort $ctx.effort -CapabilityFreshnessDays $capabilityFreshnessDays
        } else { $null }
        $profileAdmissibilityVerdicts[$profileKey] = [pscustomobject]@{
            verdicts = $profileVerdicts
            incumbentModel = $incumbent
            incumbentVerdict = $incumbentVerdict
            availabilityConfidence = $availability.confidence
            inputCeiling = [double]$ctx.requirement.inputCeilingPerMillion
            outputCeiling = [double]$ctx.requirement.outputCeilingPerMillion
        }

        $sourceDates = if ($isFullFresh -and $null -ne $candidate) { Get-RequiredSourceDatesForProfile -Snapshot $rankingSnapshot -ProfileKey $profileKey } else { @{} }
        $sourceVersions = if ($isFullFresh -and $null -ne $candidate) { Get-RequiredSourceVersionsForProfile -Snapshot $rankingSnapshot -ProfileKey $profileKey } else { @{} }

        $resolved = Resolve-BenchmarkConsensusState -ProfileKey $profileKey -PolicyPreferredModel $d.policyPreferred -IncumbentModel $incumbent -CurrentState $profileState -IsFullFreshRun $isFullFresh -Candidate $candidate -SourceDates $sourceDates -SourceVersions $sourceVersions -ActiveOverrideStillValid $activeStillValid -ForceImmediateApply $forceBenchmarkConsensus
        $profileState = $resolved.state
        $d.pendingCount = $resolved.pendingCount
        if ($resolved.activeCleared -and $d.changeType -eq "active_override") {
            $d.finalModel = if (-not [string]::IsNullOrWhiteSpace($d.policyPreferred)) { $d.policyPreferred } else { $d.currentModel }
            $d.changeType = "policy_preference"
        }
        if ($resolved.applied) {
            $d.finalModel = $resolved.finalModel
            $d.changeType = if ($resolved.forcedApply) { "benchmark_consensus_forced" } else { "benchmark_consensus" }
            $d.benchmarkApplied = $true
            $changeLabel = if ($resolved.forcedApply) { "benchmark_consensus_forced - manual override, first qualifying run" } else { "benchmark_consensus" }
            $benchmarkChanges.Add(('- "{0}": "{1}" -> "{2}" ({3})' -f $profileKey, $d.currentModel, $d.finalModel, $changeLabel))
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
    $lines += "Force benchmark consensus (manual first-run override): **$forceBenchmarkConsensus**"
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
    $lines += "## Model admissibility (rule 9: availability confidence, capability/pricing freshness, profile ceilings, exclusion reasons)"
    $lines += ""
    foreach ($profile in $profiles) {
        $k = [string]$profile.key
        $entry = $profileAdmissibilityVerdicts[$k]
        if ($null -eq $entry) { continue }
        $lines += Get-AdmissibilityReportLines -ProfileKey $k -Verdicts $entry.verdicts -AvailabilityConfidence $entry.availabilityConfidence -InputCeiling $entry.inputCeiling -OutputCeiling $entry.outputCeiling -IncumbentModel $entry.incumbentModel -IncumbentVerdict $entry.incumbentVerdict
    }
    $lines += $rankingReportLines

    Set-Content -Path $reportPath -Value (($lines -join "`r`n").TrimEnd()) -Encoding UTF8
    Write-Host "Wrote $reportPath"
    if ($profilesUpdated) { Write-Host "Updated $profilesPath" }
}

if ($MyInvocation.InvocationName -ne '.') {
    Invoke-TaskProfileReview
}
