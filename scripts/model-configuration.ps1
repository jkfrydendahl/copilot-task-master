Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

function New-ModelConfiguration {
    param(
        [Parameter(Mandatory)][string]$Model,
        [Parameter(Mandatory)][string]$Effort,
        [Parameter(Mandatory)][string]$Context,
        $CapabilityRecord = $null
    )
    $effectiveEffort = if ((Get-ObjectMemberValue $CapabilityRecord "effortMode") -eq "unsupported") {
        "none"
    } else {
        $Effort
    }
    $identity = @{model=$Model;effort=$effectiveEffort;context=$Context}
    return [pscustomobject]@{
        model = $Model
        effort = $effectiveEffort
        context = $Context
        configurationId = Get-ModelDataFingerprint $identity
    }
}

function Get-ProfileModelConfigurations {
    param(
        [Parameter(Mandatory)]$Profile,
        [AllowEmptyCollection()][string[]]$Models,
        [hashtable]$Capabilities = @{},
        [Parameter(Mandatory)][hashtable]$Policy
    )
    $configurations = [System.Collections.Generic.List[object]]::new()
    $diagnostics = [System.Collections.Generic.List[string]]::new()
    $selection = Get-ObjectMemberValue $Policy.selectionPolicy.profiles[$Profile.key] "configurationSelection"
    foreach ($model in @($Models | Sort-Object -Unique)) {
        $capability = $Capabilities[$model]
        $efforts = @($Profile.effort)
        if ((Get-ObjectMemberValue $selection "mode") -eq "bounded_effort" -and
            (Get-ObjectMemberValue $capability "effortMode") -ne "unsupported") {
            if ($null -eq $capability) {
                $diagnostics.Add("${model}: configuration capabilities_missing")
                continue
            }
            $supported = @(Get-ObjectMemberValue $capability "supportedEfforts")
            $efforts = @($selection.allowedEfforts | Where-Object { $supported -contains $_ })
            if (-not $efforts.Count) { $diagnostics.Add("${model}: no supported effort within the configured range") }
        }
        foreach ($effort in $efforts) {
            $configurations.Add((New-ModelConfiguration -Model $model -Effort $effort -Context $Profile.context -CapabilityRecord $capability))
        }
    }
    return [pscustomobject]@{configurations=@($configurations);diagnostics=@($diagnostics)}
}

function Get-RecordModelConfiguration {
    param([Parameter(Mandatory)]$Record, [Parameter(Mandatory)]$Profile, [switch]$RequireExplicitEffort)
    $model = Get-ObjectMemberValue $Record "modelId"
    if ([string]::IsNullOrWhiteSpace([string]$model)) { $model = Get-ObjectMemberValue $Record "model" }
    $effort = Get-ObjectMemberValue $Record "effort"
    $context = Get-ObjectMemberValue $Record "context"
    if ($RequireExplicitEffort -and $null -eq $effort) {
        throw "Configuration for '$model' requires an explicit effort in bounded selection."
    }
    # Older fixed-profile callers have no per-record effort/context.
    if ($null -eq $effort) { $effort = $Profile.effort }
    if ($null -eq $context) { $context = $Profile.context }
    New-ModelConfiguration -Model $model -Effort $effort -Context $context -CapabilityRecord (Get-ObjectMemberValue $Record "capabilities")
}
