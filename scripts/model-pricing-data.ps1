Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")
$script:GitHubPricingUrl = "https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing"

function ConvertFrom-PricingCell {
    param([string]$Html)
    $text = [regex]::Replace($Html, '(?is)<sup\b.*?</sup>', '')
    return ([System.Net.WebUtility]::HtmlDecode([regex]::Replace($text, '<[^>]+>', '')) -replace '\s+', ' ').Trim()
}

function ConvertFrom-GitHubPricingHtml {
    param([AllowEmptyString()][string]$Html)
    $models = @{}
    foreach ($table in [regex]::Matches($Html, '(?is)<table\b[^>]*>.*?</table>')) {
        $headers = @([regex]::Matches($table.Value, '(?is)<th\b[^>]*>(.*?)</th>') | ForEach-Object { ConvertFrom-PricingCell $_.Groups[1].Value })
        if ($headers -notcontains "Model") { continue }
        if ($headers -notcontains "Input" -or $headers -notcontains "Output") {
            throw [System.IO.InvalidDataException]::new("GitHub model pricing table is missing Input/Output columns.")
        }
        if (@($headers | Select-Object -Unique).Count -ne $headers.Count) {
            throw [System.IO.InvalidDataException]::new("Duplicate GitHub pricing columns.")
        }
        foreach ($row in [regex]::Matches($table.Value, '(?is)<tr\b[^>]*>(.*?)</tr>')) {
            $cells = @([regex]::Matches($row.Value, '(?is)<td\b[^>]*>(.*?)</td>') | ForEach-Object { ConvertFrom-PricingCell $_.Groups[1].Value })
            if ($cells.Count -eq 0) { continue }
            if ($cells.Count -ne $headers.Count) { throw [System.IO.InvalidDataException]::new("GitHub pricing row has an unexpected column count.") }
            if (-not ($cells -join '').Trim()) { continue }
            $fields = @{}
            for ($i = 0; $i -lt $headers.Count; $i++) { $fields[$headers[$i]] = $cells[$i] }
            $name = $fields.Model
            if (-not $name) { throw [System.IO.InvalidDataException]::new("Pricing row missing model identity.") }
            $tier = "default"
            if ($fields.ContainsKey("Tier")) {
                switch ($fields.Tier) {
                    "Default" { $tier = "default" }
                    "Long context" { $tier = "long_context" }
                    default { throw [System.IO.InvalidDataException]::new("Unknown pricing tier '$($fields.Tier)' for $name.") }
                }
            }
            $price = [ordered]@{}
            foreach ($column in @("Input", "Output", "Cached input", "Cache write")) {
                $key = @{Input="inputPerMillion";Output="outputPerMillion";"Cached input"="cachedInputPerMillion";"Cache write"="cacheWritePerMillion"}[$column]
                $value = $fields[$column]
                if ($column -in @("Cached input", "Cache write") -and ($null -eq $value -or $value -eq "Not applicable")) {
                    $price[$key] = $null
                    continue
                }
                $number = 0.0
                if ($value -notmatch '^\$\d+(?:\.\d+)?$' -or
                    -not [double]::TryParse($value.Substring(1), [System.Globalization.NumberStyles]::AllowDecimalPoint, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$number) -or
                    -not [double]::IsFinite($number)) {
                    throw [System.IO.InvalidDataException]::new("Invalid $column price '$value' for $name.")
                }
                $price[$key] = $number
            }
            $price.thresholdInputTokens = $null
            $threshold = $fields["Threshold (input tokens)"]
            if ($null -ne $threshold -and $threshold -ne "Not applicable") {
                if ($threshold -notmatch '^(?<operator>\u2264|>)\s*(?<count>\d+(?:\.\d+)?)\s*(?<unit>[KM])$') {
                    throw [System.IO.InvalidDataException]::new("Unrecognized pricing threshold '$threshold'.")
                }
                if (($tier -eq "long_context") -ne ($Matches.operator -eq ">")) {
                    throw [System.IO.InvalidDataException]::new("Threshold operator disagrees with tier for $name.")
                }
                $multiplier = if ($Matches.unit -eq "M") { 1000000 } else { 1000 }
                $price.thresholdInputTokens = [double]::Parse($Matches.count, [System.Globalization.CultureInfo]::InvariantCulture) * $multiplier
            }
            if (-not $models.ContainsKey($name)) { $models[$name] = @{} }
            if ($models[$name].ContainsKey($tier)) { throw [System.IO.InvalidDataException]::new("Duplicate pricing identity: $name / $tier.") }
            $models[$name][$tier] = $price
        }
    }
    if ($models.Count -eq 0) { throw [System.IO.InvalidDataException]::new("No GitHub model pricing rows found.") }
    foreach ($name in $models.Keys) {
        if (-not $models[$name].ContainsKey("default")) { throw [System.IO.InvalidDataException]::new("Missing default pricing tier for $name.") }
        if ($models[$name].ContainsKey("long_context") -and
            ($null -eq $models[$name].default.thresholdInputTokens -or $models[$name].default.thresholdInputTokens -ne $models[$name].long_context.thresholdInputTokens)) {
            throw [System.IO.InvalidDataException]::new("Inconsistent context thresholds for $name.")
        }
    }
    return $models
}

function Resolve-ModelPricingRefresh {
    param(
        [hashtable]$Previous = @{schemaVersion=1; models=@{}},
        [Parameter(Mandatory)][hashtable]$Aliases,
        [Parameter(Mandatory)]$FetchResult,
        [datetime]$NowUtc = [datetime]::UtcNow
    )
    $names = @($Aliases.Values)
    if (@($names | Select-Object -Unique).Count -ne $names.Count -or @($names | Where-Object { $_ -isnot [string] -or [string]::IsNullOrWhiteSpace($_) }).Count) {
        throw "Pricing aliases must contain unique, nonempty display names."
    }

    $diagnostics = [System.Collections.Generic.List[string]]::new()
    $changes = [System.Collections.Generic.List[object]]::new()
    $parsed = $null
    if ($FetchResult.status -ne "ok") {
        $diagnostics.Add("Pricing fetch failed: $($FetchResult.error)")
    } else {
        try { $parsed = ConvertFrom-GitHubPricingHtml -Html $FetchResult.content }
        catch [System.IO.InvalidDataException] { $diagnostics.Add("Pricing parse failed: $($_.Exception.Message)") }
    }
    if ($null -eq $parsed) {
        return [pscustomobject]@{
            snapshot = $Previous
            shouldWrite = $false
            status = "degraded"
            diagnostics = @($diagnostics)
            changes = @($changes)
        }
    }
    $snapshot = $Previous.Clone()
    $snapshot.models = $Previous.models.Clone()
    $snapshot.schemaVersion = 1
    $snapshot.sourceUrl = $script:GitHubPricingUrl
    $snapshot.fetchedAtUtc = $NowUtc.ToUniversalTime().ToString("o")
    $snapshot.sourceFingerprint = [Convert]::ToHexString([System.Security.Cryptography.SHA256]::HashData([System.Text.Encoding]::UTF8.GetBytes($FetchResult.content))).ToLowerInvariant()
    foreach ($id in @($Aliases.Keys | Sort-Object)) {
        $name = $Aliases[$id]
        if (-not $parsed.ContainsKey($name)) {
            $diagnostics.Add("Missing pricing row: $id ($name); retaining original verification timestamp if available.")
            continue
        }
        $old = $snapshot.models[$id]
        $newTiers = $parsed[$name]
        if ($null -ne $old -and $old.name -eq $name -and
            @($old.tiers.Keys | Where-Object { -not $newTiers.Contains($_) }).Count) {
            $diagnostics.Add("Missing pricing tier: $id ($name); retaining original tiers and verification timestamp.")
            continue
        }
        $oldTiers = if ($null -ne $old) { Get-ModelDataFingerprint $old.tiers } else { "" }
        if ($oldTiers -ne (Get-ModelDataFingerprint $newTiers)) {
            $changes.Add([pscustomobject]@{
                model = $id
                previous = $(if ($old) { $old.tiers } else { $null })
                current = $newTiers
            })
        }
        $snapshot.models[$id] = [ordered]@{
            name = $name
            verifiedAtUtc = $snapshot.fetchedAtUtc
            sourceUrl = $script:GitHubPricingUrl
            tiers = $newTiers
        }
    }
    foreach ($name in @($parsed.Keys | Sort-Object)) {
        if ($names -notcontains $name) { $diagnostics.Add("Unmapped GitHub pricing model: $name") }
    }
    return [pscustomobject]@{
        snapshot = $snapshot
        shouldWrite = $true
        status = $(if ($diagnostics.Count) { "partial" } else { "ok" })
        diagnostics = @($diagnostics)
        changes = @($changes)
    }
}

function Update-ModelPricingSnapshot {
    param(
        [Parameter(Mandatory)][string]$SnapshotPath,
        [Parameter(Mandatory)][hashtable]$Aliases,
        [scriptblock]$FetchText = { param($url) Invoke-TextFetch -Url $url },
        [datetime]$NowUtc = [datetime]::UtcNow
    )
    $previous = @{schemaVersion=1; models=@{}}
    if (Test-Path -LiteralPath $SnapshotPath) {
        $previous = ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $SnapshotPath -Raw)
        if ($previous.schemaVersion -ne 1 -or $previous.models -isnot [System.Collections.IDictionary]) {
            throw "Invalid pricing snapshot schema: $SnapshotPath"
        }
    }
    $result = Resolve-ModelPricingRefresh -Previous $previous -Aliases $Aliases -FetchResult (& $FetchText $script:GitHubPricingUrl) -NowUtc $NowUtc
    if ($result.shouldWrite) { Write-ModelJsonAtomic -SnapshotPath $SnapshotPath -SnapshotObject $result.snapshot }
    return $result
}
