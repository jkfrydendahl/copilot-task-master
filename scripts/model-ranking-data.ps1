Set-StrictMode -Version Latest

$script:ModelRankingSchemaVersion = 1
$script:ModelRankingStaleAfterDays = 45
$script:ArtificialAnalysisUrl = "https://artificialanalysis.ai/?intelligence=agentic-index"
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
            $categoryObj = ConvertFrom-Json -InputObject $CategoriesJsonText -AsHashtable
            if ($categoryObj -is [hashtable]) {
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

    return [pscustomobject]@{
        status = "ok"
        message = "Parsed LiveBench table and categories."
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
    $categoriesFile = @($items | Where-Object { $_.name -eq $categoriesName } | Select-Object -First 1)

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

    $parsed = Parse-LiveBenchData -CsvText ([string]$tableFetch.content) -CategoriesJsonText $categoriesText -SourceDate ($tableDate -replace '_', '-')
    return [pscustomobject]@{
        status = $parsed.status
        message = $parsed.message
        models = $parsed.models
        sourceDate = $parsed.sourceDate
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

    $parsed = ConvertFrom-Json -InputObject (Get-Content -Path $AliasesPath -Raw) -AsHashtable
    if (-not $parsed.ContainsKey("aliases") -or -not ($parsed.aliases -is [hashtable])) {
        throw "Aliases file schema invalid: expected top-level 'aliases' object."
    }
    return $parsed.aliases
}

function Get-RankingBucketAssignments {
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory = $true)][hashtable]$ScoresByModel
    )

    $buckets = @{}
    $scored = @(
        $ScoresByModel.GetEnumerator() |
        Where-Object { $null -ne $_.Value } |
        Sort-Object -Property @{ Expression = { [double]$_.Value }; Descending = $true }, @{ Expression = { $_.Key }; Descending = $false }
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
            liveBenchUrl = $script:LiveBenchRepoUrl
        }
        sourceStatus = [ordered]@{
            artificialAnalysis = [ordered]@{
                status = "unavailable"
                message = "Not fetched."
                sourceDate = $null
                fetchedAtUtc = $null
                sourceUrl = $script:ArtificialAnalysisUrl
            }
            liveBench = [ordered]@{
                status = "unavailable"
                message = "Not fetched."
                sourceDate = $null
                fetchedAtUtc = $null
                sourceUrl = $script:LiveBenchRepoUrl
            }
        }
        models = [ordered]@{}
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
        fetchedAtUtc = $ArtificialAnalysisData.fetchedAtUtc
        sourceUrl = $ArtificialAnalysisData.sourceUrl
    }
    $snapshot.sourceStatus.liveBench = [ordered]@{
        status = $LiveBenchData.status
        message = $LiveBenchData.message
        sourceDate = $LiveBenchData.sourceDate
        fetchedAtUtc = $LiveBenchData.fetchedAtUtc
        sourceUrl = $LiveBenchData.sourceUrl
    }

    $aaScores = @{}
    $lbCodingScores = @{}
    $lbAgenticCodingScores = @{}
    $lbReasoningScores = @{}
    $lbInstructionScores = @{}

    foreach ($model in $ValidModels) {
        $alias = if ($Aliases.ContainsKey($model)) { $Aliases[$model] } else { $null }
        $aaSlug = $null
        $lbName = $null
        if ($null -ne $alias) {
            if ($alias -is [hashtable]) {
                $aaSlug = $alias.artificialAnalysis
                $lbName = $alias.liveBench
            } elseif ($alias.PSObject -and $alias.PSObject.Properties) {
                $aaSlug = $alias.artificialAnalysis
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

        $lbCoding = $null
        $lbAgenticCoding = $null
        $lbReasoning = $null
        $lbInstruction = $null
        if (-not [string]::IsNullOrWhiteSpace([string]$lbName) -and $LiveBenchData.models.ContainsKey([string]$lbName)) {
            $lbRecord = $LiveBenchData.models[[string]$lbName]
            $lbCoding = $lbRecord.coding
            $lbAgenticCoding = $lbRecord.agenticCoding
            $lbReasoning = $lbRecord.reasoning
            $lbInstruction = $lbRecord.instructionFollowing
        }
        $lbCodingScores[$model] = $lbCoding
        $lbAgenticCodingScores[$model] = $lbAgenticCoding
        $lbReasoningScores[$model] = $lbReasoning
        $lbInstructionScores[$model] = $lbInstruction

        $snapshot.models[$model] = [ordered]@{
            artificialAnalysis = [ordered]@{
                alias = $aaSlug
                name = $aaName
                agenticIndex = $aaScore
                bucket = "n/a"
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
            }
        }
    }

    $aaBuckets = Get-RankingBucketAssignments -ScoresByModel $aaScores
    $lbCodingBuckets = Get-RankingBucketAssignments -ScoresByModel $lbCodingScores
    $lbAgenticCodingBuckets = Get-RankingBucketAssignments -ScoresByModel $lbAgenticCodingScores
    $lbReasoningBuckets = Get-RankingBucketAssignments -ScoresByModel $lbReasoningScores
    $lbInstructionBuckets = Get-RankingBucketAssignments -ScoresByModel $lbInstructionScores

    $hasAnyBucketedData = $false
    foreach ($model in $ValidModels) {
        $snapshot.models[$model].artificialAnalysis.bucket = $aaBuckets[$model]
        $snapshot.models[$model].liveBench.buckets.coding = $lbCodingBuckets[$model]
        $snapshot.models[$model].liveBench.buckets.agenticCoding = $lbAgenticCodingBuckets[$model]
        $snapshot.models[$model].liveBench.buckets.reasoning = $lbReasoningBuckets[$model]
        $snapshot.models[$model].liveBench.buckets.instructionFollowing = $lbInstructionBuckets[$model]

        if (
            $aaBuckets[$model] -ne "n/a" -or
            $lbCodingBuckets[$model] -ne "n/a" -or
            $lbAgenticCodingBuckets[$model] -ne "n/a" -or
            $lbReasoningBuckets[$model] -ne "n/a" -or
            $lbInstructionBuckets[$model] -ne "n/a"
        ) {
            $hasAnyBucketedData = $true
        }
    }

    if ($hasAnyBucketedData) {
        $allSourcesValid = (
            $ArtificialAnalysisData.status -eq "ok" -and
            $LiveBenchData.status -eq "ok"
        )
        $snapshot.status = if ($allSourcesValid) { "ok" } else { "partial" }
        $snapshot.message = if ($allSourcesValid) {
            "Advisory ranking buckets generated from live source data. Rankings are advisory-only and never auto-applied."
        } else {
            "Advisory ranking buckets generated from partial live data. The committed last-good snapshot was not replaced."
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
        $fallbackObj.message = "Live ranking data unavailable; using committed snapshot fallback. Rankings are advisory-only and never auto-applied."
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
    $lbData = Get-LiveBenchData -FetchJson $FetchLiveBenchJson -FetchText $FetchLiveBenchText

    $resolved = Resolve-ModelRankingSnapshot -ValidModels $ValidModels -Aliases $aliases -ArtificialAnalysisData $aaData -LiveBenchData $lbData -FallbackSnapshot $fallbackSnapshot
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
    $lines.Add("## Advisory model ranking snapshot")
    $lines.Add("")
    $lines.Add("- Status: **$($Snapshot.status)**")
    $staleText = ([string]$Snapshot.stale).ToLowerInvariant()
    $fallbackText = ([string]$Snapshot.fallbackUsed).ToLowerInvariant()
    $lines.Add("- Stale: **$staleText**")
    $lines.Add("- Fallback used: **$fallbackText**")
    if (-not [string]::IsNullOrWhiteSpace([string]$Snapshot.message)) {
        $lines.Add("- Note: $($Snapshot.message)")
    }
    $lines.Add("- Artificial Analysis URL: $($Snapshot.attribution.artificialAnalysisUrl)")
    $lines.Add("- LiveBench URL: $($Snapshot.attribution.liveBenchUrl)")
    $lines.Add("- Artificial Analysis source date: $($Snapshot.sourceStatus.artificialAnalysis.sourceDate)")
    $lines.Add("- LiveBench source date: $($Snapshot.sourceStatus.liveBench.sourceDate)")
    $lines.Add("- Artificial Analysis fetched at (UTC): $($Snapshot.sourceStatus.artificialAnalysis.fetchedAtUtc)")
    $lines.Add("- LiveBench fetched at (UTC): $($Snapshot.sourceStatus.liveBench.fetchedAtUtc)")
    $lines.Add("")
    $lines.Add("> Advisory only: external rankings never auto-apply and never influence profile-selection policy.")
    $lines.Add("")
    $lines.Add("| Model | AA Agentic | LB Coding | LB Agentic Coding | LB Reasoning | LB Instruction Following |")
    $lines.Add("|---|---|---|---|---|---|")
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
            $lines.Add("| $model | n/a | n/a | n/a | n/a | n/a |")
            continue
        }
        $aaBucket = [string]$modelData.artificialAnalysis.bucket
        $lbCodingBucket = [string]$modelData.liveBench.buckets.coding
        $lbAgenticBucket = [string]$modelData.liveBench.buckets.agenticCoding
        $lbReasoningBucket = [string]$modelData.liveBench.buckets.reasoning
        $lbInstructionBucket = [string]$modelData.liveBench.buckets.instructionFollowing
        $lines.Add("| $model | $aaBucket | $lbCodingBucket | $lbAgenticBucket | $lbReasoningBucket | $lbInstructionBucket |")
    }
    $lines.Add("")

    return @($lines)
}
