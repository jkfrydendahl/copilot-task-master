<#
.SYNOPSIS
    Prepares a release branch: syncs branches, creates release branch, merges, updates version.
.DESCRIPTION
    Performs steps 02-07 of the release workflow in a single invocation.
    Auto-detects the version file (app.json, package.json, VERSION, or *.csproj/Directory.Build.props).
    Stops with a clear error message if merge conflicts occur.
.PARAMETER Branches
    The task branches to merge into the release.
.PARAMETER Version
    The version number for this release (e.g. "1.2.4").
.PARAMETER MainBranch
    The main branch name. Defaults to auto-detect (main or master).
.EXAMPLE
    .\Prepare-Release.ps1 -Branches "feature/auth","12450_Tjek-af-Leveringsnavn" -Version "1.0.2.53"
#>
param(
    [Parameter(Mandatory)]
    [string[]]$Branches,

    [Parameter(Mandatory)]
    [string]$Version,

    [string]$MainBranch
)

$ErrorActionPreference = 'Stop'

# Auto-detect main branch if not specified
if (-not $MainBranch) {
    $localBranches = git branch | ForEach-Object { $_.Trim().TrimStart('* ') }
    if ($localBranches -contains 'main') { $MainBranch = 'main' }
    elseif ($localBranches -contains 'master') { $MainBranch = 'master' }
    else { Write-Error "Could not detect main/master branch. Specify -MainBranch."; exit 1 }
}

$releaseBranch = "release/$Version"

# Check if release branch already exists
$existing = git branch | ForEach-Object { $_.Trim().TrimStart('* ') } | Where-Object { $_ -eq $releaseBranch }
if ($existing) {
    Write-Error "Branch '$releaseBranch' already exists locally. Aborting."
    exit 1
}

# Step 1: Fetch all task branches
Write-Host "`n=== Fetching task branches ===" -ForegroundColor Cyan
foreach ($branch in $Branches) {
    Write-Host "  Fetching $branch..." -NoNewline
    git fetch origin $branch 2>$null
    if ($LASTEXITCODE -ne 0) { Write-Error "`nFailed to fetch '$branch'"; exit 1 }
    Write-Host " OK" -ForegroundColor Green
}

# Step 2: Sync main branch
Write-Host "`n=== Syncing $MainBranch ===" -ForegroundColor Cyan
git checkout $MainBranch 2>$null
if ($LASTEXITCODE -ne 0) { Write-Error "Failed to checkout $MainBranch"; exit 1 }
git pull origin $MainBranch 2>$null
if ($LASTEXITCODE -ne 0) { Write-Error "Failed to pull $MainBranch"; exit 1 }
Write-Host "  $MainBranch is up to date." -ForegroundColor Green

# Step 3: Create release branch
Write-Host "`n=== Creating $releaseBranch ===" -ForegroundColor Cyan
git checkout -b $releaseBranch 2>$null
if ($LASTEXITCODE -ne 0) { Write-Error "Failed to create '$releaseBranch'"; exit 1 }
Write-Host "  Created $releaseBranch from $MainBranch." -ForegroundColor Green

# Step 4: Merge all task branches
Write-Host "`n=== Merging task branches ===" -ForegroundColor Cyan
foreach ($branch in $Branches) {
    Write-Host "  Merging $branch..." -NoNewline
    git pull origin $branch 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host " CONFLICT" -ForegroundColor Red
        Write-Host "`nMerge conflict while merging '$branch'." -ForegroundColor Red
        Write-Host "Resolve the conflicts, then re-run the remaining steps manually." -ForegroundColor Yellow
        exit 1
    }
    Write-Host " OK" -ForegroundColor Green
}

# Step 5: Update version — auto-detect version file
Write-Host "`n=== Updating version to $Version ===" -ForegroundColor Cyan

$versionUpdated = $false
$filesToStage = @()

# Priority 1: app.json (AL / Business Central)
$appJsonPath = Join-Path $PWD 'app.json'
if (Test-Path $appJsonPath) {
    Write-Host "  Detected: app.json (AL/BC project)" -ForegroundColor DarkGray
    $content = Get-Content $appJsonPath -Raw
    $newContent = $content -replace '("version"\s*:\s*")[^"]*"', "`${1}$Version`""
    if ($content -ne $newContent) {
        Set-Content $appJsonPath $newContent -NoNewline -Encoding UTF8
        $filesToStage += 'app.json'
        $versionUpdated = $true
    }
}

# Priority 2: package.json (Node.js)
if (-not $versionUpdated) {
    $pkgJsonPath = Join-Path $PWD 'package.json'
    if (Test-Path $pkgJsonPath) {
        Write-Host "  Detected: package.json (Node.js project)" -ForegroundColor DarkGray
        $content = Get-Content $pkgJsonPath -Raw
        $newContent = $content -replace '("version"\s*:\s*")[^"]*"', "`${1}$Version`""
        if ($content -ne $newContent) {
            Set-Content $pkgJsonPath $newContent -NoNewline -Encoding UTF8
            $filesToStage += 'package.json'
            $versionUpdated = $true
        }
    }
}

# Priority 3: VERSION file (plain text)
if (-not $versionUpdated) {
    $versionFilePath = Join-Path $PWD 'VERSION'
    if (Test-Path $versionFilePath) {
        Write-Host "  Detected: VERSION file" -ForegroundColor DarkGray
        Set-Content $versionFilePath $Version -NoNewline -Encoding UTF8
        $filesToStage += 'VERSION'
        $versionUpdated = $true
    }
}

# Priority 4: Directory.Build.props or *.csproj (.NET)
if (-not $versionUpdated) {
    $dirBuildProps = Join-Path $PWD 'Directory.Build.props'
    $csprojFiles = Get-ChildItem -Path $PWD -Filter '*.csproj' -Recurse -Depth 1 | Select-Object -First 1

    $dotnetFile = $null
    if (Test-Path $dirBuildProps) {
        $dotnetFile = $dirBuildProps
    } elseif ($csprojFiles) {
        $dotnetFile = $csprojFiles.FullName
    }

    if ($dotnetFile) {
        Write-Host "  Detected: $($dotnetFile | Split-Path -Leaf) (.NET project)" -ForegroundColor DarkGray
        $content = Get-Content $dotnetFile -Raw
        $newContent = $content -replace '(<Version>)[^<]*(</Version>)', "`${1}$Version`${2}"
        if ($content -ne $newContent) {
            Set-Content $dotnetFile $newContent -NoNewline -Encoding UTF8
            $relativePath = [System.IO.Path]::GetRelativePath($PWD, $dotnetFile)
            $filesToStage += $relativePath
            $versionUpdated = $true
        } else {
            Write-Host "  Warning: <Version> element not found in $($dotnetFile | Split-Path -Leaf)" -ForegroundColor Yellow
        }
    }
}

if (-not $versionUpdated) {
    Write-Error "No version file detected (checked: app.json, package.json, VERSION, Directory.Build.props, *.csproj). Cannot update version."
    exit 1
}

foreach ($file in $filesToStage) {
    git add $file
}
git commit -m "Update to version $Version" 2>$null
if ($LASTEXITCODE -ne 0) { Write-Error "Failed to commit version update"; exit 1 }
Write-Host "  Version updated and committed." -ForegroundColor Green

Write-Host "`n=== Release branch $releaseBranch is ready for build ===" -ForegroundColor Green
