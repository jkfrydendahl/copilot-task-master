Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$modelRankingModulePath = Join-Path $PSScriptRoot "model-ranking-data.ps1"
if (Test-Path $modelRankingModulePath) {
    . $modelRankingModulePath
}

# Models that appear in `copilot help config` but are not yet actually selectable.
# Add a model here when it shows up in the CLI list but can't be used in practice.
# Remove it once it becomes fully available.
$script:ModelDenylist = @(
    "claude-fable-5"  # Listed in CLI but pulled back by Anthropic; re-enable when available
)

# Update this list when new models become available in GitHub Copilot.
# Used as fallback when `copilot help config` is not available (e.g. on CI runners).
$script:FallbackKnownModels = @(
    "claude-sonnet-5", "claude-sonnet-4.6", "claude-sonnet-4.5",
    "claude-haiku-4.5",
    "claude-opus-5", "claude-opus-4.8", "claude-opus-4.7", "claude-opus-4.6", "claude-opus-4.6-fast", "claude-opus-4.5",
    "claude-fable-5",
    "gpt-5.6-sol", "gpt-5.6-terra", "gpt-5.6-luna",
    "gpt-5.5", "gpt-5.4", "gpt-5.4-mini", "gpt-5.3-codex", "gpt-5.2-codex", "gpt-5.2", "gpt-5-mini",
    "gemini-3.1-pro-preview", "gemini-3.6-flash", "gemini-3.5-flash",
    "mai-code-1-flash-picker"
)

function Get-ValidModels {
    [OutputType([string[]])]
    param()

    # Matches quoted model IDs in CLI help output. Add new provider prefixes here
    # when new model families appear (e.g. qwen, raptor, kimi).
    $modelPattern = '"(claude-[\w.\-]+|gpt-[\w.\-]+|gemini-[\w.\-]+|mai-[\w.\-]+)"'

    if (Get-Command copilot -ErrorAction SilentlyContinue) {
        try {
            $helpText = (copilot help config 2>&1 | Out-String)
            $cliModels = @(
                [regex]::Matches($helpText, $modelPattern) |
                ForEach-Object { $_.Groups[1].Value } |
                Select-Object -Unique |
                Where-Object { $script:ModelDenylist -notcontains $_ }
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
                Select-Object -Unique |
                Where-Object { $script:ModelDenylist -notcontains $_ }
            )
            if ($cliModels.Count -gt 0) {
                return $cliModels, "gh copilot help config"
            }
        } catch { }
    }

    $fallbackModels = @($script:FallbackKnownModels | Where-Object { $script:ModelDenylist -notcontains $_ })
    return $fallbackModels, "hardcoded fallback (copilot help config not available on this runner)"
}

function Get-PreferredModelForProfile {
    param(
        [string]$ProfileKey,
        [string[]]$ValidModels
    )

    # Regex patterns that identify each model family from a model ID string.
    $familyPatterns = @{
        "sonnet-family"        = 'claude-sonnet-\d'
        "haiku-family"         = 'claude-haiku-\d'
        "opus-family"          = 'claude-opus-\d'
        "fable-family"         = 'claude-fable-\d'
        "codex-family"         = 'gpt-.*-codex'
        "mini-family"          = 'gpt-.*-mini'
        "gpt-flagship-family"  = 'gpt-5\.\d+$'          # numbered base models: gpt-5.4, gpt-5.5
        "gpt-sol-family"       = 'gpt-5\.\d+-sol$'      # deep reasoning + long agentic work
        "gpt-terra-family"     = 'gpt-5\.\d+-terra$'    # balanced general-purpose + agentic
        "gpt-luna-family"      = 'gpt-5\.\d+-luna$'     # fast, cost-efficient
        "mai-family"           = 'mai-[\w.\-]+'          # MAI-Code models: fast, general-purpose coding
    }

    # Per task-class, an ordered list of families to try (first match wins).
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

    if (-not $classPreferences.ContainsKey($ProfileKey)) {
        return $null
    }

    foreach ($familyName in $classPreferences[$ProfileKey]) {
        $pattern = $familyPatterns[$familyName]
        # Filter candidates that belong to this family, then sort so the newest
        # base model wins. Quality-reducing suffixes (-fast, -lite) are demoted
        # below the base model at the same version by sorting on a normalized key
        # that strips those suffixes, with the original ID as a tiebreaker that
        # puts the base model (shorter string) above the suffixed variant.
        $candidates = @(
            $ValidModels |
            Where-Object { $_ -match $pattern } |
            Sort-Object -Descending -Property @(
                @{ Expression = { ($_ -replace '-fast$|-lite$', '') }; Descending = $true },
                @{ Expression = { $_.Length }; Descending = $false }
            )
        )
        if ($candidates.Count -gt 0) {
            return $candidates[0]
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

$rankingReportLines = @(
    "## Advisory model ranking snapshot",
    "",
    "- Status: **unavailable**",
    "- Note: Ranking module unavailable.",
    "",
    "> Advisory only: external rankings never auto-apply and never influence profile-selection policy.",
    ""
)

if (Get-Command Get-AdvisoryModelRankingSnapshot -ErrorAction SilentlyContinue) {
    try {
        $rankingSnapshot = Get-AdvisoryModelRankingSnapshot -RepoRoot $repoRoot -ValidModels $validModels
        $rankingReportLines = Get-ModelRankingReportLines -Snapshot $rankingSnapshot -ValidModels $validModels
    } catch {
        $rankingReportLines = @(
            "## Advisory model ranking snapshot",
            "",
            "- Status: **unavailable**",
            "- Note: Ranking pipeline failed safely: $($_.Exception.Message)",
            "",
            "> Advisory only: external rankings never auto-apply and never influence profile-selection policy.",
            ""
        )
    }
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
$lines += ""
$lines += $rankingReportLines

Set-Content -Path $reportPath -Value (($lines -join "`r`n").TrimEnd()) -Encoding UTF8
Write-Host "Wrote $reportPath"
if ($profilesUpdated) {
    Write-Host "Updated $profilesPath"
}
