Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-aa-components.ps1")
. (Join-Path $PSScriptRoot "model-benchmark-evidence.ps1")
. (Join-Path $PSScriptRoot "model-profile-selection.ps1")
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
. (Join-Path $PSScriptRoot "model-review-report.ps1")
$script:Failed = 0
$now = [datetime]"2026-09-23Z"
function Assert-True($Condition, $Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name, [scriptblock]$Action) {
    try { & $Action; Write-Host "PASS: $Name" } catch {
        $script:Failed++; Write-Host "FAIL: $Name -- $_"; Write-Host $_.ScriptStackTrace
    }
}
function Release-Row($Model, $Date, $Effort="low") {
    @{slug="$Model-$Effort";name=$Model;releaseDate=$Date;release=@{slug=$Model};effort=@{slug=$Effort};lcr=0.8}
}
function Release-Source($Rows) {
    $parsed=ConvertFrom-AAComponentPage (Release-Html $Rows)
    $source=@{fetchedAtUtc="2026-09-23Z";sourceDate=$null}
    foreach ($field in @("status","models","releases","diagnostics")) { $source[$field]=$parsed.$field }
    return $source
}
function Release-Html($Rows) {
    $json=@{models=@($Rows)} | ConvertTo-Json -Depth 10 -Compress
    '<script>self.__next_f.push([1,' + (ConvertTo-Json -InputObject $json -Compress) + '])</script>'
}
function New-RecencyFixture {
    $policy=Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
    @{
        profile=@{key="quick";model="old";effort="low";context="default"}
        policy=$policy
        aliases=@{old=@{artificialAnalysis=@{low="old-low"}};new=@{artificialAnalysis=@{low="new-low"}}}
        sources=@{
            artificialAnalysis=@{status="ok";fetchedAtUtc="2026-09-23Z";sourceDate=$null;models=@{
                "old-low"=@{codingIndex=80};"new-low"=@{codingIndex=78}
            }}
            artificialAnalysisComponents=(Release-Source @((Release-Row old "2026-07-01"),(Release-Row new "2026-09-01")))
        }
        verdicts=@(foreach ($model in @("old","new")) {
            @{modelId=$model;effort="low";context="default";admissible=$true;reasonCodes=@();warningCodes=@();
                capabilities=@{asOf="2026-09-23"};pricing=@{inputPerMillion=1;outputPerMillion=5;tier="default";verifiedAtUtc="2026-09-23"}}
        })
    }
}
function Select-RecencyFixture($Fixture) {
    $evidence=Get-ProfileBenchmarkEvidence -Profile $Fixture.profile -Models @("old","new") -Sources $Fixture.sources `
        -Aliases $Fixture.aliases -Policy $Fixture.policy -NowUtc $now
    Get-ProfileSelection -Profile $Fixture.profile -Evidence $evidence.records -Verdicts $Fixture.verdicts `
        -Policy $Fixture.policy -Aliases $Fixture.aliases
}
Run-Test "Release metadata is separate from component scores and publication dates" {
    $row=Release-Row one "2026-09-01"
    $dateOnly=Release-Row two "2026-08-01";$dateOnly.Remove("lcr")
    $source=Release-Source @($row,$dateOnly)
    Assert-True ($source.models.Count -eq 1 -and $source.releases.Count -eq 2) "Dates inflated score coverage or were discarded"
    Assert-True ($null -eq $source.sourceDate) "Release became benchmark publication"
    $aliases=@{one=@{artificialAnalysis=@{low="one-low"}}}
    $release=Get-ModelReleaseEvidence one $source $aliases 45 $now
    Assert-True ($release.status -eq "verified" -and $release.date -eq "2026-09-01") "Release missing"
}
Run-Test "Equally priced newer qualified model beats incumbent despite a lower score" {
    $f=New-RecencyFixture;$s=Select-RecencyFixture $f
    Assert-True ($s.winner.model -eq "new" -and $s.valueDecision.recencyDecision.status -eq "newest_release") "Incumbent/score outranked newer release"
    Assert-True ($s.winner.modelRelease.sourceUrl -eq "https://artificialanalysis.ai/models/new-low") "Release provenance missing"
}
Run-Test "Newness cannot override price, quality bands or admissibility" {
    foreach ($change in @(
        {param($f) $f.verdicts[1].pricing.inputPerMillion=1.1},
        {param($f) $f.sources.artificialAnalysis.models["new-low"].codingIndex=76.999},
        {param($f) $f.verdicts[1].admissible=$false}
    )) {
        $f=New-RecencyFixture;& $change $f;$s=Select-RecencyFixture $f
        Assert-True ($null -eq $s.winner -or $s.winner.model -eq "old") "Newer bypassed qualification or price"
    }
}
Run-Test "Recency does not override any required role dimension" {
    $f=New-RecencyFixture;$f.profile.key="deep-reasoning";$f.profile.effort="high"
    foreach ($model in @("old","new")) {
        $f.aliases[$model].artificialAnalysis=@{high="$model-high"}
        $f.sources.artificialAnalysis.models["$model-high"]=@{intelligenceIndex=80}
    }
    foreach ($verdict in $f.verdicts) { $verdict.effort="high" }
    $old=Release-Row old "2026-07-01" high
    $new=Release-Row new "2026-09-01" high;$new.lcr=0.7
    $f.sources.artificialAnalysisComponents=Release-Source @($old,$new)
    $s=Select-RecencyFixture $f
    Assert-True ($s.winner.model -eq "old") "Recency bypassed AA-LCR"
}
Run-Test "Missing, malformed, future or contradictory release metadata triggers disclosed fallback" {
    foreach ($rows in @(
        @((Release-Row old "2026-07-01"),(Release-Row new $null)),
        @((Release-Row old "2026-07-01"),(Release-Row new "not-a-date")),
        @((Release-Row old "2026-07-01"),(Release-Row new "9999-12-31")),
        @((Release-Row old "2026-07-01"),(Release-Row new "2026-02-30")),
        @((Release-Row old "2026-07-01"),(Release-Row new "2026-09-01"),(Release-Row new "2026-09-02"))
    )) {
        $f=New-RecencyFixture;$f.sources.artificialAnalysisComponents=Release-Source $rows
        $s=Select-RecencyFixture $f
        Assert-True ($s.winner.model -eq "old" -and $s.valueDecision.recencyDecision.status -eq "unavailable") "Unverified date sorted as known"
        Assert-True ($s.qualification.pool.Count -eq 2) "Bad dates discarded valid benchmarks"
    }
}
Run-Test "Unknown incumbent date is not treated as older than a dated challenger" {
    $f=New-RecencyFixture;$f.sources.artificialAnalysisComponents.releases.Remove("old-low")
    Assert-True ((Select-RecencyFixture $f).winner.model -eq "old") "Unknown treated as oldest"
}
Run-Test "One unknown contender disables recency for the entire multi-model tie" {
    $candidates=@(
        @{model="older";modelRelease=@{status="verified";date="2026-07-01";releaseId="older"}},
        @{model="newer";modelRelease=@{status="verified";date="2026-09-01";releaseId="newer"}},
        @{model="unknown";modelRelease=@{status="conflicting";date=$null;releaseId=$null}}
    )
    $decision=Get-ModelRecencyTieDecision $candidates
    Assert-True ($decision.status -eq "unavailable" -and $decision.models.Count -eq 3) "Partially known dates narrowed tie"
    Assert-True (($decision.contenders | Where-Object model -eq unknown).status -eq "conflicting") "Specific recency failure hidden"
}
Run-Test "Identical release days preserve deterministic incumbent and score tie-breaks" {
    $f=New-RecencyFixture;$f.sources.artificialAnalysisComponents.releases["old-low"][0].date="2026-09-01"
    $s=Select-RecencyFixture $f
    Assert-True ($s.winner.model -eq "old" -and $s.valueDecision.recencyDecision.status -eq "same_release_day") "Same-day churn"
    $f.profile.model="unscored"
    Assert-True ((Select-RecencyFixture $f).winner.model -eq "old") "Primary score fallback lost"
}
Run-Test "Effort variants of one model are not different releases" {
    $decision=Get-ModelRecencyTieDecision @(@{model="one";effort="high"},@{model="one";effort="max"})
    Assert-True ($decision.status -eq "not_needed" -and $null -eq $decision.identity) "Effort ranked as release"
}
Run-Test "Exact alias release identities reconcile across efforts without borrowing scores" {
    $f=New-RecencyFixture
    $f.aliases.new.artificialAnalysis.high="new-high"
    $f.sources.artificialAnalysisComponents=Release-Source @((Release-Row old "2026-07-01"),(Release-Row new "2026-09-01" high))
    $s=Select-RecencyFixture $f
    Assert-True ($s.winner.model -eq "new" -and $s.winner.effort -eq "low" -and $s.winner.score -eq 78) "Model release confused with effort score"
    $f.sources.artificialAnalysisComponents.releases["new-low"]=@(@{date="2026-09-01";releaseId="another-model";effort="low"})
    Assert-True ((Select-RecencyFixture $f).valueDecision.recencyDecision.status -eq "unavailable") "Conflicting release identity accepted"
}
Run-Test "Ambiguous aliases and published effort mismatch cannot verify recency" {
    $f=New-RecencyFixture;$f.aliases.other=@{artificialAnalysis=@{low="new-low"}}
    $r=Get-ModelReleaseEvidence new $f.sources.artificialAnalysisComponents $f.aliases 45 $now
    Assert-True ($r.status -eq "alias_ambiguous") "Shared identity accepted"
    $f=New-RecencyFixture;$f.sources.artificialAnalysisComponents.releases["new-low"][0].effort="high"
    Assert-True ((Select-RecencyFixture $f).valueDecision.recencyDecision.status -eq "unavailable") "Effort mismatch verified"
}
Run-Test "Legacy snapshots and stale metadata fall back without erasing scores" {
    foreach ($change in @(
        {param($f) $f.sources.artificialAnalysisComponents.Remove("releases")},
        {param($f) $f.sources.artificialAnalysisComponents.fetchedAtUtc="2026-01-01Z"},
        {param($f) $f.sources.artificialAnalysisComponents.status="error"}
    )) {
        $f=New-RecencyFixture;& $change $f;$s=Select-RecencyFixture $f
        Assert-True ($s.winner.model -eq "old" -and $s.valueDecision.recencyDecision.status -eq "unavailable") "Legacy/stale metadata used"
    }
    Run-Test "Previously verified release facts can use a fresh cache without refreshing their age" {
        $f=New-RecencyFixture;$f.sources.artificialAnalysisComponents.status="cached"
        Assert-True ((Select-RecencyFixture $f).winner.model -eq "new") "Immutable cached release facts discarded"
        $f.sources.artificialAnalysisComponents.fetchedAtUtc=$now.AddDays(-45).AddSeconds(-1).ToString("o")
        Assert-True ((Select-RecencyFixture $f).valueDecision.recencyDecision.status -eq "unavailable") "Expired cached release facts verified"
    }
}
Run-Test "Release changes do not change acquisition or normalized benchmark observations" {
    $row=Release-Row one "2026-07-01"
    $fetch={param($u) @{status="ok";content=(Release-Html @($row))}}
    $a=Get-AAComponentData -ModelSlugs @("one-low") -FetchText $fetch
    $row.releaseDate="2026-08-01"
    $b=Get-AAComponentData -ModelSlugs @("one-low") -FetchText $fetch
    Assert-True ($a.sourceVersion -eq $b.sourceVersion -and $a.metricVersions.lcr -eq $b.metricVersions.lcr) "Release refresh became score observation"
    $f=New-RecencyFixture;$first=Select-RecencyFixture $f
    $f.sources.artificialAnalysisComponents.releases["new-low"][0].date="2026-09-02"
    $second=Select-RecencyFixture $f
    Assert-True ($first.observation -eq $second.observation -and $first.evidenceIdentity -ne $second.evidenceIdentity) "Release correction confirmed or failed to invalidate decision"
    $state=Resolve-ProfileSelectionState -CurrentModel old -Selection $first -NowUtc $now
    $next=Resolve-ProfileSelectionState -CurrentModel old -Selection $second -State $state.state -NowUtc $now
    Assert-True (-not $next.applied -and $next.state.pending.count -eq 0) "Date-only change counted as benchmark confirmation"
}
Run-Test "Stable recency still requires two distinct observations and respects cached evidence" {
    $f=New-RecencyFixture;$s=Select-RecencyFixture $f
    $first=Resolve-ProfileSelectionState -CurrentModel old -Selection $s -NowUtc $now
    $same=Resolve-ProfileSelectionState -CurrentModel old -Selection $s -State $first.state -NowUtc $now
    Assert-True (-not $same.applied -and $same.state.pending.count -eq 1) "Recency bypassed confirmation"
    $f.sources.artificialAnalysis.models["new-low"].codingIndex=79
    $s=Select-RecencyFixture $f
    Assert-True (Resolve-ProfileSelectionState -CurrentModel old -Selection $s -State $same.state -NowUtc $now).applied "Stable recency prevented confirmation"
    $f.sources.artificialAnalysis.status="cached";$s=Select-RecencyFixture $f
    Assert-True (-not (Resolve-ProfileSelectionState -CurrentModel old -Selection $s -ForceImmediateApply -NowUtc $now).applied) "Recency bypassed cached benchmark protection"
}
Run-Test "Report explains newest selection and missing-date fallback with provenance" {
    $f=New-RecencyFixture
    foreach ($missing in @($false,$true)) {
        if ($missing) { $f.sources.artificialAnalysisComponents.Remove("releases") }
        $s=Select-RecencyFixture $f
        $r=Resolve-ProfileSelectionState -CurrentModel old -Selection $s -NowUtc $now
        $result=@{key="quick";selection=$s;resolution=$r;requirement=$f.policy.profileRequirements.quick;fallback=$null;verdicts=$f.verdicts;evidence=@{records=@()}}
        $report=(Get-ProfileReviewReportLines $result) -join "`n"
        $term=if($missing){"Recency unavailable"}else{"Newest verified release day wins"}
        Assert-True ($report.Contains($term) -and $report.Contains("not count as new confirmation observations")) "Recency decision hidden"
        if (-not $missing) { Assert-True ($report.Contains("2026-09-01") -and $report.Contains("https://artificialanalysis.ai/models/new-low")) "Missing provenance" }
    }
}
if ($script:Failed) { exit 1 }
