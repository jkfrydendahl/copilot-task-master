Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-value-selection.ps1")

function Get-ProfileSelection {
    param(
        [Parameter(Mandatory)]$Profile,
        [AllowEmptyCollection()][object[]]$Evidence,
        [AllowEmptyCollection()][object[]]$Verdicts,
        [Parameter(Mandatory)][hashtable]$Policy,
        [Parameter(Mandatory)][hashtable]$Aliases
    )
    $strategy = $Policy.selectionPolicy.profiles[$Profile.key].strategy
    if ($strategy -notin @("quality_first", "value_balanced")) { throw "Unknown selection strategy for '$($Profile.key)'." }
    $byModel = @{}
    foreach ($verdict in $Verdicts) {
        $byModel[$verdict.modelId] = $verdict
    }
    $eligible = @($Evidence | Where-Object {
        $byModel.ContainsKey($_.model) -and $byModel[$_.model].admissible
    })
    $sources = @("artificialAnalysis", "liveBench")
    if ($Profile.key -eq "agentic-implementation") {
        $sources = @("artificialAnalysisCodingAgents") + $sources
    }

    $decidingSource = $null
    $pool = @()
    foreach ($cached in @($false, $true)) {
        foreach ($source in $sources) {
            $pool = @($eligible | Where-Object { $_.source -eq $source -and $_.cached -eq $cached })
            if ($pool.Count) {
                $decidingSource = $source
                break
            }
        }
        if ($pool.Count) { break }
    }

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
        }
    }

    $sortOrder = @(
        @{ Expression = { $_.score }; Descending = $true }
        @{
            Expression = {
                Get-ModelReferenceCost $byModel[$_.model] $Policy.selectionPolicy
            }
        }
        @{ Expression = { if ($_.model -eq $Profile.model) { 0 } else { 1 } } }
        "model"
    )
    $ranked = @($pool | Sort-Object -Property $sortOrder)
    $winner = $ranked[0]
    $valueDecision = $null
    if ($strategy -eq "value_balanced") {
        $valueDecision = Get-ValueBalancedSelection $Profile $ranked $byModel $Policy.selectionPolicy $Evidence
        $winner = $valueDecision.winner
    }
    $qualityPool = @($Evidence | Where-Object {
        $_.source -eq $decidingSource -and $byModel.ContainsKey($_.model) -and
        @($byModel[$_.model].reasonCodes | Where-Object {
            $_ -notin @("pricing_input_exceeds_ceiling", "pricing_output_exceeds_ceiling")
        }).Count -eq 0
    } | Sort-Object -Property @{ Expression = { $_.score }; Descending = $true }, model)
    $qualityWinner = $qualityPool[0]

    $lbWinner = @($eligible | Where-Object { $_.source -eq "liveBench" -and $_.model -eq $winner.model })
    $poolModels = @($pool | ForEach-Object model)
    $lbComparable = @($eligible | Where-Object { $_.source -eq "liveBench" -and $poolModels -contains $_.model })
    $lbTolerance = 0
    if ($strategy -eq "value_balanced" -and $lbWinner.Count) {
        $lbMetric = "liveBench.$($lbWinner[0].metric)"
        $lbTolerance = Get-ObjectMemberValue $Policy.selectionPolicy.profiles[$Profile.key].qualityBands $lbMetric
        if ($null -eq $lbTolerance) { throw "Missing quality band '$lbMetric' for '$($Profile.key)'." }
    }
    $contested = $decidingSource -ne "liveBench" -and $lbWinner.Count -gt 0 -and
        @($lbComparable | Where-Object { $_.score -gt $lbWinner[0].score + $lbTolerance }).Count -gt 0

    if ($decidingSource -eq "liveBench") {
        $reason = "livebench_fallback"
    } elseif ($ranked[0].score -lt $qualityWinner.score) {
        $reason = "budget_constrained_choice"
    } elseif ($Profile.key -eq "agentic-implementation" -and $decidingSource -eq "artificialAnalysis") {
        $reason = "aa_coding_fallback"
    } elseif ($strategy -eq "value_balanced") {
        $reason = "value_balanced_choice"
    } else {
        $reason = "quality_winner"
    }
    $reducedConfidence = $winner.publicationAgeUnknown -or $winner.cached -or
        $lbWinner.Count -eq 0 -or $lbComparable.Count -lt 2 -or
        $decidingSource -ne "artificialAnalysis" -or $contested -or
        $lbWinner[0].cached -or $lbWinner[0].publicationAgeUnknown
    $hasVersion = -not [string]::IsNullOrWhiteSpace([string]$winner.sourceVersion)
    $observation = Get-ModelDataFingerprint @{
        source = $decidingSource
        sourceVersion = $winner.sourceVersion
    }
    return [pscustomobject]@{
        winner = $winner
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
        (Get-ObjectMemberValue $State "schemaVersion") -eq 1
    $next = [ordered]@{
        schemaVersion = 1
        policyFingerprint = $Selection.policyFingerprint
        pending = $null
        activeOverride = $null
        observations = @{}
        latestSourceDates = @{}
    }
    if ($compatible) {
        $next = ConvertTo-CanonicalModelData $State
    }
    $result = [pscustomobject]@{
        state = $next
        finalModel = $CurrentModel
        applied = $false
        status = $Selection.reason
    }
    if ($null -eq $Selection.winner) {
        return $result
    }
    $winner = $Selection.winner
    if ($winner.model -eq $CurrentModel) {
        $next.pending = $null
        return $result
    }
    if (-not $Selection.freshObservation) {
        $result.status = "retained_cached_evidence"
        return $result
    }
    $promotionBlockReason = Get-ObjectMemberValue $Selection.valueDecision "promotionBlockReason"
    if ($promotionBlockReason) {
        $result.status = $promotionBlockReason
        return $result
    }
    $source = $Selection.decidingSource
    $sourceDate = $winner.sourceDate
    $lastDate = Get-ObjectMemberValue $next.latestSourceDates $source
    if ($null -ne $lastDate -and -not [string]::IsNullOrWhiteSpace([string]$sourceDate) -and
        [datetime]$sourceDate -lt [datetime]$lastDate) {
        $result.status = "retained_source_regression"
        return $result
    }
    $history = @(Get-ObjectMemberValue $next.observations $source | Where-Object { $null -ne $_ })
    $seen = $history -contains $Selection.observation
    $pending = $next.pending
    $sameCandidate = $null -ne $pending -and $pending.model -eq $winner.model -and $pending.decidingSource -eq $source
    $count = if ($sameCandidate) { [int]$pending.count } else { 0 }
    if (-not $seen) {
        $count++
        $next.observations[$source] = @($history) + @($Selection.observation)
    }
    if (-not [string]::IsNullOrWhiteSpace([string]$sourceDate)) {
        $next.latestSourceDates[$source] = $sourceDate
    }
    $next.pending = [ordered]@{
        model = $winner.model
        decidingSource = $source
        count = $count
        observation = $Selection.observation
        updatedAtUtc = $NowUtc.ToUniversalTime().ToString("o")
    }
    if ($ForceImmediateApply -or $count -ge 2) {
        $next.activeOverride = [ordered]@{
            model = $winner.model
            policyFingerprint = $Selection.policyFingerprint
            decidingSource = $source
            observation = $Selection.observation
            activatedAtUtc = $NowUtc.ToUniversalTime().ToString("o")
            forced = [bool]$ForceImmediateApply
        }
        $next.pending = $null
        $result.finalModel = $winner.model
        $result.applied = $true
        $result.status = "applied_$($Selection.reason)"
    } else {
        $result.status = "pending_$($Selection.reason)"
    }
    return $result
}
