Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

function Get-RoleEvidencePool {
    param($Profile, $Policy, [AllowEmptyCollection()][object[]]$Eligible)
    $contract = $Policy.selectionPolicy.profiles[$Profile.key]
    $diagnostics = [System.Collections.Generic.List[string]]::new()
    foreach ($cached in @($false, $true)) {
        for ($index = 0; $index -lt $contract.evidenceRoutes.Count; $index++) {
            $key = $contract.evidenceRoutes[$index]
            $definition = $Policy.evidenceMetrics[$key]
            $pool = @($Eligible | Where-Object {
                $_.source -eq $definition.source -and $_.metric -eq $definition.metric -and $_.cached -eq $cached -and
                (Test-ModelScore $_.score $definition.min $definition.max)
            })
            if (-not $pool.Count) { continue }
            $versions = @($pool | ForEach-Object {
                Get-ModelDataFingerprint @{version=$_.sourceVersion;identity=(Get-ObjectMemberValue $_ "metricIdentity")}
            } | Sort-Object -Unique)
            if ($versions.Count -gt 1) {
                $diagnostics.Add("${key}: incomparable_observations")
                continue
            }
            return [pscustomobject]@{pool=$pool;metricKey=$key;routeIndex=$index;diagnostics=@($diagnostics)}
        }
    }
    return [pscustomobject]@{pool=@();metricKey=$null;routeIndex=-1;diagnostics=@($diagnostics)}
}

function Test-BenchmarkEvidenceComparable {
    param($Left, $Right)
    return $Left.source -eq $Right.source -and $Left.metric -eq $Right.metric -and
        $Left.sourceVersion -eq $Right.sourceVersion -and $Left.cached -eq $Right.cached -and
        (Get-ObjectMemberValue $Left "metricIdentity") -eq (Get-ObjectMemberValue $Right "metricIdentity")
}
