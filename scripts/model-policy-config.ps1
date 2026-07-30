Set-StrictMode -Version Latest

# Strict schema loading/validation for config/model-policy.json.
# Fails fast (throws) on any structural or type problem instead of
# silently defaulting, per the "malformed local policy = fail fast" rule.

# Rule 3 (strict policy config): every task profile key actually used by
# task-profiles.json must have an entry in profileRequirements,
# classPreferences, and profileLiveBenchCategories -- a profile silently
# missing from one of these maps must fail config loading, not fall back to
# an unlimited/no-requirements default at use time. Hardcoding the nine
# currently-known profile keys here (rather than reading task-profiles.json
# from this config-loading module) is acceptable per the finalized design.
$script:KnownTaskProfileKeys = @(
    "orchestrator", "quick", "default-development", "agentic-implementation",
    "deep-reasoning", "review", "visual-ui", "mechanical", "triage"
)

function Get-ModelPolicyConfig {
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory = $true)][string]$PolicyPath
    )

    if (-not (Test-Path $PolicyPath)) {
        throw "Missing model policy file: $PolicyPath"
    }

    $cmd = Get-Command ConvertFrom-Json
    $raw = Get-Content -Path $PolicyPath -Raw
    $parsed = if ($cmd.Parameters.ContainsKey("AsHashtable")) {
        ConvertFrom-Json -InputObject $raw -AsHashtable
    } else {
        throw "PowerShell 6+ with ConvertFrom-Json -AsHashtable is required to load model-policy.json."
    }

    foreach ($required in @("schemaVersion", "denylist", "familyPatterns", "classPreferences", "profileLiveBenchCategories", "profileRequirements", "consensusPolicy")) {
        if (-not $parsed.ContainsKey($required)) {
            throw "Malformed model-policy.json: missing required top-level key '$required'."
        }
    }

    if (-not ($parsed.denylist -is [System.Collections.IEnumerable]) -or ($parsed.denylist -is [string])) {
        throw "Malformed model-policy.json: 'denylist' must be an array."
    }
    if (-not ($parsed.familyPatterns -is [hashtable])) {
        throw "Malformed model-policy.json: 'familyPatterns' must be an object."
    }
    if (-not ($parsed.classPreferences -is [hashtable])) {
        throw "Malformed model-policy.json: 'classPreferences' must be an object."
    }
    if (-not ($parsed.profileLiveBenchCategories -is [hashtable])) {
        throw "Malformed model-policy.json: 'profileLiveBenchCategories' must be an object."
    }
    if (-not ($parsed.profileRequirements -is [hashtable])) {
        throw "Malformed model-policy.json: 'profileRequirements' must be an object."
    }
    if ($parsed.profileRequirements.Count -eq 0) {
        throw "Malformed model-policy.json: 'profileRequirements' must not be empty."
    }

    $requiredRequirementFields = @("inputCeilingPerMillion", "outputCeilingPerMillion", "requiresVision", "requiresCliAgent", "costSensitive")
    foreach ($profileKey in @($parsed.profileRequirements.Keys)) {
        $requirement = $parsed.profileRequirements[$profileKey]
        if (-not ($requirement -is [hashtable])) {
            throw "Malformed model-policy.json: profileRequirements.$profileKey must be an object."
        }
        foreach ($field in $requiredRequirementFields) {
            if (-not $requirement.ContainsKey($field)) {
                throw "Malformed model-policy.json: profileRequirements.$profileKey is missing required field '$field'."
            }
        }
        foreach ($numericField in @("inputCeilingPerMillion", "outputCeilingPerMillion")) {
            $value = $requirement[$numericField]
            $parsedNumber = 0.0
            $isNumeric = ($value -is [double]) -or ($value -is [int]) -or ($value -is [long])
            if (-not $isNumeric -and $value -is [string]) {
                $isNumeric = [double]::TryParse($value, [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$parsedNumber)
            }
            if (-not $isNumeric) {
                throw "Malformed model-policy.json: profileRequirements.$profileKey.$numericField must be numeric."
            }
        }
        foreach ($boolField in @("requiresVision", "requiresCliAgent", "costSensitive")) {
            if (-not ($requirement[$boolField] -is [bool])) {
                throw "Malformed model-policy.json: profileRequirements.$profileKey.$boolField must be a boolean."
            }
        }
    }

    # Every known task profile key must have an entry in all three
    # per-profile maps -- a profile silently missing from any one of them
    # must fail config loading now rather than surface later as a
    # permissive/unlimited default at use time (see
    # Get-ProfileAdmissibilityRequirement in scripts/review-task-profiles.ps1,
    # which has no fallback and throws if asked for a profile not present
    # here).
    foreach ($requiredProfileKey in $script:KnownTaskProfileKeys) {
        if (-not $parsed.profileRequirements.ContainsKey($requiredProfileKey)) {
            throw "Malformed model-policy.json: profileRequirements is missing required profile key '$requiredProfileKey'."
        }
        if (-not $parsed.classPreferences.ContainsKey($requiredProfileKey)) {
            throw "Malformed model-policy.json: classPreferences is missing required profile key '$requiredProfileKey'."
        }
        if (-not $parsed.profileLiveBenchCategories.ContainsKey($requiredProfileKey)) {
            throw "Malformed model-policy.json: profileLiveBenchCategories is missing required profile key '$requiredProfileKey'."
        }
    }

    if (-not ($parsed.consensusPolicy -is [hashtable])) {
        throw "Malformed model-policy.json: 'consensusPolicy' must be an object."
    }
    foreach ($field in @("staleAfterDays", "capabilityFreshnessDays")) {
        if (-not $parsed.consensusPolicy.ContainsKey($field)) {
            throw "Malformed model-policy.json: consensusPolicy is missing required field '$field'."
        }
    }

    return $parsed
}

# Strict schema loading/validation for config/model-capabilities.json.

function Get-ModelCapabilitiesCatalog {
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory = $true)][string]$CatalogPath
    )

    if (-not (Test-Path $CatalogPath)) {
        throw "Missing model capabilities file: $CatalogPath"
    }

    $cmd = Get-Command ConvertFrom-Json
    $raw = Get-Content -Path $CatalogPath -Raw
    $parsed = if ($cmd.Parameters.ContainsKey("AsHashtable")) {
        ConvertFrom-Json -InputObject $raw -AsHashtable
    } else {
        throw "PowerShell 6+ with ConvertFrom-Json -AsHashtable is required to load model-capabilities.json."
    }

    foreach ($required in @("schemaVersion", "generatedDate", "freshnessThresholdDays", "models")) {
        if (-not $parsed.ContainsKey($required)) {
            throw "Malformed model-capabilities.json: missing required top-level key '$required'."
        }
    }
    if (-not ($parsed.models -is [hashtable])) {
        throw "Malformed model-capabilities.json: 'models' must be an object."
    }

    foreach ($modelId in @($parsed.models.Keys)) {
        $record = $parsed.models[$modelId]
        if (-not ($record -is [hashtable])) {
            throw "Malformed model-capabilities.json: models.$modelId must be an object."
        }
        if (-not $record.ContainsKey("asOf")) {
            throw "Malformed model-capabilities.json: models.$modelId is missing 'asOf'."
        }
        $pricingUnavailable = $record.ContainsKey("pricingUnavailable") -and [bool]$record["pricingUnavailable"]
        if ($pricingUnavailable) {
            continue
        }
        foreach ($field in @("vision", "supportedContexts", "supportedEfforts", "capabilitySource", "pricing")) {
            if (-not $record.ContainsKey($field)) {
                throw "Malformed model-capabilities.json: models.$modelId is missing required field '$field' (or must set pricingUnavailable=true)."
            }
        }
        if (-not ($record.supportedContexts -is [System.Collections.IEnumerable]) -or ($record.supportedContexts -is [string])) {
            throw "Malformed model-capabilities.json: models.$modelId.supportedContexts must be an array."
        }
        if (-not ($record.supportedEfforts -is [System.Collections.IEnumerable]) -or ($record.supportedEfforts -is [string])) {
            throw "Malformed model-capabilities.json: models.$modelId.supportedEfforts must be an array."
        }
        # effortMode is optional (defaults to "supported" when absent, meaning
        # gated by supportedEfforts as usual); when present it must be one of
        # the two known values. "unsupported" means the model's CLI surface
        # does not accept an --effort flag at all (e.g. claude-haiku-4.5) --
        # a fact independent of supportedEfforts, which is left empty for
        # such models rather than guessed.
        if ($record.ContainsKey("effortMode")) {
            $effortMode = [string]$record["effortMode"]
            if ($effortMode -ne "supported" -and $effortMode -ne "unsupported") {
                throw "Malformed model-capabilities.json: models.$modelId.effortMode must be 'supported' or 'unsupported'."
            }
        }
        # cliAgentCompatible is intentionally NOT part of this schema: it is
        # derived per run by scripts/model-admissibility.ps1 from this run's
        # own verified live availability, never from a static catalog claim.
        if (-not ($record.pricing -is [hashtable]) -or $record.pricing.Count -eq 0) {
            throw "Malformed model-capabilities.json: models.$modelId.pricing must be a non-empty object."
        }
        foreach ($tierKey in @($record.pricing.Keys)) {
            $tier = $record.pricing[$tierKey]
            if (-not ($tier -is [hashtable])) {
                throw "Malformed model-capabilities.json: models.$modelId.pricing.$tierKey must be an object."
            }
            foreach ($priceField in @("inputPerMillion", "outputPerMillion")) {
                if (-not $tier.ContainsKey($priceField)) {
                    throw "Malformed model-capabilities.json: models.$modelId.pricing.$tierKey is missing '$priceField'."
                }
                $value = $tier[$priceField]
                $isNumeric = ($value -is [double]) -or ($value -is [int]) -or ($value -is [long])
                if (-not $isNumeric) {
                    throw "Malformed model-capabilities.json: models.$modelId.pricing.$tierKey.$priceField must be numeric."
                }
            }
        }
    }

    return $parsed
}
