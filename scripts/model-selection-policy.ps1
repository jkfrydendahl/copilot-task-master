Set-StrictMode -Version Latest

function Get-ModelSelectionPolicy {
    [OutputType([hashtable])]
    param()

    . (Join-Path $PSScriptRoot "model-policy-config.ps1")
    $config = Get-ModelPolicyConfig -PolicyPath (Join-Path $PSScriptRoot "..\config\model-policy.json")
    return @{
        familyPatterns = $config.familyPatterns
        classPreferences = $config.classPreferences
    }
}

function Get-PreferredModelForProfilePolicy {
    # Informational fallback only; this never selects or applies a benchmark winner.
    param(
        [Parameter(Mandatory = $true)][string]$ProfileKey,
        [Parameter(Mandatory = $true)][string[]]$ValidModels,
        [hashtable]$Policy = (Get-ModelSelectionPolicy),
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
                -not $hasAdmissibleModelList -or $AdmissibleModels -contains $_
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
