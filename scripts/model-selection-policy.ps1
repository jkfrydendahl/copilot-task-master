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
    param(
        [Parameter(Mandatory = $true)][string]$ProfileKey,
        [Parameter(Mandatory = $true)][string[]]$ValidModels,
        [hashtable]$Policy = (Get-ModelSelectionPolicy)
    )

    if (-not $Policy.classPreferences.ContainsKey($ProfileKey)) {
        return $null
    }

    foreach ($familyName in $Policy.classPreferences[$ProfileKey]) {
        $pattern = [string]$Policy.familyPatterns[$familyName]
        $candidates = @(
            $ValidModels |
            Where-Object { $_ -match $pattern } |
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

function Test-ModelEligibleForProfilePolicy {
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
