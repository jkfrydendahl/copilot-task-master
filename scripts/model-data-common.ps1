Set-StrictMode -Version Latest

function Invoke-TextFetch {
    param(
        [Parameter(Mandatory = $true)][string]$Url,
        [int]$TimeoutSec = 30
    )

    try {
        $response = Invoke-WebRequest -Uri $Url -TimeoutSec $TimeoutSec -Headers @{ "User-Agent" = "copilot-task-master-model-ranking" }
        return [pscustomobject]@{
            status = "ok"
            content = [string]$response.Content
            error = $null
        }
    } catch {
        return [pscustomobject]@{
            status = "error"
            content = $null
            error = $_.Exception.Message
        }
    }
}

function Invoke-JsonFetch {
    param(
        [Parameter(Mandatory = $true)][string]$Url,
        [int]$TimeoutSec = 30
    )

    try {
        $response = Invoke-RestMethod -Uri $Url -TimeoutSec $TimeoutSec -Headers @{ "User-Agent" = "copilot-task-master-model-ranking" }
        return [pscustomobject]@{
            status = "ok"
            value = $response
            error = $null
        }
    } catch {
        return [pscustomobject]@{
            status = "error"
            value = $null
            error = $_.Exception.Message
        }
    }
}

function ConvertTo-HashtableDeep {
    param($Value)
    if ($null -eq $Value) { return $null }
    if ($Value -is [System.Collections.IDictionary]) { return $Value }
    if ($Value -is [System.Collections.IEnumerable] -and -not ($Value -is [string])) {
        $list = New-Object System.Collections.ArrayList
        foreach ($item in $Value) { [void]$list.Add((ConvertTo-HashtableDeep -Value $item)) }
        return $list
    }
    $props = @()
    if ($Value.PSObject) { $props = @($Value.PSObject.Properties) }
    if ($props.Count -gt 0) {
        $ht = @{}
        foreach ($prop in $props) {
            $ht[$prop.Name] = ConvertTo-HashtableDeep -Value $prop.Value
        }
        return $ht
    }
    return $Value
}

function ConvertFrom-JsonAsHashtableCompat {
    [OutputType([hashtable])]
    param([Parameter(Mandatory = $true)][string]$JsonText)
    $cmd = Get-Command ConvertFrom-Json
    if ($cmd.Parameters.ContainsKey("AsHashtable")) {
        $options = @{AsHashtable=$true}
        if ($cmd.Parameters.ContainsKey("DateKind")) { $options.DateKind = "String" }
        return ConvertFrom-Json -InputObject $JsonText @options
    }
    $obj = ConvertFrom-Json -InputObject $JsonText
    return (ConvertTo-HashtableDeep -Value $obj)
}

function Test-ObjectMember {
    param($InputObject, [Parameter(Mandatory = $true)][string]$Name)
    if ($null -eq $InputObject) { return $false }
    if ($InputObject -is [System.Collections.IDictionary]) { return $InputObject.Contains($Name) }
    return @($InputObject.PSObject.Properties | Where-Object { $_.Name -eq $Name }).Count -gt 0
}

function Get-ObjectMemberValue {
    param($InputObject, [Parameter(Mandatory = $true)][string]$Name)
    if (-not (Test-ObjectMember -InputObject $InputObject -Name $Name)) { return $null }
    if ($InputObject -is [System.Collections.IDictionary]) { return $InputObject[$Name] }
    return $InputObject.PSObject.Properties[$Name].Value
}

function ConvertTo-CanonicalModelData {
    param($Value)
    if ($null -eq $Value -or $Value -is [string] -or $Value -is [ValueType]) { return $Value }
    if ($Value -is [System.Collections.IDictionary]) {
        $result=[ordered]@{}
        foreach ($key in @($Value.Keys | Sort-Object)) { $result[$key]=ConvertTo-CanonicalModelData $Value[$key] }
        return $result
    }
    if ($Value -is [System.Collections.IEnumerable]) {
        $result=@(foreach ($item in $Value) { ConvertTo-CanonicalModelData $item })
        return ,$result
    }
    $result=[ordered]@{}
    foreach ($property in @($Value.PSObject.Properties | Sort-Object Name)) { $result[$property.Name]=ConvertTo-CanonicalModelData $property.Value }
    return $result
}

function Get-ModelDataFingerprint {
    param($Value)
    $json = ConvertTo-CanonicalModelData $Value | ConvertTo-Json -Depth 50 -Compress
    return [Convert]::ToHexString([System.Security.Cryptography.SHA256]::HashData([System.Text.Encoding]::UTF8.GetBytes($json))).ToLowerInvariant()
}

function Test-ModelDataFresh {
    param($Date, [int]$MaxAgeDays, [datetime]$NowUtc = [datetime]::UtcNow)
    if ($null -eq $Date) { return $false }
    $parsed = [datetime]::MinValue
    if ($Date -is [datetime]) { $parsed=$Date.ToUniversalTime() }
    elseif (-not [datetime]::TryParse([string]$Date, [System.Globalization.CultureInfo]::InvariantCulture,
        ([System.Globalization.DateTimeStyles]::AssumeUniversal -bor [System.Globalization.DateTimeStyles]::AdjustToUniversal), [ref]$parsed)) { return $false }
    $age = ($NowUtc.ToUniversalTime() - $parsed).TotalDays
    return $age -ge 0 -and $age -le $MaxAgeDays
}

function Test-ModelScore {
    param($Score, [double]$Minimum = 0, [double]$Maximum = 100)
    return ($Score -is [double] -or $Score -is [int] -or $Score -is [long] -or $Score -is [decimal]) -and
        [double]::IsFinite([double]$Score) -and $Score -ge $Minimum -and $Score -le $Maximum
}

function Get-StructuredJsonText {
    param([string]$Text, [int]$Start)
    $opening = $Text[$Start]
    if ($opening -notin @('[','{')) { throw [FormatException]::new("Expected a structured JSON container.") }
    $closing = if ($opening -eq '[') { ']' } else { '}' }
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
        elseif ($character -eq $opening) { $depth++ }
        elseif ($character -eq $closing) {
            $depth--
            if ($depth -eq 0) { return $Text.Substring($Start, $i - $Start + 1) }
        }
    }
    throw [FormatException]::new("Truncated structured JSON.")
}

function Get-PageJsonPayload {
    param([AllowEmptyString()][string]$Html)
    # Decode JSON strings, never execute page scripts. Chunks may split a record.
    $chunks = @(foreach ($match in [regex]::Matches($Html, 'self\.__next_f\.push\(\[1,("(?:\\.|[^"\\])*")\]\)')) {
        ConvertFrom-JsonAsHashtableCompat $match.Groups[1].Value
    })
    return $chunks -join ""
}

function Write-ModelJsonAtomic {
    param(
        [Parameter(Mandatory = $true)][string]$SnapshotPath,
        [Parameter(Mandatory = $true)]$SnapshotObject
    )
    $directory = Split-Path -Path $SnapshotPath -Parent
    if (-not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }
    $tempPath = Join-Path $directory ("{0}.tmp" -f [Guid]::NewGuid().ToString("N"))
    $json = $SnapshotObject | ConvertTo-Json -Depth 20
    try {
        Set-Content -LiteralPath $tempPath -Value $json -Encoding UTF8 -ErrorAction Stop
        Move-Item -LiteralPath $tempPath -Destination $SnapshotPath -Force -ErrorAction Stop
    } finally {
        if (Test-Path -LiteralPath $tempPath) { Remove-Item -LiteralPath $tempPath -ErrorAction Stop }
    }
}
