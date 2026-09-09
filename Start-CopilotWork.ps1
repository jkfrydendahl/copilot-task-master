# Start-CopilotWork.ps1

$MasterPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoIndex = Join-Path $MasterPath "repos.json"
$ProfileIndex = Join-Path $MasterPath "task-profiles.json"
$LogPath = Join-Path $MasterPath "usage-log.csv"
. (Join-Path $MasterPath "scripts\model-id-parser.ps1")
. (Join-Path $MasterPath "scripts\workbench-setup.ps1")
. (Join-Path $MasterPath "scripts\workbench-session.ps1")

function Get-ValidCopilotModels {
    # Discover the authoritative model list from the CLI itself so it never goes stale.
    try {
        $helpText = (copilot help config 2>&1 | Out-String)
    } catch {
        return @()
    }

    return @(Get-CopilotModelIdsFromHelpText -HelpText $helpText)
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

# Ensure task-class custom agents are kept in sync with task-profiles.json.
# This is additive to launch-time model selection (not a replacement).
Update-TaskClassAgents -MasterPath $MasterPath -Profiles $profiles

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
$validModels = @(Get-ValidCopilotModels)

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
    $newModels = @($validModels | Where-Object { $known -notcontains $_ -and $usedModels -notcontains $_ })

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

# Offer to resume a previous session (e.g. continuing after a triage relaunch).
Write-Host ""
$resumeInput = Read-Host "Resume a previous session? (paste session ID or Enter to skip)"

# Build launch arguments deterministically from the selected profile.
# --effort is omitted for models whose capability catalog record declares
# effortMode="unsupported" (e.g. claude-haiku-4.5), since the CLI does not
# accept the flag for those models. See scripts/model-launch-args.ps1 and
# scripts/test-model-launch-args.ps1 for the tested convention.
$copilotArgs = & {
    . (Join-Path $MasterPath "scripts\model-launch-args.ps1")

    $capabilitiesCatalog = @{}
    try {
        $capabilitiesCatalog = Get-LaunchCapabilitiesCatalog -CatalogPath (Join-Path $MasterPath "config\model-capabilities.json")
    } catch {
        Write-Host "Warning: could not load model capabilities catalog ($($_.Exception.Message)); assuming --effort is supported for all models." -ForegroundColor Yellow
    }

    Get-CopilotLaunchModelArgs -Profile $selectedProfile -CapabilitiesCatalog $capabilitiesCatalog
}

if (-not [string]::IsNullOrWhiteSpace($resumeInput)) {
    $sessionId = $resumeInput.Trim()
    $copilotArgs += @("--resume", $sessionId)
} else {
    $sessionId = [System.Guid]::NewGuid().ToString()
    $copilotArgs += @("--session-id", $sessionId)
}

$kickoff = Get-WorkbenchSessionKickoff -Profile $selectedProfile -MasterPath $MasterPath
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
$PendingFile = Join-Path $MasterPath "usage-pending-$([guid]::NewGuid().ToString('N')).json"
$sessionInfo = [pscustomobject]@{
    session_id = $sessionId
    timestamp_start = $sessionStart.ToString("s")
    repo_name = $repoName
    repo_type = $repoType
    task_class = $selectedProfile.key
    task_label = $selectedProfile.label
}

# Write pending marker so a window-close is recoverable on next launch.
try {
    Write-WorkbenchSessionMarker -Path $PendingFile -SessionInfo $sessionInfo
} catch {
    Write-Host "Could not write session marker (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
}

copilot @copilotArgs
$sessionEnd = Get-Date

Complete-WorkbenchSession -SessionInfo $sessionInfo -PendingPath $PendingFile -LogPath $LogPath -StartedAt $sessionStart -EndedAt $sessionEnd
