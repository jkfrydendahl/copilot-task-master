Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

$script:LiveBenchContentsApiUrl = "https://api.github.com/repos/LiveBench/new-livebench/contents/public"
$script:LiveBenchRepoUrl = "https://github.com/LiveBench/new-livebench/tree/main/public"

function Get-LiveBenchCategoryColumns {
    param(
        [Parameter(Mandatory = $true)][hashtable]$CategoryMap,
        [Parameter(Mandatory = $true)][string[]]$PreferredNames
    )

    foreach ($preferred in $PreferredNames) {
        foreach ($key in $CategoryMap.Keys) {
            if ($key -ieq $preferred) {
                $value = $CategoryMap[$key]
                if ($value -is [System.Collections.IEnumerable] -and $value -isnot [string]) {
                    return @($value | ForEach-Object { [string]$_ })
                }
            }
        }
    }

    return @()
}

function Get-NumericAverageFromRecord {
    param(
        [Parameter(Mandatory = $true)]$Record,
        [Parameter(Mandatory = $true)][string[]]$Columns
    )

    $values = New-Object System.Collections.Generic.List[double]
    foreach ($column in $Columns) {
        if (-not $Record.PSObject.Properties.Name.Contains($column)) {
            return $null
        }
        $text = [string]$Record.$column
        if ([string]::IsNullOrWhiteSpace($text)) {
            return $null
        }
        $number = 0.0
        if ([double]::TryParse($text, [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$number) -and
            [double]::IsFinite($number) -and $number -ge 0 -and $number -le 100) {
            $values.Add($number)
        } else { return $null }
    }

    if ($values.Count -eq 0) {
        return $null
    }

    return ($values | Measure-Object -Average).Average
}

function Parse-LiveBenchData {
    [OutputType([pscustomobject])]
    param(
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$CsvText,
        [AllowEmptyString()][string]$CategoriesJsonText,
        [AllowEmptyString()][string]$CostCsvText,
        [string]$SourceDate
    )

    if ([string]::IsNullOrWhiteSpace($CsvText)) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "LiveBench CSV was empty."
            models = @{}
            sourceDate = $SourceDate
        }
    }

    try {
        $rows = @($CsvText | ConvertFrom-Csv)
    } catch {
        return [pscustomobject]@{
            status = "unavailable"
            message = "LiveBench CSV parse failed: $($_.Exception.Message)"
            models = @{}
            sourceDate = $SourceDate
        }
    }

    if ($rows.Count -eq 0 -or -not $rows[0].PSObject.Properties.Name.Contains("model")) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "LiveBench CSV missing required 'model' column."
            models = @{}
            sourceDate = $SourceDate
        }
    }

    $categoryMap = @{}
    if (-not [string]::IsNullOrWhiteSpace($CategoriesJsonText)) {
        try {
            $categoryObj = ConvertFrom-JsonAsHashtableCompat -JsonText $CategoriesJsonText
            if ($categoryObj -is [System.Collections.IDictionary]) {
                $categoryMap = $categoryObj
            }
        } catch {
            return [pscustomobject]@{
                status = "unavailable"
                message = "LiveBench categories JSON parse failed: $($_.Exception.Message)"
                models = @{}
                sourceDate = $SourceDate
            }
        }
    }

    $codingColumns = @(Get-LiveBenchCategoryColumns -CategoryMap $categoryMap -PreferredNames @("Coding"))
    if ($codingColumns.Count -eq 0) { $codingColumns = @("code_generation", "code_completion") }

    $agenticCodingColumns = @(Get-LiveBenchCategoryColumns -CategoryMap $categoryMap -PreferredNames @("Agentic Coding"))
    if ($agenticCodingColumns.Count -eq 0) { $agenticCodingColumns = @("javascript", "typescript", "python") }

    $reasoningColumns = @(Get-LiveBenchCategoryColumns -CategoryMap $categoryMap -PreferredNames @("Reasoning"))
    if ($reasoningColumns.Count -eq 0) { $reasoningColumns = @("theory_of_mind", "zebra_puzzle", "spatial", "logic_with_navigation") }

    $instructionFollowingColumns = @(Get-LiveBenchCategoryColumns -CategoryMap $categoryMap -PreferredNames @("IF", "Instruction Following"))
    if ($instructionFollowingColumns.Count -eq 0) { $instructionFollowingColumns = @("paraphrase", "simplify", "story_generation", "summarize") }

    $costByModel = @{}
    $costStatus = "unavailable"
    $costMessage = "LiveBench cost CSV was empty."
    if (-not [string]::IsNullOrWhiteSpace($CostCsvText)) {
        try {
            $costRows = @($CostCsvText | ConvertFrom-Csv)
            if ($costRows.Count -eq 0 -or -not $costRows[0].PSObject.Properties.Name.Contains("model") -or -not $costRows[0].PSObject.Properties.Name.Contains("cost_per_successful_task")) {
                $costMessage = "LiveBench cost CSV missing required model or cost_per_successful_task columns."
            } else {
                foreach ($costRow in $costRows) {
                    $costModel = [string]$costRow.model
                    if ([string]::IsNullOrWhiteSpace($costModel)) {
                        continue
                    }
                    $costValueText = [string]$costRow.cost_per_successful_task
                    if ([string]::IsNullOrWhiteSpace($costValueText)) {
                        continue
                    }
                    $costValue = 0.0
                    if (
                        [double]::TryParse($costValueText, [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$costValue) -and
                        -not [double]::IsNaN($costValue) -and
                        -not [double]::IsInfinity($costValue) -and
                        $costValue -ge 0
                    ) {
                        $costByModel[$costModel] = $costValue
                    }
                }
            }
        } catch [System.Management.Automation.ExtendedTypeSystemException] {
            $costByModel = @{}
            $costMessage = "LiveBench cost CSV parse failed: $($_.Exception.Message)"
        }
    }

    $models = @{}
    $diagnostics = [System.Collections.Generic.List[string]]::new()
    $categoryColumns = @{
        coding=$codingColumns;agenticCoding=$agenticCodingColumns
        reasoning=$reasoningColumns;instructionFollowing=$instructionFollowingColumns
    }
    foreach ($row in $rows) {
        $modelName = [string]$row.model
        if ([string]::IsNullOrWhiteSpace($modelName)) {
            continue
        }

        $models[$modelName] = [pscustomobject]@{
            model = $modelName
            coding = Get-NumericAverageFromRecord -Record $row -Columns $codingColumns
            agenticCoding = Get-NumericAverageFromRecord -Record $row -Columns $agenticCodingColumns
            reasoning = Get-NumericAverageFromRecord -Record $row -Columns $reasoningColumns
            instructionFollowing = Get-NumericAverageFromRecord -Record $row -Columns $instructionFollowingColumns
            costPerSuccessfulTask = if ($costByModel.ContainsKey($modelName)) { [double]$costByModel[$modelName] } else { $null }
            evaluationDate = $null
        }
        foreach ($metric in $categoryColumns.Keys) {
            if ($null -eq $models[$modelName].$metric) { $diagnostics.Add("${modelName}: ${metric} category_incomplete_or_invalid") }
        }
    }

    if ($models.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "LiveBench parsed but yielded no models."
            models = @{}
            sourceDate = $SourceDate
            categoryColumns = $categoryColumns
            diagnostics = @($diagnostics)
        }
    }

    $missingCostModels = @($models.Keys | Where-Object { -not $costByModel.ContainsKey($_) })
    if ($costByModel.Count -gt 0 -and $missingCostModels.Count -eq 0) {
        $costStatus = "ok"
        $costMessage = "Parsed complete LiveBench cost data."
    } elseif ($costByModel.Count -gt 0) {
        $costMessage = "LiveBench cost data was incomplete for $($missingCostModels.Count) table models."
    }

    return [pscustomobject]@{
        status = "ok"
        message = "Parsed LiveBench table and categories."
        costStatus = $costStatus
        costMessage = $costMessage
        models = $models
        sourceDate = if ([string]::IsNullOrWhiteSpace($SourceDate)) { $null } else { $SourceDate }
        categoryColumns = $categoryColumns
        diagnostics = @($diagnostics)
    }
}

function Get-LiveBenchData {
    [OutputType([pscustomobject])]
    param(
        [string]$ContentsApiUrl = $script:LiveBenchContentsApiUrl,
        [scriptblock]$FetchJson = $null,
        [scriptblock]$FetchText = $null
    )

    $fetchedAtUtc = (Get-Date).ToUniversalTime().ToString("o")

    if ($null -eq $FetchJson) {
        $FetchJson = { param($u) Invoke-JsonFetch -Url $u -TimeoutSec 30 }
    }
    if ($null -eq $FetchText) {
        $FetchText = { param($u) Invoke-TextFetch -Url $u -TimeoutSec 30 }
    }

    $listResult = & $FetchJson $ContentsApiUrl
    if ($listResult.status -ne "ok" -or $null -eq $listResult.value) {
        return [pscustomobject]@{
            status = "error"
            message = "LiveBench directory listing fetch failed: $($listResult.error)"
            models = @{}
            sourceDate = $null
            fetchedAtUtc = $fetchedAtUtc
            sourceUrl = $script:LiveBenchRepoUrl
        }
    }

    $items = @($listResult.value)
    $tables = @(
        $items |
        Where-Object { $_.name -match '^table_(\d{4}_\d{2}_\d{2})\.csv$' } |
        Sort-Object name -Descending
    )
    if ($tables.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "LiveBench listing had no table_YYYY_MM_DD.csv files."
            models = @{}
            sourceDate = $null
            fetchedAtUtc = $fetchedAtUtc
            sourceUrl = $script:LiveBenchRepoUrl
        }
    }

    $latestTable = $tables[0]
    $tableDate = [regex]::Match($latestTable.name, '^table_(\d{4}_\d{2}_\d{2})\.csv$').Groups[1].Value
    $categoriesName = "categories_$tableDate.json"
    $costName = "cost_$tableDate.csv"
    $categoriesFile = @($items | Where-Object { $_.name -eq $categoriesName } | Select-Object -First 1)
    $costFile = @($items | Where-Object { $_.name -eq $costName } | Select-Object -First 1)

    $tableFetch = & $FetchText $latestTable.download_url
    if ($tableFetch.status -ne "ok") {
        return [pscustomobject]@{
            status = "error"
            message = "LiveBench table fetch failed: $($tableFetch.error)"
            models = @{}
            sourceDate = $null
            fetchedAtUtc = $fetchedAtUtc
            sourceUrl = [string]$latestTable.html_url
        }
    }

    $categoriesText = ""
    if ($categoriesFile.Count -gt 0) {
        $categoryFetch = & $FetchText $categoriesFile[0].download_url
        if ($categoryFetch.status -ne "ok") {
            return [pscustomobject]@{
                status = "unavailable"
                message = "LiveBench categories fetch failed: $($categoryFetch.error)"
                models = @{}
                sourceDate = $null
                fetchedAtUtc = $fetchedAtUtc
                sourceUrl = [string]$latestTable.html_url
            }
        }
        $categoriesText = [string]$categoryFetch.content
    }

    $costText = ""
    if ($costFile.Count -gt 0) {
        $costFetch = & $FetchText $costFile[0].download_url
        if ($costFetch.status -eq "ok") { $costText = [string]$costFetch.content }
    }

    $parsed = Parse-LiveBenchData -CsvText ([string]$tableFetch.content) -CategoriesJsonText $categoriesText -CostCsvText $costText
    $publication = $null
    $artifactCommit = $null
    $diagnostics = @(Get-ObjectMemberValue $parsed "diagnostics")
    $commits = & $FetchJson ("https://api.github.com/repos/LiveBench/new-livebench/commits?path=public%2F$($latestTable.name)&per_page=1")
    $commitRecords = @(Get-ObjectMemberValue $commits "value")
    if ($commits.status -eq "ok" -and $commitRecords.Count) {
        $commit = $commitRecords[0]
        $date = Get-ObjectMemberValue (Get-ObjectMemberValue (Get-ObjectMemberValue $commit "commit") "committer") "date"
        $parsedDate = [datetime]::MinValue
        $validDate = $false
        if ($date -is [datetime]) { $parsedDate = $date.ToUniversalTime(); $validDate = $true }
        elseif ($null -ne $date) {
            $validDate = [datetime]::TryParse([string]$date, [Globalization.CultureInfo]::InvariantCulture,
                ([Globalization.DateTimeStyles]::AssumeUniversal -bor [Globalization.DateTimeStyles]::AdjustToUniversal), [ref]$parsedDate)
        }
        if ($validDate) {
            $publication = $parsedDate.ToUniversalTime().ToString("o")
            $artifactCommit = Get-ObjectMemberValue $commit "sha"
        } elseif ($null -ne $date) {
            $publication = [string]$date
            $diagnostics += "artifact_publication_invalid"
        }
    } elseif ($commits.status -ne "ok") {
        $diagnostics += "artifact_publication_fetch_failed: $((Get-ObjectMemberValue $commits 'error'))"
    }
    if ($null -eq $publication) { $diagnostics += "artifact_publication_unknown; row evaluation ages remain unknown" }
    return [pscustomobject]@{
        status = $parsed.status
        message = $parsed.message
        costStatus = if (Test-ObjectMember -InputObject $parsed -Name "costStatus") { $parsed.costStatus } else { "unavailable" }
        costMessage = if (Test-ObjectMember -InputObject $parsed -Name "costMessage") { $parsed.costMessage } else { $parsed.message }
        models = $parsed.models
        sourceDate = $parsed.sourceDate
        datasetVersion = $tableDate -replace '_', '-'
        artifactPublishedAtUtc = $publication
        artifactCommit = $artifactCommit
        categoryColumns = Get-ObjectMemberValue $parsed "categoryColumns"
        diagnostics = $diagnostics
        sourceVersion = if ($parsed.status -eq "ok") { Get-ModelDataFingerprint @{table=$tableFetch.content;categories=$categoriesText} } else { $null }
        fetchedAtUtc = $fetchedAtUtc
        sourceUrl = [string]$latestTable.html_url
    }
}
