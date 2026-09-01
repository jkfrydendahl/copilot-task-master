Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "model-policy-config.ps1")
. (Join-Path $PSScriptRoot "model-availability.ps1")
. (Join-Path $PSScriptRoot "model-admissibility.ps1")
. (Join-Path $PSScriptRoot "model-selection-policy.ps1")
. (Join-Path $PSScriptRoot "model-review-report.ps1")

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$fixtureRoot = Join-Path $PSScriptRoot "fixtures/model-policy"

$script:Passed = 0
$script:Failed = 0

function Assert-True {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) { throw $Message }
}

function Assert-Eq {
    param($Expected, $Actual, [string]$Message)
    if ("$Expected" -ne "$Actual") { throw "$Message (expected='$Expected', actual='$Actual')" }
}

function Run-Test {
    param([string]$Name, [scriptblock]$Action)
    try { & $Action; $script:Passed++; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $($_.Exception.Message)" }
}

function New-Capability {
    param(
        [Nullable[bool]]$Vision = $false,
        [string[]]$SupportedContexts = @("default"),
        [string[]]$SupportedEfforts = @("low", "medium", "high", "xhigh", "max"),
        [string]$EffortMode = "supported",
        [string]$AsOf = "2026-07-20",
        [hashtable]$Pricing = @{ default = @{ inputPerMillion = 1.0; outputPerMillion = 5.0 } }
    )
    return [pscustomobject]@{
        asOf = $AsOf
        vision = $Vision
        supportedContexts = $SupportedContexts
        supportedEfforts = $SupportedEfforts
        effortMode = $EffortMode
        pricing = $Pricing
    }
}

function New-Requirement {
    param(
        [double]$InputCeiling = 3,
        [double]$OutputCeiling = 15,
        [bool]$RequiresVision = $false,
        [bool]$RequiresCliAgent = $true,
        [bool]$CostSensitive = $false
    )
    return [pscustomobject]@{
        inputCeilingPerMillion = $InputCeiling
        outputCeilingPerMillion = $OutputCeiling
        requiresVision = $RequiresVision
        requiresCliAgent = $RequiresCliAgent
        costSensitive = $CostSensitive
    }
}

# ---- config/model-policy.json loading ----

Run-Test "P1 Real model-policy.json loads and validates" {
    $policy = Get-ModelPolicyConfig -PolicyPath (Join-Path $repoRoot "config/model-policy.json")
    Assert-True ($policy.denylist -contains "claude-fable-5") "Expected denylist to contain claude-fable-5."
    Assert-True ($policy.profileRequirements.ContainsKey("agentic-implementation")) "Expected profile requirement for agentic-implementation."
    Assert-Eq "10" $policy.profileRequirements["agentic-implementation"].inputCeilingPerMillion "Expected agentic-implementation input ceiling 10."
    Assert-Eq "50" $policy.profileRequirements["agentic-implementation"].outputCeilingPerMillion "Expected agentic-implementation output ceiling 50."
    Assert-Eq "2" $policy.profileRequirements["quick"].inputCeilingPerMillion "Expected quick input ceiling 2."
    Assert-Eq "45" $policy.profileRequirements["deep-reasoning"].outputCeilingPerMillion "Expected deep-reasoning output ceiling 45."
    Assert-True ([bool]$policy.profileRequirements["visual-ui"].requiresVision) "Expected visual-ui to require vision."
}

Run-Test "P2 Malformed policy (missing profileRequirements) fails fast" {
    $threw = $false
    try {
        Get-ModelPolicyConfig -PolicyPath (Join-Path $fixtureRoot "policy-malformed-missing-requirements.json")
    } catch { $threw = $true }
    Assert-True $threw "Expected malformed policy to throw."
}

Run-Test "P3 Malformed policy (non-numeric ceiling) fails fast" {
    $threw = $false
    try {
        Get-ModelPolicyConfig -PolicyPath (Join-Path $fixtureRoot "policy-malformed-bad-ceiling.json")
    } catch { $threw = $true }
    Assert-True $threw "Expected non-numeric ceiling to throw."
}

# ---- config/model-capabilities.json loading ----

Run-Test "C1 Real model-capabilities.json loads and validates" {
    $catalog = Get-ModelCapabilitiesCatalog -CatalogPath (Join-Path $repoRoot "config/model-capabilities.json")
    Assert-True ($catalog.models.ContainsKey("claude-sonnet-5")) "Expected claude-sonnet-5 in catalog."
    Assert-Eq "2" $catalog.models["claude-sonnet-5"].pricing.default.inputPerMillion "Expected real sonnet-5 input price."
    Assert-Eq "10" $catalog.models["claude-sonnet-5"].pricing.default.outputPerMillion "Expected real sonnet-5 output price."
    Assert-True ([bool]$catalog.models["mai-code-1-flash-picker"].pricingUnavailable) "Expected undocumented model id marked pricingUnavailable, not guessed."
    Assert-True ($catalog.models["gpt-5.6-sol"].supportedContexts -contains "long_context") "Expected gpt-5.6-sol long_context tier."
    Assert-True ($catalog.models["claude-opus-5"].supportedContexts -contains "long_context") "Expected claude-opus-5 to support long_context (session-verified capability, independent of whether GitHub pricing documents a separate long tier)."
}

Run-Test "C2 Malformed capabilities catalog fails fast" {
    $threw = $false
    try {
        Get-ModelCapabilitiesCatalog -CatalogPath (Join-Path $fixtureRoot "capabilities-malformed.json")
    } catch { $threw = $true }
    Assert-True $threw "Expected malformed capabilities catalog to throw."
}

Run-Test "C3 Stale model id claude-opus-4.6-fast is replaced by canonical claude-opus-4.8-fast" {
    $catalog = Get-ModelCapabilitiesCatalog -CatalogPath (Join-Path $repoRoot "config/model-capabilities.json")
    Assert-True ($catalog.models.ContainsKey("claude-opus-4.8-fast")) "Expected canonical claude-opus-4.8-fast entry in capability catalog."
    Assert-True (-not $catalog.models.ContainsKey("claude-opus-4.6-fast")) "Expected stale claude-opus-4.6-fast id to be removed from capability catalog."
}

Run-Test "C4 Vision is only asserted true for the positively-confirmed GitHub visuals models" {
    $catalog = Get-ModelCapabilitiesCatalog -CatalogPath (Join-Path $repoRoot "config/model-capabilities.json")
    Assert-True ($catalog.models["claude-sonnet-4.6"].vision -eq $true) "Expected claude-sonnet-4.6 vision=true (positively documented)."
    Assert-True ($catalog.models["gemini-3.1-pro-preview"].vision -eq $true) "Expected gemini-3.1-pro-preview vision=true (positively documented)."
    Assert-True ($catalog.models["gpt-5-mini"].vision -eq $true) "Expected gpt-5-mini vision=true (positively documented)."
    Assert-True ($null -eq $catalog.models["claude-sonnet-5"].vision) "Expected claude-sonnet-5 vision left unknown (null), not guessed true or false."
    Assert-True ($null -eq $catalog.models["claude-opus-5"].vision) "Expected claude-opus-5 vision left unknown (null), not guessed."
}

Run-Test "C5 supportedEfforts/supportedContexts reflect the authoritative per-model breakdown, not a blanket guess" {
    $catalog = Get-ModelCapabilitiesCatalog -CatalogPath (Join-Path $repoRoot "config/model-capabilities.json")
    Assert-True (-not ($catalog.models["claude-sonnet-4.6"].supportedEfforts -contains "xhigh")) "Expected claude-sonnet-4.6 to NOT claim xhigh effort support."
    Assert-True (-not ($catalog.models["gpt-5.5"].supportedEfforts -contains "max")) "Expected gpt-5.5 to NOT claim max effort support."
    Assert-True (-not ($catalog.models["gpt-5.4"].supportedEfforts -contains "max")) "Expected gpt-5.4 to NOT claim max effort support."
    Assert-True (-not ($catalog.models["gpt-5.3-codex"].supportedContexts -contains "long_context")) "Expected gpt-5.3-codex to NOT claim long_context."
    Assert-True ($catalog.models["gemini-3.6-flash"].supportedContexts -contains "long_context") "Expected gemini-3.6-flash to support long_context per session metadata."
    Assert-True ($catalog.models["gemini-3.6-flash"].supportedEfforts -contains "minimal") "Expected gemini-3.6-flash to support the minimal effort level."
    Assert-True (-not ($catalog.models["gemini-3.1-pro-preview"].supportedEfforts -contains "xhigh")) "Expected gemini-3.1-pro-preview to NOT claim xhigh effort support."
}

Run-Test "C6 Haiku's unsupported effort is represented explicitly (effortMode), not a false capability gap" {
    $catalog = Get-ModelCapabilitiesCatalog -CatalogPath (Join-Path $repoRoot "config/model-capabilities.json")
    Assert-Eq "unsupported" $catalog.models["claude-haiku-4.5"].effortMode "Expected claude-haiku-4.5 effortMode=unsupported."
}

# ---- model-availability.ps1 ----

Run-Test "A1 CLI discovery marks availability verified" {
    $result = Get-ModelAvailability -Denylist @("claude-fable-5") -CliProbe { return @("claude-sonnet-5", "gpt-5.4") }
    Assert-True $result.verified "Expected CLI discovery to be verified."
    Assert-Eq "verified" $result.confidence "Expected verified confidence."
    Assert-True ($result.models -contains "claude-sonnet-5") "Expected discovered model present."
    Assert-True ($result.models -notcontains "claude-fable-5") "Expected denylist applied."
}

Run-Test "A2 Fallback discovery marks availability unverified" {
    $result = Get-ModelAvailability -Denylist @() -CliProbe { return @() } -GhProbe { return @() }
    Assert-True (-not $result.verified) "Expected fallback discovery to be unverified."
    Assert-Eq "unverified" $result.confidence "Expected unverified confidence."
    Assert-True ($result.models.Count -gt 0) "Expected fallback models preserved, not empty."
}

# ---- model-admissibility.ps1 ----

Run-Test "M1 Denylisted model is inadmissible" {
    $v = Get-ModelAdmissibilityVerdict -ModelId "claude-fable-5" -ProfileKey "agentic-implementation" -AvailabilityVerified $true -Denylist @("claude-fable-5") -AvailableModels @("claude-fable-5") -CapabilityRecord (New-Capability) -ProfileRequirement (New-Requirement -InputCeiling 10 -OutputCeiling 50) -ProfileContextTier "default" -ProfileEffort "high"
    Assert-True (-not $v.admissible) "Denylisted model must be inadmissible."
    Assert-True ($v.reasonCodes -contains "denylisted") "Expected denylisted reason code."
}

Run-Test "M2 Unverified availability freezes promotion even with perfect facts" {
    $v = Get-ModelAdmissibilityVerdict -ModelId "gpt-5.6-terra" -ProfileKey "default-development" -AvailabilityVerified $false -Denylist @() -AvailableModels @("gpt-5.6-terra") -CapabilityRecord (New-Capability) -ProfileRequirement (New-Requirement) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True (-not $v.admissible) "Unverified availability must block promotion."
    Assert-True ($v.reasonCodes -contains "unverified_availability_freezes_promotion") "Expected unverified-availability reason code."
}

Run-Test "M3 Missing capability record blocks and reports reason" {
    $v = Get-ModelAdmissibilityVerdict -ModelId "unknown-model" -ProfileKey "default-development" -AvailabilityVerified $true -Denylist @() -AvailableModels @("unknown-model") -CapabilityRecord $null -ProfileRequirement (New-Requirement) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True (-not $v.admissible) "Missing capability record must block."
    Assert-True ($v.reasonCodes -contains "capabilities_missing") "Expected capabilities_missing reason code."
}

Run-Test "M4 Stale capability record blocks" {
    $stale = New-Capability -AsOf "2026-01-01"
    $v = Get-ModelAdmissibilityVerdict -ModelId "old-model" -ProfileKey "default-development" -AvailabilityVerified $true -Denylist @() -AvailableModels @("old-model") -CapabilityRecord $stale -ProfileRequirement (New-Requirement) -ProfileContextTier "default" -ProfileEffort "medium" -CapabilityFreshnessDays 60 -NowUtc ([datetime]::Parse("2026-07-30"))
    Assert-True (-not $v.admissible) "Stale capability record must block."
    Assert-True ($v.reasonCodes -contains "capabilities_stale") "Expected capabilities_stale reason code."
}

Run-Test "M5 Fresh capability record (within threshold) does not go stale" {
    $fresh = New-Capability -AsOf "2026-07-01"
    $v = Get-ModelAdmissibilityVerdict -ModelId "fresh-model" -ProfileKey "default-development" -AvailabilityVerified $true -Denylist @() -AvailableModels @("fresh-model") -CapabilityRecord $fresh -ProfileRequirement (New-Requirement) -ProfileContextTier "default" -ProfileEffort "medium" -CapabilityFreshnessDays 60 -NowUtc ([datetime]::Parse("2026-07-30"))
    Assert-True (-not ($v.reasonCodes -contains "capabilities_stale")) "Expected fresh record to not be stale."
}

Run-Test "M6 Vision required + unknown blocks with vision_unknown" {
    $cap = New-Capability -Vision $null
    $v = Get-ModelAdmissibilityVerdict -ModelId "vis-model" -ProfileKey "visual-ui" -AvailabilityVerified $true -Denylist @() -AvailableModels @("vis-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -RequiresVision $true) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True (-not $v.admissible) "Unknown vision must block visual-ui."
    Assert-True ($v.reasonCodes -contains "vision_unknown") "Expected vision_unknown reason code."
}

Run-Test "M7 Vision required + false blocks with vision_unsupported" {
    $cap = New-Capability -Vision $false
    $v = Get-ModelAdmissibilityVerdict -ModelId "vis-model" -ProfileKey "visual-ui" -AvailabilityVerified $true -Denylist @() -AvailableModels @("vis-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -RequiresVision $true) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True (-not $v.admissible) "vision=false must block visual-ui."
    Assert-True ($v.reasonCodes -contains "vision_unsupported") "Expected vision_unsupported reason code."
}

Run-Test "M8 Vision required + true passes vision gate" {
    $cap = New-Capability -Vision $true
    $v = Get-ModelAdmissibilityVerdict -ModelId "vis-model" -ProfileKey "visual-ui" -AvailabilityVerified $true -Denylist @() -AvailableModels @("vis-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -RequiresVision $true) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($v.admissible) "vision=true must pass and satisfy all other default gates."
}

Run-Test "M9 Context unsupported blocks (long_context requested, default-only model)" {
    $cap = New-Capability -SupportedContexts @("default") -Pricing @{ default = @{ inputPerMillion = 5.0; outputPerMillion = 25.0 } }
    $v = Get-ModelAdmissibilityVerdict -ModelId "opus-like" -ProfileKey "deep-reasoning" -AvailabilityVerified $true -Denylist @() -AvailableModels @("opus-like") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -InputCeiling 10 -OutputCeiling 45) -ProfileContextTier "long_context" -ProfileEffort "high"
    Assert-True (-not $v.admissible) "Model without documented long_context must not be claimed admissible for long_context profile."
    Assert-True ($v.reasonCodes -contains "context_unsupported") "Expected context_unsupported reason code."
}

Run-Test "M10 Context supported selects long_context tier pricing" {
    $cap = New-Capability -SupportedContexts @("default", "long_context") -Pricing @{ default = @{ inputPerMillion = 5.0; outputPerMillion = 30.0 }; long_context = @{ inputPerMillion = 10.0; outputPerMillion = 45.0 } }
    $v = Get-ModelAdmissibilityVerdict -ModelId "sol-like" -ProfileKey "deep-reasoning" -AvailabilityVerified $true -Denylist @() -AvailableModels @("sol-like") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -InputCeiling 10 -OutputCeiling 45) -ProfileContextTier "long_context" -ProfileEffort "high"
    Assert-True ($v.admissible) "Expected long_context-capable model to pass using long_context tier price."
    Assert-Eq "long_context" $v.pricing.tier "Expected long_context tier selected."
    Assert-Eq "10" $v.pricing.inputPerMillion "Expected long_context input price used."
}

Run-Test "M11 Effort unsupported blocks" {
    $cap = New-Capability -SupportedEfforts @("none", "low", "medium")
    $v = Get-ModelAdmissibilityVerdict -ModelId "lite-model" -ProfileKey "deep-reasoning" -AvailabilityVerified $true -Denylist @() -AvailableModels @("lite-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -InputCeiling 10 -OutputCeiling 45) -ProfileContextTier "default" -ProfileEffort "high"
    Assert-True (-not $v.admissible) "Missing 'high' effort support must block."
    Assert-True ($v.reasonCodes -contains "effort_unsupported") "Expected effort_unsupported reason code."
}

Run-Test "M12 CLI-agent compatibility derives from verified live availability, not a static catalog claim" {
    $cap = New-Capability
    $v = Get-ModelAdmissibilityVerdict -ModelId "cli-ok-model" -ProfileKey "default-development" -AvailabilityVerified $true -Denylist @() -AvailableModels @("cli-ok-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($v.admissible) "Model present in this run's verified availability list must satisfy requiresCliAgent even without any catalog cliAgentCompatible field."

    $v2 = Get-ModelAdmissibilityVerdict -ModelId "cli-ghost-model" -ProfileKey "default-development" -AvailabilityVerified $true -Denylist @() -AvailableModels @("other-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True (-not $v2.admissible) "Model absent from verified availability must block requiresCliAgent."
    Assert-True ($v2.reasonCodes -contains "cli_agent_incompatible") "Expected cli_agent_incompatible reason code derived from verified availability presence, not a static catalog field."
}

Run-Test "M13 Missing pricing blocks" {
    $cap = [pscustomobject]@{ asOf = "2026-07-20"; vision = $false; supportedContexts = @("default"); supportedEfforts = @("none", "low", "medium", "high", "xhigh", "max"); cliAgentCompatible = $true; pricingUnavailable = $true }
    $v = Get-ModelAdmissibilityVerdict -ModelId "unpriced-model" -ProfileKey "default-development" -AvailabilityVerified $true -Denylist @() -AvailableModels @("unpriced-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True (-not $v.admissible) "Missing pricing must block."
    Assert-True ($v.reasonCodes -contains "pricing_missing") "Expected pricing_missing reason code."
}

Run-Test "M14 Pricing exact ceiling boundary passes" {
    $cap = New-Capability -Pricing @{ default = @{ inputPerMillion = 3.0; outputPerMillion = 15.0 } }
    $v = Get-ModelAdmissibilityVerdict -ModelId "boundary-model" -ProfileKey "default-development" -AvailabilityVerified $true -Denylist @() -AvailableModels @("boundary-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -InputCeiling 3 -OutputCeiling 15) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($v.admissible) "Exact ceiling boundary (<=) must pass."
}

Run-Test "M15 Pricing over ceiling boundary blocks (input)" {
    $cap = New-Capability -Pricing @{ default = @{ inputPerMillion = 3.01; outputPerMillion = 15.0 } }
    $v = Get-ModelAdmissibilityVerdict -ModelId "over-model" -ProfileKey "default-development" -AvailabilityVerified $true -Denylist @() -AvailableModels @("over-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -InputCeiling 3 -OutputCeiling 15) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True (-not $v.admissible) "Over-ceiling input price must block."
    Assert-True ($v.reasonCodes -contains "pricing_input_exceeds_ceiling") "Expected pricing_input_exceeds_ceiling reason code."
}

Run-Test "M16 Pricing over ceiling boundary blocks (output)" {
    $cap = New-Capability -Pricing @{ default = @{ inputPerMillion = 3.0; outputPerMillion = 15.01 } }
    $v = Get-ModelAdmissibilityVerdict -ModelId "over-model-2" -ProfileKey "default-development" -AvailabilityVerified $true -Denylist @() -AvailableModels @("over-model-2") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -InputCeiling 3 -OutputCeiling 15) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True (-not $v.admissible) "Over-ceiling output price must block."
    Assert-True ($v.reasonCodes -contains "pricing_output_exceeds_ceiling") "Expected pricing_output_exceeds_ceiling reason code."
}

Run-Test "M17 Cached price is report-only, never a gate" {
    $cap = New-Capability -Pricing @{ default = @{ inputPerMillion = 1.0; outputPerMillion = 5.0; cachedInputPerMillion = 999.0 } }
    $v = Get-ModelAdmissibilityVerdict -ModelId "cached-model" -ProfileKey "quick" -AvailabilityVerified $true -Denylist @() -AvailableModels @("cached-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -InputCeiling 2 -OutputCeiling 10 -CostSensitive $true) -ProfileContextTier "default" -ProfileEffort "low"
    Assert-True ($v.admissible) "A huge cached-input price must not block admissibility."
}

Run-Test "M18 All applicable reason codes are reported together, not just first failure" {
    $cap = New-Capability -Vision $false -SupportedContexts @("default") -SupportedEfforts @("none") -Pricing @{ default = @{ inputPerMillion = 999.0; outputPerMillion = 999.0 } }
    $v = Get-ModelAdmissibilityVerdict -ModelId "many-fail-model" -ProfileKey "visual-ui" -AvailabilityVerified $true -Denylist @() -AvailableModels @("many-fail-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -RequiresVision $true -InputCeiling 3 -OutputCeiling 15) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True (-not $v.admissible) "Expected inadmissible."
    Assert-True ($v.reasonCodes -contains "vision_unsupported") "Expected vision reason present."
    Assert-True ($v.reasonCodes -contains "effort_unsupported") "Expected effort reason present."
    Assert-True ($v.reasonCodes -contains "pricing_input_exceeds_ceiling") "Expected input pricing reason present."
    Assert-True ($v.reasonCodes -contains "pricing_output_exceeds_ceiling") "Expected output pricing reason present."
}

Run-Test "M19 Family-mismatched Opus/Sol can still be admissible for review (no family gate)" {
    $cap = New-Capability -Pricing @{ default = @{ inputPerMillion = 5.0; outputPerMillion = 25.0 } }
    $v = Get-ModelAdmissibilityVerdict -ModelId "claude-opus-5" -ProfileKey "review" -AvailabilityVerified $true -Denylist @() -AvailableModels @("claude-opus-5") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -InputCeiling 5 -OutputCeiling 30) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($v.admissible) "Opus (not in review's baseline family list) must still be able to compete for review under the admissibility engine."
    $cap2 = New-Capability -Pricing @{ default = @{ inputPerMillion = 5.0; outputPerMillion = 30.0 } }
    $v2 = Get-ModelAdmissibilityVerdict -ModelId "gpt-5.6-sol" -ProfileKey "review" -AvailabilityVerified $true -Denylist @() -AvailableModels @("gpt-5.6-sol") -CapabilityRecord $cap2 -ProfileRequirement (New-Requirement -InputCeiling 5 -OutputCeiling 30) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($v2.admissible) "Sol (not in review's baseline family list) must still be able to compete for review under the admissibility engine."
}

Run-Test "M20 Model not in discovered availability list is inadmissible" {
    $v = Get-ModelAdmissibilityVerdict -ModelId "ghost-model" -ProfileKey "default-development" -AvailabilityVerified $true -Denylist @() -AvailableModels @("other-model") -CapabilityRecord (New-Capability) -ProfileRequirement (New-Requirement) -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True (-not $v.admissible) "Model absent from discovery must be inadmissible."
    Assert-True ($v.reasonCodes -contains "not_available") "Expected not_available reason code."
}

Run-Test "M21 Active override retained unchanged on unverified availability" {
    Assert-True (Test-ActiveOverrideAdmissible -ProfileKey "default-development" -ModelId "whatever" -AvailabilityVerified $false -Denylist @("whatever") -AvailableModels @() -CapabilityRecord $null -ProfileRequirement (New-Requirement) -ProfileContextTier "default" -ProfileEffort "medium") "Unverified availability must retain active override unchanged (treated admissible) even if denylisted/missing data."
}

Run-Test "M22 Active override revalidated (and can be revoked) on verified availability" {
    Assert-True (-not (Test-ActiveOverrideAdmissible -ProfileKey "default-development" -ModelId "bad-model" -AvailabilityVerified $true -Denylist @("bad-model") -AvailableModels @("bad-model") -CapabilityRecord (New-Capability) -ProfileRequirement (New-Requirement) -ProfileContextTier "default" -ProfileEffort "medium")) "Verified run must revalidate and revoke a denylisted active override."
}

Run-Test "M22b Active override is retained when verified facts are merely uncertain" {
    $unknownVision = New-Capability
    $unknownVision.vision = $null
    Assert-True (Test-ActiveOverrideAdmissible -ProfileKey "visual-ui" -ModelId "current-model" -AvailabilityVerified $true -AvailableModels @("current-model") -CapabilityRecord $unknownVision -ProfileRequirement (New-Requirement -RequiresVision $true) -ProfileContextTier "default" -ProfileEffort "medium") "Unknown capability data must retain an existing active override."
}

Run-Test "A3 Shared CLI parser recognizes every supported model-id family" {
    $models = @(Get-ModelsFromHelpText -HelpText '"claude-sonnet-5" "gpt-5.6-sol" "gemini-3.1-pro-preview" "mai-code-1-flash-picker"')
    Assert-Eq 4 $models.Count "Expected all four model-id families."
    Assert-True ($models -contains "gemini-3.1-pro-preview") "Expected Gemini model discovery."
    Assert-True ($models -contains "mai-code-1-flash-picker") "Expected MAI model discovery."
}

Run-Test "M23 Forced bootstrap candidate still cannot bypass admissibility" {
    . (Join-Path $PSScriptRoot "model-ranking-data.ps1")
    . (Join-Path $PSScriptRoot "review-task-profiles.ps1")
    $snapshot = [pscustomobject]@{
        models = [ordered]@{
            "claude-sonnet-5" = [ordered]@{
                artificialAnalysis = [ordered]@{ intelligenceIndex = 50; bucket = "competitive"; ordinalRank = 2 }
                liveBench = [ordered]@{ categories = [ordered]@{ coding = 50 }; buckets = [ordered]@{ coding = "competitive" }; ordinalRanks = [ordered]@{ coding = 2 }; costPerSuccessfulTask = 1.0; costBucket = "competitive" }
            }
            "claude-fable-5" = [ordered]@{
                artificialAnalysis = [ordered]@{ intelligenceIndex = 99; bucket = "top"; ordinalRank = 1 }
                liveBench = [ordered]@{ categories = [ordered]@{ coding = 99 }; buckets = [ordered]@{ coding = "top" }; ordinalRanks = [ordered]@{ coding = 1 }; costPerSuccessfulTask = 0.1; costBucket = "top" }
            }
        }
    }
    $capCatalog = @{
        "claude-sonnet-5" = (New-Capability -Pricing @{ default = @{ inputPerMillion = 2.0; outputPerMillion = 10.0 } })
        "claude-fable-5" = (New-Capability -Pricing @{ default = @{ inputPerMillion = 10.0; outputPerMillion = 50.0 } })
    }
    $requirement = New-Requirement -InputCeiling 3 -OutputCeiling 15
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5", "claude-fable-5") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist @("claude-fable-5") -CapabilitiesCatalog $capCatalog -ProfileRequirement $requirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-True ($null -eq $candidate) "Denylisted top-bucket challenger must never qualify as a benchmark candidate, even under a forced bootstrap run."
}

Run-Test "M25 effortMode=unsupported model is admissible regardless of the profile's stored effort value" {
    $cap = New-Capability -EffortMode "unsupported" -SupportedEfforts @()
    $v = Get-ModelAdmissibilityVerdict -ModelId "haiku-like" -ProfileKey "quick" -AvailabilityVerified $true -Denylist @() -AvailableModels @("haiku-like") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -InputCeiling 2 -OutputCeiling 10 -CostSensitive $true) -ProfileContextTier "default" -ProfileEffort "low"
    Assert-True ($v.admissible) "effortMode=unsupported must not block admissibility merely because the profile stores a non-empty effort value; the launcher is responsible for safely omitting the flag."
    Assert-True (-not ($v.reasonCodes -contains "effort_unsupported")) "Expected no effort_unsupported reason when effortMode=unsupported."
}

Run-Test "M26 effortMode=supported (default) still enforces the supportedEfforts list" {
    $cap = New-Capability -SupportedEfforts @("low", "medium")
    $v = Get-ModelAdmissibilityVerdict -ModelId "capped-model" -ProfileKey "deep-reasoning" -AvailabilityVerified $true -Denylist @() -AvailableModels @("capped-model") -CapabilityRecord $cap -ProfileRequirement (New-Requirement -InputCeiling 10 -OutputCeiling 45) -ProfileContextTier "default" -ProfileEffort "high"
    Assert-True (-not $v.admissible) "A model without effortMode=unsupported must still be gated by its supportedEfforts list."
    Assert-True ($v.reasonCodes -contains "effort_unsupported") "Expected effort_unsupported reason code."
}

Run-Test "M24 LiveBench cost no longer blocks a qualifying challenger, only breaks ties" {
    . (Join-Path $PSScriptRoot "model-ranking-data.ps1")
    . (Join-Path $PSScriptRoot "review-task-profiles.ps1")
    $snapshot = [pscustomobject]@{
        models = [ordered]@{
            "claude-sonnet-5" = [ordered]@{
                artificialAnalysis = [ordered]@{ intelligenceIndex = 70; bucket = "competitive"; ordinalRank = 2 }
                liveBench = [ordered]@{ categories = [ordered]@{ coding = 70 }; buckets = [ordered]@{ coding = "competitive" }; ordinalRanks = [ordered]@{ coding = 2 }; costPerSuccessfulTask = 1.0; costBucket = "competitive" }
            }
            "gpt-5.6-terra" = [ordered]@{
                artificialAnalysis = [ordered]@{ intelligenceIndex = 80; bucket = "top"; ordinalRank = 1 }
                liveBench = [ordered]@{ categories = [ordered]@{ coding = 80 }; buckets = [ordered]@{ coding = "top" }; ordinalRanks = [ordered]@{ coding = 1 }; costPerSuccessfulTask = 50.0; costBucket = "lagging" }
            }
        }
    }
    $capCatalog = @{
        "claude-sonnet-5" = (New-Capability -Pricing @{ default = @{ inputPerMillion = 2.0; outputPerMillion = 10.0 } })
        "gpt-5.6-terra" = (New-Capability -Pricing @{ default = @{ inputPerMillion = 2.5; outputPerMillion = 15.0 } })
    }
    $requirement = New-Requirement -InputCeiling 3 -OutputCeiling 15
    $candidate = Get-BenchmarkConsensusCandidate -ProfileKey "default-development" -ValidModels @("claude-sonnet-5", "gpt-5.6-terra") -IncumbentModel "claude-sonnet-5" -Snapshot $snapshot -AvailabilityVerified $true -Denylist @() -CapabilitiesCatalog $capCatalog -ProfileRequirement $requirement -ProfileContextTier "default" -ProfileEffort "medium"
    Assert-Eq "gpt-5.6-terra" $candidate.model "Expected the top+raw-win challenger to qualify despite a much higher LiveBench cost bucket (cost is no longer a hard gate)."
}

# ---- model-selection-policy.ps1 rename ----

Run-Test "F1 Renamed baseline family-match helper is informational only (not an admissibility gate)" {
    $valid = @("gpt-5.6-luna", "claude-haiku-4.5")
    Assert-True (Test-ModelMatchesProfileFamilyPolicy -ProfileKey "quick" -ModelId "gpt-5.6-luna" -ValidModels $valid) "Expected gpt-luna to match quick's baseline family list."
}

Run-Test "F2 Automatic family baseline selection skips an inadmissible top family candidate" {
    $filter = { param($modelId) $modelId -ne "claude-sonnet-5" }
    $result = Get-PreferredModelForProfilePolicy -ProfileKey "default-development" -ValidModels @("claude-sonnet-5", "claude-sonnet-4.6") -AdmissibilityFilter $filter
    Assert-Eq "claude-sonnet-4.6" $result "Expected the next admissible sonnet-family candidate to be chosen when the newest one fails admissibility."
}

Run-Test "F2b Agentic baseline selects the newest admissible Codex version" {
    $result = Get-PreferredModelForProfilePolicy -ProfileKey "agentic-implementation" `
        -ValidModels @("gpt-5.2-codex", "gpt-5.3-codex") `
        -AdmissibleModels @("gpt-5.2-codex", "gpt-5.3-codex")
    Assert-Eq "gpt-5.3-codex" $result "Expected the newest admissible Codex model to remain the agentic baseline."
}

Run-Test "F3 Automatic family baseline selection returns null (grandfather current model) when no candidate is admissible" {
    $filter = { param($modelId) $false }
    $result = Get-PreferredModelForProfilePolicy -ProfileKey "default-development" -ValidModels @("claude-sonnet-5", "gpt-5.6-terra") -AdmissibilityFilter $filter
    Assert-True ($null -eq $result) "Expected null policyPreferred so the current/incumbent model is grandfathered instead of being silently replaced with an inadmissible one."
}

Run-Test "F4 Automatic family baseline selection freezes on unverified availability via the same admissibility engine" {
    $capCatalog = @{
        "claude-sonnet-5" = (New-Capability -Pricing @{ default = @{ inputPerMillion = 2.0; outputPerMillion = 10.0 } })
        "gpt-5.6-terra"   = (New-Capability -Pricing @{ default = @{ inputPerMillion = 2.5; outputPerMillion = 15.0 } })
    }
    $requirement = New-Requirement -InputCeiling 3 -OutputCeiling 15
    $validModels = @("claude-sonnet-5", "gpt-5.6-terra")
    $filter = {
        param($modelId)
        $rec = if ($capCatalog.ContainsKey($modelId)) { $capCatalog[$modelId] } else { $null }
        (Get-ModelAdmissibilityVerdict -ModelId $modelId -ProfileKey "default-development" -AvailabilityVerified $false -Denylist @() -AvailableModels $validModels -CapabilityRecord $rec -ProfileRequirement $requirement -ProfileContextTier "default" -ProfileEffort "medium").admissible
    }.GetNewClosure()
    $result = Get-PreferredModelForProfilePolicy -ProfileKey "default-development" -ValidModels $validModels -AdmissibilityFilter $filter
    Assert-True ($null -eq $result) "Expected unverified availability to freeze automatic baseline changes -- no model can pass the admissibility engine while availability is unverified."
}

Run-Test "F4b Precomputed admissible model list avoids cross-scope callback execution" {
    $result = Get-PreferredModelForProfilePolicy -ProfileKey "default-development" `
        -ValidModels @("claude-sonnet-5", "claude-sonnet-4.6") `
        -AdmissibleModels @("claude-sonnet-4.6")
    Assert-Eq "claude-sonnet-4.6" $result "Expected selection to use only the precomputed admissible model IDs."

    $none = Get-PreferredModelForProfilePolicy -ProfileKey "default-development" `
        -ValidModels @("claude-sonnet-5") `
        -AdmissibleModels @()
    Assert-True ($null -eq $none) "An explicitly empty admissible list must reject every baseline candidate."
}

# ---- strict profile-key requirement (model-policy-config.ps1) ----

Run-Test "P4 Malformed policy (a known profile key missing from one requirement map) fails fast" {
    $threw = $false
    $message = ""
    try {
        Get-ModelPolicyConfig -PolicyPath (Join-Path $fixtureRoot "policy-malformed-missing-profile-key.json")
    } catch { $threw = $true; $message = $_.Exception.Message }
    Assert-True $threw "Expected a policy missing one known profile key from profileLiveBenchCategories to throw."
    Assert-True ($message -match "mechanical") "Expected the error to name the missing profile key."
}

Run-Test "Q1 Get-ProfileAdmissibilityRequirement fails fast for an unknown/omitted profile key (no permissive unlimited fallback)" {
    . (Join-Path $PSScriptRoot "review-task-profiles.ps1")
    $threw = $false
    try {
        Get-ProfileAdmissibilityRequirement -ProfilesByKey @{} -ProfileKey "not-a-real-profile-xyz"
    } catch { $threw = $true }
    Assert-True $threw "Expected a missing profileRequirements entry to throw instead of silently defaulting to an unlimited/no-requirements verdict."
}

# ---- reporting ledger ----

Run-Test "R1 Admissibility report lines include ceilings, freshness, availability confidence and exclusion reasons" {
    $verdicts = @(
        [pscustomobject]@{ modelId = "bad-model"; admissible = $false; reasonCodes = @("pricing_input_exceeds_ceiling"); availabilityConfidence = "verified"; pricing = [pscustomobject]@{ tier = "default"; inputPerMillion = 99; outputPerMillion = 5; ceilingInput = 3; ceilingOutput = 15 }; capabilities = [pscustomobject]@{ asOf = "2026-07-30" } }
    )
    $lines = Get-AdmissibilityReportLines -ProfileKey "default-development" -Verdicts $verdicts -AvailabilityConfidence "verified" -InputCeiling 3 -OutputCeiling 15
    Assert-True (($lines -join "`n") -match "verified") "Expected availability confidence rendered."
    Assert-True (($lines -join "`n") -match "pricing_input_exceeds_ceiling") "Expected exclusion reason rendered."
    Assert-True (($lines -join "`n") -match "3") "Expected input ceiling rendered."
    Assert-True (($lines -join "`n") -match "15") "Expected output ceiling rendered."
}

Run-Test "R2 Admissibility report always renders the incumbent/current model's own verdict, even when it is not in the exclusion table" {
    $incumbentVerdict = [pscustomobject]@{ modelId = "claude-sonnet-5"; admissible = $false; reasonCodes = @("vision_unknown"); availabilityConfidence = "verified"; pricing = $null; capabilities = [pscustomobject]@{ asOf = "2026-07-30" } }
    $lines = Get-AdmissibilityReportLines -ProfileKey "visual-ui" -Verdicts @() -AvailabilityConfidence "verified" -InputCeiling 3 -OutputCeiling 15 -IncumbentModel "claude-sonnet-5" -IncumbentVerdict $incumbentVerdict
    $joined = ($lines -join "`n")
    Assert-True ($joined -match "(?i)incumbent") "Expected the report to clearly label the incumbent/current model line."
    Assert-True ($joined -match "claude-sonnet-5") "Expected the incumbent model id rendered."
    Assert-True ($joined -match "vision_unknown") "Expected the incumbent's own admissibility reason codes rendered (e.g. unknown vision), making cases like an unverified-vision incumbent visible."
}

Run-Test "R3 Admissibility report renders a freeze notice when availability is unverified" {
    $lines = Get-AdmissibilityReportLines -ProfileKey "default-development" -Verdicts @() -AvailabilityConfidence "unverified" -InputCeiling 3 -OutputCeiling 15
    $joined = ($lines -join "`n")
    Assert-True ($joined -match "(?i)unverified") "Expected the unverified availability confidence to be visible."
    Assert-True ($joined -match "(?i)froze|freeze|frozen") "Expected the report to explicitly call out that automatic changes are frozen on unverified availability."
}

Run-Test "F5 Current baseline is grandfathered only for unknown capability data" {
    $unknown = [pscustomobject]@{ admissible = $false; reasonCodes = @("vision_unknown") }
    $incompatible = [pscustomobject]@{ admissible = $false; reasonCodes = @("vision_unsupported") }
    $mixed = [pscustomobject]@{ admissible = $false; reasonCodes = @("vision_unknown", "pricing_output_exceeds_ceiling") }
    Assert-True (Test-ModelAdmissibilityGrandfatherable -Verdict $unknown) "Unknown vision should grandfather the current baseline."
    Assert-True (-not (Test-ModelAdmissibilityGrandfatherable -Verdict $incompatible)) "Confirmed incompatibility must not be grandfathered."
    Assert-True (-not (Test-ModelAdmissibilityGrandfatherable -Verdict $mixed)) "A hard failure must override an uncertainty reason."
}

Write-Host ""
Write-Host "Tests passed: $script:Passed"
Write-Host "Tests failed: $script:Failed"
if ($script:Failed -gt 0) { exit 1 }
