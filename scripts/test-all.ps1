Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Aggregates every test file in this repo and exits non-zero if any test file
# fails. Used locally and by the monthly workflow to gate report generation
# on a fully green test run (rule: workflow must run tests before generating
# the review report).

$testFiles = @(
    (Join-Path $PSScriptRoot "test-module-boundaries.ps1"),
    (Join-Path $PSScriptRoot "test-workbench-helpers.ps1"),
    (Join-Path $PSScriptRoot "test-model-ranking-data.ps1"),
    (Join-Path $PSScriptRoot "test-model-policy.ps1"),
    (Join-Path $PSScriptRoot "test-model-pricing.ps1"),
    (Join-Path $PSScriptRoot "test-model-evidence.ps1"),
    (Join-Path $PSScriptRoot "test-model-selection.ps1"),
    (Join-Path $PSScriptRoot "test-model-recency.ps1"),
    (Join-Path $PSScriptRoot "test-model-onboarding.ps1"),
    (Join-Path $PSScriptRoot "test-role-qualification.ps1"),
    (Join-Path $PSScriptRoot "test-model-review.ps1"),
    (Join-Path $PSScriptRoot "test-model-launch-args.ps1")
)

$failedFiles = [System.Collections.Generic.List[string]]::new()
foreach ($testFile in $testFiles) {
    Write-Host "==== Running $testFile ====" -ForegroundColor Cyan
    # Each test file calls `exit 1` on failure. Run it in its own pwsh
    # process (rather than `&`/dot-sourcing in this process) so that exit
    # code terminates only that test file's run, not this aggregator.
    & pwsh -NoProfile -File $testFile
    if ($LASTEXITCODE -ne 0) {
        $failedFiles.Add((Split-Path $testFile -Leaf))
        Write-Host "==== FAILED: $testFile ====" -ForegroundColor Red
    } else {
        Write-Host "==== OK: $testFile ====" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Test files passed: $($testFiles.Count - $failedFiles.Count)"
Write-Host "Test files failed: $($failedFiles.Count)"
if ($failedFiles.Count -gt 0) {
    Write-Host "Failed files: $($failedFiles -join ', ')" -ForegroundColor Red
    Write-Host "One or more test files failed." -ForegroundColor Red
    exit 1
}

Write-Host "All test files passed." -ForegroundColor Green
