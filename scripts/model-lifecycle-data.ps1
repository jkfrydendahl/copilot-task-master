Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")
$script:GitHubModelLifecycleUrl = "https://docs.github.com/en/copilot/reference/ai-models/supported-models"

function Test-ModelRetirementDate {
    param($Date)
    $parsed = [datetime]::MinValue
    return $Date -is [string] -and [datetime]::TryParseExact($Date, "yyyy-MM-dd",
        [Globalization.CultureInfo]::InvariantCulture, [Globalization.DateTimeStyles]::None, [ref]$parsed)
}

function ConvertFrom-GitHubModelLifecycleHtml {
    param([AllowEmptyString()][string]$Html)
    $cellPattern = '(?is)<(?<cell>th|td)\b[^>]*>(?<content>.*?)</\k<cell>>'
    $tables = @(foreach ($table in [regex]::Matches($Html, '(?is)<table\b[^>]*>.*?</table>')) {
        $firstRow = [regex]::Match($table.Value, '(?is)<tr\b[^>]*>(.*?)</tr>')
        $headers = @([regex]::Matches($firstRow.Groups[1].Value, $cellPattern) |
            ForEach-Object { ConvertFrom-ModelHtmlCell $_.Groups["content"].Value })
        if ($headers -contains "Retirement date") {
            if ($headers.Count -ne 3 -or @($headers | Select-Object -Unique).Count -ne 3 -or
                $headers -notcontains "Model name" -or $headers -notcontains "Suggested alternative") {
                throw [IO.InvalidDataException]::new("Unexpected GitHub model retirement columns.")
            }
            @{html=$table.Value;headers=$headers}
        }
    })
    if ($tables.Count -ne 1) { throw [IO.InvalidDataException]::new("Expected one GitHub model retirement table.") }
    $models = @{}
    foreach ($row in @([regex]::Matches($tables[0].html, '(?is)<tr\b[^>]*>(.*?)</tr>') | Select-Object -Skip 1)) {
        $cells = @([regex]::Matches($row.Groups[1].Value, $cellPattern))
        if ($cells.Count -ne 3) { throw [IO.InvalidDataException]::new("Unexpected GitHub model retirement row.") }
        $fields = @{}
        for ($i = 0; $i -lt 3; $i++) { $fields[$tables[0].headers[$i]] = ConvertFrom-ModelHtmlCell $cells[$i].Groups["content"].Value }
        $name = $fields["Model name"]
        if ([string]::IsNullOrWhiteSpace($name) -or -not (Test-ModelRetirementDate $fields["Retirement date"]) -or
            [string]::IsNullOrWhiteSpace($fields["Suggested alternative"]) -or $models.ContainsKey($name)) {
            throw [IO.InvalidDataException]::new("Invalid or duplicate GitHub model retirement identity/date.")
        }
        $notes = [Collections.Generic.List[string]]::new()
        foreach ($annotation in [regex]::Matches($row.Value, '(?is)<sup\b[^>]*>.*?</sup>')) {
            $references = @([regex]::Matches($annotation.Value, '(?is)\bhref=["'']#(?<id>[^"'']+)["'']'))
            if (-not $references.Count) { throw [IO.InvalidDataException]::new("Unresolved GitHub model retirement annotation.") }
            foreach ($reference in $references) {
                $pattern = '(?is)<li\b[^>]*\s+id=["'']' + [regex]::Escape($reference.Groups["id"].Value) + '["''][^>]*>(.*?)</li>'
                $footnotes = @([regex]::Matches($Html, $pattern))
                if ($footnotes.Count -ne 1) { throw [IO.InvalidDataException]::new("Missing or ambiguous GitHub model retirement footnote.") }
                $text = [regex]::Replace($footnotes[0].Groups[1].Value, '(?is)<a\b[^>]*data-footnote-backref[^>]*>.*?</a>', '')
                $note = ConvertFrom-ModelHtmlCell $text
                if ([string]::IsNullOrWhiteSpace($note)) { throw [IO.InvalidDataException]::new("Empty GitHub model retirement footnote.") }
                $notes.Add($note)
            }
        }
        $models[$name] = @{
            retirementDate=$fields["Retirement date"]
            suggestedAlternative=$fields["Suggested alternative"]
            scope=$(if ($notes.Count) { "conditional" } else { "all" })
            exceptionNotes=@($notes | Select-Object -Unique)
        }
    }
    if (-not $models.Count) { throw [IO.InvalidDataException]::new("No GitHub model retirement records found.") }
    return $models
}

function Get-ModelLifecycleData {
    param(
        [scriptblock]$FetchText={param($url) Invoke-TextFetch -Url $url},
        [datetime]$NowUtc=[datetime]::UtcNow
    )
    $fetch = & $FetchText $script:GitHubModelLifecycleUrl
    if ($fetch.status -ne "ok") { return @{status="error";message="GitHub model retirement fetch failed: $($fetch.error)"} }
    try { $models = ConvertFrom-GitHubModelLifecycleHtml $fetch.content }
    catch [IO.InvalidDataException] { return @{status="error";message="GitHub model retirement parse failed: $($_.Exception.Message)"} }
    if (-not $PSBoundParameters.ContainsKey("NowUtc")) { $NowUtc=[datetime]::UtcNow }
    return @{status="ok";sourceUrl=$script:GitHubModelLifecycleUrl;fetchedAtUtc=$NowUtc.ToUniversalTime().ToString("o");models=$models}
}

function Test-ModelLifecycleCatalog {
    param($Catalog, [int]$MaxAgeDays, [datetime]$NowUtc=[datetime]::UtcNow)
    foreach ($field in @("status","sourceUrl","fetchedAtUtc")) {
        if (-not (Test-ObjectMember $Catalog $field) -or $Catalog.$field -isnot [string]) { return $false }
    }
    $models = if (Test-ObjectMember $Catalog "models") { ,$Catalog.models } else { $null }
    if ((Get-ObjectMemberValue $Catalog "status") -ne "ok" -or
        (Get-ObjectMemberValue $Catalog "sourceUrl") -cne $script:GitHubModelLifecycleUrl -or
        -not (Test-ModelDataFresh (Get-ObjectMemberValue $Catalog "fetchedAtUtc") $MaxAgeDays $NowUtc) -or
        $models -isnot [Collections.IDictionary] -or -not $models.Count) { return $false }
    foreach ($name in $models.Keys) {
        $row = $models[$name]
        foreach ($field in @("retirementDate","suggestedAlternative","scope")) {
            if (-not (Test-ObjectMember $row $field) -or $row.$field -isnot [string]) { return $false }
        }
        $notes = if (Test-ObjectMember $row "exceptionNotes") { ,$row.exceptionNotes } else { $null }
        $scope = Get-ObjectMemberValue $row "scope"
        $alternative = Get-ObjectMemberValue $row "suggestedAlternative"
        if ($name -isnot [string] -or [string]::IsNullOrWhiteSpace($name) -or
            -not (Test-ModelRetirementDate (Get-ObjectMemberValue $row "retirementDate")) -or
            $alternative -isnot [string] -or [string]::IsNullOrWhiteSpace($alternative) -or
            $scope -notin @("all","conditional") -or $notes -isnot [array] -or
            @($notes | Where-Object { $_ -isnot [string] -or [string]::IsNullOrWhiteSpace($_) }).Count -or
            ($scope -eq "all" -and $notes.Count) -or ($scope -eq "conditional" -and -not $notes.Count)) { return $false }
    }
    return $true
}

function Get-ModelLifecycleStatus {
    param([string]$ModelName, $Catalog, [datetime]$NowUtc=[datetime]::UtcNow)
    $row = if (-not [string]::IsNullOrWhiteSpace($ModelName)) { Get-ObjectMemberValue (Get-ObjectMemberValue $Catalog "models") $ModelName }
    if ($null -eq $row) { return @{status="not_listed";name=$ModelName;sourceUrl=$Catalog.sourceUrl;fetchedAtUtc=$Catalog.fetchedAtUtc} }
    $date = [datetime]::ParseExact($row.retirementDate, "yyyy-MM-dd", [Globalization.CultureInfo]::InvariantCulture)
    $status = if ($date -gt $NowUtc.ToUniversalTime().Date) { "scheduled" }
        elseif ($row.scope -eq "conditional") { "conditional" } else { "retired" }
    return @{
        status=$status;name=$ModelName;retirementDate=$row.retirementDate;suggestedAlternative=$row.suggestedAlternative
        exceptionNotes=@($row.exceptionNotes);sourceUrl=$Catalog.sourceUrl;fetchedAtUtc=$Catalog.fetchedAtUtc
    }
}
