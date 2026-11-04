Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")
. (Join-Path $PSScriptRoot "model-role-evidence.ps1")
. (Join-Path $PSScriptRoot "model-release-data.ps1")
. (Join-Path $PSScriptRoot "model-usage-evidence.ps1")

function Get-ModelWorkloadCost {
    # Uncached price of one input/output token workload at the verdict's own GitHub rates. Output tokens already
    # include reasoning, so reasoning is never charged a second time.
    param($Verdict, $InputTokens, $OutputTokens)
    $price = Get-ObjectMemberValue $Verdict "pricing"
    $priceErrors = @(Get-ObjectMemberValue $Verdict "reasonCodes" | Where-Object {
        $_ -in @("pricing_missing", "pricing_invalid", "pricing_stale")
    })
    if ($null -eq $price -or $priceErrors.Count) { return $null }
    return [decimal]$price.inputPerMillion * [decimal]$InputTokens / 1000000 +
        [decimal]$price.outputPerMillion * [decimal]$OutputTokens / 1000000
}

function Get-ModelReferenceCost {
    param($Verdict, $SelectionPolicy)
    return Get-ModelWorkloadCost $Verdict $SelectionPolicy.referenceInputTokens $SelectionPolicy.referenceOutputTokens
}

function Get-ValueQualifiedEvidence {
    # The value-balanced competitor set: ranked records within the policy band of the quality reference. Shared so the
    # cost basis is decided over exactly the configurations the value decision compares.
    param($Profile, $RankedEvidence, $SelectionPolicy, $QualityReference = $null)
    $reference = if ($null -ne $QualityReference) { $QualityReference } else { $RankedEvidence[0] }
    $metricKey = "$($reference.source).$($reference.metric)"
    $bands = $SelectionPolicy.profiles[$Profile.key].qualityBands
    $maxGap = Get-ObjectMemberValue $bands $metricKey
    if ($null -eq $maxGap) { throw "Missing quality band '$metricKey' for '$($Profile.key)'." }
    return [pscustomobject]@{
        reference = $reference
        maxScoreGap = $maxGap
        qualified = @($RankedEvidence | Where-Object { $_.score -ge $reference.score - $maxGap })
    }
}

function Get-UsageEntryProblems {
    param($Entry, [string]$WorkloadId, $WorkloadFingerprint)
    if ($null -eq $Entry) { return @("usage_missing") }
    if ((Get-ObjectMemberValue $Entry "status") -ne "valid") {
        $entryReasons = @(Get-ObjectMemberValue $Entry "reasons" | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) })
        if ($entryReasons.Count) { return $entryReasons }
        return @("usage_invalid")
    }
    if ((Get-ObjectMemberValue $Entry "workloadId") -ne $WorkloadId -or
        $WorkloadFingerprint -isnot [string] -or [string]::IsNullOrWhiteSpace($WorkloadFingerprint) -or
        (Get-ObjectMemberValue $Entry "workloadFingerprint") -ne $WorkloadFingerprint) {
        return @("usage_workload_mismatch")
    }
    if (-not (Test-ModelTokenCount (Get-ObjectMemberValue $Entry "inputTokens")) -or
        -not (Test-ModelTokenCount (Get-ObjectMemberValue $Entry "outputTokens"))) {
        return @("usage_counts_invalid")
    }
    return @()
}

function Resolve-ReferenceCostBasis {
    # Chooses ONE cost basis for a whole profile. Measured consumption is used only when every competing configuration
    # has valid, fresh, comparable usage on the same workload; otherwise the entire profile uses the fixed reference
    # basket. Measured and fixed dollars are never mixed, and unqualified configurations cannot disable the measured basis.
    param(
        $SelectionPolicy,
        [AllowEmptyCollection()][object[]]$Competitors,
        $VerdictsByConfiguration,
        $Usage = $null,
        [string]$Strategy = "value_balanced"
    )
    $competitorRecords = @{}
    foreach ($competitor in @($Competitors | Where-Object { $null -ne $_ })) {
        $competitorRecords[[string]$competitor.configurationId] = $competitor
    }
    $competitorIds = @($competitorRecords.Keys | Sort-Object)
    $basis = [ordered]@{
        mode = "fixed_basket"
        fallback = $false
        reasons = @()
        unavailable = @()
        workloadId = $null
        workloadFingerprint = $null
        competitorCount = $competitorIds.Count
        costs = @{}
        identity = $null
    }
    $measured = Get-MeasuredCostPolicy $SelectionPolicy
    if ($null -eq $measured) {
        $basis.reasons = @("measured_cost_disabled")
        return [pscustomobject]$basis
    }
    $basis.workloadId = $measured.workload
    if ($Strategy -ne "value_balanced") {
        $basis.reasons = @("strategy_quality_first")
        return [pscustomobject]$basis
    }
    if (-not $competitorIds.Count) {
        $basis.reasons = @("no_ranked_pool")
        return [pscustomobject]$basis
    }
    $basis.fallback = $true
    $usageById = Get-ObjectMemberValue $Usage "configurations"
    if ((Get-ObjectMemberValue $Usage "enabled") -ne $true -or $usageById -isnot [System.Collections.IDictionary]) {
        $basis.reasons = @("usage_unavailable")
        return [pscustomobject]$basis
    }
    $fingerprint = Get-ObjectMemberValue (Get-ObjectMemberValue $Usage "workload") "fingerprint"
    $unavailable = [System.Collections.Generic.List[object]]::new()
    foreach ($id in $competitorIds) {
        $problems = @(Get-UsageEntryProblems (Get-ObjectMemberValue $usageById $id) $measured.workload $fingerprint)
        if ($null -eq (Get-ModelWorkloadCost $VerdictsByConfiguration[$id] 0 0)) { $problems += "pricing_unavailable" }
        if ($problems.Count) {
            $record = $competitorRecords[$id]
            $unavailable.Add([pscustomobject]@{
                configurationId = $id
                model = $record.model
                effort = $record.effort
                context = $record.context
                reasons = @($problems | Sort-Object -Unique)
            })
        }
    }
    $basis.unavailable = @($unavailable)
    if ($unavailable.Count) {
        $basis.reasons = @($unavailable | ForEach-Object { $_.reasons } | Sort-Object -Unique)
        return [pscustomobject]$basis
    }
    $costs = @{}
    foreach ($id in @($usageById.Keys)) {
        $entry = $usageById[$id]
        if (@(Get-UsageEntryProblems $entry $measured.workload $fingerprint).Count) { continue }
        $cost = Get-ModelWorkloadCost $VerdictsByConfiguration[[string]$id] `
            (Get-ObjectMemberValue $entry "inputTokens") (Get-ObjectMemberValue $entry "outputTokens")
        if ($null -ne $cost) { $costs[[string]$id] = $cost }
    }
    $basis.mode = "measured_workload"
    $basis.fallback = $false
    $basis.workloadFingerprint = $fingerprint
    $basis.costs = $costs
    # No timestamps and no prices: the identity changes only when the consumption that ranks the competitors changes.
    $basis.identity = Get-ModelDataFingerprint @{
        mode = "measured_workload"
        workload = $measured.workload
        workloadFingerprint = $fingerprint
        usage = @($competitorIds | ForEach-Object {
            @{
                configurationId = $_
                inputTokens = [long](Get-ObjectMemberValue $usageById[$_] "inputTokens")
                outputTokens = [long](Get-ObjectMemberValue $usageById[$_] "outputTokens")
            }
        })
    }
    return [pscustomobject]$basis
}

function Get-BasisReferenceCost {
    # Cost on the profile's chosen basis. In measured mode a configuration without a measurement has NO cost: it is
    # never priced with the fixed basket, so the two bases cannot be compared.
    param($CostBasis, $Verdict, [string]$ConfigurationId, $SelectionPolicy)
    if ($CostBasis.mode -ne "measured_workload") { return Get-ModelReferenceCost $Verdict $SelectionPolicy }
    if ($CostBasis.costs.ContainsKey($ConfigurationId)) { return $CostBasis.costs[$ConfigurationId] }
    return $null
}

function Get-BasisSortCost {
    # A measured basis ranks a configuration without a measurement last (the profile would already have fallen back
    # to the fixed basket, so this only guards against a mismatched basis). The fixed basket keeps its original ordering.
    param($CostBasis, $VerdictsByConfiguration, [string]$ConfigurationId, $SelectionPolicy)
    $cost = Get-BasisReferenceCost $CostBasis $VerdictsByConfiguration[$ConfigurationId] $ConfigurationId $SelectionPolicy
    if ($null -eq $cost -and $CostBasis.mode -eq "measured_workload") { return [decimal]::MaxValue }
    return $cost
}

function Get-ValueBalancedSelection {
    param($Profile, $RankedEvidence, $VerdictsByConfiguration, $SelectionPolicy, $Evidence, $CurrentConfiguration, $QualityReference = $null, $CostBasis = $null)
    $band = Get-ValueQualifiedEvidence $Profile $RankedEvidence $SelectionPolicy $QualityReference
    $reference = $band.reference
    $maxGap = $band.maxScoreGap
    $qualified = @($band.qualified)
    if ($null -eq $CostBasis) {
        $CostBasis = Resolve-ReferenceCostBasis -SelectionPolicy $SelectionPolicy -Competitors $qualified -VerdictsByConfiguration $VerdictsByConfiguration
    }
    $sortOrder = @(
        @{ Expression = { Get-BasisSortCost $CostBasis $VerdictsByConfiguration $_.configurationId $SelectionPolicy } }
        @{ Expression = { if ($_.configurationId -eq $CurrentConfiguration.configurationId) { 0 } else { 1 } } }
        @{ Expression = { $_.score }; Descending = $true }
        "model"
        "effort"
        "context"
    )
    $ordered = @($qualified | Sort-Object -Property $sortOrder)
    $minimumCost = Get-BasisSortCost $CostBasis $VerdictsByConfiguration $ordered[0].configurationId $SelectionPolicy
    $cheapest = @($ordered | Where-Object {
        (Get-BasisSortCost $CostBasis $VerdictsByConfiguration $_.configurationId $SelectionPolicy) -eq $minimumCost
    })
    $recency = Get-ModelRecencyTieDecision $cheapest
    $winner = @($cheapest | Where-Object model -in $recency.models)[0]
    $referenceCost = Get-BasisReferenceCost $CostBasis $VerdictsByConfiguration[$winner.configurationId] $winner.configurationId $SelectionPolicy
    $incumbentCost = Get-BasisReferenceCost $CostBasis $VerdictsByConfiguration[$CurrentConfiguration.configurationId] `
        $CurrentConfiguration.configurationId $SelectionPolicy
    $costIncreasePercent = if ($null -ne $incumbentCost -and $incumbentCost -gt 0) {
        ($referenceCost - $incumbentCost) / $incumbentCost * 100
    } elseif ($incumbentCost -eq 0 -and $referenceCost -eq 0) {
        0
    } else {
        $null
    }
    $comparableIncumbent = @($Evidence | Where-Object {
        $_.configurationId -eq $CurrentConfiguration.configurationId -and (Test-BenchmarkEvidenceComparable $_ $winner)
    })
    return [pscustomobject]@{
        winner = $winner
        recencyDecision = $recency
        qualityReference = $reference
        maxScoreGap = $maxGap
        scoreGap = $reference.score - $winner.score
        referenceAic = $referenceCost * 100
        incumbentReferenceAic = $(if ($null -ne $incumbentCost) { $incumbentCost * 100 } else { $null })
        costIncreasePercent = $costIncreasePercent
        costBasis = $CostBasis
        incumbentEvidenceAvailable = $comparableIncumbent.Count -gt 0
        incumbentScore = $(if ($comparableIncumbent.Count) { $comparableIncumbent[0].score } else { $null })
    }
}
