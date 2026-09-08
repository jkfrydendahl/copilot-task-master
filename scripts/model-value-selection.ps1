Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

function Get-ModelReferenceCost {
    param($Verdict, $SelectionPolicy)
    $price = Get-ObjectMemberValue $Verdict "pricing"
    $priceErrors = @(Get-ObjectMemberValue $Verdict "reasonCodes" | Where-Object {
        $_ -in @("pricing_missing", "pricing_invalid", "pricing_stale")
    })
    if ($null -eq $price -or $priceErrors.Count) { return $null }
    return [decimal]$price.inputPerMillion * [decimal]$SelectionPolicy.referenceInputTokens / 1000000 +
        [decimal]$price.outputPerMillion * [decimal]$SelectionPolicy.referenceOutputTokens / 1000000
}

function Get-ValueBalancedSelection {
    param($Profile, $RankedEvidence, $VerdictsByModel, $SelectionPolicy, $Evidence)
    $reference = $RankedEvidence[0]
    $metricKey = "$($reference.source).$($reference.metric)"
    $bands = $SelectionPolicy.profiles[$Profile.key].qualityBands
    $maxGap = Get-ObjectMemberValue $bands $metricKey
    if ($null -eq $maxGap) { throw "Missing quality band '$metricKey' for '$($Profile.key)'." }
    $qualified = @($RankedEvidence | Where-Object { $_.score -ge $reference.score - $maxGap })
    $sortOrder = @(
        @{ Expression = { Get-ModelReferenceCost $VerdictsByModel[$_.model] $SelectionPolicy } }
        @{ Expression = { if ($_.model -eq $Profile.model) { 0 } else { 1 } } }
        @{ Expression = { $_.score }; Descending = $true }
        "model"
    )
    $winner = @($qualified | Sort-Object -Property $sortOrder)[0]
    $referenceCost = Get-ModelReferenceCost $VerdictsByModel[$winner.model] $SelectionPolicy
    $incumbent = $VerdictsByModel[$Profile.model]
    $incumbentCost = Get-ModelReferenceCost $incumbent $SelectionPolicy
    $incumbentCapability = Get-ObjectMemberValue $incumbent "capabilities"
    $incumbentEffort = if ((Get-ObjectMemberValue $incumbentCapability "effortMode") -eq "unsupported") {
        "none"
    } else {
        $Profile.effort
    }
    $comparableIncumbent = @($Evidence | Where-Object {
        $_.model -eq $Profile.model -and $_.source -eq $winner.source -and
        $_.metric -eq $winner.metric -and $_.effort -eq $incumbentEffort -and
        -not $_.cached -and $_.sourceVersion -eq $winner.sourceVersion
    })
    $promotionBlockReason = $null
    if ($winner.model -ne $Profile.model) {
        if ($null -eq $incumbentCost) {
            $promotionBlockReason = "retained_incumbent_cost_unknown"
        } elseif ($referenceCost -gt $incumbentCost -and -not $comparableIncumbent.Count) {
            $promotionBlockReason = "retained_unproven_cost_increase"
        }
    }
    return [pscustomobject]@{
        winner = $winner
        qualityReference = $reference
        maxScoreGap = $maxGap
        scoreGap = $reference.score - $winner.score
        referenceAic = $referenceCost * 100
        incumbentReferenceAic = $(if ($null -ne $incumbentCost) { $incumbentCost * 100 } else { $null })
        promotionBlockReason = $promotionBlockReason
    }
}
