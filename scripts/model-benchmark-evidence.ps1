Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-configuration.ps1")
. (Join-Path $PSScriptRoot "model-agent-identity.ps1")
. (Join-Path $PSScriptRoot "model-role-evidence.ps1")
. (Join-Path $PSScriptRoot "model-release-data.ps1")

function Get-SourceMetricObservation {
    param($Source, $Definition)
    $metric = $Definition.metric
    $identity = @{
        source=$Definition.source;metric=$metric;normalizationVersion=2
        datasetVersion=(Get-ObjectMemberValue $Source "datasetVersion")
        methodologyVersion=(Get-ObjectMemberValue $Source "methodologyVersion")
        categoryColumns=(Get-ObjectMemberValue (Get-ObjectMemberValue $Source "categoryColumns") $metric)
    }
    $scores = @{}
    $models = Get-ObjectMemberValue $Source "models"
    if ($models -is [System.Collections.IDictionary]) {
        foreach ($alias in $models.Keys) {
            $record = $models[$alias]
            $score = Get-ObjectMemberValue $record $metric
            if (-not (Test-ModelScore $score $Definition.min $Definition.max)) { continue }
            $scores[$alias] = @{
                score=$score;harness=(Get-ObjectMemberValue $record "harness")
                versions=(Get-ObjectMemberValue $record "versions")
                suite=(Get-ObjectMemberValue $record "suiteFingerprint")
            }
        }
    }
    return @{identity=(Get-ModelDataFingerprint $identity);version=(Get-ModelDataFingerprint @{identity=$identity;scores=$scores})}
}

function Get-ProfileBenchmarkEvidence {
    param(
        [Parameter(Mandatory)]$Profile,
        [AllowEmptyCollection()][string[]]$Models,
        [AllowEmptyCollection()][object[]]$Configurations,
        [Parameter(Mandatory)][hashtable]$Sources,
        [Parameter(Mandatory)][hashtable]$Aliases,
        [hashtable]$Capabilities = @{},
        [Parameter(Mandatory)][hashtable]$Policy,
        [datetime]$NowUtc = [datetime]::UtcNow
    )
    $records = [System.Collections.Generic.List[object]]::new()
    $diagnostics = [System.Collections.Generic.List[string]]::new()
    if (-not $PSBoundParameters.ContainsKey("Configurations")) {
        $Configurations = @(foreach ($model in $Models) {
            New-ModelConfiguration -Model $model -Effort $Profile.effort -Context $Profile.context -CapabilityRecord $Capabilities[$model]
        })
    }
    $contract = $Policy.selectionPolicy.profiles[$Profile.key]
    $modelReleases = @{}
    foreach ($model in @($Configurations | ForEach-Object model | Sort-Object -Unique)) {
        $modelReleases[$model] = Get-ModelReleaseEvidence -Model $model -Source (Get-ObjectMemberValue $Sources "artificialAnalysisComponents") `
            -Aliases $Aliases -StaleAfterDays $Policy.consensusPolicy.staleAfterDays -NowUtc $NowUtc
    }
    $qualificationMetrics = @(foreach ($dimension in @(Get-ObjectMemberValue (Get-ObjectMemberValue $contract "qualification") "dimensions")) {
        if ($null -ne $dimension) { $dimension.evidenceRoutes }
    })
    $metricKeys = @(@($contract.evidenceRoutes) + $qualificationMetrics + @($contract.supportingMetrics) | Select-Object -Unique)
    foreach ($metricKey in $metricKeys) {
        $definition = $Policy.evidenceMetrics[$metricKey]
        $sourceName = $definition.source
        $metric = $definition.metric
        $source = $Sources[$sourceName]
        foreach ($diagnostic in @(Get-ObjectMemberValue $source "diagnostics" | Where-Object { $null -ne $_ })) {
            $diagnostics.Add("${sourceName}: $diagnostic")
        }
        $status = Get-ObjectMemberValue $source "status"
        if ($status -notin @("ok", "cached")) {
            $diagnostics.Add("${sourceName}: unavailable ($((Get-ObjectMemberValue $source 'message')))")
            continue
        }
        if ((Get-ObjectMemberValue $source "categoryCompletenessUnknown") -eq $true) {
            $diagnostics.Add("${sourceName}: legacy_category_completeness_unknown")
            continue
        }
        $artifactDate = Get-ObjectMemberValue $source "artifactPublishedAtUtc"
        if ($null -ne $artifactDate -and -not (Test-ModelDataFresh $artifactDate ([int]::MaxValue) $NowUtc)) {
            $diagnostics.Add("${sourceName}: artifact_publication_invalid")
            continue
        }
        $fetched = Get-ObjectMemberValue $source "fetchedAtUtc"
        $publication = Get-ObjectMemberValue $source "sourceDate"
        $unknownDate = [string]::IsNullOrWhiteSpace([string]$publication)
        if (-not (Test-ModelDataFresh $fetched $Policy.consensusPolicy.staleAfterDays $NowUtc)) {
            $diagnostics.Add("${sourceName}: retrieval_stale_or_invalid")
            continue
        }
        if (-not $unknownDate -and -not (Test-ModelDataFresh $publication $Policy.consensusPolicy.benchmarkMaxPublicationAgeDays $NowUtc)) {
            $diagnostics.Add("${sourceName}: publication_stale_or_invalid")
            continue
        }
        $observation = Get-SourceMetricObservation $source $definition
        $aliasSource = if ($sourceName -eq "artificialAnalysisComponents") { "artificialAnalysis" } else { $sourceName }
        $aliasUses = @{}
        foreach ($knownModel in $Aliases.Keys) {
            $knownMapping = Get-ObjectMemberValue $Aliases[$knownModel] $aliasSource
            if ($knownMapping -isnot [System.Collections.IDictionary]) { continue }
            foreach ($knownEffort in $knownMapping.Keys) {
                $knownAlias = [string]$knownMapping[$knownEffort]
                if (-not $aliasUses.ContainsKey($knownAlias)) { $aliasUses[$knownAlias] = 0 }
                $aliasUses[$knownAlias]++
            }
        }
        $agentRecords = @{}
        if ($sourceName -eq "artificialAnalysisCodingAgents") {
            $sourceModels = Get-ObjectMemberValue $source "models"
            if ($sourceModels -isnot [System.Collections.IDictionary]) {
                $diagnostics.Add("${sourceName}: structured_models_missing")
                continue
            }
            $knownModels = @(@($Capabilities.Keys) + @($Configurations | ForEach-Object model) | Sort-Object -Unique)
            $resolved = Resolve-AgentModelIdentities -Records $sourceModels -KnownModels $knownModels -Capabilities $Capabilities
            foreach ($diagnostic in $resolved.diagnostics) { $diagnostics.Add("${sourceName}: $diagnostic") }
            foreach ($identity in $resolved.records) {
                $agentRecords["$($identity.model)/$($identity.effort)"] = $identity.record
                if (-not @($Configurations | Where-Object { $_.model -eq $identity.model -and $_.effort -eq $identity.effort }).Count) {
                    $diagnostics.Add("$($identity.model): ${sourceName} effort '$($identity.effort)' not_in_requested_configurations")
                }
            }
        }
        foreach ($configuration in $Configurations) {
            $model = $configuration.model
            $effort = $configuration.effort
            if ($sourceName -eq "artificialAnalysisCodingAgents") {
                $record = $agentRecords["$model/$effort"]
                if ($null -eq $record) {
                    $diagnostics.Add("${model}: ${sourceName} effort '$effort' structured_variant_not_matched")
                    continue
                }
                $alias = $record.label
            } else {
                $mapping = Get-ObjectMemberValue (Get-ObjectMemberValue $Aliases $model) $aliasSource
                $alias = if ($mapping -is [System.Collections.IDictionary]) { Get-ObjectMemberValue $mapping $effort } else { $null }
                if ([string]::IsNullOrWhiteSpace([string]$alias)) {
                    $diagnostics.Add("${model}: ${sourceName} effort '$effort' alias_not_configured")
                    continue
                }
                if ($aliasUses[$alias] -gt 1) {
                    $diagnostics.Add("${model}: ${metricKey} '$alias' alias_ambiguous")
                    continue
                }
                $record = Get-ObjectMemberValue (Get-ObjectMemberValue $source "models") $alias
            }
            if ($sourceName -eq "artificialAnalysisComponents") {
                $publishedEffort = Get-ObjectMemberValue $record "effort"
                $name = [string](Get-ObjectMemberValue $record "name")
                if (($null -ne $publishedEffort -and $publishedEffort -ne $effort) -or
                    $name -match '(?i)\bfallback\b|\bensemble\b|\s\+\s') {
                    $diagnostics.Add("${model}: ${metricKey} identity_ambiguous_or_effort_mismatch")
                    continue
                }
            }
            $score = Get-ObjectMemberValue $record $metric
            if (-not (Test-ModelScore $score $definition.min $definition.max)) {
                $diagnostics.Add("${model}: ${metricKey} '$alias' score_missing_or_invalid")
                continue
            }
            $records.Add([pscustomobject]@{
                model = $model
                modelRelease = $modelReleases[$model]
                effort = $effort
                context = $configuration.context
                configurationId = $configuration.configurationId
                alias = [string]$alias
                source = $sourceName
                metric = $metric
                score = [double]$score
                name = Get-ObjectMemberValue $record "name"
                sourceUrl = Get-ObjectMemberValue $source "sourceUrl"
                sourceVersion = $observation.version
                metricIdentity = $observation.identity
                metricKey = $metricKey
                evidenceRole = if ($metricKey -in $contract.evidenceRoutes) { "deciding" } elseif ($metricKey -in $qualificationMetrics) { "qualification" } else { "supporting" }
                scale = $definition.scale
                limitation = $definition.limitation
                lineage = $definition.lineage
                sourceDate = $publication
                datasetVersion = Get-ObjectMemberValue $source "datasetVersion"
                evaluationDate = Get-ObjectMemberValue $record "evaluationDate"
                artifactPublishedAtUtc = Get-ObjectMemberValue $source "artifactPublishedAtUtc"
                fetchedAtUtc = $fetched
                publicationAgeUnknown = $unknownDate
                cached = $status -eq "cached"
                harness = $(if ($sourceName -eq "artificialAnalysisCodingAgents") {
                    "$($record.harness); variant $($record.variantId); external agent harness, not Copilot CLI"
                } else {
                    "source benchmark harness, not Copilot CLI"
                })
                sourceMetadata = $record
            })
        }
    }
    return [pscustomobject]@{
        records = @($records)
        diagnostics = @($diagnostics)
    }
}
