Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Aggregates every test file in this repo and exits non-zero if any test file
# fails. Used locally and by the monthly workflow to gate report generation
# on a fully green test run (rule: workflow must run tests before generating
# the review report).

$testFiles = @(
    (Join-Path $PSScriptRoot "test-model-ranking-data.ps1"),
    (Join-Path $PSScriptRoot "test-model-policy.ps1"),
    (Join-Path $PSScriptRoot "test-model-launch-args.ps1")
)

$overallFailed = $false
foreach ($testFile in $testFiles) {
    Write-Host "==== Running $testFile ====" -ForegroundColor Cyan
    # Each test file calls `exit 1` on failure. Run it in its own pwsh
    # process (rather than `&`/dot-sourcing in this process) so that exit
    # code terminates only that test file's run, not this aggregator.
    & pwsh -NoProfile -File $testFile
    if ($LASTEXITCODE -ne 0) {
        $overallFailed = $true
        Write-Host "==== FAILED: $testFile ====" -ForegroundColor Red
    } else {
        Write-Host "==== OK: $testFile ====" -ForegroundColor Green
    }
}

if ($overallFailed) {
    Write-Host "One or more test files failed." -ForegroundColor Red
    exit 1
}

Write-Host "All test files passed." -ForegroundColor Green
