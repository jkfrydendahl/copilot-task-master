function Resolve-AbandonedSession {
    # If previous sessions ended by closing the window (not graceful exit), their pending
    # marker files are left behind. Log each one as abandoned on the next launch.
    param([string]$MasterPath, [string]$LogPath)

    $pendingFiles = @(Get-ChildItem -Path $MasterPath -Filter "usage-pending-*.json" -ErrorAction SilentlyContinue)
    if ($pendingFiles.Count -eq 0) { return }

    $endTime = Get-Date
    $recovered = 0

    foreach ($file in $pendingFiles) {
        try {
            $pending = Get-Content $file.FullName -Raw | ConvertFrom-Json
            Get-WorkbenchUsageRecord -SessionInfo $pending -EndedAt $endTime -Abandoned $true |
                Export-Csv -Path $LogPath -Append -NoTypeInformation

            Remove-Item $file.FullName -Force
            $recovered++
        } catch {
            Write-Host "Could not resolve pending session '$($file.Name)' (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
            try { Remove-Item $file.FullName -Force } catch { }
        }
    }

    if ($recovered -gt 0) {
        $label = if ($recovered -eq 1) { "session" } else { "$recovered sessions" }
        Write-Host "  $recovered previous $label not closed gracefully - logged in usage-log.csv." -ForegroundColor Yellow
        Write-Host ""
    }
}

function Write-WorkbenchSessionMarker {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)]$SessionInfo
    )

    $SessionInfo | ConvertTo-Json | Set-Content -LiteralPath $Path -ErrorAction Stop
}

function Get-WorkbenchUsageRecord {
    param(
        [Parameter(Mandatory)]$SessionInfo,
        [Parameter(Mandatory)][datetime]$EndedAt,
        [bool]$Abandoned = $false,
        [datetime]$StartedAt = ([datetime]$SessionInfo.timestamp_start)
    )

    $rawMinutes = ($EndedAt - $StartedAt).TotalMinutes
    $durationMinutes = [math]::Round([math]::Min($rawMinutes, 600), 1)
    return [pscustomobject]@{
        session_id = $SessionInfo.session_id
        timestamp_start = $SessionInfo.timestamp_start
        timestamp_end = $EndedAt.ToString("s")
        duration_min = $durationMinutes.ToString([System.Globalization.CultureInfo]::InvariantCulture)
        repo_name = $SessionInfo.repo_name
        repo_type = $SessionInfo.repo_type
        task_class = $SessionInfo.task_class
        task_label = $SessionInfo.task_label
        abandoned = $Abandoned
    }
}

function Complete-WorkbenchSession {
    param(
        [Parameter(Mandatory)]$SessionInfo,
        [Parameter(Mandatory)][string]$PendingPath,
        [Parameter(Mandatory)][string]$LogPath,
        [datetime]$EndedAt = (Get-Date),
        [datetime]$StartedAt = ([datetime]$SessionInfo.timestamp_start)
    )

    Remove-Item -LiteralPath $PendingPath -Force -ErrorAction SilentlyContinue
    try {
        $usage = Get-WorkbenchUsageRecord -SessionInfo $SessionInfo -EndedAt $EndedAt -StartedAt $StartedAt
        $usage | Export-Csv -LiteralPath $LogPath -Append -NoTypeInformation -ErrorAction Stop

        Write-Host ""
        $shortId = $SessionInfo.session_id.Substring(0, 8)
        Write-Host "Session ended. Duration: $($usage.duration_min) min in $($SessionInfo.repo_name). (ID: $shortId)" -ForegroundColor DarkGray
        if ($SessionInfo.task_class -eq "triage") {
            Write-Host "  To continue with full context: relaunch and paste session ID: $($SessionInfo.session_id)" -ForegroundColor Cyan
        }
    } catch [System.IO.IOException] {
        Write-Host "Usage logging failed (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
    } catch [System.UnauthorizedAccessException] {
        Write-Host "Usage logging failed (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
    } catch [System.InvalidOperationException] {
        Write-Host "Usage logging failed (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
    }
}
