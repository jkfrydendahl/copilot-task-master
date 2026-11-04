Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")
. (Join-Path $PSScriptRoot "model-release-data.ps1")

function Get-MeasuredCostPolicy {
    param($SelectionPolicy)
    $measured = Get-ObjectMemberValue $SelectionPolicy "measuredCost"
    if ($measured -isnot [System.Collections.IDictionary] -or (Get-ObjectMemberValue $measured "enabled") -ne $true) { return $null }
    return $measured
}

function Get-ProfileUsageEvidence {
    # Configuration-matched measured consumption on one common whole-suite cost workload. This is deliberately separate
    # from the task-specific quality evidence: it never reads a score, and anything that cannot be proven to describe
    # the same configuration on the same workload is reported as unusable with a reason, never repaired or guessed.
    param(
        [AllowEmptyCollection()][object[]]$Configurations,
        $Source,
        [Parameter(Mandatory)][hashtable]$Aliases,
        [Parameter(Mandatory)][hashtable]$Policy,
        [datetime]$NowUtc = [datetime]::UtcNow
    )
    $measured = Get-MeasuredCostPolicy (Get-ObjectMemberValue $Policy "selectionPolicy")
    if ($null -eq $measured) { return $null }
    $usage = Get-ObjectMemberValue $Source "usage"
    $usageModels = Get-ObjectMemberValue $usage "models"
    $workload = Get-ObjectMemberValue $usage "workload"
    $sourceFingerprint = Get-ObjectMemberValue $workload "fingerprint"
    $sourceStatus = Get-ObjectMemberValue $Source "status"
    $publication = Get-ObjectMemberValue $Source "sourceDate"
    $sourceReason = if ($sourceStatus -eq "cached") { "usage_source_cached" }
        elseif ($sourceStatus -ne "ok") { "usage_source_unavailable" }
        elseif (-not (Test-ModelDataFresh (Get-ObjectMemberValue $Source "fetchedAtUtc") $Policy.consensusPolicy.staleAfterDays $NowUtc) -or
            (-not [string]::IsNullOrWhiteSpace([string]$publication) -and
                -not (Test-ModelDataFresh $publication $Policy.consensusPolicy.benchmarkMaxPublicationAgeDays $NowUtc))) { "usage_source_stale" }
        elseif ($usageModels -isnot [System.Collections.IDictionary]) { "usage_missing" }
        elseif ((Get-ObjectMemberValue $workload "id") -ne $measured.workload -or
            $sourceFingerprint -isnot [string] -or [string]::IsNullOrWhiteSpace($sourceFingerprint)) { "usage_workload_mismatch" }
        else { $null }
    $aliasUses = @{}
    foreach ($knownModel in $Aliases.Keys) {
        $knownMapping = Get-ObjectMemberValue $Aliases[$knownModel] "artificialAnalysis"
        if ($knownMapping -isnot [System.Collections.IDictionary]) { continue }
        foreach ($knownEffort in $knownMapping.Keys) {
            $knownAlias = [string]$knownMapping[$knownEffort]
            if (-not $aliasUses.ContainsKey($knownAlias)) { $aliasUses[$knownAlias] = 0 }
            $aliasUses[$knownAlias]++
        }
    }
    $modelReleases = @{}
    $configurationUsage = @{}
    foreach ($configuration in @($Configurations | Where-Object { $null -ne $_ })) {
        $model = $configuration.model
        $effort = $configuration.effort
        $mapping = Get-ObjectMemberValue (Get-ObjectMemberValue $Aliases $model) "artificialAnalysis"
        $alias = if ($mapping -is [System.Collections.IDictionary]) { Get-ObjectMemberValue $mapping $effort } else { $null }
        $row = $null
        $reason = $null
        if ([string]::IsNullOrWhiteSpace([string]$alias)) { $reason = "usage_alias_not_configured" }
        elseif ($aliasUses[[string]$alias] -gt 1) { $reason = "usage_alias_ambiguous" }
        elseif ($null -ne $sourceReason) { $reason = $sourceReason }
        else {
            $row = Get-ObjectMemberValue $usageModels ([string]$alias)
            if ($null -eq $row) { $reason = "usage_missing" }
        }
        if ($null -eq $reason) {
            $identity = Get-ObjectMemberValue (Get-ObjectMemberValue $Source "identities") ([string]$alias)
            $releaseId = Get-ObjectMemberValue $identity "releaseId"
            if (-not $modelReleases.ContainsKey($model)) {
                $modelReleases[$model] = Get-ModelReleaseEvidence -Model $model -Source $Source -Aliases $Aliases `
                    -StaleAfterDays $Policy.consensusPolicy.staleAfterDays -NowUtc $NowUtc
            }
            $name = [string](Get-ObjectMemberValue $row "name")
            $namedEffort = if ($name -match '\((?<effort>none|minimal|low|medium|high|xhigh|max)\)') {
                $Matches.effort.ToLowerInvariant()
            } else { $null }
            if ((Get-ObjectMemberValue $identity "status") -ne "verified" -or (Get-ObjectMemberValue $identity "effort") -ne $effort -or
                $releaseId -isnot [string] -or [string]::IsNullOrWhiteSpace($releaseId) -or
                $modelReleases[$model].status -in @("conflicting","invalid_or_ambiguous","alias_ambiguous") -or
                ($null -ne $namedEffort -and $namedEffort -ne $effort) -or $name -match '(?i)\bfallback\b|\bensemble\b|\s\+\s') {
                $reason = "usage_identity_unverified"
            } elseif ((Get-ObjectMemberValue $row "status") -ne "verified") {
                $rowReasons = @(Get-ObjectMemberValue $row "reasons")
                $reason = if ("usage_conflicting" -in $rowReasons) { "usage_conflicting" }
                    elseif ("usage_workload_mismatch" -in $rowReasons) { "usage_workload_mismatch" }
                    else { "usage_counts_invalid" }
            } elseif ((Get-ObjectMemberValue $row "workloadFingerprint") -ne $sourceFingerprint) {
                $reason = "usage_workload_mismatch"
            } elseif ((Get-ObjectMemberValue $row "effort") -ne $effort -or (Get-ObjectMemberValue $row "releaseId") -ne $releaseId) {
                $reason = "usage_identity_unverified"
            } else {
                # The builder re-validates counts: it must not trust that a captured or cached source was well formed.
                $inputTokens = Get-ObjectMemberValue $row "inputTokens"
                $outputTokens = Get-ObjectMemberValue $row "outputTokens"
                $answerTokens = Get-ObjectMemberValue $row "answerTokens"
                $reasoningTokens = Get-ObjectMemberValue $row "reasoningTokens"
                if (-not (Test-ModelTokenCount $inputTokens) -or -not (Test-ModelTokenCount $outputTokens) -or
                    -not (Test-ModelTokenCount $answerTokens -AllowZero) -or -not (Test-ModelTokenCount $reasoningTokens -AllowZero) -or
                    [decimal]$answerTokens + [decimal]$reasoningTokens -ne [decimal]$outputTokens) {
                    $reason = "usage_counts_invalid"
                }
            }
        }
        $configurationUsage[[string]$configuration.configurationId] = [pscustomobject]@{
            configurationId = [string]$configuration.configurationId
            model = $model
            effort = $effort
            context = $configuration.context
            alias = [string]$alias
            status = if ($null -eq $reason) { "valid" } else { "invalid" }
            reasons = @($reason | Where-Object { $null -ne $_ })
            inputTokens = if ($null -eq $reason) { [long]$row.inputTokens } else { $null }
            outputTokens = if ($null -eq $reason) { [long]$row.outputTokens } else { $null }
            workloadId = $measured.workload
            workloadFingerprint = if ($null -eq $reason) { $sourceFingerprint } else { $null }
        }
    }
    return [pscustomobject]@{
        enabled = $true
        workload = [pscustomobject]@{id=$measured.workload;fingerprint=$(if ($sourceFingerprint -is [string]) { $sourceFingerprint } else { $null })}
        configurations = $configurationUsage
    }
}
