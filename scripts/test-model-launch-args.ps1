Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Tests for scripts/model-launch-args.ps1's Get-CopilotLaunchModelArgs, which
# Start-CopilotWork.ps1 uses to build the `copilot` CLI argument list. This is
# the actual launcher convention: it must OMIT --effort for models whose
# capability catalog record says effortMode=unsupported (e.g. claude-haiku-4.5),
# instead of always passing the profile's stored effort value unconditionally.
# If it always passed --effort, an effortMode=unsupported model would be
# genuinely incompatible with the quick/mechanical baseline -- this is what
# makes admissibility's "effortMode=unsupported passes regardless of stored
# effort" rule actually safe.

. (Join-Path $PSScriptRoot "model-launch-args.ps1")

$script:Passed = 0
$script:Failed = 0

function Assert-True {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) { throw $Message }
}

function Run-Test {
    param([string]$Name, [scriptblock]$Action)
    try { & $Action; $script:Passed++; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $($_.Exception.Message)" }
}

Run-Test "L1 Effort flag included for an effortMode=supported (or unspecified) model" {
    $profile = [pscustomobject]@{ model = "claude-sonnet-5"; effort = "medium"; context = "default" }
    $catalog = @{ "claude-sonnet-5" = [pscustomobject]@{ effortMode = "supported" } }
    $args = Get-CopilotLaunchModelArgs -Profile $profile -CapabilitiesCatalog $catalog
    Assert-True (($args -join " ") -match '--effort medium') "Expected --effort to be passed for a model that supports it."
}

Run-Test "L2 Effort flag omitted for an effortMode=unsupported model (e.g. claude-haiku-4.5), even though the profile stores a non-empty effort value" {
    $profile = [pscustomobject]@{ model = "claude-haiku-4.5"; effort = "low"; context = "default" }
    $catalog = @{ "claude-haiku-4.5" = [pscustomobject]@{ effortMode = "unsupported" } }
    $args = Get-CopilotLaunchModelArgs -Profile $profile -CapabilitiesCatalog $catalog
    Assert-True (-not ($args -contains "--effort")) "Expected --effort to be omitted entirely for an effortMode=unsupported model."
}

Run-Test "L3 Effort flag included by default when the model is absent from the capabilities catalog" {
    $profile = [pscustomobject]@{ model = "unknown-model"; effort = "high"; context = "default" }
    $args = Get-CopilotLaunchModelArgs -Profile $profile -CapabilitiesCatalog @{}
    Assert-True (($args -join " ") -match '--effort high') "Expected --effort to still be passed when no catalog record exists (safe default: supported)."
}

Run-Test "L4 Model and context flags are always present" {
    $profile = [pscustomobject]@{ model = "claude-opus-5"; effort = "high"; context = "long_context" }
    $args = Get-CopilotLaunchModelArgs -Profile $profile -CapabilitiesCatalog @{}
    Assert-True (($args -join " ") -match '--model claude-opus-5') "Expected --model to be passed."
    Assert-True (($args -join " ") -match '--context long_context') "Expected --context to be passed."
}

Run-Test "L5 Empty effort/context values are omitted regardless of effortMode" {
    $profile = [pscustomobject]@{ model = "claude-sonnet-5"; effort = ""; context = "" }
    $catalog = @{ "claude-sonnet-5" = [pscustomobject]@{ effortMode = "supported" } }
    $args = Get-CopilotLaunchModelArgs -Profile $profile -CapabilitiesCatalog $catalog
    Assert-True (-not ($args -contains "--effort")) "Expected --effort omitted when the profile's effort is blank."
    Assert-True (-not ($args -contains "--context")) "Expected --context omitted when the profile's context is blank."
}

Run-Test "L6 Launch catalog loader works with normal ConvertFrom-Json objects" {
    $catalog = Get-LaunchCapabilitiesCatalog -CatalogPath (Join-Path $PSScriptRoot "..\config\model-capabilities.json")
    Assert-True ($catalog.ContainsKey("claude-haiku-4.5")) "Expected model-keyed launch catalog."
    Assert-True ($catalog["claude-haiku-4.5"].effortMode -eq "unsupported") "Expected effort metadata to survive conversion."
}

Write-Host ""
Write-Host "Tests passed: $script:Passed"
Write-Host "Tests failed: $script:Failed"
if ($script:Failed -gt 0) { exit 1 }
