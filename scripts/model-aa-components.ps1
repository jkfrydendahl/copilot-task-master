Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-aa-component-data.ps1")

function Get-AAComponentData {
    param(
        [AllowEmptyCollection()][string[]]$ModelSlugs,
        [scriptblock]$FetchText = { param($url) Invoke-TextFetch -Url $url }
    )
    $anchor = @($ModelSlugs | Where-Object { $_ -match '^[a-z0-9][a-z0-9.-]*$' } | Sort-Object -Unique | Select-Object -First 1)
    $url = if ($anchor.Count) { "https://artificialanalysis.ai/models/$($anchor[0])" } else { $null }
    $result = [ordered]@{
        status="unavailable"; message="No valid AA model identity for the bulk component page."; models=@{}
        sourceUrl=$url; sourceDate=$null; fetchedAtUtc=[datetime]::UtcNow.ToString("o")
        sourceVersion=$null; metricVersions=@{}; diagnostics=@(); observationSchemaVersion=1
        publicationDateKind="unknown"; evaluationDate=$null
        methodologyUrl="https://artificialanalysis.ai/methodology/intelligence-benchmarking"
    }
    if (-not $anchor.Count) { return [pscustomobject]$result }
    $fetch = & $FetchText $url
    $result.fetchedAtUtc = [datetime]::UtcNow.ToString("o")
    if ($fetch.status -ne "ok") {
        $result.status = "error"
        $result.message = "AA component fetch failed: $($fetch.error)"
        return [pscustomobject]$result
    }
    $parsed = ConvertFrom-AAComponentPage $fetch.content
    foreach ($field in @("status","message","models","diagnostics")) { $result[$field] = $parsed.$field }
    if ($parsed.status -eq "ok") {
        foreach ($metric in $script:AAComponentProperties.Keys) {
            $scores = @{}
            foreach ($slug in $parsed.models.Keys) {
                $score = $parsed.models[$slug][$metric]
                if ($null -ne $score) { $scores[$slug] = $score }
            }
            if ($scores.Count) {
                $result.metricVersions[$metric] = Get-ModelDataFingerprint @{schema=1;metric=$metric;scores=$scores}
            }
        }
        $result.sourceVersion = Get-ModelDataFingerprint $result.metricVersions
    }
    return [pscustomobject]$result
}
