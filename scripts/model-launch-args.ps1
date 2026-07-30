Set-StrictMode -Version Latest

# Builds the `copilot` CLI launch argument list for a selected task-profile.
# Pulled out of Start-CopilotWork.ps1 so the actual launcher convention is
# unit-testable (see scripts/test-model-launch-args.ps1).
#
# Convention (rule 2 / effortMode): if a model's capability catalog record
# has effortMode="unsupported" (e.g. claude-haiku-4.5), --effort is OMITTED
# entirely, regardless of whatever the profile's stored `effort` value is.
# This is what makes the admissibility engine's "effortMode=unsupported
# passes regardless of the profile's stored effort" rule actually safe: if
# this launcher instead always passed --effort whenever the profile field
# was non-empty, an effortMode=unsupported model would be genuinely
# incompatible with a baseline that stores a non-empty effort (e.g.
# quick/mechanical's "low"), and admissibility would have to reflect that
# instead of waiving it.

function Get-EffortModeForLaunch {
    param(
        [string]$ModelId,
        [hashtable]$CapabilitiesCatalog = @{}
    )
    if ($null -eq $CapabilitiesCatalog -or -not $CapabilitiesCatalog.ContainsKey($ModelId)) {
        return "supported"
    }
    $record = $CapabilitiesCatalog[$ModelId]
    if ($null -eq $record) { return "supported" }
    $value = $null
    if ($record -is [System.Collections.IDictionary]) {
        if ($record.Contains("effortMode")) { $value = $record["effortMode"] }
    } else {
        $prop = $record.PSObject.Properties["effortMode"]
        if ($null -ne $prop) { $value = $prop.Value }
    }
    if ([string]::IsNullOrWhiteSpace([string]$value)) { return "supported" }
    return [string]$value
}

function Get-LaunchCapabilitiesCatalog {
    [OutputType([hashtable])]
    param([Parameter(Mandatory = $true)][string]$CatalogPath)

    $raw = Get-Content $CatalogPath -Raw | ConvertFrom-Json
    $catalog = @{}
    if ($null -eq $raw -or $null -eq $raw.models) { return $catalog }

    foreach ($property in $raw.models.PSObject.Properties) {
        $catalog[$property.Name] = $property.Value
    }
    return $catalog
}

function Get-CopilotLaunchModelArgs {
    [OutputType([string[]])]
    param(
        [Parameter(Mandatory = $true)]$Profile,
        [hashtable]$CapabilitiesCatalog = @{}
    )

    $modelId = [string]$Profile.model
    $args = @("--model", $modelId)

    $effortMode = Get-EffortModeForLaunch -ModelId $modelId -CapabilitiesCatalog $CapabilitiesCatalog
    if ($effortMode -ne "unsupported" -and -not [string]::IsNullOrWhiteSpace([string]$Profile.effort)) {
        $args += @("--effort", [string]$Profile.effort)
    }

    if (-not [string]::IsNullOrWhiteSpace([string]$Profile.context)) {
        $args += @("--context", [string]$Profile.context)
    }

    return $args
}
