# Start-CopilotWork.ps1

$MasterPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoIndex = Join-Path $MasterPath "repos.json"
$ProfileIndex = Join-Path $MasterPath "task-profiles.json"
$LogPath = Join-Path $MasterPath "usage-log.csv"

function Sync-PersonalSkills {
    # The CLI reads personal skills from ~/.copilot/skills in every repo. Keep that path
    # pointed at this folder's skills\ directory via a junction so the master folder stays
    # the single source of truth. Self-healing and non-fatal.
    param([string]$MasterPath)

    $skillsSource = Join-Path $MasterPath "skills"
    if (!(Test-Path $skillsSource)) { return }

    $personalSkills = Join-Path $env:USERPROFILE ".copilot\skills"

    try {
        if (Test-Path $personalSkills) {
            $item = Get-Item $personalSkills -Force
            if ($item.LinkType -eq "Junction") {
                $current = @($item.Target)[0]
                if ($current -eq $skillsSource) { return }
                # Junction points elsewhere -> repoint it.
                $item.Delete()
                New-Item -ItemType Junction -Path $personalSkills -Target $skillsSource | Out-Null
                Write-Host "Re-pointed ~/.copilot/skills -> $skillsSource" -ForegroundColor DarkGray
            } else {
                # A real directory already exists; don't clobber the user's own skills.
                Write-Host "~/.copilot/skills exists and is not a junction; leaving it untouched." -ForegroundColor Yellow
                Write-Host "  Shared skills in '$skillsSource' will not be auto-linked." -ForegroundColor DarkGray
            }
        } else {
            New-Item -ItemType Junction -Path $personalSkills -Target $skillsSource | Out-Null
            Write-Host "Linked ~/.copilot/skills -> $skillsSource" -ForegroundColor DarkGray
        }
    } catch {
        Write-Host "Could not sync personal skills (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

function Resolve-AbandonedSession {
    # If previous sessions ended by closing the window (not graceful exit), their pending
    # marker files are left behind. Log each one as abandoned on the next launch.
    param([string]$MasterPath, [string]$LogPath)

    $pendingFiles = @(Get-ChildItem -Path $MasterPath -Filter "usage-pending-*.json" -ErrorAction SilentlyContinue)
    if ($pendingFiles.Count -eq 0) { return }

    $invariant = [System.Globalization.CultureInfo]::InvariantCulture
    $endTime = Get-Date
    $recovered = 0

    foreach ($file in $pendingFiles) {
        try {
            $pending = Get-Content $file.FullName -Raw | ConvertFrom-Json
            $startTime = [datetime]$pending.timestamp_start
            $rawMin = ($endTime - $startTime).TotalMinutes
            $durationMin = [math]::Round([math]::Min($rawMin, 600), 1)

            [pscustomobject]@{
                session_id      = $pending.session_id
                timestamp_start = $pending.timestamp_start
                timestamp_end   = $endTime.ToString("s")
                duration_min    = $durationMin.ToString($invariant)
                repo_name       = $pending.repo_name
                repo_type       = $pending.repo_type
                task_class      = $pending.task_class
                task_label      = $pending.task_label
                abandoned       = $true
            } | Export-Csv -Path $LogPath -Append -NoTypeInformation

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

function Get-ValidCopilotModels {
    # Discover the authoritative model list from the CLI itself so it never goes stale.
    try {
        $helpText = (copilot help config 2>&1 | Out-String)
    } catch {
        return @()
    }

    $matches = [regex]::Matches($helpText, '"(claude-[\w.\-]+|gpt-[\w.\-]+)"')
    return $matches | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique
}

if (!(Test-Path $RepoIndex)) {
    Write-Host "Missing repos.json in $MasterPath" -ForegroundColor Red
    exit 1
}

try {
    $repos = Get-Content $RepoIndex -Raw | ConvertFrom-Json
} catch {
    Write-Host "repos.json is not valid JSON: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

if ($null -eq $repos) {
    $repos = @()
}

# Normalize to an array so .Count and indexing work for a single-entry file.
$repos = @($repos)

if (!(Test-Path $ProfileIndex)) {
    Write-Host "Missing task-profiles.json in $MasterPath" -ForegroundColor Red
    exit 1
}

try {
    $profiles = @(Get-Content $ProfileIndex -Raw | ConvertFrom-Json)
} catch {
    Write-Host "task-profiles.json is not valid JSON: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

if ($profiles.Count -eq 0) {
    Write-Host "task-profiles.json contains no task profiles." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=== Copilot Workbench ===" -ForegroundColor Cyan
Write-Host ""

Resolve-AbandonedSession -MasterPath $MasterPath -LogPath $LogPath

Write-Host "Select repo:"
Write-Host ""

for ($i = 0; $i -lt $repos.Count; $i++) {
    Write-Host "$($i + 1). $($repos[$i].name) [$($repos[$i].type)]"
}

Write-Host "C. Custom path"
Write-Host ""

$choice = Read-Host "Choice"

if ($choice -eq "C" -or $choice -eq "c") {
    $repoPath = Read-Host "Enter repo/source folder path"
    $repoName = "Custom path"
    $repoType = "Unknown"
} else {
    if ($choice -notmatch '^\d+$') {
        Write-Host "Invalid choice." -ForegroundColor Red
        exit 1
    }

    $index = [int]$choice - 1

    if ($index -lt 0 -or $index -ge $repos.Count) {
        Write-Host "Choice out of range." -ForegroundColor Red
        exit 1
    }

    $repoPath = $repos[$index].path
    $repoName = $repos[$index].name
    $repoType = $repos[$index].type
}

if (!(Test-Path $repoPath)) {
    Write-Host "Path does not exist: $repoPath" -ForegroundColor Red
    exit 1
}

# Tell Copilot CLI where your shared master instructions live.
$env:COPILOT_CUSTOM_INSTRUCTIONS_DIRS = $MasterPath

# Ensure shared skills are linked into the personal skills dir the CLI reads everywhere.
Sync-PersonalSkills -MasterPath $MasterPath

Set-Location $repoPath

Write-Host ""
Write-Host "Master instructions:" -ForegroundColor DarkGray
Write-Host "  $env:COPILOT_CUSTOM_INSTRUCTIONS_DIRS"
Write-Host ""
Write-Host "Working repo:" -ForegroundColor DarkGray
Write-Host "  $repoPath"
Write-Host ""
Write-Host "Repo type:" -ForegroundColor DarkGray
Write-Host "  $repoType"
Write-Host ""

# --- Task class -> model / effort / context selection ---
Write-Host "Select task class:" -ForegroundColor Cyan
Write-Host ""

for ($i = 0; $i -lt $profiles.Count; $i++) {
    $p = $profiles[$i]
    Write-Host "$($i + 1). $($p.label)  ->  $($p.model) | effort=$($p.effort) | context=$($p.context)"
    Write-Host "     $($p.description)" -ForegroundColor DarkGray
}

Write-Host ""
$taskChoice = Read-Host "Task class"

if ($taskChoice -notmatch '^\d+$') {
    Write-Host "Invalid choice." -ForegroundColor Red
    exit 1
}

$tIndex = [int]$taskChoice - 1

if ($tIndex -lt 0 -or $tIndex -ge $profiles.Count) {
    Write-Host "Choice out of range." -ForegroundColor Red
    exit 1
}

$selectedProfile = $profiles[$tIndex]

if ([string]::IsNullOrWhiteSpace($selectedProfile.model)) {
    Write-Host "Profile '$($selectedProfile.label)' has no model set in task-profiles.json." -ForegroundColor Red
    exit 1
}

# Validate the chosen model against the CLI's own current list.
$validModels = Get-ValidCopilotModels

if ($validModels.Count -gt 0 -and ($validModels -notcontains $selectedProfile.model)) {
    Write-Host ""
    Write-Host "Model '$($selectedProfile.model)' is not in the CLI's current model list:" -ForegroundColor Yellow
    Write-Host "  $($validModels -join ', ')" -ForegroundColor DarkGray
    $proceed = Read-Host "Launch anyway? y/n"
    if ($proceed -ne "y" -and $proceed -ne "Y") {
        Write-Host "Aborted. Update task-profiles.json." -ForegroundColor Red
        exit 1
    }
}

# Nudge: announce models the CLI has *newly* started offering since the last run, so you can
# decide whether to adopt them. Informational only; the config is never edited automatically.
# A small seen-models cache (.known-models.json) keeps this from listing every unused model.
if ($validModels.Count -gt 0) {
    $knownFile = Join-Path $MasterPath ".known-models.json"
    $firstRun = -not (Test-Path $knownFile)

    $known = @()
    if (-not $firstRun) {
        try { $known = @(Get-Content $knownFile -Raw | ConvertFrom-Json) } catch { $known = @() }
    }

    $usedModels = $profiles | ForEach-Object { $_.model } | Where-Object { $_ } | Select-Object -Unique
    $newModels = $validModels | Where-Object { $known -notcontains $_ -and $usedModels -notcontains $_ }

    if (-not $firstRun -and $newModels.Count -gt 0) {
        Write-Host ""
        Write-Host "i  New model(s) now offered by the CLI, not used in any profile:" -ForegroundColor Cyan
        Write-Host "     $($newModels -join ', ')" -ForegroundColor DarkGray
        Write-Host "   Review against the model-comparison docs and update task-profiles.json if useful:" -ForegroundColor DarkGray
        Write-Host "     https://docs.github.com/en/copilot/reference/ai-models/model-comparison" -ForegroundColor DarkGray
    }

    # Refresh the baseline so each new model is announced once, when it first appears.
    try { $validModels | ConvertTo-Json | Set-Content $knownFile } catch { }
}

Write-Host ""
Write-Host "Task class:" -ForegroundColor DarkGray
Write-Host "  $($selectedProfile.label)"
Write-Host "Model / effort / context:" -ForegroundColor DarkGray
Write-Host "  $($selectedProfile.model) | effort=$($selectedProfile.effort) | context=$($selectedProfile.context)"
if (-not [string]::IsNullOrWhiteSpace($selectedProfile.hint)) {
    Write-Host ""
    Write-Host "💡 $($selectedProfile.hint)" -ForegroundColor Cyan
}
Write-Host ""

# Expose the launched task class to the session so the agent can detect drift
# (see Model Selection Rules: mismatch banner).
$env:COPILOT_TASK_CLASS = $selectedProfile.key
$env:COPILOT_TASK_LABEL = $selectedProfile.label
$env:COPILOT_TASK_MODEL = $selectedProfile.model
$env:COPILOT_TASK_EFFORT = $selectedProfile.effort
$env:COPILOT_TASK_CONTEXT = $selectedProfile.context

$openVsCode = Read-Host "Open VS Code for Git/source-control review? y/n"

if ($openVsCode -eq "y" -or $openVsCode -eq "Y") {
    if (Get-Command code -ErrorAction SilentlyContinue) {
        code -n $repoPath
    } else {
        Write-Host "VS Code 'code' command not found on PATH. Skipping." -ForegroundColor Yellow
    }
}

Write-Host ""

if (-not (Get-Command copilot -ErrorAction SilentlyContinue)) {
    Write-Host "Copilot CLI 'copilot' command not found on PATH." -ForegroundColor Red
    Write-Host "Install it, then run 'copilot' from: $repoPath" -ForegroundColor Red
    exit 1
}

# Generate a session UUID upfront so it can be logged and displayed.
$sessionId = [System.Guid]::NewGuid().ToString()

# Offer to resume a previous session (e.g. continuing after a triage relaunch).
Write-Host ""
$resumeInput = Read-Host "Resume a previous session? (paste session ID or Enter to skip)"

# Build launch arguments deterministically from the selected profile.
$copilotArgs = @("--model", $selectedProfile.model)

if (-not [string]::IsNullOrWhiteSpace($selectedProfile.effort)) {
    $copilotArgs += @("--effort", $selectedProfile.effort)
}

if (-not [string]::IsNullOrWhiteSpace($selectedProfile.context)) {
    $copilotArgs += @("--context", $selectedProfile.context)
}

if (-not [string]::IsNullOrWhiteSpace($resumeInput)) {
    $copilotArgs += @("--resume", $resumeInput)
} else {
    $copilotArgs += @("--session-id", $sessionId)
}

# Build the session kickoff message so the agent knows its task class from turn 0.
# This makes drift detection reliable (no env-var reading required) and triggers
# triage estimation automatically.
$kickoff = "Session initialized: task class = **$($selectedProfile.label)** (``$($selectedProfile.key)``), model = ``$($selectedProfile.model)``, effort = ``$($selectedProfile.effort)``, context = ``$($selectedProfile.context)``. Class definition: $($selectedProfile.description) Acknowledge briefly and await my task."

if ($selectedProfile.key -eq "triage") {
    $kickoff += " This is a triage session. Your ENTIRE first response to the user's task must consist of only the TRIAGE ESTIMATE callout block and nothing else - no introduction, no answer, no code, no file walkthrough, no explanation. Do NOT answer the user's task, explain the repo, write code, or provide any substantive content before showing the callout - even if the task appears trivial or informational. After the callout, STOP and wait. Do not proceed under any circumstances until the user relaunches or explicitly says 'continue here'."
} else {
    $kickoff += " On your FIRST response to my task (not this acknowledgment), start with a single line: Drift check: launched **$($selectedProfile.label)** ($($selectedProfile.description)) | this task: [one phrase] -> [fits / MISMATCH: suggest X]. If it is a mismatch, show the full drift banner immediately after. Then proceed with the work."
}

$copilotArgs += @("--interactive", $kickoff)

Write-Host ""
Write-Host "Starting Copilot CLI inside target repo..." -ForegroundColor Cyan
Write-Host "  copilot $($copilotArgs -join " ")" -ForegroundColor DarkGray
Write-Host ""

if ($selectedProfile.key -eq "triage") {
    Write-Host "TRIAGE SESSION - Copilot must show the estimate callout before doing any work." -ForegroundColor Yellow
    Write-Host "  If it skips straight to answering, say 'triage first' to redirect it." -ForegroundColor DarkGray
    Write-Host ""
}

$sessionStart = Get-Date
$PendingFile = Join-Path $MasterPath "usage-pending-$($sessionStart.ToString(`"yyyyMMddTHHmmss`")).json"

# Write pending marker so a window-close is recoverable on next launch.
try {
    "{`"session_id`":`"$sessionId`",`"timestamp_start`":`"$($sessionStart.ToString('s'))`",`"repo_name`":`"$repoName`",`"repo_type`":`"$repoType`",`"task_class`":`"$($selectedProfile.key)`",`"task_label`":`"$($selectedProfile.label)`"}" | Set-Content $PendingFile
} catch {
    Write-Host "Could not write session marker (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
}

copilot @copilotArgs
$sessionEnd = Get-Date

# Remove pending marker — session exited gracefully.
try { Remove-Item $PendingFile -Force -ErrorAction SilentlyContinue } catch { }

# --- Silent usage logging (duration capped at 10h to guard against forgotten sessions) ---
try {
    $invariant = [System.Globalization.CultureInfo]::InvariantCulture
    $rawMin = ($sessionEnd - $sessionStart).TotalMinutes
    $durationMin = [math]::Round([math]::Min($rawMin, 600), 1)

    [pscustomobject]@{
        session_id      = $sessionId
        timestamp_start = $sessionStart.ToString("s")
        timestamp_end   = $sessionEnd.ToString("s")
        duration_min    = $durationMin.ToString($invariant)
        repo_name       = $repoName
        repo_type       = $repoType
        task_class      = $selectedProfile.key
        task_label      = $selectedProfile.label
        abandoned       = $false
    } | Export-Csv -Path $LogPath -Append -NoTypeInformation

    Write-Host ""
    $shortId = $sessionId.Substring(0, 8)
    Write-Host "Session ended. Duration: $durationMin min in $repoName. (ID: $shortId)" -ForegroundColor DarkGray
    if ($selectedProfile.key -eq "triage") {
        Write-Host "  To continue with full context: relaunch and paste session ID: $sessionId" -ForegroundColor Cyan
    }
} catch {
    Write-Host "Usage logging failed (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
}