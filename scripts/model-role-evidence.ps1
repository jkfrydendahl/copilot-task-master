Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

function Get-RoleEvidencePool {
    param($Profile, $Policy, [AllowEmptyCollection()][object[]]$Eligible)
    $contract = $Policy.selectionPolicy.profiles[$Profile.key]
    $qualification = Get-ObjectMemberValue $contract "qualification"
    # File-backed policies require qualification; legacy in-memory callers retain their contract.
    $minimum = if ($null -eq $qualification) { 1 } else { $qualification.minimumModels }
    Get-MetricEvidencePool -Routes $contract.evidenceRoutes -Definitions $Policy.evidenceMetrics -Eligible $Eligible -MinimumModels $minimum
}

function Get-MetricEvidencePool {
    param([string[]]$Routes, $Definitions, [AllowEmptyCollection()][object[]]$Eligible, [long]$MinimumModels)
    $diagnostics = [System.Collections.Generic.List[string]]::new()
    foreach ($cached in @($false, $true)) {
        for ($index = 0; $index -lt $Routes.Count; $index++) {
            $key = $Routes[$index]
            $definition = $Definitions[$key]
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
            if (@($pool | Group-Object configurationId | Where-Object Count -gt 1).Count) {
                $diagnostics.Add("${key}: duplicate_configuration_evidence")
                continue
            }
            $modelCount = @($pool.model | Sort-Object -Unique).Count
            if ($modelCount -lt $MinimumModels) {
                $diagnostics.Add("${key}: insufficient_comparison_models ($modelCount/$MinimumModels)")
                continue
            }
            return [pscustomobject]@{pool=$pool;metricKey=$key;routeIndex=$index;diagnostics=@($diagnostics)}
        }
    }
    return [pscustomobject]@{pool=@();metricKey=$null;routeIndex=-1;diagnostics=@($diagnostics)}
}

function Get-RoleQualification {
    param($Profile, $Policy, $Role, [AllowEmptyCollection()][object[]]$Eligible,
        [Parameter(Mandatory)][AllowEmptyCollection()][object[]]$Configurations)
    $contract = $Policy.selectionPolicy.profiles[$Profile.key]
    $rules = Get-ObjectMemberValue $contract "qualification"
    $result = [pscustomobject]@{
        enabled=($null -ne $rules);pool=@($Role.pool);dimensions=@();candidates=@();diagnostics=@()
        status="not_configured";governingEvidence=@();observation=$null;identity=$null;fresh=$true
        minimumModels=$null
    }
    if ($null -eq $rules) { return $result }
    $result.minimumModels = $rules.minimumModels
    $dimensions = [System.Collections.Generic.List[object]]::new()
    $diagnostics = [System.Collections.Generic.List[string]]::new()
    $definitions = @(@{key="primary";evidenceRoutes=$contract.evidenceRoutes;qualityBands=(Get-ObjectMemberValue $contract "qualityBands")}) + @($rules.dimensions)
    foreach ($dimension in $definitions) {
        $route = if ($dimension.key -eq "primary") { $Role } else {
            Get-MetricEvidencePool -Routes $dimension.evidenceRoutes -Definitions $Policy.evidenceMetrics `
                -Eligible $Eligible -MinimumModels $rules.minimumModels
        }
        foreach ($message in $route.diagnostics) { $diagnostics.Add("$($dimension.key): $message") }
        $reference = @($route.pool | Sort-Object -Property @{Expression={ $_.score };Descending=$true},model,effort | Select-Object -First 1)
        $gap = if ($route.pool.Count) {
            if ($dimension.key -eq "primary" -and $contract.strategy -eq "quality_first") { 0 } else { $dimension.qualityBands[$route.metricKey] }
        } else { $null }
        $dimensions.Add([pscustomobject]@{
            key=$dimension.key;metricKey=$route.metricKey;routeIndex=$route.routeIndex
            evidenceRoutes=$dimension.evidenceRoutes;pool=@($route.pool)
            modelCount=@($route.pool | ForEach-Object model | Sort-Object -Unique).Count
            reference=$(if ($reference.Count) { $reference[0] } else { $null })
            maxScoreGap=$gap
            minimumScore=$(if ($reference.Count) { $reference[0].score - $gap } else { $null })
        })
    }
    $checks = @(foreach ($candidate in @($Configurations | Sort-Object configurationId -Unique)) {
        $dimensionChecks = @(foreach ($dimension in $dimensions) {
            $matched = @($dimension.pool | Where-Object configurationId -eq $candidate.configurationId)
            $record = if ($matched.Count -eq 1) { $matched[0] } else { $null }
            $status = if (-not $dimension.pool.Count) { "insufficient_comparison_evidence" }
                elseif ($null -eq $record) { "exact_configuration_evidence_missing" }
                elseif ($record.score -lt $dimension.minimumScore) { "outside_quality_band" }
                else { "passed" }
            [pscustomobject]@{dimension=$dimension.key;metricKey=$dimension.metricKey;status=$status;record=$record}
        })
        [pscustomobject]@{
            model=$candidate.model;effort=$candidate.effort;context=$candidate.context
            configurationId=$candidate.configurationId
            qualified=(@($dimensionChecks | Where-Object status -ne "passed").Count -eq 0)
            checks=$dimensionChecks
        }
    })
    $qualifiedIds = @($checks | Where-Object qualified | ForEach-Object configurationId)
    $result.pool = @($Role.pool | Where-Object configurationId -in $qualifiedIds)
    $result.dimensions = @($dimensions)
    $result.candidates = $checks
    $result.diagnostics = @($diagnostics)
    $result.status = if (@($dimensions | Where-Object { -not $_.pool.Count }).Count) {
        "retained_insufficient_role_evidence"
    } elseif (-not $result.pool.Count) {
        "retained_no_role_qualified_candidate"
    } else { "qualified" }
    $result.governingEvidence = @($dimensions | Where-Object { $_.pool.Count } | ForEach-Object { $_.pool[0] })
    $result.fresh = $result.status -eq "qualified" -and -not @($result.governingEvidence | Where-Object {
        $_.cached -or [string]::IsNullOrWhiteSpace([string]$_.sourceVersion)
    }).Count
    $result.observation = Get-ModelDataFingerprint @($dimensions | ForEach-Object {
        @{dimension=$_.key;metricKey=$_.metricKey;sourceVersion=(Get-ObjectMemberValue $_.reference "sourceVersion")}
    })
    $result.identity = Get-ModelDataFingerprint @($dimensions | ForEach-Object {
        @{dimension=$_.key;metricKey=$_.metricKey;metricIdentity=(Get-ObjectMemberValue $_.reference "metricIdentity")}
    })
    return $result
}

function Test-BenchmarkEvidenceComparable {
    param($Left, $Right)
    return $Left.source -eq $Right.source -and $Left.metric -eq $Right.metric -and
        $Left.sourceVersion -eq $Right.sourceVersion -and $Left.cached -eq $Right.cached -and
        (Get-ObjectMemberValue $Left "metricIdentity") -eq (Get-ObjectMemberValue $Right "metricIdentity")
}
