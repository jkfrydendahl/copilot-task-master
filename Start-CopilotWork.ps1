# Start-CopilotWork.ps1

$MasterPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoIndex = Join-Path $MasterPath "repos.json"

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

Write-Host ""
Write-Host "=== Copilot Workbench ===" -ForegroundColor Cyan
Write-Host ""
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

Write-Host "Starting Copilot CLI inside target repo..." -ForegroundColor Cyan
Write-Host ""

copilot