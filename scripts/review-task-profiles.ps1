Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Update this list when new models become available in GitHub Copilot.
# Used as fallback when `copilot help config` is not available (e.g. on CI runners).
$script:FallbackKnownModels = @(
    "claude-sonnet-4.6", "claude-sonnet-4.5",
    "claude-haiku-4.5",
    "claude-opus-4.8", "claude-opus-4.7", "claude-opus-4.6", "claude-opus-4.6-fast", "claude-opus-4.5",
    "claude-fable-5",
    "gpt-5.5", "gpt-5.4", "gpt-5.4-mini", "gpt-5.3-codex", "gpt-5.2-codex", "gpt-5.2", "gpt-5-mini",
    "gemini-3.1-pro-preview", "gemini-3.5-flash"
)

function Get-ValidModels {
    [OutputType([string[]])]
    param()

    $modelPattern = '"(claude-[\w.\-]+|gpt-[\w.\-]+|gemini-[\w.\-]+)"'

    if (Get-Command copilot -ErrorAction SilentlyContinue) {
        try {
            $helpText = (copilot help config 2>&1 | Out-String)
            $cliModels = @(
                [regex]::Matches($helpText, $modelPattern) |
                ForEach-Object { $_.Groups[1].Value } |
                Select-Object -Unique
            )
            if ($cliModels.Count -gt 0) {
                return $cliModels, "copilot help config"
            }
        } catch { }
    }

    if (Get-Command gh -ErrorAction SilentlyContinue) {
        try {
            $helpText = (gh copilot help config 2>&1 | Out-String)
            $cliModels = @(
                [regex]::Matches($helpText, $modelPattern) |
                ForEach-Object { $_.Groups[1].Value } |
                Select-Object -Unique
            )
            if ($cliModels.Count -gt 0) {
                return $cliModels, "gh copilot help config"
            }
        } catch { }
    }

    return $script:FallbackKnownModels, "hardcoded fallback (copilot help config not available on this runner)"
}

function Get-PreferredModelForProfile {
    param(
        [string]$ProfileKey,
        [string[]]$ValidModels
    )

    $preferences = @{
        "orchestrator" = @("claude-sonnet-4.6", "claude-sonnet-4.5", "gpt-5.4-mini", "gpt-5-mini")
        "quick" = @("claude-haiku-4.5", "gpt-5-mini", "gpt-5.4-mini")
        "default-development" = @("claude-sonnet-4.6", "claude-sonnet-4.5", "gpt-5.4-mini", "gpt-5.4")
        "agentic-implementation" = @("gpt-5.3-codex", "gpt-5.2-codex", "gpt-5.4", "claude-sonnet-4.6")
        "deep-reasoning" = @("claude-opus-4.8", "claude-opus-4.7", "claude-opus-4.6", "gpt-5.5", "gpt-5.4")
        "review" = @("claude-sonnet-4.6", "gpt-5.3-codex", "claude-sonnet-4.5")
        "visual-ui" = @("claude-sonnet-4.6", "claude-sonnet-4.5", "gpt-5.4")
        "mechanical" = @("claude-haiku-4.5", "gpt-5-mini", "gpt-5.4-mini")
        "triage" = @("claude-sonnet-4.6", "claude-sonnet-4.5", "gpt-5.4-mini")
    }

    if (-not $preferences.ContainsKey($ProfileKey)) {
        return $null
    }

    foreach ($candidate in $preferences[$ProfileKey]) {
        if ($ValidModels -contains $candidate) {
            return $candidate
        }
    }

    return $null
}

$modelComparisonUrl = "https://docs.github.com/en/copilot/reference/ai-models/model-comparison"
$applyAllSuggestionsDirectly = $true

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$profilesPath = Join-Path $repoRoot "task-profiles.json"
$reportDir = Join-Path $repoRoot "reports"
$reportPath = Join-Path $reportDir "task-profile-review.md"

if (!(Test-Path $profilesPath)) {
    throw "Missing task-profiles.json at $profilesPath"
}

if (!(Test-Path $reportDir)) {
    New-Item -ItemType Directory -Path $reportDir -Force | Out-Null
}

$profiles = @(Get-Content $profilesPath -Raw | ConvertFrom-Json)
$requiredFields = @("key", "label", "description", "model", "effort", "context")

$missingFieldFindings = @()
foreach ($profile in $profiles) {
    foreach ($field in $requiredFields) {
        if ([string]::IsNullOrWhiteSpace([string]$profile.$field)) {
            $missingFieldFindings += ('- "{0}" missing `{1}`' -f $profile.key, $field)
        }
    }
}

$usedModels = @(
    $profiles |
    ForEach-Object { $_.model } |
    Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
    Select-Object -Unique
)

$validModels, $modelSource = Get-ValidModels
$validModels = @($validModels)

$invalidUsed = @()
$newAvailable = @()
if ($validModels.Count -gt 0) {
    $invalidUsed = @($usedModels | Where-Object { $validModels -notcontains $_ })
    $newAvailable = @($validModels | Where-Object { $usedModels -notcontains $_ })
}

$suggestions = New-Object System.Collections.Generic.List[object]
$appliedChanges = New-Object System.Collections.Generic.List[string]
$profilesUpdated = $false

if ($validModels.Count -gt 0) {
    foreach ($profile in $profiles) {
        $profileKey = [string]$profile.key
        $currentModel = [string]$profile.model
        if ([string]::IsNullOrWhiteSpace($profileKey) -or [string]::IsNullOrWhiteSpace($currentModel)) {
            continue
        }

        $isCurrentValid = ($validModels -contains $currentModel)
        $preferredModel = Get-PreferredModelForProfile -ProfileKey $profileKey -ValidModels $validModels

        if ([string]::IsNullOrWhiteSpace($preferredModel)) {
            if (-not $isCurrentValid) {
                $suggestions.Add([pscustomobject]@{
                    key = $profileKey
                    current_model = $currentModel
                    suggested_model = $null
                    type = "invalid_model"
                    reason = "Current model is not in the CLI list and no safe class-specific fallback is available."
                    confidence = "high"
                    applied = $false
                })
            }
            continue
        }

        if ($preferredModel -eq $currentModel) {
            continue
        }

        $suggestionType = if ($isCurrentValid) { "policy_preference" } else { "invalid_model" }
        $reason = if ($isCurrentValid) {
            "Preferred monthly policy model for this task class."
        } else {
            "Current model is not in the CLI list; replacing with safe class-specific fallback."
        }
        $confidence = if ($isCurrentValid) { "medium" } else { "high" }

        $applied = $false
        if ($applyAllSuggestionsDirectly) {
            $profile.model = $preferredModel
            $profilesUpdated = $true
            $applied = $true
            $appliedChanges.Add(('- "{0}": "{1}" -> "{2}" ({3})' -f $profileKey, $currentModel, $preferredModel, $suggestionType))
        }

        $suggestions.Add([pscustomobject]@{
            key = $profileKey
            current_model = $currentModel
            suggested_model = $preferredModel
            type = $suggestionType
            reason = $reason
            confidence = $confidence
            applied = $applied
        })
    }
}

if ($profilesUpdated) {
    $profilesJson = $profiles | ConvertTo-Json -Depth 10
    Set-Content -Path $profilesPath -Value $profilesJson -Encoding UTF8
}

$today = (Get-Date).ToString("yyyy-MM-dd")
$lines = @()
$lines += "# Monthly task profile review ($today)"
$lines += ""
$lines += "Reference: $modelComparisonUrl"
$lines += ""
$lines += "Model source: **$modelSource**"
$lines += ""
$lines += "Direct-apply mode: **$($applyAllSuggestionsDirectly.ToString().ToLowerInvariant())**"
$lines += ""
$lines += "## Current profiles"
$lines += ""
$lines += "| Key | Model | Effort | Context |"
$lines += "|---|---|---|---|"
foreach ($profile in $profiles) {
    $lines += "| $($profile.key) | $($profile.model) | $($profile.effort) | $($profile.context) |"
}
$lines += ""

$lines += "## Findings"
if ($missingFieldFindings.Count -eq 0 -and $invalidUsed.Count -eq 0) {
    $lines += "- No structural problems detected."
} else {
    foreach ($finding in $missingFieldFindings) {
        $lines += $finding
    }
    foreach ($model in $invalidUsed) {
        $lines += ('- Model in use not in current CLI list before updates: "{0}"' -f $model)
    }
}
$lines += ""

$lines += "## Suggested profile changes"
if ($suggestions.Count -eq 0) {
    $lines += "- None."
} else {
    foreach ($s in $suggestions) {
        $lines += ('- "{0}": "{1}" -> "{2}" | type: {3} | confidence: {4} | applied: {5}' -f $s.key, $s.current_model, $s.suggested_model, $s.type, $s.confidence, $s.applied)
        $lines += ('  - reason: {0}' -f $s.reason)
    }
}
$lines += ""

$lines += "## Applied profile changes in this run"
if ($appliedChanges.Count -eq 0) {
    $lines += "- None."
} else {
    foreach ($item in $appliedChanges) {
        $lines += $item
    }
}
$lines += ""

$lines += "## Newly available models not currently used"
if ($newAvailable.Count -eq 0) {
    $lines += "- None (or live model list unavailable on runner)."
} else {
    foreach ($model in $newAvailable) {
        $lines += ('- "{0}"' -f $model)
    }
}
$lines += ""

$lines += "## Review checklist"
$lines += "- [ ] Compare candidates on model-comparison page."
$lines += "- [ ] Review suggested/applied model swaps for cost and quality fit."
$lines += "- [ ] Keep cost-sensitive defaults unless clear quality gain is expected."

Set-Content -Path $reportPath -Value ($lines -join "`r`n") -Encoding UTF8
Write-Host "Wrote $reportPath"
if ($profilesUpdated) {
    Write-Host "Updated $profilesPath"
}
