Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-configuration.ps1")

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
    $sourceNames = @("artificialAnalysis", "liveBench")
    if ($Profile.key -eq "agentic-implementation") { $sourceNames = @("artificialAnalysisCodingAgents") + $sourceNames }
    foreach ($sourceName in $sourceNames) {
        $source = $Sources[$sourceName]
        $status = Get-ObjectMemberValue $source "status"
        if ($status -notin @("ok", "cached")) {
            $diagnostics.Add("${sourceName}: unavailable ($((Get-ObjectMemberValue $source 'message')))")
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
        foreach ($configuration in $Configurations) {
            $model = $configuration.model
            $effort = $configuration.effort
            $mapping = Get-ObjectMemberValue (Get-ObjectMemberValue $Aliases $model) $sourceName
            $alias = if ($mapping -is [System.Collections.IDictionary]) { Get-ObjectMemberValue $mapping $effort } else { $null }
            if ([string]::IsNullOrWhiteSpace([string]$alias)) {
                $diagnostics.Add("${model}: ${sourceName} effort '$effort' alias_not_configured")
                continue
            }
            $record = Get-ObjectMemberValue (Get-ObjectMemberValue $source "models") $alias
            if ($sourceName -eq "liveBench") {
                $metric = $Policy.profileLiveBenchCategories[$Profile.key]
            } elseif ($sourceName -eq "artificialAnalysisCodingAgents") {
                $metric = "codingAgentIndex"
            } elseif ($Policy.profileArtificialAnalysisMetrics[$Profile.key] -eq "coding") {
                $metric = "codingIndex"
            } else {
                $metric = "intelligenceIndex"
            }
            $score = Get-ObjectMemberValue $record $metric
            if ($null -eq $score -or ($score -isnot [double] -and $score -isnot [int] -and $score -isnot [long] -and $score -isnot [decimal]) -or
                -not [double]::IsFinite([double]$score) -or [double]$score -lt 0) {
                $diagnostics.Add("${model}: ${sourceName} '$alias' score_missing_or_invalid")
                continue
            }
            $records.Add([pscustomobject]@{
                model = $model
                effort = $effort
                context = $configuration.context
                configurationId = $configuration.configurationId
                alias = [string]$alias
                source = $sourceName
                metric = $metric
                score = [double]$score
                name = Get-ObjectMemberValue $record "name"
                sourceUrl = Get-ObjectMemberValue $source "sourceUrl"
                sourceVersion = Get-ObjectMemberValue $source "sourceVersion"
                sourceDate = $publication
                fetchedAtUtc = $fetched
                publicationAgeUnknown = $unknownDate
                cached = $status -eq "cached"
                harness = $(if ($sourceName -eq "artificialAnalysisCodingAgents") {
                    "external agent harness, not Copilot CLI"
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
