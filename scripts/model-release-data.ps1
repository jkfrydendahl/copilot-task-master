Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

function Test-ModelReleaseDate {
    param($Value, [datetime]$NowUtc = [datetime]::UtcNow)
    $date = [datetime]::MinValue
    return $Value -is [string] -and
        [datetime]::TryParseExact($Value, "yyyy-MM-dd", [cultureinfo]::InvariantCulture,
            [System.Globalization.DateTimeStyles]::None, [ref]$date) -and $date.Date -le $NowUtc.Date
}

function Get-ModelReleaseEvidence {
    param([string]$Model, $Source, $Aliases, [int]$StaleAfterDays, [datetime]$NowUtc = [datetime]::UtcNow)
    $result = @{status="missing";date=$null;releaseId=$null;sourceUrl=$null}
    if ((Get-ObjectMemberValue $Source "status") -notin @("ok","cached") -or
        -not (Test-ModelDataFresh (Get-ObjectMemberValue $Source "fetchedAtUtc") $StaleAfterDays $NowUtc)) {
        $result.status = "source_unavailable_or_stale"
        return $result
    }
    $mapping = Get-ObjectMemberValue (Get-ObjectMemberValue $Aliases $Model) "artificialAnalysis"
    if ($mapping -isnot [System.Collections.IDictionary]) { return $result }
    $releases = Get-ObjectMemberValue $Source "releases"
    $records = @()
    foreach ($effort in $mapping.Keys) {
        $alias = [string]$mapping[$effort]
        if ([string]::IsNullOrWhiteSpace($alias)) { continue }
        foreach ($other in $Aliases.Keys) {
            if ($other -eq $Model) { continue }
            $otherMapping = Get-ObjectMemberValue $Aliases[$other] "artificialAnalysis"
            if ($otherMapping -is [System.Collections.IDictionary] -and $alias -in $otherMapping.Values) {
                $result.status = "alias_ambiguous"
                return $result
            }
        }
        foreach ($record in @(Get-ObjectMemberValue $releases $alias)) {
            if ($null -eq $record) { continue }
            $date = Get-ObjectMemberValue $record "date"
            $releaseId = Get-ObjectMemberValue $record "releaseId"
            $publishedEffort = Get-ObjectMemberValue $record "effort"
            if (-not (Test-ModelReleaseDate $date $NowUtc) -or
                $releaseId -isnot [string] -or $releaseId -notmatch '^[a-z0-9][a-z0-9.-]*$' -or
                ($null -ne $publishedEffort -and $publishedEffort -ne $effort) -or
                (Get-ObjectMemberValue $record "blocked") -eq $true) {
                $result.status = "invalid_or_ambiguous"
                return $result
            }
            $records += @{date=$date;releaseId=$releaseId;alias=$alias}
        }
    }
    if (-not $records.Count) { return $result }
    if (@($records.date | Sort-Object -Unique).Count -ne 1 -or
        @($records.releaseId | Sort-Object -Unique).Count -ne 1) {
        $result.status = "conflicting"
        return $result
    }
    $result.status = "verified"
    $result.date = $records[0].date
    $result.releaseId = $records[0].releaseId
    $alias = @($records.alias | Sort-Object -Unique)[0]
    $result.sourceUrl = "https://artificialanalysis.ai/models/$alias"
    return $result
}

function Get-ModelRecencyTieDecision {
    param([object[]]$Candidates)
    $models = @($Candidates.model | Sort-Object -Unique)
    $result = @{status="not_needed";models=$models;contenders=@();identity=$null}
    if ($models.Count -lt 2) { return $result }
    $contenders = @(foreach ($model in $models) {
        $facts = @($Candidates | Where-Object model -eq $model | ForEach-Object { Get-ObjectMemberValue $_ "modelRelease" })
        $dates = @($facts | ForEach-Object { Get-ObjectMemberValue $_ "date" } | Sort-Object -Unique)
        $ids = @($facts | ForEach-Object { Get-ObjectMemberValue $_ "releaseId" } | Sort-Object -Unique)
        $verified = $facts.Count -gt 0 -and $dates.Count -eq 1 -and $ids.Count -eq 1 -and
            -not @($facts | Where-Object {
                (Get-ObjectMemberValue $_ "status") -ne "verified" -or
                -not (Test-ModelReleaseDate (Get-ObjectMemberValue $_ "date"))
            }).Count
        $unavailable = @($facts | ForEach-Object { Get-ObjectMemberValue $_ "status" } |
            Where-Object { $_ -and $_ -ne "verified" } | Sort-Object -Unique)
        $status = if ($verified) { "verified" } elseif (-not $facts.Count) { "missing" }
            elseif ($unavailable.Count) { $unavailable -join ", " } else { "conflicting_or_invalid" }
        @{
            model=$model
            status=$status
            date=$(if ($verified) { $dates[0] } else { $null })
            releaseId=$(if ($verified) { $ids[0] } else { $null })
            sourceUrl=$(if ($facts.Count) { Get-ObjectMemberValue $facts[0] "sourceUrl" } else { $null })
        }
    })
    $result.contenders = $contenders
    $result.status = "unavailable"
    if (-not @($contenders | Where-Object status -ne "verified").Count) {
        $latest = @($contenders.date | Sort-Object -Descending)[0]
        $result.models = @($contenders | Where-Object date -eq $latest | ForEach-Object model)
        $result.status = if ($result.models.Count -eq $models.Count) { "same_release_day" } else { "newest_release" }
    }
    $result.identity = Get-ModelDataFingerprint @{
        status=$result.status
        contenders=@($contenders | ForEach-Object { @{model=$_.model;status=$_.status;date=$_.date;releaseId=$_.releaseId} })
    }
    return $result
}
