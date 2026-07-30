Set-StrictMode -Version Latest

# Pure verdict engine: given a model id, a profile key, discovery/capability
# facts, and profile requirements, decides whether a model is *admissible*
# for benchmark promotion / active-override retention, and returns every
# applicable reason code plus resolved pricing/capability details.
#
# No I/O, no environment reads, no globals — everything needed is passed in
# by the caller so this can be unit tested in isolation and reused by both
# the consensus candidate search and active-override revalidation.

function Get-AdmissibilityMember {
    param($InputObject, [Parameter(Mandatory = $true)][string]$Name)
    if ($null -eq $InputObject) { return $null }
    if ($InputObject -is [System.Collections.IDictionary]) {
        if ($InputObject.Contains($Name)) { return $InputObject[$Name] }
        return $null
    }
    $prop = $InputObject.PSObject.Properties[$Name]
    if ($null -eq $prop) { return $null }
    return $prop.Value
}

function Test-AdmissibilityHasMember {
    param($InputObject, [Parameter(Mandatory = $true)][string]$Name)
    if ($null -eq $InputObject) { return $false }
    if ($InputObject -is [System.Collections.IDictionary]) { return $InputObject.Contains($Name) }
    return $null -ne $InputObject.PSObject.Properties[$Name]
}

function Get-ModelAdmissibilityVerdict {
    [OutputType([pscustomobject])]
    param(
        [Parameter(Mandatory = $true)][string]$ModelId,
        [Parameter(Mandatory = $true)][string]$ProfileKey,
        [Parameter(Mandatory = $true)][bool]$AvailabilityVerified,
        [string[]]$Denylist = @(),
        [string[]]$AvailableModels = @(),
        $CapabilityRecord = $null,
        [Parameter(Mandatory = $true)]$ProfileRequirement,
        [Parameter(Mandatory = $true)][string]$ProfileContextTier,
        [Parameter(Mandatory = $true)][string]$ProfileEffort,
        [int]$CapabilityFreshnessDays = 60,
        [datetime]$NowUtc = ((Get-Date).ToUniversalTime())
    )

    $reasonCodes = New-Object System.Collections.Generic.List[string]

    if ($Denylist -contains $ModelId) {
        $reasonCodes.Add("denylisted")
    }
    if ($AvailableModels -notcontains $ModelId) {
        $reasonCodes.Add("not_available")
    }
    if (-not $AvailabilityVerified) {
        $reasonCodes.Add("unverified_availability_freezes_promotion")
    }

    # Rule 2 (capability catalog must not assert guessed facts): CLI-agent
    # compatibility is derived from this run's own verified live availability
    # surface (AvailableModels + AvailabilityVerified), never from a static
    # catalog claim -- a catalog can't independently verify what the CLI
    # currently exposes, but this run's own discovery already can.
    $requiresCliAgent = [bool](Get-AdmissibilityMember -InputObject $ProfileRequirement -Name "requiresCliAgent")
    $verifiedCliAgentPresence = $AvailabilityVerified -and ($AvailableModels -contains $ModelId)
    if ($requiresCliAgent -and -not $verifiedCliAgentPresence) {
        $reasonCodes.Add("cli_agent_incompatible")
    }

    $pricingResult = $null
    $capabilitiesResult = $null

    if ($null -eq $CapabilityRecord) {
        $reasonCodes.Add("capabilities_missing")
    } else {
        $asOfRaw = Get-AdmissibilityMember -InputObject $CapabilityRecord -Name "asOf"
        $isStale = $false
        if (-not [string]::IsNullOrWhiteSpace([string]$asOfRaw)) {
            try {
                $asOf = [datetime]::Parse([string]$asOfRaw, [System.Globalization.CultureInfo]::InvariantCulture)
                $isStale = ($NowUtc - $asOf.ToUniversalTime()).TotalDays -gt $CapabilityFreshnessDays
            } catch {
                $isStale = $true
            }
        } else {
            $isStale = $true
        }
        if ($isStale) { $reasonCodes.Add("capabilities_stale") }

        $pricingUnavailableFlag = [bool](Get-AdmissibilityMember -InputObject $CapabilityRecord -Name "pricingUnavailable")

        $requiresVision = [bool](Get-AdmissibilityMember -InputObject $ProfileRequirement -Name "requiresVision")
        if ($requiresVision) {
            $vision = Get-AdmissibilityMember -InputObject $CapabilityRecord -Name "vision"
            if ($null -eq $vision) {
                $reasonCodes.Add("vision_unknown")
            } elseif ($vision -ne $true) {
                $reasonCodes.Add("vision_unsupported")
            }
        }

        $supportedContexts = @(Get-AdmissibilityMember -InputObject $CapabilityRecord -Name "supportedContexts")
        if ($supportedContexts -notcontains $ProfileContextTier) {
            $reasonCodes.Add("context_unsupported")
        }

        # effortMode="unsupported" (e.g. claude-haiku-4.5) means the model's
        # own CLI surface does not accept an --effort flag at all -- this is
        # not the same fact as "doesn't support this particular effort
        # level". It is admissible for any profile-configured effort value
        # as long as the launcher safely omits the flag for such models (see
        # scripts/model-launch-args.ps1 / Get-CopilotLaunchModelArgs, which
        # is unit-tested against this exact convention). Models without this
        # marker (or with effortMode="supported") are still gated by their
        # supportedEfforts list as before.
        $effortMode = [string](Get-AdmissibilityMember -InputObject $CapabilityRecord -Name "effortMode")
        $supportedEfforts = @(Get-AdmissibilityMember -InputObject $CapabilityRecord -Name "supportedEfforts")
        if ($effortMode -ne "unsupported") {
            if ($supportedEfforts -notcontains $ProfileEffort) {
                $reasonCodes.Add("effort_unsupported")
            }
        }

        $capabilitiesResult = [pscustomobject]@{
            asOf = $asOfRaw
            vision = Get-AdmissibilityMember -InputObject $CapabilityRecord -Name "vision"
            supportedContexts = $supportedContexts
            supportedEfforts = $supportedEfforts
            effortMode = if ([string]::IsNullOrWhiteSpace($effortMode)) { "supported" } else { $effortMode }
            cliAgentCompatible = $verifiedCliAgentPresence
        }

        if ($pricingUnavailableFlag) {
            $reasonCodes.Add("pricing_missing")
        } else {
            $pricing = Get-AdmissibilityMember -InputObject $CapabilityRecord -Name "pricing"
            if ($null -eq $pricing) {
                $reasonCodes.Add("pricing_missing")
            } else {
                $tierKey = "default"
                if ($ProfileContextTier -eq "long_context" -and (Test-AdmissibilityHasMember -InputObject $pricing -Name "long_context")) {
                    $tierKey = "long_context"
                }
                $tierPrice = Get-AdmissibilityMember -InputObject $pricing -Name $tierKey
                if ($null -eq $tierPrice -and $tierKey -ne "default") {
                    $tierKey = "default"
                    $tierPrice = Get-AdmissibilityMember -InputObject $pricing -Name $tierKey
                }
                if ($null -eq $tierPrice) {
                    $reasonCodes.Add("pricing_missing")
                } else {
                    $inputPrice = [double](Get-AdmissibilityMember -InputObject $tierPrice -Name "inputPerMillion")
                    $outputPrice = [double](Get-AdmissibilityMember -InputObject $tierPrice -Name "outputPerMillion")
                    $ceilingInput = [double](Get-AdmissibilityMember -InputObject $ProfileRequirement -Name "inputCeilingPerMillion")
                    $ceilingOutput = [double](Get-AdmissibilityMember -InputObject $ProfileRequirement -Name "outputCeilingPerMillion")

                    if ($inputPrice -gt $ceilingInput) { $reasonCodes.Add("pricing_input_exceeds_ceiling") }
                    if ($outputPrice -gt $ceilingOutput) { $reasonCodes.Add("pricing_output_exceeds_ceiling") }

                    $pricingResult = [pscustomobject]@{
                        tier = $tierKey
                        inputPerMillion = $inputPrice
                        outputPerMillion = $outputPrice
                        cachedInputPerMillion = Get-AdmissibilityMember -InputObject $tierPrice -Name "cachedInputPerMillion"
                        ceilingInput = $ceilingInput
                        ceilingOutput = $ceilingOutput
                    }
                }
            }
        }
    }

    return [pscustomobject]@{
        modelId = $ModelId
        profileKey = $ProfileKey
        admissible = ($reasonCodes.Count -eq 0)
        reasonCodes = @($reasonCodes)
        availabilityConfidence = if ($AvailabilityVerified) { "verified" } else { "unverified" }
        pricing = $pricingResult
        capabilities = $capabilitiesResult
    }
}

function Test-ActiveOverrideAdmissible {
    [OutputType([bool])]
    param(
        [Parameter(Mandatory = $true)][string]$ProfileKey,
        [Parameter(Mandatory = $true)][string]$ModelId,
        [Parameter(Mandatory = $true)][bool]$AvailabilityVerified,
        [string[]]$Denylist = @(),
        [string[]]$AvailableModels = @(),
        $CapabilityRecord = $null,
        [Parameter(Mandatory = $true)]$ProfileRequirement,
        [Parameter(Mandatory = $true)][string]$ProfileContextTier,
        [Parameter(Mandatory = $true)][string]$ProfileEffort,
        [int]$CapabilityFreshnessDays = 60,
        [datetime]$NowUtc = ((Get-Date).ToUniversalTime())
    )

    # Rule: active overrides are revalidated through this same admissibility
    # engine only on verified discovery runs. On unverified availability
    # (hardcoded fallback), retain the override unchanged instead of
    # revoking it based on unverifiable data.
    if (-not $AvailabilityVerified) { return $true }

    $verdict = Get-ModelAdmissibilityVerdict -ModelId $ModelId -ProfileKey $ProfileKey -AvailabilityVerified $AvailabilityVerified `
        -Denylist $Denylist -AvailableModels $AvailableModels -CapabilityRecord $CapabilityRecord `
        -ProfileRequirement $ProfileRequirement -ProfileContextTier $ProfileContextTier -ProfileEffort $ProfileEffort `
        -CapabilityFreshnessDays $CapabilityFreshnessDays -NowUtc $NowUtc
    return $verdict.admissible -or (Test-ModelAdmissibilityGrandfatherable -Verdict $verdict)
}

function Test-ModelAdmissibilityGrandfatherable {
    [OutputType([bool])]
    param(
        [Parameter(Mandatory = $true)]$Verdict
    )

    if ([bool]$Verdict.admissible) { return $false }
    $uncertaintyReasons = @(
        "capabilities_missing",
        "capabilities_stale",
        "vision_unknown",
        "pricing_missing"
    )
    $reasons = @($Verdict.reasonCodes)
    return $reasons.Count -gt 0 -and @($reasons | Where-Object { $uncertaintyReasons -notcontains $_ }).Count -eq 0
}
