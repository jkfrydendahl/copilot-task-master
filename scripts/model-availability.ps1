Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-id-parser.ps1")

# Current model discovery/availability logic. Returns which models are usable
# right now, where that list came from, and — critically — whether the
# discovery is *verified* (came from a live Copilot CLI/GHE source) or is the
# hardcoded fallback (unverified). Callers use `verified` to decide whether
# benchmark promotion may proceed this run (rule: hardcoded fallback discovery
# freezes promotion but must not revoke active overrides).

$script:ModelAvailabilityFallbackKnownModels = @(
    "claude-sonnet-5", "claude-sonnet-4.6", "claude-sonnet-4.5",
    "claude-haiku-4.5",
    "claude-opus-5", "claude-opus-4.8", "claude-opus-4.8-fast", "claude-opus-4.7", "claude-opus-4.6", "claude-opus-4.5",
    "claude-fable-5",
    "gpt-5.6-sol", "gpt-5.6-terra", "gpt-5.6-luna",
    "gpt-5.5", "gpt-5.4", "gpt-5.4-mini", "gpt-5.3-codex", "gpt-5.2-codex", "gpt-5.2", "gpt-5-mini",
    "gemini-3.1-pro-preview", "gemini-3.6-flash", "gemini-3.5-flash",
    "mai-code-1-flash-picker"
)

function Get-ModelsFromHelpText {
    [OutputType([string[]])]
    param([Parameter(Mandatory = $true)][string]$HelpText)
    return @(Get-CopilotModelIdsFromHelpText -HelpText $HelpText)
}

function Get-ModelAvailability {
    [OutputType([pscustomobject])]
    param(
        [string[]]$Denylist = @(),
        [string[]]$FallbackModels = $script:ModelAvailabilityFallbackKnownModels,
        [scriptblock]$CliProbe = $null,
        [scriptblock]$GhProbe = $null
    )

    if ($null -eq $CliProbe) {
        $CliProbe = {
            if (-not (Get-Command copilot -ErrorAction SilentlyContinue)) { return @() }
            try {
                $helpText = (copilot help config 2>&1 | Out-String)
                return Get-ModelsFromHelpText -HelpText $helpText
            } catch {
                return @()
            }
        }
    }
    if ($null -eq $GhProbe) {
        $GhProbe = {
            if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { return @() }
            try {
                $helpText = (gh copilot help config 2>&1 | Out-String)
                return Get-ModelsFromHelpText -HelpText $helpText
            } catch {
                return @()
            }
        }
    }

    $cliModels = @(& $CliProbe | Where-Object { $Denylist -notcontains $_ })
    if ($cliModels.Count -gt 0) {
        return [pscustomobject]@{
            models = $cliModels
            source = "copilot help config"
            verified = $true
            confidence = "verified"
        }
    }

    $ghModels = @(& $GhProbe | Where-Object { $Denylist -notcontains $_ })
    if ($ghModels.Count -gt 0) {
        return [pscustomobject]@{
            models = $ghModels
            source = "gh copilot help config"
            verified = $true
            confidence = "verified"
        }
    }

    return [pscustomobject]@{
        models = @($FallbackModels | Where-Object { $Denylist -notcontains $_ })
        source = "hardcoded fallback (copilot help config not available on this runner)"
        verified = $false
        confidence = "unverified"
    }
}
