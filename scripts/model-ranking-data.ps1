Set-StrictMode -Version Latest

$script:ModelRankingSchemaVersion = 2
$script:ModelRankingStaleAfterDays = 45
$script:ArtificialAnalysisUrl = "https://artificialanalysis.ai/?intelligence=agentic-index"
$script:ArtificialAnalysisCodingAgentsUrl = "https://artificialanalysis.ai/agents/coding-agents"
$script:LiveBenchContentsApiUrl = "https://api.github.com/repos/LiveBench/new-livebench/contents/public"
$script:LiveBenchRepoUrl = "https://github.com/LiveBench/new-livebench/tree/main/public"

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
        return ConvertFrom-Json -InputObject $JsonText -AsHashtable
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

function Get-ModelScoreFingerprint {
    param(
        [Parameter(Mandatory = $true)][System.Collections.IDictionary]$Models,
        [Parameter(Mandatory = $true)][string]$ScoreProperty
    )
    $parts = foreach ($key in @($Models.Keys | Sort-Object)) {
        $score = Get-ObjectMemberValue -InputObject $Models[$key] -Name $ScoreProperty
        if ($null -ne $score) {
            "{0}={1}" -f $key, ([double]$score).ToString("R", [System.Globalization.CultureInfo]::InvariantCulture)
        }
    }
    if (@($parts).Count -eq 0) { return $null }
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes(($parts -join "`n"))
        return ([System.BitConverter]::ToString($sha.ComputeHash($bytes))).Replace("-", "").ToLowerInvariant()
    } finally {
        $sha.Dispose()
    }
}

function Parse-ArtificialAnalysisAgenticIndexFromHtml {
    [OutputType([pscustomobject])]
    param(
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Html
    )

    if ([string]::IsNullOrWhiteSpace($Html)) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "Artificial Analysis HTML was empty."
            models = @{}
            sourceDate = $null
        }
    }

    $pattern = '\\\"slug\\\":\\\"(?<slug>[^\\\"]+)\\\",\\\"name\\\":\\\"(?<name>[^\\\"]+)\\\"(?:(?!\\\"slug\\\":).){0,2000}?\\\"releaseDate\\\":\\\"(?<releaseDate>[^\\\"]+)\\\"(?:(?!\\\"slug\\\":).){0,4000}?\\\"agenticIndex\\\":(?<agenticIndex>-?\d+(?:\.\d+)?)'
    $matches = [regex]::Matches($Html, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    if ($matches.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "Artificial Analysis embedded model records with agenticIndex were not found."
            models = @{}
            sourceDate = $null
        }
    }

    $models = @{}
    $maxDate = $null
    foreach ($match in $matches) {
        $slug = [string]$match.Groups["slug"].Value
        $name = [string]$match.Groups["name"].Value
        $scoreText = [string]$match.Groups["agenticIndex"].Value
        $releaseDateText = [string]$match.Groups["releaseDate"].Value

        $score = 0.0
        if (-not [double]::TryParse($scoreText, [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$score)) {
            continue
        }

        $releaseDate = $null
        try {
            $releaseDate = [datetime]::Parse($releaseDateText, [System.Globalization.CultureInfo]::InvariantCulture)
            if ($null -eq $maxDate -or $releaseDate -gt $maxDate) {
                $maxDate = $releaseDate
            }
        } catch { }

        if ($models.ContainsKey($slug)) {
            if ([math]::Abs([double]$models[$slug].agenticIndex - $score) -gt 0.000001) {
                return [pscustomobject]@{
                    status = "unavailable"
                    message = "Artificial Analysis embedded data was ambiguous for model slug '$slug'."
                    models = @{}
                    sourceDate = $null
                }
            }
            continue
        }

        $models[$slug] = [pscustomobject]@{
            slug = $slug
            name = $name
            agenticIndex = $score
        }
    }

    if ($models.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "Artificial Analysis parsing found no numeric agentic index records."
            models = @{}
            sourceDate = $null
        }
    }

    return [pscustomobject]@{
        status = "ok"
        message = "Parsed embedded model records."
        models = $models
        sourceDate = if ($null -ne $maxDate) { $maxDate.ToString("yyyy-MM-dd") } else { $null }
    }
}

function Parse-ArtificialAnalysisCodingAgentIndexFromHtml {
    [OutputType([pscustomobject])]
    param(
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Html
    )

    if ([string]::IsNullOrWhiteSpace($Html)) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "Artificial Analysis Coding Agents HTML was empty."
            models = @{}
            sourceDate = $null
        }
    }

    $normalizedHtml = $Html -replace '\\+"', '"'
    $pattern = '"label":"(?<label>[^"]+)","codingAgentsIndex":(?<codingAgentIndex>-?\d+(?:\.\d+)?)'
    $matches = [regex]::Matches($normalizedHtml, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    if ($matches.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "Artificial Analysis embedded coding-agent records with codingAgentsIndex were not found."
            models = @{}
            sourceDate = $null
        }
    }

    $models = @{}
    foreach ($match in $matches) {
        $label = [string]$match.Groups["label"].Value
        $scoreText = [string]$match.Groups["codingAgentIndex"].Value

        $score = 0.0
        if (-not [double]::TryParse($scoreText, [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$score)) {
            continue
        }

        if ($models.ContainsKey($label)) {
            if ([math]::Abs([double]$models[$label].codingAgentIndex - $score) -gt 0.000001) {
                return [pscustomobject]@{
                    status = "unavailable"
                    message = "Artificial Analysis coding-agent data was ambiguous for label '$label'."
                    models = @{}
                    sourceDate = $null
                }
            }
            continue
        }

        $models[$label] = [pscustomobject]@{
            label = $label
            name = $label
            codingAgentIndex = $score
        }
    }

    if ($models.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "Artificial Analysis coding-agent parsing found no numeric records."
            models = @{}
            sourceDate = $null
        }
    }

    return [pscustomobject]@{
        status = "ok"
        message = "Parsed embedded coding-agent records."
        models = $models
        sourceDate = $null
    }
}

function Get-ArtificialAnalysisAgenticIndexData {
    [OutputType([pscustomobject])]
    param(
        [string]$Url = $script:ArtificialAnalysisUrl,
        [scriptblock]$FetchText = $null
    )

    $fetchedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
    if ($null -eq $FetchText) {
        $FetchText = { param($u) Invoke-TextFetch -Url $u -TimeoutSec 30 }
    }

    $fetchResult = & $FetchText $Url
    if ($fetchResult.status -ne "ok") {
        return [pscustomobject]@{
            status = "error"
            message = "Fetch failed: $($fetchResult.error)"
            models = @{}
            sourceDate = $null
            fetchedAtUtc = $fetchedAtUtc
            sourceUrl = $Url
        }
    }

    $parsed = Parse-ArtificialAnalysisAgenticIndexFromHtml -Html ([string]$fetchResult.content)
    return [pscustomobject]@{
        status = $parsed.status
        message = $parsed.message
        models = $parsed.models
        sourceDate = $parsed.sourceDate
        sourceVersion = if ($parsed.status -eq "ok") { Get-ModelScoreFingerprint -Models $parsed.models -ScoreProperty "agenticIndex" } else { $null }
        fetchedAtUtc = $fetchedAtUtc
        sourceUrl = $Url
    }
}

function Get-ArtificialAnalysisCodingAgentIndexData {
    [OutputType([pscustomobject])]
    param(
        [string]$Url = $script:ArtificialAnalysisCodingAgentsUrl,
        [scriptblock]$FetchText = $null
    )

    $fetchedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
    if ($null -eq $FetchText) {
        $FetchText = { param($u) Invoke-TextFetch -Url $u -TimeoutSec 30 }
    }

    $fetchResult = & $FetchText $Url
    if ($fetchResult.status -ne "ok") {
        return [pscustomobject]@{
            status = "error"
            message = "Fetch failed: $($fetchResult.error)"
            models = @{}
            sourceDate = $null
            fetchedAtUtc = $fetchedAtUtc
            sourceUrl = $Url
        }
    }

    $parsed = Parse-ArtificialAnalysisCodingAgentIndexFromHtml -Html ([string]$fetchResult.content)
    return [pscustomobject]@{
        status = $parsed.status
        message = $parsed.message
        models = $parsed.models
        sourceDate = $parsed.sourceDate
        sourceVersion = if ($parsed.status -eq "ok") { Get-ModelScoreFingerprint -Models $parsed.models -ScoreProperty "codingAgentIndex" } else { $null }
        fetchedAtUtc = $fetchedAtUtc
        sourceUrl = $Url
    }
}

function Get-LiveBenchCategoryColumns {
    param(
        [Parameter(Mandatory = $true)][hashtable]$CategoryMap,
        [Parameter(Mandatory = $true)][string[]]$PreferredNames
    )

    foreach ($preferred in $PreferredNames) {
        foreach ($key in $CategoryMap.Keys) {
            if ($key -ieq $preferred) {
                $value = $CategoryMap[$key]
                if ($value -is [System.Collections.IEnumerable]) {
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
            continue
        }
        $text = [string]$Record.$column
        if ([string]::IsNullOrWhiteSpace($text)) {
            continue
        }
        $number = 0.0
        if ([double]::TryParse($text, [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$number)) {
            $values.Add($number)
        }
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

    $codingColumns = Get-LiveBenchCategoryColumns -CategoryMap $categoryMap -PreferredNames @("Coding")
    if ($codingColumns.Count -eq 0) { $codingColumns = @("code_generation", "code_completion") }

    $agenticCodingColumns = Get-LiveBenchCategoryColumns -CategoryMap $categoryMap -PreferredNames @("Agentic Coding")
    if ($agenticCodingColumns.Count -eq 0) { $agenticCodingColumns = @("javascript", "typescript", "python") }

    $reasoningColumns = Get-LiveBenchCategoryColumns -CategoryMap $categoryMap -PreferredNames @("Reasoning")
    if ($reasoningColumns.Count -eq 0) { $reasoningColumns = @("theory_of_mind", "zebra_puzzle", "spatial", "logic_with_navigation") }

    $instructionFollowingColumns = Get-LiveBenchCategoryColumns -CategoryMap $categoryMap -PreferredNames @("IF", "Instruction Following")
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
        } catch {
            return [pscustomobject]@{
                status = "unavailable"
                message = "LiveBench cost CSV parse failed: $($_.Exception.Message)"
                models = @{}
                sourceDate = $SourceDate
            }
        }
    }

    $models = @{}
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
        }
    }

    if ($models.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "LiveBench parsed but yielded no models."
            models = @{}
            sourceDate = $SourceDate
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
        sourceDate = $SourceDate
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
    if ($costFile.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "LiveBench listing had no matching $costName file."
            models = @{}
            sourceDate = $tableDate -replace '_', '-'
            fetchedAtUtc = $fetchedAtUtc
            sourceUrl = [string]$latestTable.html_url
        }
    }

    $tableFetch = & $FetchText $latestTable.download_url
    if ($tableFetch.status -ne "ok") {
        return [pscustomobject]@{
            status = "error"
            message = "LiveBench table fetch failed: $($tableFetch.error)"
            models = @{}
            sourceDate = $tableDate -replace '_', '-'
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
                sourceDate = $tableDate -replace '_', '-'
                fetchedAtUtc = $fetchedAtUtc
                sourceUrl = [string]$latestTable.html_url
            }
        }
        $categoriesText = [string]$categoryFetch.content
    }

    $costText = ""
    $costFetch = & $FetchText $costFile[0].download_url
    if ($costFetch.status -ne "ok") {
        return [pscustomobject]@{
            status = "unavailable"
            message = "LiveBench cost fetch failed: $($costFetch.error)"
            models = @{}
            sourceDate = $tableDate -replace '_', '-'
            fetchedAtUtc = $fetchedAtUtc
            sourceUrl = [string]$latestTable.html_url
        }
    }
    $costText = [string]$costFetch.content

    $parsed = Parse-LiveBenchData -CsvText ([string]$tableFetch.content) -CategoriesJsonText $categoriesText -CostCsvText $costText -SourceDate ($tableDate -replace '_', '-')
    return [pscustomobject]@{
        status = $parsed.status
        message = $parsed.message
        costStatus = if (Test-ObjectMember -InputObject $parsed -Name "costStatus") { $parsed.costStatus } else { "unavailable" }
        costMessage = if (Test-ObjectMember -InputObject $parsed -Name "costMessage") { $parsed.costMessage } else { $parsed.message }
        models = $parsed.models
        sourceDate = $parsed.sourceDate
        sourceVersion = if ($parsed.status -eq "ok") { $parsed.sourceDate } else { $null }
        fetchedAtUtc = $fetchedAtUtc
        sourceUrl = [string]$latestTable.html_url
    }
}

function Get-ModelRankingAliases {
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory = $true)][string]$AliasesPath
    )

    if (-not (Test-Path $AliasesPath)) {
        throw "Missing model ranking aliases file: $AliasesPath"
    }

    $parsed = ConvertFrom-JsonAsHashtableCompat -JsonText (Get-Content -Path $AliasesPath -Raw)
    if (-not $parsed.ContainsKey("aliases") -or -not ($parsed.aliases -is [hashtable])) {
        throw "Aliases file schema invalid: expected top-level 'aliases' object."
    }
    return $parsed.aliases
}

function Get-RankingBucketAssignments {
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory = $true)][hashtable]$ScoresByModel,
        [switch]$LowerIsBetter
    )

    $buckets = @{}
    $scored = @(
        $ScoresByModel.GetEnumerator() |
        Where-Object { $null -ne $_.Value } |
        Sort-Object -Property @{ Expression = { [double]$_.Value }; Descending = (-not $LowerIsBetter.IsPresent) }, @{ Expression = { $_.Key }; Descending = $false }
    )

    if ($scored.Count -lt 3) {
        foreach ($entry in $scored) { $buckets[$entry.Key] = "competitive" }
    } else {
        $n = $scored.Count
        $topCut = [Math]::Ceiling($n / 3.0)
        $lagCut = $n - $topCut
        for ($i = 0; $i -lt $n; $i++) {
            $position = $i + 1
            $bucket = if ($position -le $topCut) { "top" } elseif ($position -gt $lagCut) { "lagging" } else { "competitive" }
            $buckets[$scored[$i].Key] = $bucket
        }

    }

    foreach ($model in $ScoresByModel.Keys) {
        if (-not $buckets.ContainsKey($model)) {
            $buckets[$model] = "n/a"
        }
    }

    return $buckets
}

function Get-OrdinalRankAssignments {
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory = $true)][hashtable]$ScoresByModel,
        [switch]$LowerIsBetter
    )

    $ranks = @{}
    $scored = @(
        $ScoresByModel.GetEnumerator() |
        Where-Object { $null -ne $_.Value } |
        Sort-Object -Property @{ Expression = { [double]$_.Value }; Descending = (-not $LowerIsBetter.IsPresent) }, @{ Expression = { $_.Key }; Descending = $false }
    )

    for ($i = 0; $i -lt $scored.Count; $i++) {
        $ranks[$scored[$i].Key] = $i + 1
    }
    foreach ($model in $ScoresByModel.Keys) {
        if (-not $ranks.ContainsKey($model)) {
            $ranks[$model] = $null
        }
    }
    return $ranks
}

function New-UnavailableModelRankingSnapshot {
    param(
        [string]$Message = "Ranking data unavailable."
    )

    return [ordered]@{
        schemaVersion = $script:ModelRankingSchemaVersion
        generatedAtUtc = $null
        staleAfterDays = $script:ModelRankingStaleAfterDays
        status = "unavailable"
        stale = $false
        fallbackUsed = $false
        message = $Message
        attribution = [ordered]@{
            artificialAnalysisUrl = $script:ArtificialAnalysisUrl
            artificialAnalysisCodingAgentsUrl = $script:ArtificialAnalysisCodingAgentsUrl
            liveBenchUrl = $script:LiveBenchRepoUrl
        }
        sourceStatus = [ordered]@{
            artificialAnalysis = [ordered]@{
                status = "unavailable"
                message = "Not fetched."
                sourceDate = $null
                sourceVersion = $null
                fetchedAtUtc = $null
                sourceUrl = $script:ArtificialAnalysisUrl
            }
            artificialAnalysisCodingAgents = [ordered]@{
                status = "unavailable"
                message = "Not fetched."
                sourceDate = $null
                sourceVersion = $null
                fetchedAtUtc = $null
                sourceUrl = $script:ArtificialAnalysisCodingAgentsUrl
            }
            liveBench = [ordered]@{
                status = "unavailable"
                message = "Not fetched."
                sourceDate = $null
                sourceVersion = $null
                fetchedAtUtc = $null
                sourceUrl = $script:LiveBenchRepoUrl
            }
            liveBenchCost = [ordered]@{
                status = "unavailable"
                message = "Not fetched."
                sourceDate = $null
                sourceVersion = $null
                fetchedAtUtc = $null
                sourceUrl = $script:LiveBenchRepoUrl
            }
        }
        models = [ordered]@{}
        consensus = [ordered]@{
            profiles = [ordered]@{}
        }
    }
}

function Test-ModelRankingSnapshotStale {
    param(
        [Parameter(Mandatory = $true)]$Snapshot,
        [datetime]$NowUtc = ((Get-Date).ToUniversalTime())
    )

    if ($null -eq $Snapshot.generatedAtUtc -or [string]::IsNullOrWhiteSpace([string]$Snapshot.generatedAtUtc)) {
        return $false
    }

    $generated = $null
    try {
        $generated = [datetime]::Parse([string]$Snapshot.generatedAtUtc, [System.Globalization.CultureInfo]::InvariantCulture)
    } catch {
        return $false
    }

    $ageDays = ($NowUtc - $generated.ToUniversalTime()).TotalDays
    $threshold = if ($Snapshot.PSObject.Properties.Name.Contains("staleAfterDays") -and $Snapshot.staleAfterDays) { [int]$Snapshot.staleAfterDays } else { $script:ModelRankingStaleAfterDays }
    return $ageDays -gt $threshold
}

function Test-ModelRankingSnapshotUsable {
    param(
        $Snapshot
    )

    if ($null -eq $Snapshot -or [string]::IsNullOrWhiteSpace([string]$Snapshot.generatedAtUtc)) {
        return $false
    }

    if ($null -eq $Snapshot.models) {
        return $false
    }

    if ($Snapshot.models -is [System.Collections.IDictionary]) {
        return $Snapshot.models.Count -gt 0
    }

    return @($Snapshot.models.PSObject.Properties).Count -gt 0
}

function Resolve-ModelRankingSnapshot {
    [OutputType([pscustomobject])]
    param(
        [Parameter(Mandatory = $true)][string[]]$ValidModels,
        [Parameter(Mandatory = $true)][hashtable]$Aliases,
        [Parameter(Mandatory = $true)]$ArtificialAnalysisData,
        [Parameter(Mandatory = $true)]$ArtificialAnalysisCodingAgentData,
        [Parameter(Mandatory = $true)]$LiveBenchData,
        $FallbackSnapshot = $null,
        [datetime]$NowUtc = ((Get-Date).ToUniversalTime())
    )

    $snapshot = New-UnavailableModelRankingSnapshot
    $snapshot.generatedAtUtc = $NowUtc.ToString("o")
    $snapshot.sourceStatus.artificialAnalysis = [ordered]@{
        status = $ArtificialAnalysisData.status
        message = $ArtificialAnalysisData.message
        sourceDate = $ArtificialAnalysisData.sourceDate
        sourceVersion = Get-ObjectMemberValue -InputObject $ArtificialAnalysisData -Name "sourceVersion"
        fetchedAtUtc = $ArtificialAnalysisData.fetchedAtUtc
        sourceUrl = $ArtificialAnalysisData.sourceUrl
    }
    $snapshot.sourceStatus.artificialAnalysisCodingAgents = [ordered]@{
        status = $ArtificialAnalysisCodingAgentData.status
        message = $ArtificialAnalysisCodingAgentData.message
        sourceDate = $ArtificialAnalysisCodingAgentData.sourceDate
        sourceVersion = Get-ObjectMemberValue -InputObject $ArtificialAnalysisCodingAgentData -Name "sourceVersion"
        fetchedAtUtc = $ArtificialAnalysisCodingAgentData.fetchedAtUtc
        sourceUrl = $ArtificialAnalysisCodingAgentData.sourceUrl
    }
    $snapshot.sourceStatus.liveBench = [ordered]@{
        status = $LiveBenchData.status
        message = $LiveBenchData.message
        sourceDate = $LiveBenchData.sourceDate
        sourceVersion = Get-ObjectMemberValue -InputObject $LiveBenchData -Name "sourceVersion"
        fetchedAtUtc = $LiveBenchData.fetchedAtUtc
        sourceUrl = $LiveBenchData.sourceUrl
    }
    $snapshot.sourceStatus.liveBenchCost = [ordered]@{
        status = if (Test-ObjectMember -InputObject $LiveBenchData -Name "costStatus") { $LiveBenchData.costStatus } else { "unavailable" }
        message = if (Test-ObjectMember -InputObject $LiveBenchData -Name "costMessage") { $LiveBenchData.costMessage } else { $LiveBenchData.message }
        sourceDate = $LiveBenchData.sourceDate
        sourceVersion = Get-ObjectMemberValue -InputObject $LiveBenchData -Name "sourceVersion"
        fetchedAtUtc = $LiveBenchData.fetchedAtUtc
        sourceUrl = $LiveBenchData.sourceUrl
    }

    $aaScores = @{}
    $aaCodingAgentScores = @{}
    $lbCodingScores = @{}
    $lbAgenticCodingScores = @{}
    $lbReasoningScores = @{}
    $lbInstructionScores = @{}
    $lbCostScores = @{}

    foreach ($model in $ValidModels) {
        $alias = if ($Aliases.ContainsKey($model)) { $Aliases[$model] } else { $null }
        $aaSlug = $null
        $aaCodingSlug = $null
        $lbName = $null
        if ($null -ne $alias) {
            if ($alias -is [hashtable]) {
                $aaSlug = $alias.artificialAnalysis
                $aaCodingSlug = if ($alias.ContainsKey("artificialAnalysisCodingAgents")) { $alias.artificialAnalysisCodingAgents } else { $null }
                $lbName = $alias.liveBench
            } elseif ($alias.PSObject -and $alias.PSObject.Properties) {
                $aaSlug = $alias.artificialAnalysis
                $aaCodingSlug = $alias.artificialAnalysisCodingAgents
                $lbName = $alias.liveBench
            }
        }

        $aaScore = $null
        $aaName = $null
        if (-not [string]::IsNullOrWhiteSpace([string]$aaSlug) -and $ArtificialAnalysisData.models.ContainsKey([string]$aaSlug)) {
            $aaScore = [double]$ArtificialAnalysisData.models[[string]$aaSlug].agenticIndex
            $aaName = [string]$ArtificialAnalysisData.models[[string]$aaSlug].name
        }
        $aaScores[$model] = $aaScore

        $aaCodingScore = $null
        $aaCodingName = $null
        if (-not [string]::IsNullOrWhiteSpace([string]$aaCodingSlug) -and $ArtificialAnalysisCodingAgentData.models.ContainsKey([string]$aaCodingSlug)) {
            $aaCodingScore = [double]$ArtificialAnalysisCodingAgentData.models[[string]$aaCodingSlug].codingAgentIndex
            $aaCodingName = [string]$ArtificialAnalysisCodingAgentData.models[[string]$aaCodingSlug].name
        }
        $aaCodingAgentScores[$model] = $aaCodingScore

        $lbCoding = $null
        $lbAgenticCoding = $null
        $lbReasoning = $null
        $lbInstruction = $null
        $lbCost = $null
        if (-not [string]::IsNullOrWhiteSpace([string]$lbName) -and $LiveBenchData.models.ContainsKey([string]$lbName)) {
            $lbRecord = $LiveBenchData.models[[string]$lbName]
            $lbCoding = $lbRecord.coding
            $lbAgenticCoding = $lbRecord.agenticCoding
            $lbReasoning = $lbRecord.reasoning
            $lbInstruction = $lbRecord.instructionFollowing
            $lbCost = $lbRecord.costPerSuccessfulTask
        }
        $lbCodingScores[$model] = $lbCoding
        $lbAgenticCodingScores[$model] = $lbAgenticCoding
        $lbReasoningScores[$model] = $lbReasoning
        $lbInstructionScores[$model] = $lbInstruction
        $lbCostScores[$model] = $lbCost

        $snapshot.models[$model] = [ordered]@{
            artificialAnalysis = [ordered]@{
                alias = $aaSlug
                name = $aaName
                agenticIndex = $aaScore
                bucket = "n/a"
                ordinalRank = $null
            }
            artificialAnalysisCodingAgents = [ordered]@{
                alias = $aaCodingSlug
                name = $aaCodingName
                codingAgentIndex = $aaCodingScore
                bucket = "n/a"
                ordinalRank = $null
            }
            liveBench = [ordered]@{
                alias = $lbName
                categories = [ordered]@{
                    coding = $lbCoding
                    agenticCoding = $lbAgenticCoding
                    reasoning = $lbReasoning
                    instructionFollowing = $lbInstruction
                }
                buckets = [ordered]@{
                    coding = "n/a"
                    agenticCoding = "n/a"
                    reasoning = "n/a"
                    instructionFollowing = "n/a"
                }
                ordinalRanks = [ordered]@{
                    coding = $null
                    agenticCoding = $null
                    reasoning = $null
                    instructionFollowing = $null
                }
                costPerSuccessfulTask = $lbCost
                costBucket = "n/a"
                costOrdinalRank = $null
            }
        }
    }

    $aaBuckets = Get-RankingBucketAssignments -ScoresByModel $aaScores
    $aaRanks = Get-OrdinalRankAssignments -ScoresByModel $aaScores
    $aaCodingBuckets = Get-RankingBucketAssignments -ScoresByModel $aaCodingAgentScores
    $aaCodingRanks = Get-OrdinalRankAssignments -ScoresByModel $aaCodingAgentScores
    $lbCodingBuckets = Get-RankingBucketAssignments -ScoresByModel $lbCodingScores
    $lbCodingRanks = Get-OrdinalRankAssignments -ScoresByModel $lbCodingScores
    $lbAgenticCodingBuckets = Get-RankingBucketAssignments -ScoresByModel $lbAgenticCodingScores
    $lbAgenticCodingRanks = Get-OrdinalRankAssignments -ScoresByModel $lbAgenticCodingScores
    $lbReasoningBuckets = Get-RankingBucketAssignments -ScoresByModel $lbReasoningScores
    $lbReasoningRanks = Get-OrdinalRankAssignments -ScoresByModel $lbReasoningScores
    $lbInstructionBuckets = Get-RankingBucketAssignments -ScoresByModel $lbInstructionScores
    $lbInstructionRanks = Get-OrdinalRankAssignments -ScoresByModel $lbInstructionScores
    $lbCostBuckets = Get-RankingBucketAssignments -ScoresByModel $lbCostScores -LowerIsBetter
    $lbCostRanks = Get-OrdinalRankAssignments -ScoresByModel $lbCostScores -LowerIsBetter

    $hasAnyBucketedData = $false
    foreach ($model in $ValidModels) {
        $snapshot.models[$model].artificialAnalysis.bucket = $aaBuckets[$model]
        $snapshot.models[$model].artificialAnalysis.ordinalRank = $aaRanks[$model]
        $snapshot.models[$model].artificialAnalysisCodingAgents.bucket = $aaCodingBuckets[$model]
        $snapshot.models[$model].artificialAnalysisCodingAgents.ordinalRank = $aaCodingRanks[$model]
        $snapshot.models[$model].liveBench.buckets.coding = $lbCodingBuckets[$model]
        $snapshot.models[$model].liveBench.ordinalRanks.coding = $lbCodingRanks[$model]
        $snapshot.models[$model].liveBench.buckets.agenticCoding = $lbAgenticCodingBuckets[$model]
        $snapshot.models[$model].liveBench.ordinalRanks.agenticCoding = $lbAgenticCodingRanks[$model]
        $snapshot.models[$model].liveBench.buckets.reasoning = $lbReasoningBuckets[$model]
        $snapshot.models[$model].liveBench.ordinalRanks.reasoning = $lbReasoningRanks[$model]
        $snapshot.models[$model].liveBench.buckets.instructionFollowing = $lbInstructionBuckets[$model]
        $snapshot.models[$model].liveBench.ordinalRanks.instructionFollowing = $lbInstructionRanks[$model]
        $snapshot.models[$model].liveBench.costBucket = $lbCostBuckets[$model]
        $snapshot.models[$model].liveBench.costOrdinalRank = $lbCostRanks[$model]

        if (
            $aaBuckets[$model] -ne "n/a" -or
            $aaCodingBuckets[$model] -ne "n/a" -or
            $lbCodingBuckets[$model] -ne "n/a" -or
            $lbAgenticCodingBuckets[$model] -ne "n/a" -or
            $lbReasoningBuckets[$model] -ne "n/a" -or
            $lbInstructionBuckets[$model] -ne "n/a" -or
            $lbCostBuckets[$model] -ne "n/a"
        ) {
            $hasAnyBucketedData = $true
        }
    }

    if ($FallbackSnapshot -and $FallbackSnapshot.PSObject.Properties.Name.Contains("consensus") -and $null -ne $FallbackSnapshot.consensus) {
        $snapshot.consensus = $FallbackSnapshot.consensus
    }

    if ($hasAnyBucketedData) {
        $allSourcesValid = (
            $ArtificialAnalysisData.status -eq "ok" -and
            $ArtificialAnalysisCodingAgentData.status -eq "ok" -and
            $LiveBenchData.status -eq "ok" -and
            (Get-ObjectMemberValue -InputObject $LiveBenchData -Name "costStatus") -eq "ok"
        )
        $snapshot.status = if ($allSourcesValid) { "ok" } else { "partial" }
        $snapshot.message = if ($allSourcesValid) {
            "Ranking buckets generated from live source data."
        } else {
            "Ranking buckets generated from partial live data. The committed last-good snapshot was not replaced."
        }
        $snapshot.stale = $false
        return [pscustomobject]@{
            snapshot = $snapshot
            shouldWriteSnapshot = $allSourcesValid
        }
    }

    if (Test-ModelRankingSnapshotUsable -Snapshot $FallbackSnapshot) {
        $fallbackObj = $FallbackSnapshot
        $isStale = Test-ModelRankingSnapshotStale -Snapshot $fallbackObj -NowUtc $NowUtc
        $fallbackObj.fallbackUsed = $true
        $fallbackObj.status = "fallback"
        $fallbackObj.stale = $isStale
        $fallbackObj.message = "Live ranking data unavailable; using committed snapshot fallback."
        return [pscustomobject]@{
            snapshot = $fallbackObj
            shouldWriteSnapshot = $false
        }
    }

    $snapshot.status = "unavailable"
    $snapshot.stale = $false
    $snapshot.fallbackUsed = $false
    $snapshot.message = "Live ranking data unavailable and no fallback snapshot could be used."
    return [pscustomobject]@{
        snapshot = $snapshot
        shouldWriteSnapshot = $false
    }
}

function Read-ModelRankingSnapshotFile {
    [OutputType([object])]
    param(
        [Parameter(Mandatory = $true)][string]$SnapshotPath
    )

    if (-not (Test-Path $SnapshotPath)) {
        return $null
    }

    try {
        return ConvertFrom-Json -InputObject (Get-Content -Path $SnapshotPath -Raw)
    } catch {
        return $null
    }
}

function Write-ModelRankingSnapshotAtomic {
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
    Set-Content -Path $tempPath -Value $json -Encoding UTF8
    Move-Item -Path $tempPath -Destination $SnapshotPath -Force
}

function Get-AdvisoryModelRankingSnapshot {
    [OutputType([object])]
    param(
        [Parameter(Mandatory = $true)][string]$RepoRoot,
        [Parameter(Mandatory = $true)][string[]]$ValidModels,
        [string]$AliasesPath = "",
        [string]$SnapshotPath = "",
        [scriptblock]$FetchArtificialAnalysisText = $null,
        [scriptblock]$FetchLiveBenchJson = $null,
        [scriptblock]$FetchLiveBenchText = $null
    )

    if ([string]::IsNullOrWhiteSpace($AliasesPath)) {
        $AliasesPath = Join-Path $RepoRoot "config/model-ranking-aliases.json"
    }
    if ([string]::IsNullOrWhiteSpace($SnapshotPath)) {
        $SnapshotPath = Join-Path $RepoRoot "data/model-ranking-snapshot.json"
    }

    $aliases = Get-ModelRankingAliases -AliasesPath $AliasesPath
    $fallbackSnapshot = Read-ModelRankingSnapshotFile -SnapshotPath $SnapshotPath

    $aaData = Get-ArtificialAnalysisAgenticIndexData -FetchText $FetchArtificialAnalysisText
    $aaCodingAgentData = Get-ArtificialAnalysisCodingAgentIndexData -FetchText $FetchArtificialAnalysisText
    $lbData = Get-LiveBenchData -FetchJson $FetchLiveBenchJson -FetchText $FetchLiveBenchText

    $resolved = Resolve-ModelRankingSnapshot -ValidModels $ValidModels -Aliases $aliases -ArtificialAnalysisData $aaData -ArtificialAnalysisCodingAgentData $aaCodingAgentData -LiveBenchData $lbData -FallbackSnapshot $fallbackSnapshot
    if ($resolved.shouldWriteSnapshot) {
        Write-ModelRankingSnapshotAtomic -SnapshotPath $SnapshotPath -SnapshotObject $resolved.snapshot
    }

    return $resolved.snapshot
}

function Get-ModelRankingReportLines {
    [OutputType([string[]])]
    param(
        [Parameter(Mandatory = $true)]$Snapshot,
        [Parameter(Mandatory = $true)][string[]]$ValidModels
    )

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("## External model ranking snapshot")
    $lines.Add("")
    $lines.Add("- Status: **$($Snapshot.status)**")
    $staleText = ([string]$Snapshot.stale).ToLowerInvariant()
    $fallbackText = ([string]$Snapshot.fallbackUsed).ToLowerInvariant()
    $lines.Add("- Stale: **$staleText**")
    $lines.Add("- Fallback used: **$fallbackText**")
    if (-not [string]::IsNullOrWhiteSpace([string]$Snapshot.message)) {
        $lines.Add("- Note: $($Snapshot.message)")
    }
    $aaUrlValue = Get-ObjectMemberValue -InputObject $Snapshot.attribution -Name "artificialAnalysisUrl"
    $aaUrl = if ($aaUrlValue) { $aaUrlValue } else { $script:ArtificialAnalysisUrl }
    $aaCodingUrl = if (Test-ObjectMember -InputObject $Snapshot.attribution -Name "artificialAnalysisCodingAgentsUrl") { Get-ObjectMemberValue -InputObject $Snapshot.attribution -Name "artificialAnalysisCodingAgentsUrl" } else { $script:ArtificialAnalysisCodingAgentsUrl }
    $lbUrlValue = Get-ObjectMemberValue -InputObject $Snapshot.attribution -Name "liveBenchUrl"
    $lbUrl = if ($lbUrlValue) { $lbUrlValue } else { $script:LiveBenchRepoUrl }
    $aaSource = Get-ObjectMemberValue -InputObject $Snapshot.sourceStatus -Name "artificialAnalysis"
    $aaDate = if ($aaSource) { Get-ObjectMemberValue -InputObject $aaSource -Name "sourceDate" } else { $null }
    $aaCodingSource = Get-ObjectMemberValue -InputObject $Snapshot.sourceStatus -Name "artificialAnalysisCodingAgents"
    $aaCodingDate = if ($aaCodingSource) { $aaCodingSource.sourceDate } else { $null }
    $lbSource = Get-ObjectMemberValue -InputObject $Snapshot.sourceStatus -Name "liveBench"
    $lbDate = if ($lbSource) { Get-ObjectMemberValue -InputObject $lbSource -Name "sourceDate" } else { $null }
    $aaFetched = if ($aaSource) { Get-ObjectMemberValue -InputObject $aaSource -Name "fetchedAtUtc" } else { $null }
    $aaCodingFetched = if ($aaCodingSource) { $aaCodingSource.fetchedAtUtc } else { $null }
    $lbFetched = if ($lbSource) { Get-ObjectMemberValue -InputObject $lbSource -Name "fetchedAtUtc" } else { $null }
    $lines.Add("- Artificial Analysis URL: $aaUrl")
    $lines.Add("- Artificial Analysis Coding Agents URL: $aaCodingUrl")
    $lines.Add("- LiveBench URL: $lbUrl")
    $lines.Add("- Artificial Analysis source date: $aaDate")
    $lines.Add("- Artificial Analysis Coding Agent source date: $(if ($aaCodingDate) { $aaCodingDate } else { 'n/a' })")
    $lines.Add("- LiveBench source date: $lbDate")
    $lines.Add("- Artificial Analysis fetched at (UTC): $aaFetched")
    $lines.Add("- Artificial Analysis Coding Agents fetched at (UTC): $(if ($aaCodingFetched) { $aaCodingFetched } else { 'n/a' })")
    $lines.Add("- LiveBench fetched at (UTC): $lbFetched")
    $lines.Add("")
    $lines.Add("> External rankings can auto-apply only after strict two-run consensus; task-family eligibility remains authoritative.")
    $lines.Add("")
    $lines.Add("| Model | AA Agentic | AA Coding Agent | LB Coding | LB Agentic Coding | LB Reasoning | LB Instruction Following | LB Cost | LB Cost Bucket |")
    $lines.Add("|---|---|---|---|---|---|---|---|---|")
    foreach ($model in $ValidModels) {
        $modelData = $null
        if ($Snapshot.models -is [System.Collections.IDictionary]) {
            if ($Snapshot.models.Contains($model)) {
                $modelData = $Snapshot.models[$model]
            }
        } elseif ($Snapshot.models.PSObject.Properties.Name -contains $model) {
            $modelData = $Snapshot.models.PSObject.Properties[$model].Value
        }
        if ($null -eq $modelData) {
            $lines.Add("| $model | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |")
            continue
        }
        $aaBucket = if ($modelData.artificialAnalysis -and $modelData.artificialAnalysis.bucket) { [string]$modelData.artificialAnalysis.bucket } else { "n/a" }
        $aaCodingData = Get-ObjectMemberValue -InputObject $modelData -Name "artificialAnalysisCodingAgents"
        $aaCodingBucket = if ($aaCodingData -and $aaCodingData.bucket) { [string]$aaCodingData.bucket } else { "n/a" }
        $lbCodingBucket = if ($modelData.liveBench -and $modelData.liveBench.buckets -and $modelData.liveBench.buckets.coding) { [string]$modelData.liveBench.buckets.coding } else { "n/a" }
        $lbAgenticBucket = if ($modelData.liveBench -and $modelData.liveBench.buckets -and $modelData.liveBench.buckets.agenticCoding) { [string]$modelData.liveBench.buckets.agenticCoding } else { "n/a" }
        $lbReasoningBucket = if ($modelData.liveBench -and $modelData.liveBench.buckets -and $modelData.liveBench.buckets.reasoning) { [string]$modelData.liveBench.buckets.reasoning } else { "n/a" }
        $lbInstructionBucket = if ($modelData.liveBench -and $modelData.liveBench.buckets -and $modelData.liveBench.buckets.instructionFollowing) { [string]$modelData.liveBench.buckets.instructionFollowing } else { "n/a" }
        $hasCostValue = $false
        if ($modelData.liveBench -and (Test-ObjectMember -InputObject $modelData.liveBench -Name "costPerSuccessfulTask") -and $null -ne $modelData.liveBench.costPerSuccessfulTask) { $hasCostValue = $true }
        $lbCost = if ($hasCostValue) { [string]([double]$modelData.liveBench.costPerSuccessfulTask) } else { "n/a" }
        $lbCostBucket = if ($modelData.liveBench -and (Test-ObjectMember -InputObject $modelData.liveBench -Name "costBucket") -and $modelData.liveBench.costBucket) { [string]$modelData.liveBench.costBucket } else { "n/a" }
        $lines.Add("| $model | $aaBucket | $aaCodingBucket | $lbCodingBucket | $lbAgenticBucket | $lbReasoningBucket | $lbInstructionBucket | $lbCost | $lbCostBucket |")
    }
    $lines.Add("")

    return @($lines)
}
