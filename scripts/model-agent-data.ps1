Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

function Get-AgentJsonArrayText {
    param([string]$Text, [int]$Start)
    $depth = 0
    $quoted = $false
    $escaped = $false
    for ($i = $Start; $i -lt $Text.Length; $i++) {
        $character = $Text[$i]
        if ($quoted) {
            if ($escaped) { $escaped = $false }
            elseif ($character -eq '\') { $escaped = $true }
            elseif ($character -eq '"') { $quoted = $false }
            continue
        }
        if ($character -eq '"') { $quoted = $true }
        elseif ($character -eq '[') { $depth++ }
        elseif ($character -eq ']') {
            $depth--
            if ($depth -eq 0) { return $Text.Substring($Start, $i - $Start + 1) }
        }
    }
    throw [FormatException]::new("Truncated structured agent rows.")
}

function Test-AgentScore {
    param($Value)
    return ($Value -is [int] -or $Value -is [long] -or $Value -is [double] -or $Value -is [decimal]) -and
        [double]::IsFinite([double]$Value) -and $Value -ge 0 -and $Value -le 1
}

function ConvertFrom-AgentPageData {
    param([AllowEmptyString()][string]$Html)
    $diagnostics = [System.Collections.Generic.List[string]]::new()
    $models = @{}
    $seen = @{}
    $suite = $null
    try {
        # Decode JSON string payloads only; never execute the page's JavaScript.
        $chunks = @(foreach ($match in [regex]::Matches($Html, 'self\.__next_f\.push\(\[1,("(?:\\.|[^"\\])*")\]\)')) {
            ConvertFrom-JsonAsHashtableCompat $match.Groups[1].Value
        })
        $text = $chunks -join ""
        foreach ($match in [regex]::Matches($text, '"(?:rows|benchmarkRows)"\s*:\s*\[')) {
            $start = $match.Index + $match.Length - 1
            $rows = @(ConvertFrom-JsonAsHashtableCompat (Get-AgentJsonArrayText $text $start))
            foreach ($row in $rows) {
                if (-not (Test-ObjectMember $row "agentName") -and -not (Test-ObjectMember $row "hostModelSlug") -and
                    -not (Test-ObjectMember $row "indexScore")) { continue }
                $id = Get-ObjectMemberValue $row "id"
                if ($id -isnot [string] -or [string]::IsNullOrWhiteSpace($id)) {
                    $diagnostics.Add("agent_record: variant_id_missing")
                    continue
                }
                $fingerprint = Get-ModelDataFingerprint $row
                if ($seen.ContainsKey($id)) {
                    if ($seen[$id] -ne $fingerprint) { throw [FormatException]::new("Conflicting agent variant '$id'.") }
                    continue
                }
                $seen[$id] = $fingerprint
                $display = Get-ObjectMemberValue $row "display"
                $required = @(
                    (Get-ObjectMemberValue $display "model"), (Get-ObjectMemberValue $row "provider"),
                    (Get-ObjectMemberValue $row "agentName"), (Get-ObjectMemberValue $row "hostModelSlug"),
                    (Get-ObjectMemberValue $row "displayLabel")
                )
                if (@($required | Where-Object { $_ -isnot [string] -or [string]::IsNullOrWhiteSpace($_) }).Count) {
                    $diagnostics.Add("${id}: identity_metadata_missing")
                    continue
                }
                if ((Get-ObjectMemberValue $row "isUnavailable") -isnot [bool] -or $row.isUnavailable) {
                    $diagnostics.Add("${id}: variant_unavailable_or_unknown")
                    continue
                }
                $count = Get-ObjectMemberValue $row "indexComponentCount"
                $evaluations = @(Get-ObjectMemberValue $row "evals")
                if (($count -isnot [int] -and $count -isnot [long]) -or $count -le 0 -or
                    (Get-ObjectMemberValue $row "evalCount") -ne $count -or $evaluations.Count -ne $count -or
                    -not (Test-AgentScore (Get-ObjectMemberValue $row "indexScore"))) {
                    $diagnostics.Add("${id}: index_coverage_or_score_invalid")
                    continue
                }
                $components = @(foreach ($evaluation in $evaluations) {
                    $name = Get-ObjectMemberValue $evaluation "datasetIndexName"
                    $reference = Get-ObjectMemberValue $evaluation "refDatasetName"
                    $weight = Get-ObjectMemberValue $evaluation "weight"
                    $reward = Get-ObjectMemberValue (Get-ObjectMemberValue $evaluation "mean") "reward"
                    if ($name -isnot [string] -or [string]::IsNullOrWhiteSpace($name) -or
                        $reference -isnot [string] -or [string]::IsNullOrWhiteSpace($reference) -or
                        -not (Test-AgentScore $weight) -or $weight -le 0 -or -not (Test-AgentScore $reward)) { continue }
                    @{name=$name;reference=$reference;weight=$weight;score=$reward}
                })
                if ($components.Count -ne $count -or @($components.name | Select-Object -Unique).Count -ne $count -or
                    [math]::Abs(($components.weight | Measure-Object -Sum).Sum - 1) -gt 0.000001) {
                    $diagnostics.Add("${id}: component_coverage_invalid")
                    continue
                }
                $components = @($components | Sort-Object { $_.name })
                $suiteIdentity = @(foreach ($component in $components) {
                    @{name=$component.name;reference=$component.reference;weight=$component.weight}
                })
                $suiteFingerprint = Get-ModelDataFingerprint $suiteIdentity
                if ($null -ne $suite -and $suite -ne $suiteFingerprint) {
                    throw [FormatException]::new("Agent rows contain incompatible benchmark suites.")
                }
                $suite = $suiteFingerprint
                $models[$id] = @{
                    identitySchemaVersion=1;variantId=$id;label=$row.displayLabel;name=$row.displayLabel
                    publishedModel=$display.model;provider=$row.provider;hostModelSlug=$row.hostModelSlug
                    harness=$row.agentName;versions=(Get-ObjectMemberValue $row "versions")
                    components=$components;suiteFingerprint=$suiteFingerprint;codingAgentIndex=[double]$row.indexScore
                }
            }
        }
    } catch [System.ArgumentException] {
        return @{status="unavailable";message="Invalid agent JSON: $($_.Exception.Message)";models=@{};sourceDate=$null;diagnostics=@($diagnostics)}
    } catch [System.FormatException] {
        return @{status="unavailable";message=$_.Exception.Message;models=@{};sourceDate=$null;diagnostics=@($diagnostics)}
    }
    return @{
        status=$(if ($models.Count) { "ok" } else { "unavailable" })
        message=$(if ($models.Count) { "Parsed structured coding-agent variants." } else { "No complete structured coding-agent records found." })
        models=$models;sourceDate=$null;diagnostics=@($diagnostics)
    }
}
