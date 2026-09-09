function Resolve-AbandonedSession {
    # PID and process start time distinguish an abandoned launcher from another live session.
    param([string]$MasterPath, [string]$LogPath)

    $pendingFiles = @(Get-ChildItem -Path $MasterPath -Filter "usage-pending-*.json" -ErrorAction SilentlyContinue)
    if ($pendingFiles.Count -eq 0) { return }

    $endTime = Get-Date
    $recovered = 0

    foreach ($file in $pendingFiles) {
        try {
            $pending = Get-Content $file.FullName -Raw | ConvertFrom-Json
            $ownerId = $pending.PSObject.Properties["owner_process_id"]
            $ownerStarted = $pending.PSObject.Properties["owner_process_started_at_utc"]
            if ($null -eq $ownerId -or $null -eq $ownerStarted -or
                [int]$ownerId.Value -le 0 -or [string]::IsNullOrWhiteSpace([string]$ownerStarted.Value)) {
                Write-Host "Pending session '$($file.Name)' has no reliable process owner; leaving it for manual recovery." -ForegroundColor Yellow
                continue
            }
            $ownerStartTime = ([datetime]$ownerStarted.Value).ToUniversalTime()
            $owner = $null
            try {
                $owner = [System.Diagnostics.Process]::GetProcessById([int]$ownerId.Value)
            } catch [System.ArgumentException] {
                # No process with that ID exists anymore.
            }
            if ($null -ne $owner) {
                try {
                    if (-not $owner.HasExited -and $owner.StartTime.ToUniversalTime() -eq $ownerStartTime) {
                        continue
                    }
                } finally {
                    $owner.Dispose()
                }
            }
            Get-WorkbenchUsageRecord -SessionInfo $pending -EndedAt $endTime -Abandoned $true |
                Export-Csv -Path $LogPath -Append -NoTypeInformation -ErrorAction Stop

            Remove-Item -LiteralPath $file.FullName -Force -ErrorAction Stop
            $recovered++
        } catch {
            Write-Host "Could not resolve pending session '$($file.Name)' (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
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

    $marker = [pscustomobject]$SessionInfo | Select-Object -Property *
    $owner = [System.Diagnostics.Process]::GetCurrentProcess()
    try {
        $marker | Add-Member -NotePropertyMembers @{
            owner_process_id = $owner.Id
            owner_process_started_at_utc = $owner.StartTime.ToUniversalTime().ToString("o")
        } -Force
    } finally {
        $owner.Dispose()
    }
    $marker | ConvertTo-Json | Set-Content -LiteralPath $Path -ErrorAction Stop
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
        $shortId = $SessionInfo.session_id.Substring(0, [math]::Min(8, $SessionInfo.session_id.Length))
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
