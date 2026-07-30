Set-StrictMode -Version Latest

# Reporting helpers for the admissibility ledger: per-profile availability
# confidence, ceilings, and an exclusion-reason table for every model that
# failed admissibility. Kept separate from model-ranking-data.ps1's
# benchmark-source report lines to avoid over-merging two different report
# sections into one file.

function Get-AdmissibilityReportLines {
    [OutputType([string[]])]
    param(
        [Parameter(Mandatory = $true)][string]$ProfileKey,
        [AllowEmptyCollection()][object[]]$Verdicts = @(),
        [Parameter(Mandatory = $true)][string]$AvailabilityConfidence,
        [Parameter(Mandatory = $true)][double]$InputCeiling,
        [Parameter(Mandatory = $true)][double]$OutputCeiling,
        [string]$IncumbentModel = $null,
        $IncumbentVerdict = $null
    )

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("### $ProfileKey")
    $lines.Add("")
    $lines.Add("- Availability confidence: **$AvailabilityConfidence**")
    if ($AvailabilityConfidence -eq "unverified") {
        $lines.Add("- **FROZEN this run**: availability discovery fell back to the unverified hardcoded list, so automatic baseline and benchmark-consensus profile changes are frozen (active overrides and the current model are preserved unchanged).")
    }
    $dollar = [char]36
    $lines.Add("- Pricing ceilings (per million tokens): input <= $dollar$InputCeiling, output <= $dollar$OutputCeiling")

    if (-not [string]::IsNullOrWhiteSpace($IncumbentModel) -and $null -ne $IncumbentVerdict) {
        $incumbentReasons = if ($IncumbentVerdict.reasonCodes -and $IncumbentVerdict.reasonCodes.Count -gt 0) { ($IncumbentVerdict.reasonCodes -join ", ") } else { "none" }
        $lines.Add("- Incumbent/current model: **$IncumbentModel** — admissible: **$($IncumbentVerdict.admissible)** (reasons: $incumbentReasons)")
    }

    $excluded = @($Verdicts | Where-Object { -not $_.admissible })
    if ($excluded.Count -eq 0) {
        $lines.Add("- Exclusions: none.")
        $lines.Add("")
        return @($lines)
    }

    $lines.Add("- Exclusions:")
    $lines.Add("")
    $lines.Add("| Model | Reasons | Pricing tier | Input ${dollar}/M | Output ${dollar}/M | Capability as-of |")
    $lines.Add("|---|---|---|---|---|---|")
    foreach ($verdict in $excluded) {
        $reasons = ($verdict.reasonCodes -join ", ")
        $tier = if ($verdict.pricing) { [string]$verdict.pricing.tier } else { "n/a" }
        $inputPrice = if ($verdict.pricing) { [string]$verdict.pricing.inputPerMillion } else { "n/a" }
        $outputPrice = if ($verdict.pricing) { [string]$verdict.pricing.outputPerMillion } else { "n/a" }
        $asOf = if ($verdict.capabilities -and $verdict.capabilities.asOf) { [string]$verdict.capabilities.asOf } else { "n/a" }
        $lines.Add("| $($verdict.modelId) | $reasons | $tier | $inputPrice | $outputPrice | $asOf |")
    }
    $lines.Add("")
    return @($lines)
}
