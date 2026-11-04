Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-aa-component-data.ps1")

function Get-AAComponentData {
    param(
        [AllowEmptyCollection()][string[]]$ModelSlugs,
        [scriptblock]$FetchText = { param($url) Invoke-TextFetch -Url $url },
        [switch]$IncludeVersionedBenchmarks
    )
    $anchor = @($ModelSlugs | Where-Object { $_ -match '^[a-z0-9][a-z0-9.-]*$' } | Sort-Object -Unique | Select-Object -First 1)
    $url = if ($anchor.Count) { "https://artificialanalysis.ai/models/$($anchor[0])" } else { $null }
    $result = [ordered]@{
        status="unavailable"; message="No valid AA model identity for the bulk component page."; models=@{}; releases=@{}; identities=@{}
        sourceUrl=$url; sourceDate=$null; fetchedAtUtc=[datetime]::UtcNow.ToString("o")
        sourceVersion=$null; metricVersions=@{}; diagnostics=@(); observationSchemaVersion=1
        publicationDateKind="unknown"; evaluationDate=$null
        methodologyUrl="https://artificialanalysis.ai/methodology/intelligence-benchmarking"
    }
    if ($IncludeVersionedBenchmarks) {
        $result.observationSchemaVersion = 2
        $result.metricDefinitions = ConvertTo-CanonicalModelData $script:AAVersionedComponentDefinitions
        $result.evaluatorRevision = $null
    }
    if (-not $anchor.Count) { return [pscustomobject]$result }
    $fetch = & $FetchText $url
    $result.fetchedAtUtc = [datetime]::UtcNow.ToString("o")
    if ($fetch.status -ne "ok") {
        $result.status = "error"
        $result.message = "AA component fetch failed: $($fetch.error)"
        return [pscustomobject]$result
    }
    $parsed = ConvertFrom-AAComponentPage $fetch.content -IncludeVersionedBenchmarks:$IncludeVersionedBenchmarks
    foreach ($field in @("status","message","models","releases","identities","diagnostics")) { $result[$field] = $parsed.$field }
    if ($parsed.status -eq "ok") {
        $metrics = @($script:AAComponentProperties.Keys)
        if ($IncludeVersionedBenchmarks) { $metrics += @($script:AAVersionedComponentDefinitions.Keys) }
        foreach ($metric in $metrics) {
            $scores = @{}
            $identities = @{}
            foreach ($slug in $parsed.models.Keys) {
                $score = $parsed.models[$slug][$metric]
                if ($null -ne $score) {
                    $scores[$slug] = $score
                    if ($script:AAVersionedComponentDefinitions.Contains($metric)) {
                        $identities[$slug] = $parsed.identities[$slug]
                    }
                }
            }
            if ($scores.Count) {
                $observation = @{schema=1;metric=$metric;scores=$scores}
                if ($script:AAVersionedComponentDefinitions.Contains($metric)) {
                    $observation.schema = 2
                    $observation.definition = $result.metricDefinitions[$metric]
                    $observation.identities = $identities
                }
                $result.metricVersions[$metric] = Get-ModelDataFingerprint $observation
            }
        }
        $result.sourceVersion = Get-ModelDataFingerprint $result.metricVersions
    }
    return [pscustomobject]$result
}
