Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

$script:AAComponentProperties = [ordered]@{
    automationBench = "automationBenchPartialScore"
    enterpriseOpsGym = "enterpriseOpsGym"
    ifbench = "ifbench"
    lcr = "lcr"
    mmmuPro = "mmmuPro"
}

$script:AAVersionedComponentDefinitions = [ordered]@{
    frontierCode20 = @{
        source="artificialAnalysisComponents";metric="frontierCode20";benchmarkId="frontiercode-2-0"
        label="FrontierCode 2.0 (AA)";min=0;max=1;scale="score fraction"
        lineage=@("aa-intelligence","aa-intelligence-v5","frontiercode-2-0")
        limitation="Repository-change benchmark with tests and rubric grading; external harness, not Copilot CLI."
    }
    terminalBench40 = @{
        source="artificialAnalysisComponents";metric="terminalBench40";benchmarkId="terminalbench-4-0"
        label="Terminal-Bench 4.0 (AA)";min=0;max=1;scale="score fraction"
        lineage=@("aa-intelligence","aa-intelligence-v5","terminalbench-4-0")
        limitation="Terminal-task benchmark; AA measurement, not independent corroboration of its aggregate."
    }
    critPtV2Hard = @{
        source="artificialAnalysisComponents";metric="critPtV2Hard";benchmarkId="critpt-v2-hard"
        label="CritPt v2 Hard (AA)";min=0;max=1;scale="score fraction"
        lineage=@("aa-intelligence","aa-intelligence-v5","critpt-v2-hard")
        limitation="Scientific problem-solving proxy, not direct defect-finding evidence."
    }
}

function ConvertFrom-AAComponentPage {
    param(
        [AllowEmptyString()][string]$Html,
        [switch]$IncludeVersionedBenchmarks
    )
    $metrics = @($script:AAComponentProperties.Keys)
    $benchmarkMetrics = @{}
    if ($IncludeVersionedBenchmarks) {
        $metrics += @($script:AAVersionedComponentDefinitions.Keys)
        foreach ($metric in $script:AAVersionedComponentDefinitions.Keys) {
            $benchmarkMetrics[$script:AAVersionedComponentDefinitions[$metric].benchmarkId] = $metric
        }
    }
    $models = @{}
    $releases = @{}
    $identities = @{}
    $blockedModels = @{}
    $blockedScores = @{}
    $diagnostics = [System.Collections.Generic.List[string]]::new()
    try {
        $text = Get-PageJsonPayload $Html
        $rows = @(foreach ($match in [regex]::Matches($text, '"(?:models|initialModels|currentModel)"\s*:\s*[\[{]')) {
            $container = ConvertFrom-JsonAsHashtableCompat (Get-StructuredJsonText $text ($match.Index + $match.Length - 1))
            if ($container -is [System.Collections.IDictionary]) { $container } else { foreach ($row in $container) { $row } }
        })
        foreach ($row in $rows) {
            if ($row -isnot [System.Collections.IDictionary] -or
                (-not @($script:AAComponentProperties.Values | Where-Object { $row.Contains($_) }).Count -and
                    -not ($IncludeVersionedBenchmarks -and $row.Contains("intelligenceIndexEvaluations")) -and
                    -not $row.Contains("releaseDate") -and -not $row.Contains("release"))) { continue }
            $slug = Get-ObjectMemberValue $row "slug"
            $name = Get-ObjectMemberValue $row "name"
            if ($slug -isnot [string] -or $slug -notmatch '^[a-z0-9][a-z0-9.-]*$' -or
                $name -isnot [string] -or [string]::IsNullOrWhiteSpace($name)) {
                $diagnostics.Add("component_record: identity_missing_or_invalid")
                continue
            }
            $rawEffort = Get-ObjectMemberValue $row "effort"
            $effort = $rawEffort
            if ($null -ne $effort -and $effort -isnot [string]) { $effort = Get-ObjectMemberValue $effort "slug" }
            if ($name -match '(?i)\bfallback\b|\bensemble\b|\s\+\s' -or
                ($null -ne $rawEffort -and $effort -notin @("none","minimal","low","medium","high","xhigh","max"))) {
                $blockedModels[$slug] = $true
                $diagnostics.Add("${slug}: identity_ambiguous_or_effort_invalid")
                continue
            }
            if ($null -ne (Get-ObjectMemberValue $row "releaseDate")) {
                if (-not $releases.ContainsKey($slug)) { $releases[$slug] = @() }
                $releases[$slug] += @{
                    date=(Get-ObjectMemberValue $row "releaseDate")
                    releaseId=(Get-ObjectMemberValue (Get-ObjectMemberValue $row "release") "slug")
                    effort=$effort
                }
            }
            $releaseId = Get-ObjectMemberValue (Get-ObjectMemberValue $row "release") "slug"
            if ($releaseId -is [string] -and $releaseId -match '^[a-z0-9][a-z0-9.-]*$' -and
                $effort -in @("none","minimal","low","medium","high","xhigh","max")) {
                $identity = @{status="verified";releaseId=$releaseId;effort=$effort}
                if ($name -match '(?i)non[- ](?:reasoning|thinking)' -and $effort -ne "none") {
                    $identity.status = "conflicting"
                }
                if ($identities.ContainsKey($slug) -and
                    (Get-ModelDataFingerprint $identities[$slug]) -ne (Get-ModelDataFingerprint $identity)) {
                    $identities[$slug] = @{status="conflicting";releaseId=$releaseId;effort=$effort}
                } else { $identities[$slug] = $identity }
            }
            $record = [ordered]@{ name = $name; effort = $effort }
            $versionedScores = @{}
            if ($IncludeVersionedBenchmarks) {
                $evaluations = $row["intelligenceIndexEvaluations"]
                if ($null -ne $evaluations -and $evaluations -isnot [System.Collections.IList]) {
                    $diagnostics.Add("${slug}: versioned_components_array_invalid")
                    foreach ($metric in $script:AAVersionedComponentDefinitions.Keys) {
                        $blockedScores["$slug.$metric"] = $true
                    }
                } else {
                    foreach ($evaluation in @($evaluations | Where-Object { $null -ne $_ })) {
                        $benchmark = Get-ObjectMemberValue $evaluation "slug"
                        if ($benchmark -isnot [string]) {
                            $diagnostics.Add("${slug}: versioned_component_identity_missing")
                            continue
                        }
                        if (-not $benchmarkMetrics.ContainsKey($benchmark)) { continue }
                        $metric = $benchmarkMetrics[$benchmark]
                        if ($benchmark -cne $script:AAVersionedComponentDefinitions[$metric].benchmarkId) {
                            $diagnostics.Add("${slug}: ${metric} benchmark_identity_invalid")
                            continue
                        }
                        $score = Get-ObjectMemberValue $evaluation "score"
                        if ($null -eq $score) { continue }
                        if (-not (Test-ModelScore $score 0 1)) {
                            $diagnostics.Add("${slug}: ${metric} score_invalid")
                            $blockedScores["$slug.$metric"] = $true
                            continue
                        }
                        if ($versionedScores.ContainsKey($metric) -and $versionedScores[$metric] -ne $score) {
                            throw [FormatException]::new("Conflicting component score: $slug.$metric")
                        }
                        $versionedScores[$metric] = [double]$score
                    }
                }
            }
            $hasScore = $false
            foreach ($metric in $metrics) {
                $score = if ($script:AAComponentProperties.Contains($metric)) {
                    Get-ObjectMemberValue $row $script:AAComponentProperties[$metric]
                } else { Get-ObjectMemberValue $versionedScores $metric }
                if ($metric -eq "automationBench") {
                    $breakdown = Get-ObjectMemberValue $row "automationBenchBreakdown"
                    if ((Get-ObjectMemberValue $breakdown "fallbackServedTurnCount") -gt 0 -or
                        (Get-ObjectMemberValue $breakdown "fallbackServedTaskCount") -gt 0) {
                        $diagnostics.Add("${slug}: automationBench fallback_served_composite")
                        $blockedScores["$slug.$metric"] = $true
                        $score = $null
                    }
                }
                $valid = Test-ModelScore $score 0 1
                $record[$metric] = if ($valid) { [double]$score } else { $null }
                if ($valid) { $hasScore = $true }
                elseif ($null -ne $score) { $diagnostics.Add("${slug}: ${metric} score_invalid") }
            }
            if (-not $hasScore) { continue }
            if ($models.ContainsKey($slug)) {
                $previous = $models[$slug]
                if ($null -ne $effort -and $null -ne $previous.effort -and $effort -ne $previous.effort) {
                    throw [FormatException]::new("Conflicting component effort: $slug")
                }
                if ($null -ne $effort) { $previous.effort = $effort }
                foreach ($metric in $metrics) {
                    if ($null -ne $record[$metric] -and $null -ne $previous[$metric] -and $record[$metric] -ne $previous[$metric]) {
                        throw [FormatException]::new("Conflicting component score: $slug.$metric")
                    }
                    if ($null -ne $record[$metric]) { $previous[$metric] = $record[$metric] }
                }
            } else {
                $models[$slug] = $record
            }
        }
    } catch [System.ArgumentException], [System.FormatException], [System.InvalidOperationException] {
        return [pscustomobject]@{ status="unavailable"; message=$_.Exception.Message; models=@{}; releases=@{}; identities=@{}; sourceDate=$null; diagnostics=@($diagnostics) }
    }
    foreach ($slug in $blockedModels.Keys) {
        $releases[$slug] = @(@{blocked=$true})
        $identities[$slug] = @{status="blocked"}
    }
    foreach ($slug in @($models.Keys)) {
        if ($blockedModels.ContainsKey($slug)) { $models.Remove($slug); continue }
        foreach ($metric in $metrics) {
            if ($blockedScores.ContainsKey("$slug.$metric")) { $models[$slug][$metric] = $null }
            if ($IncludeVersionedBenchmarks -and $script:AAVersionedComponentDefinitions.Contains($metric) -and
                $null -ne $models[$slug][$metric] -and
                (-not $identities.ContainsKey($slug) -or $identities[$slug].status -ne "verified")) {
                $diagnostics.Add("${slug}: ${metric} published_configuration_unverified")
                $models[$slug][$metric] = $null
            }
        }
        if (-not @($metrics | Where-Object { $null -ne $models[$slug][$_] }).Count) {
            $models.Remove($slug)
        }
    }
    return [pscustomobject]@{
        status = if ($models.Count) { "ok" } else { "unavailable" }
        message = if ($models.Count) { "Parsed AA public component scores." } else { "No structured AA component scores." }
        models = $models
        releases = $releases
        identities = $identities
        sourceDate = $null
        diagnostics = @($diagnostics)
    }
}
