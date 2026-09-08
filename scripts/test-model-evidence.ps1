Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-benchmark-evidence.ps1")
$script:Failed = 0
function Assert-True($Condition, $Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name, [scriptblock]$Action) {
    try { & $Action; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $_" }
}
$now=[datetime]"2026-09-08Z"
$profile=@{key="default-development";effort="medium";context="default"}
$policy=@{profileArtificialAnalysisMetrics=@{"default-development"="coding"};profileLiveBenchCategories=@{"default-development"="coding"};consensusPolicy=@{staleAfterDays=45;benchmarkMaxPublicationAgeDays=90}}
$aliases=@{one=@{artificialAnalysis=@{medium="one-medium";max="one-max"};liveBench=@{medium="one-lb"}}}
$aa=@{status="ok";sourceDate=$null;fetchedAtUtc="2026-09-08Z";sourceUrl="https://example.test/aa";sourceVersion="aa-v1";models=@{"one-medium"=@{name="One medium";codingIndex=50;intelligenceIndex=60};"one-max"=@{codingIndex=90}}}
$lb=@{status="ok";sourceDate="2026-09-01";fetchedAtUtc="2026-09-08Z";sourceUrl="https://example.test/lb";sourceVersion="lb-v1";models=@{"one-lb"=@{coding=80}}}
function Evidence($Sources=@{artificialAnalysis=$aa;liveBench=$lb}, $Mapping=$aliases, $Profile=$profile, $Caps=@{}) {
    Get-ProfileBenchmarkEvidence -Profile $Profile -Models @("one") -Sources $Sources -Aliases $Mapping -Capabilities $Caps -Policy $policy -NowUtc $now
}
Run-Test "Fixed effort uses exact variant and carries provenance" {
    $r=Evidence
    Assert-True ($r.records.Count -eq 2) "Expected both sources"
    $e=@($r.records | Where-Object source -eq artificialAnalysis)[0]
    Assert-True ($e.score -eq 50 -and $e.alias -eq "one-medium") "Used max score"
    Assert-True ($e.publicationAgeUnknown -and $e.effort -eq "medium") "Provenance"
}
Run-Test "Unmatched configuration is excluded rather than substituted" {
    $r=Evidence -Mapping @{one=@{artificialAnalysis=@{max="one-max"}}}
    Assert-True ($r.records.Count -eq 0) "Max substituted for medium"
    Assert-True ($r.diagnostics.Count -gt 0) "Missing match not reported"
}
Run-Test "Independent sources and missing LB cost data do not gate evidence" {
    $r=Evidence -Sources @{artificialAnalysis=$aa;liveBench=@{status="error";message="HTTP503"}}
    Assert-True ($r.records.Count -eq 1 -and $r.records[0].source -eq "artificialAnalysis") "AA blocked"
    $r=Evidence -Sources @{artificialAnalysis=@{status="error";message="no key"};liveBench=$lb}
    Assert-True ($r.records.Count -eq 1 -and $r.records[0].source -eq "liveBench") "LB blocked"
}
Run-Test "Known publication age and retrieval age are separate gates" {
    $old=$lb.Clone();$old.sourceDate="2026-01-01"
    Assert-True ((Evidence -Sources @{liveBench=$old}).records.Count -eq 0) "Old publication"
    $old=$aa.Clone();$old.fetchedAtUtc="2026-01-01"
    Assert-True ((Evidence -Sources @{artificialAnalysis=$old}).records.Count -eq 0) "Old retrieval"
    Assert-True ((Evidence -Sources @{artificialAnalysis=$aa}).records.Count -eq 1) "Unknown date should be disclosed, not fabricated"
}
Run-Test "Unsupported effort models use explicitly declared no-effort variant" {
    $r=Evidence -Mapping @{one=@{artificialAnalysis=@{none="one-medium"}}} -Caps @{one=@{effortMode="unsupported"}}
    Assert-True ($r.records.Count -eq 1 -and $r.records[0].effort -eq "none") "Unsupported effort semantics"
}
if ($script:Failed) { exit 1 }
