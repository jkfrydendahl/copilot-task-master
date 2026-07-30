Set-StrictMode -Version Latest

function Get-ModelSelectionPolicy {
    [OutputType([hashtable])]
    param()

    $familyPatterns = @{
        "sonnet-family"        = 'claude-sonnet-\d'
        "haiku-family"         = 'claude-haiku-\d'
        "opus-family"          = 'claude-opus-\d'
        "fable-family"         = 'claude-fable-\d'
        "codex-family"         = 'gpt-.*-codex'
        "mini-family"          = 'gpt-.*-mini'
        "gpt-flagship-family"  = 'gpt-5\.\d+$'
        "gpt-sol-family"       = 'gpt-5\.\d+-sol$'
        "gpt-terra-family"     = 'gpt-5\.\d+-terra$'
        "gpt-luna-family"      = 'gpt-5\.\d+-luna$'
        "mai-family"           = 'mai-[\w.\-]+'
    }

    $classPreferences = @{
        "orchestrator"           = @("sonnet-family", "gpt-terra-family", "gpt-flagship-family")
        "quick"                  = @("haiku-family", "mai-family", "gpt-luna-family", "mini-family")
        "default-development"    = @("sonnet-family", "gpt-terra-family", "gpt-flagship-family")
        "agentic-implementation" = @("fable-family", "codex-family", "gpt-terra-family", "gpt-flagship-family", "sonnet-family")
        "deep-reasoning"         = @("opus-family", "gpt-sol-family", "gpt-flagship-family")
        "review"                 = @("sonnet-family", "gpt-terra-family", "codex-family")
        "visual-ui"              = @("sonnet-family", "gpt-terra-family", "gpt-flagship-family")
        "mechanical"             = @("haiku-family", "mai-family", "gpt-luna-family", "mini-family")
        "triage"                 = @("sonnet-family", "mai-family", "gpt-luna-family", "mini-family")
    }

    return @{
        familyPatterns = $familyPatterns
        classPreferences = $classPreferences
    }
}

function Get-PreferredModelForProfilePolicy {
    # Rule 1 (baseline/incumbent consistency): family matching alone is only a
    # baseline *preference* ordering. An automatic family-baseline change must
    # never select a model that is inadmissible for this profile (missing
    # capability metadata, wrong pricing tier, unsupported context/effort,
    # etc.). Callers pass -AdmissibilityFilter (typically backed by
    # Get-ModelAdmissibilityVerdict) so each family's candidates are narrowed
    # to admissible ones before the newest/best match is picked. When the
    # filter is omitted, behavior is unchanged (family match only) for
    # existing informational-only callers.
    #
    # Passing an admissibility filter built with AvailabilityVerified=$false
    # naturally returns $null here too: the admissibility engine adds
    # "unverified_availability_freezes_promotion" unconditionally in that
    # case, so no candidate can ever pass, which is exactly how unverified
    # (hardcoded-fallback) discovery runs are required to freeze automatic
    # baseline changes.
    param(
        [Parameter(Mandatory = $true)][string]$ProfileKey,
        [Parameter(Mandatory = $true)][string[]]$ValidModels,
        [hashtable]$Policy = (Get-ModelSelectionPolicy),
        [scriptblock]$AdmissibilityFilter = $null,
        [string[]]$AdmissibleModels
    )

    if (-not $Policy.classPreferences.ContainsKey($ProfileKey)) {
        return $null
    }
    $hasAdmissibleModelList = $PSBoundParameters.ContainsKey("AdmissibleModels")

    foreach ($familyName in $Policy.classPreferences[$ProfileKey]) {
        $pattern = [string]$Policy.familyPatterns[$familyName]
        $candidates = @(
            $ValidModels |
            Where-Object { $_ -match $pattern } |
            Where-Object {
                if ($hasAdmissibleModelList) { $AdmissibleModels -contains $_ }
                elseif ($null -eq $AdmissibilityFilter) { $true }
                else { [bool](& $AdmissibilityFilter $_) }
            } |
            Sort-Object -Descending -Property @(
                @{ Expression = { ($_ -replace '-fast$|-lite$', '') }; Descending = $true },
                @{ Expression = { $_.Length }; Descending = $false }
            )
        )
        if ($candidates.Count -gt 0) {
            return [string]$candidates[0]
        }
    }

    return $null
}

function Test-ModelMatchesProfileFamilyPolicy {
    # Baseline family-pattern match only. This is NOT an admissibility gate:
    # per the finalized architecture, GitHub task-family guidance is baseline
    # preference only and must not gate benchmark-consensus candidates or
    # active-override validity (see scripts/model-admissibility.ps1 for the
    # real admissibility engine). Use this only for informational/baseline
    # purposes (e.g. "does this model match the profile's deterministic
    # fallback family list").
    [OutputType([bool])]
    param(
        [Parameter(Mandatory = $true)][string]$ProfileKey,
        [Parameter(Mandatory = $true)][string]$ModelId,
        [Parameter(Mandatory = $true)][string[]]$ValidModels,
        [string[]]$ModelDenylist = @(),
        [hashtable]$Policy = (Get-ModelSelectionPolicy)
    )

    if ($ValidModels -notcontains $ModelId) {
        return $false
    }
    if ($ModelDenylist -contains $ModelId) {
        return $false
    }
    if (-not $Policy.classPreferences.ContainsKey($ProfileKey)) {
        return $false
    }

    foreach ($familyName in $Policy.classPreferences[$ProfileKey]) {
        $pattern = [string]$Policy.familyPatterns[$familyName]
        if ($ModelId -match $pattern) {
            return $true
        }
    }

    return $false
}
