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
    param($Profile, $RankedEvidence, $VerdictsByConfiguration, $SelectionPolicy, $Evidence, $CurrentConfiguration)
    $reference = $RankedEvidence[0]
    $metricKey = "$($reference.source).$($reference.metric)"
    $bands = $SelectionPolicy.profiles[$Profile.key].qualityBands
    $maxGap = Get-ObjectMemberValue $bands $metricKey
    if ($null -eq $maxGap) { throw "Missing quality band '$metricKey' for '$($Profile.key)'." }
    $qualified = @($RankedEvidence | Where-Object { $_.score -ge $reference.score - $maxGap })
    $sortOrder = @(
        @{ Expression = { Get-ModelReferenceCost $VerdictsByConfiguration[$_.configurationId] $SelectionPolicy } }
        @{ Expression = { if ($_.configurationId -eq $CurrentConfiguration.configurationId) { 0 } else { 1 } } }
        @{ Expression = { $_.score }; Descending = $true }
        "model"
        "effort"
        "context"
    )
    $winner = @($qualified | Sort-Object -Property $sortOrder)[0]
    $referenceCost = Get-ModelReferenceCost $VerdictsByConfiguration[$winner.configurationId] $SelectionPolicy
    $incumbent = $VerdictsByConfiguration[$CurrentConfiguration.configurationId]
    $incumbentCost = Get-ModelReferenceCost $incumbent $SelectionPolicy
    $costIncreasePercent = if ($null -ne $incumbentCost -and $incumbentCost -gt 0) {
        ($referenceCost - $incumbentCost) / $incumbentCost * 100
    } elseif ($incumbentCost -eq 0 -and $referenceCost -eq 0) {
        0
    } else {
        $null
    }
    $comparableIncumbent = @($Evidence | Where-Object {
        $_.configurationId -eq $CurrentConfiguration.configurationId -and $_.source -eq $winner.source -and
        $_.metric -eq $winner.metric -and
        $_.cached -eq $winner.cached -and $_.sourceVersion -eq $winner.sourceVersion
    })
    return [pscustomobject]@{
        winner = $winner
        qualityReference = $reference
        maxScoreGap = $maxGap
        scoreGap = $reference.score - $winner.score
        referenceAic = $referenceCost * 100
        incumbentReferenceAic = $(if ($null -ne $incumbentCost) { $incumbentCost * 100 } else { $null })
        costIncreasePercent = $costIncreasePercent
        incumbentEvidenceAvailable = $comparableIncumbent.Count -gt 0
        incumbentScore = $(if ($comparableIncumbent.Count) { $comparableIncumbent[0].score } else { $null })
    }
}
