Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")





function Get-ModelAdmissibilityVerdict {
    param(
        [Parameter(Mandatory)][string]$ModelId,
        [Parameter(Mandatory)][string]$ProfileKey,
        [Parameter(Mandatory)][bool]$AvailabilityVerified,
        [string[]]$Denylist = @(),
        [string[]]$AvailableModels = @(),
        $CapabilityRecord = $null,
        $PricingRecord = $null,
        [Parameter(Mandatory)]$ProfileRequirement,
        [Parameter(Mandatory)][string]$ProfileContextTier,
        [Parameter(Mandatory)][string]$ProfileEffort,
        [int]$CapabilityFreshnessDays = 60,
        [int]$PricingFreshnessDays = 45,
        [datetime]$NowUtc = [datetime]::UtcNow
    )
    $reasons = [System.Collections.Generic.List[string]]::new()
    $warnings = [System.Collections.Generic.List[string]]::new()
    if ($Denylist -contains $ModelId) { $reasons.Add("denylisted") }
    if ($AvailableModels -notcontains $ModelId) { $reasons.Add("not_available") }
    if (-not $AvailabilityVerified) { $reasons.Add("unverified_availability_freezes_promotion") }
    $cliCompatible = $AvailabilityVerified -and $AvailableModels -contains $ModelId
    if ((Get-ObjectMemberValue $ProfileRequirement "requiresCliAgent") -and -not $cliCompatible) { $reasons.Add("cli_agent_incompatible") }

    if ($null -eq $CapabilityRecord) { $reasons.Add("capabilities_missing") }
    else {
        if (-not (Test-ModelDataFresh (Get-ObjectMemberValue $CapabilityRecord "asOf") $CapabilityFreshnessDays $NowUtc)) { $reasons.Add("capabilities_stale") }
        if (Get-ObjectMemberValue $ProfileRequirement "requiresVision") {
            $vision = Get-ObjectMemberValue $CapabilityRecord "vision"
            if ($null -eq $vision) { $reasons.Add("vision_unknown") }
            elseif ($vision -ne $true) { $reasons.Add("vision_unsupported") }
        }
        if (@(Get-ObjectMemberValue $CapabilityRecord "supportedContexts") -notcontains $ProfileContextTier) { $reasons.Add("context_unsupported") }
        if ((Get-ObjectMemberValue $CapabilityRecord "effortMode") -ne "unsupported" -and
            @(Get-ObjectMemberValue $CapabilityRecord "supportedEfforts") -notcontains $ProfileEffort) { $reasons.Add("effort_unsupported") }
    }

    $pricing = $null
    if ($null -eq $PricingRecord) { $reasons.Add("pricing_missing") }
    else {
        $verifiedAt = Get-ObjectMemberValue $PricingRecord "verifiedAtUtc"
        if (-not (Test-ModelDataFresh $verifiedAt $PricingFreshnessDays $NowUtc)) { $reasons.Add("pricing_stale") }
        $tiers = Get-ObjectMemberValue $PricingRecord "tiers"
        $tier = "default"
        if ($ProfileContextTier -eq "long_context" -and $null -ne (Get-ObjectMemberValue $tiers "long_context")) { $tier = "long_context" }
        $price = Get-ObjectMemberValue $tiers $tier
        if ($ProfileContextTier -eq "long_context" -and $tier -eq "default" -and
            $null -ne (Get-ObjectMemberValue $price "thresholdInputTokens")) { $price = $null }
        if ($null -eq $price) { $reasons.Add("pricing_missing") }
        else {
            $inputPrice = Get-ObjectMemberValue $price "inputPerMillion"
            $outputPrice = Get-ObjectMemberValue $price "outputPerMillion"
            $invalid = @($inputPrice, $outputPrice | Where-Object {
                ($_ -isnot [double] -and $_ -isnot [int] -and $_ -isnot [long] -and $_ -isnot [decimal]) -or
                -not [double]::IsFinite([double]$_) -or [double]$_ -lt 0
            }).Count -gt 0
            if ($invalid) { $reasons.Add("pricing_invalid") }
            else {
                $ceilingInput = [double](Get-ObjectMemberValue $ProfileRequirement "inputCeilingPerMillion")
                $ceilingOutput = [double](Get-ObjectMemberValue $ProfileRequirement "outputCeilingPerMillion")
                $budgetReasons = @(
                    if ($inputPrice -gt $ceilingInput) { "pricing_input_exceeds_ceiling" }
                    if ($outputPrice -gt $ceilingOutput) { "pricing_output_exceeds_ceiling" }
                )
                foreach ($reason in $budgetReasons) {
                    if (Get-ObjectMemberValue $ProfileRequirement "costSensitive") { $reasons.Add($reason) }
                    else { $warnings.Add($reason) }
                }
                $pricing = [pscustomobject]@{
                    tier = $tier
                    inputPerMillion = $inputPrice
                    outputPerMillion = $outputPrice
                    cachedInputPerMillion = Get-ObjectMemberValue $price "cachedInputPerMillion"
                    cacheWritePerMillion = Get-ObjectMemberValue $price "cacheWritePerMillion"
                    thresholdInputTokens = Get-ObjectMemberValue $price "thresholdInputTokens"
                    verifiedAtUtc = $verifiedAt
                    ceilingInput = $ceilingInput
                    ceilingOutput = $ceilingOutput
                }
            }
        }
    }
    return [pscustomobject]@{
        modelId = $ModelId
        profileKey = $ProfileKey
        admissible = $reasons.Count -eq 0
        reasonCodes = @($reasons)
        warningCodes = @($warnings)
        pricing = $pricing
        capabilities = $CapabilityRecord
        availabilityConfidence = $(if ($AvailabilityVerified) { "verified" } else { "unverified" })
    }
}
