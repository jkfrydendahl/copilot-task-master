Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-value-selection.ps1")
. (Join-Path $PSScriptRoot "model-configuration.ps1")
. (Join-Path $PSScriptRoot "model-role-evidence.ps1")

function Get-ProfileSelection {
    param(
        [Parameter(Mandatory)]$Profile,
        [AllowEmptyCollection()][object[]]$Evidence,
        [AllowEmptyCollection()][object[]]$Verdicts,
        [Parameter(Mandatory)][hashtable]$Policy,
        [Parameter(Mandatory)][hashtable]$Aliases
    )
    $strategy = $Policy.selectionPolicy.profiles[$Profile.key].strategy
    $configurationPolicy = Get-ObjectMemberValue $Policy.selectionPolicy.profiles[$Profile.key] "configurationSelection"
    $configurationMode = if ($null -eq $configurationPolicy) { "fixed" } else { $configurationPolicy.mode }
    if ($strategy -notin @("quality_first", "value_balanced")) { throw "Unknown selection strategy for '$($Profile.key)'." }
    $byConfiguration = @{}
    foreach ($verdict in $Verdicts) {
        $configuration = Get-RecordModelConfiguration -Record $verdict -Profile $Profile -RequireExplicitEffort:($configurationMode -eq "bounded_effort")
        $byConfiguration[$configuration.configurationId] = $verdict
    }
    $incumbentVerdict = @($Verdicts | Where-Object modelId -eq $Profile.model | Select-Object -First 1)
    $incumbentCapability = if ($incumbentVerdict.Count) { Get-ObjectMemberValue $incumbentVerdict[0] "capabilities" } else { $null }
    $currentConfiguration = New-ModelConfiguration -Model $Profile.model -Effort $Profile.effort -Context $Profile.context -CapabilityRecord $incumbentCapability
    $incumbentCost = Get-ModelReferenceCost $byConfiguration[$currentConfiguration.configurationId] $Policy.selectionPolicy
    $Evidence = @(foreach ($record in $Evidence) {
        $configuration = Get-RecordModelConfiguration -Record $record -Profile $Profile -RequireExplicitEffort:($configurationMode -eq "bounded_effort")
        $normalized = [pscustomobject]$record | Select-Object -Property *
        $normalized | Add-Member -NotePropertyMembers @{
            effort=$configuration.effort;context=$configuration.context;configurationId=$configuration.configurationId
        } -Force
        $normalized
    })
    $comparisonEvidence = @($Evidence | Where-Object {
        $metric = Get-ObjectMemberValue $Policy.evidenceMetrics "$($_.source).$($_.metric)"
        $null -ne $metric -and (Test-ModelScore $_.score $metric.min $metric.max)
    })
    $Evidence = @($Evidence | Where-Object {
        $configurationMode -ne "bounded_effort" -or (
            $_.context -eq $Profile.context -and (
                $configurationPolicy.allowedEfforts -contains $_.effort -or
                ($_.effort -eq "none" -and
                    (Get-ObjectMemberValue (Get-ObjectMemberValue $byConfiguration[$_.configurationId] "capabilities") "effortMode") -eq "unsupported")
            )
        )
    })
    $eligible = @($Evidence | Where-Object {
        $byConfiguration.ContainsKey($_.configurationId) -and $byConfiguration[$_.configurationId].admissible
    })
    $contract = $Policy.selectionPolicy.profiles[$Profile.key]
    $role = Get-RoleEvidencePool -Profile $Profile -Policy $Policy -Eligible $eligible
    $pool = @($role.pool)
    $decidingSource = if ($pool.Count) { $pool[0].source } else { $null }

    $fingerprint = Get-ModelDataFingerprint @{
        profile = $Profile.key
        effort = $Profile.effort
        context = $Profile.context
        policy = $Policy
        aliases = $Aliases
    }
    if (-not $pool.Count) {
        return [pscustomobject]@{
            winner = $null
            currentConfiguration = $currentConfiguration
            configurationMode = $configurationMode
            allowedEfforts = @(Get-ObjectMemberValue $configurationPolicy "allowedEfforts")
            candidateReferenceAic = $null
            incumbentReferenceAic = $(if ($null -ne $incumbentCost) { $incumbentCost * 100 } else { $null })
            strategy = $strategy
            valueDecision = $null
            qualityWinner = $null
            decidingSource = $null
            reason = "retained_insufficient_evidence"
            confidence = "none"
            contested = $false
            policyFingerprint = $fingerprint
            observation = $null
            freshObservation = $false
            metricKey = $null
            decidingMetric = $null
            evidenceRoutes = $contract.evidenceRoutes
            supportingMetrics = $contract.supportingMetrics
            metricDefinitions = $Policy.evidenceMetrics
            routeIndex = -1
            roleDiagnostics = $role.diagnostics
        }
    }

    $sortOrder = @(
        @{ Expression = { $_.score }; Descending = $true }
        @{
            Expression = {
                Get-ModelReferenceCost $byConfiguration[$_.configurationId] $Policy.selectionPolicy
            }
        }
        @{ Expression = { if ($_.configurationId -eq $currentConfiguration.configurationId) { 0 } else { 1 } } }
        "model"
        "effort"
        "context"
    )
    $ranked = @($pool | Sort-Object -Property $sortOrder)
    $winner = $ranked[0]
    $valueDecision = $null
    if ($strategy -eq "value_balanced") {
        $valueDecision = Get-ValueBalancedSelection $Profile $ranked $byConfiguration $Policy.selectionPolicy $comparisonEvidence $currentConfiguration
        $winner = $valueDecision.winner
    }
    $definition = $Policy.evidenceMetrics[$role.metricKey]
    $qualityPool = @($Evidence | Where-Object {
        $_.source -eq $decidingSource -and $_.cached -eq $winner.cached -and
        (Test-BenchmarkEvidenceComparable $_ $winner) -and
        (Test-ModelScore $_.score $definition.min $definition.max) -and
        $byConfiguration.ContainsKey($_.configurationId) -and
        @($byConfiguration[$_.configurationId].reasonCodes | Where-Object {
            $_ -notin @("pricing_input_exceeds_ceiling", "pricing_output_exceeds_ceiling")
        }).Count -eq 0
    } | Sort-Object -Property @{ Expression = { $_.score }; Descending = $true }, model)
    $qualityWinner = $qualityPool[0]

    $companion = @($contract.evidenceRoutes | Where-Object {
        $other = $Policy.evidenceMetrics[$_]
        $other.source -ne $decidingSource -and -not @($other.lineage | Where-Object { $_ -in $definition.lineage }).Count
    } | Select-Object -First 1)
    $companionRecords = if ($companion.Count) {
        $other = $Policy.evidenceMetrics[$companion[0]]
        @($eligible | Where-Object { $_.source -eq $other.source -and $_.metric -eq $other.metric })
    } else { @() }
    $lbWinner = @($companionRecords | Where-Object configurationId -eq $winner.configurationId)
    $poolConfigurations = @($pool | ForEach-Object configurationId)
    $lbComparable = @($companionRecords | Where-Object {
        $poolConfigurations -contains $_.configurationId -and $lbWinner.Count -and
        (Test-BenchmarkEvidenceComparable $_ $lbWinner[0])
    })
    $lbTolerance = 0
    if ($strategy -eq "value_balanced" -and $lbWinner.Count) {
        $lbMetric = "$($lbWinner[0].source).$($lbWinner[0].metric)"
        $lbTolerance = Get-ObjectMemberValue $Policy.selectionPolicy.profiles[$Profile.key].qualityBands $lbMetric
        if ($null -eq $lbTolerance) { throw "Missing quality band '$lbMetric' for '$($Profile.key)'." }
    }
    $contested = $role.routeIndex -eq 0 -and $lbWinner.Count -gt 0 -and
        @($lbComparable | Where-Object { $_.score -gt $lbWinner[0].score + $lbTolerance }).Count -gt 0

    if ($role.routeIndex -gt 0) {
        $reason = if ($decidingSource -eq "liveBench") { "livebench_fallback" } else { "role_metric_fallback" }
    } elseif ($ranked[0].score -lt $qualityWinner.score) {
        $reason = "budget_constrained_choice"
    } elseif ($strategy -eq "value_balanced") {
        $reason = "value_balanced_choice"
    } else {
        $reason = "quality_winner"
    }
    $reducedConfidence = $winner.publicationAgeUnknown -or $winner.cached -or
        $lbWinner.Count -eq 0 -or @($lbComparable.model | Select-Object -Unique).Count -lt 2 -or
        $role.routeIndex -gt 0 -or $contested -or
        $lbWinner[0].cached -or $lbWinner[0].publicationAgeUnknown
    $hasVersion = -not [string]::IsNullOrWhiteSpace([string]$winner.sourceVersion)
    $promotionBlockReason = $null
    if ($role.routeIndex -gt 0 -and
        $winner.configurationId -ne $currentConfiguration.configurationId) {
        $matchedIncumbent = @($comparisonEvidence | Where-Object {
            $_.configurationId -eq $currentConfiguration.configurationId -and (Test-BenchmarkEvidenceComparable $_ $winner)
        })
        if (-not $hasVersion -or -not $matchedIncumbent.Count) {
            $promotionBlockReason = "retained_fallback_incumbent_evidence_missing"
        }
    }
    $observation = Get-ModelDataFingerprint @{
        source = $decidingSource
        metric = $winner.metric
        sourceVersion = $winner.sourceVersion
    }
    $metadata = Get-ObjectMemberValue $winner "sourceMetadata"
    $evidenceIdentity = Get-ModelDataFingerprint @{
        metricKey=$role.metricKey
        metricIdentity=(Get-ObjectMemberValue $winner "metricIdentity")
        variantId=(Get-ObjectMemberValue $metadata "variantId")
        harness=(Get-ObjectMemberValue $metadata "harness")
        versions=(Get-ObjectMemberValue $metadata "versions")
        suite=(Get-ObjectMemberValue $metadata "suiteFingerprint")
    }
    $candidateCost = Get-ModelReferenceCost $byConfiguration[$winner.configurationId] $Policy.selectionPolicy
    return [pscustomobject]@{
        winner = $winner
        currentConfiguration = $currentConfiguration
        configurationMode = $configurationMode
        allowedEfforts = @(Get-ObjectMemberValue $configurationPolicy "allowedEfforts")
        candidateReferenceAic = $(if ($null -ne $candidateCost) { $candidateCost * 100 } else { $null })
        incumbentReferenceAic = $(if ($null -ne $incumbentCost) { $incumbentCost * 100 } else { $null })
        strategy = $strategy
        valueDecision = $valueDecision
        qualityWinner = $qualityWinner
        decidingSource = $decidingSource
        reason = $reason
        confidence = $(if ($reducedConfidence) { "reduced" } else { "corroborated" })
        contested = $contested
        policyFingerprint = $fingerprint
        observation = $observation
        freshObservation = -not $winner.cached -and $hasVersion
        promotionBlockReason = $promotionBlockReason
        evidenceIdentity = $evidenceIdentity
        metricKey = $role.metricKey
        decidingMetric = $winner.metric
        evidenceRoutes = $contract.evidenceRoutes
        supportingMetrics = $contract.supportingMetrics
        metricDefinitions = $Policy.evidenceMetrics
        routeIndex = $role.routeIndex
        roleDiagnostics = $role.diagnostics
    }
}

function Resolve-ProfileSelectionState {
    param(
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()][string]$CurrentModel,
        [Parameter(Mandatory)]$Selection,
        $State = $null,
        [switch]$ForceImmediateApply,
        [datetime]$NowUtc = [datetime]::UtcNow
    )
    $compatible = (Get-ObjectMemberValue $State "policyFingerprint") -eq $Selection.policyFingerprint -and
        (Get-ObjectMemberValue $State "schemaVersion") -eq 3
    $next = [ordered]@{
        schemaVersion = 3
        policyFingerprint = $Selection.policyFingerprint
        pending = $null
        activeOverride = $null
        observations = @{}
        latestSourceDates = @{}
        legacyLatestSourceDates = @{}
        incumbentBasis = $null
    }
    if ($compatible) {
        $next = ConvertTo-CanonicalModelData $State
    } else {
        foreach ($field in @("latestSourceDates","legacyLatestSourceDates","activeOverride","incumbentBasis")) {
            $value = Get-ObjectMemberValue $State $field
            if ($null -ne $value) { $next[$field] = ConvertTo-CanonicalModelData $value }
        }
        if ((Get-ObjectMemberValue $State "schemaVersion") -ne 3) {
            $next.legacyLatestSourceDates = ConvertTo-CanonicalModelData $next.latestSourceDates
        }
    }
    $currentConfiguration = New-ModelConfiguration -Model $CurrentModel -Effort $Selection.currentConfiguration.effort -Context $Selection.currentConfiguration.context
    if ((Get-ObjectMemberValue $next.incumbentBasis "configurationId") -ne $currentConfiguration.configurationId) {
        $next.incumbentBasis = $null
    }
    $legacy = $next.activeOverride
    # Schema 2 identifies the specialized agent metric unambiguously, unlike its
    # general AA source, which could mean either Coding or Intelligence.
    if ($null -eq $next.incumbentBasis -and (Get-ObjectMemberValue $State "schemaVersion") -eq 2 -and
        (Get-ObjectMemberValue $legacy "decidingSource") -eq "artificialAnalysisCodingAgents" -and
        (Get-ObjectMemberValue $legacy "configurationId") -eq $currentConfiguration.configurationId -and
        (Get-ObjectMemberValue $legacy "model") -eq $currentConfiguration.model -and
        (Get-ObjectMemberValue $legacy "effort") -eq $currentConfiguration.effort -and
        (Get-ObjectMemberValue $legacy "context") -eq $currentConfiguration.context -and
        -not [string]::IsNullOrWhiteSpace([string](Get-ObjectMemberValue $legacy "evidenceIdentity"))) {
        $next.incumbentBasis = @{
            configurationId=$currentConfiguration.configurationId
            metricKey="artificialAnalysisCodingAgents.codingAgentIndex"
            evidenceIdentity=$legacy.evidenceIdentity
            observation=(Get-ObjectMemberValue $legacy "observation")
            observedAtUtc=(Get-ObjectMemberValue $legacy "activatedAtUtc")
            provenance="legacy_schema_2_agent_source"
        }
    }
    $result = [pscustomobject]@{
        state = $next
        finalModel = $CurrentModel
        finalConfiguration = $currentConfiguration
        applied = $false
        status = $Selection.reason
    }
    if ($null -eq $Selection.winner) {
        return $result
    }
    $winner = $Selection.winner
    $winnerConfiguration = New-ModelConfiguration -Model $winner.model -Effort $winner.effort -Context $winner.context
    if (-not $Selection.freshObservation) {
        $result.status = "retained_cached_evidence"
        return $result
    }
    $source = $Selection.decidingSource
    $metricKey = $Selection.metricKey
    $sourceDate = $winner.sourceDate
    $dateKey = $metricKey
    if ([string]::IsNullOrWhiteSpace([string]$sourceDate)) {
        $sourceDate = Get-ObjectMemberValue $winner "artifactPublishedAtUtc"
        $dateKey = "${metricKey}:artifact"
    }
    $lastDate = Get-ObjectMemberValue $next.latestSourceDates $dateKey
    if ($null -eq $lastDate -and $dateKey -eq $metricKey) {
        $lastDate = Get-ObjectMemberValue $next.legacyLatestSourceDates $source
    }
    if ($null -ne $lastDate -and -not [string]::IsNullOrWhiteSpace([string]$sourceDate) -and
        [datetime]$sourceDate -lt [datetime]$lastDate) {
        $result.status = "retained_source_regression"
        return $result
    }
    # Publication rollback protection tracks observations, not just promotion attempts.
    if (-not [string]::IsNullOrWhiteSpace([string]$sourceDate)) {
        if ($dateKey -eq $metricKey) { $next.latestSourceDates[$source] = $sourceDate }
        $next.latestSourceDates[$dateKey] = $sourceDate
    }
    $promotionBlockReason = Get-ObjectMemberValue $Selection "promotionBlockReason"
    if ($null -ne $promotionBlockReason) {
        $result.status = $promotionBlockReason
        return $result
    }
    $basisIndex = [array]::IndexOf(@($Selection.evidenceRoutes), (Get-ObjectMemberValue $next.incumbentBasis "metricKey"))
    $winnerBasis = @{
        configurationId=$winnerConfiguration.configurationId;metricKey=$metricKey
        sourceVersion=$winner.sourceVersion;evidenceIdentity=$Selection.evidenceIdentity
        metricIdentity=(Get-ObjectMemberValue $winner "metricIdentity")
        observedAtUtc=$NowUtc.ToUniversalTime().ToString("o")
    }
    if ($winnerConfiguration.configurationId -eq $currentConfiguration.configurationId) {
        $next.pending = $null
        if ($basisIndex -lt 0 -or $Selection.routeIndex -le $basisIndex) { $next.incumbentBasis = $winnerBasis }
        return $result
    }
    if ($basisIndex -ge 0 -and $basisIndex -lt $Selection.routeIndex) {
        $result.status = "retained_stronger_incumbent_basis"
        return $result
    }
    $history = @(Get-ObjectMemberValue $next.observations $metricKey | Where-Object { $null -ne $_ })
    $seen = $history -contains $Selection.observation
    $pending = $next.pending
    $evidenceIdentity = Get-ObjectMemberValue $Selection "evidenceIdentity"
    $sameCandidate = $null -ne $pending -and (Get-ObjectMemberValue $pending "configurationId") -eq $winnerConfiguration.configurationId -and
        (Get-ObjectMemberValue $pending "metricKey") -eq $metricKey -and (Get-ObjectMemberValue $pending "evidenceIdentity") -eq $evidenceIdentity
    $count = if ($sameCandidate) { [int]$pending.count } else { 0 }
    if (-not $seen) {
        $count++
        $next.observations[$metricKey] = @($history) + @($Selection.observation)
    }
    $next.pending = [ordered]@{
        model = $winner.model
        effort = $winnerConfiguration.effort
        context = $winnerConfiguration.context
        configurationId = $winnerConfiguration.configurationId
        decidingSource = $source
        metricKey = $metricKey
        count = $count
        observation = $Selection.observation
        evidenceIdentity = $evidenceIdentity
        updatedAtUtc = $NowUtc.ToUniversalTime().ToString("o")
    }
    if ($ForceImmediateApply -or $count -ge 2) {
        $next.activeOverride = [ordered]@{
            model = $winner.model
            effort = $winnerConfiguration.effort
            context = $winnerConfiguration.context
            configurationId = $winnerConfiguration.configurationId
            policyFingerprint = $Selection.policyFingerprint
            decidingSource = $source
            metricKey = $metricKey
            observation = $Selection.observation
            evidenceIdentity = $evidenceIdentity
            activatedAtUtc = $NowUtc.ToUniversalTime().ToString("o")
            forced = [bool]$ForceImmediateApply
        }
        $next.pending = $null
        $next.incumbentBasis = $winnerBasis
        $result.finalModel = $winner.model
        $result.finalConfiguration = $winnerConfiguration
        $result.applied = $true
        $result.status = "applied_$($Selection.reason)"
    } else {
        $result.status = "pending_$($Selection.reason)"
    }
    return $result
}
