Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-admissibility.ps1")
$script:Failed = 0
function Assert-True($Condition, $Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name, [scriptblock]$Action) {
    try { & $Action; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $_" }
}
$now = [datetime]"2026-09-08T00:00:00Z"
$cap = @{asOf="2026-09-01"; vision=$true; supportedContexts=@("default","long_context"); supportedEfforts=@("low","medium","high")}
$prices = @{verifiedAtUtc="2026-09-01"; tiers=@{default=@{inputPerMillion=4;outputPerMillion=20};long_context=@{inputPerMillion=8;outputPerMillion=30}}}
$req = @{inputCeilingPerMillion=2;outputCeilingPerMillion=10;requiresVision=$true;requiresCliAgent=$true;costSensitive=$false}
function Verdict($Requirement=$req, $Capability=$cap, $Price=$prices, $Context="default", $Verified=$true) {
    Get-ModelAdmissibilityVerdict -ModelId "one" -ProfileKey "test" -AvailabilityVerified $Verified -AvailableModels @("one") -CapabilityRecord $Capability -PricingRecord $Price -ProfileRequirement $Requirement -ProfileContextTier $Context -ProfileEffort "medium" -NowUtc $now
}
Run-Test "Hard budgets exclude; advisory budgets warn without excluding" {
    $v = Verdict
    Assert-True $v.admissible "Advisory price ceiling excluded candidate"
    Assert-True ($v.warningCodes -contains "pricing_input_exceeds_ceiling") "Missing advisory warning"
    $hard = $req.Clone(); $hard.costSensitive=$true
    Assert-True (-not (Verdict -Requirement $hard).admissible) "Hard cap bypassed"
}
Run-Test "Independent price expiry has an exact boundary" {
    $p = $prices.Clone(); $p.verifiedAtUtc=$now.AddDays(-45).ToString("o")
    Assert-True (Verdict -Price $p).admissible "45 day boundary"
    $p.verifiedAtUtc=$now.AddDays(-45).AddSeconds(-1).ToString("o")
    Assert-True ((Verdict -Price $p).reasonCodes -contains "pricing_stale") "Expired price admitted"
    Assert-True ((Verdict -Price $null).reasonCodes -contains "pricing_missing") "Missing price admitted"
}
Run-Test "Capability timestamps and required vision remain independent of pricing" {
    $before = $cap | ConvertTo-Json -Compress
    $c = $cap.Clone(); $c.asOf="2026-01-01"
    Assert-True ((Verdict -Capability $c).reasonCodes -contains "capabilities_stale") "Fresh prices refreshed capabilities"
    $c=$cap.Clone(); $c.vision=$null
    Assert-True ((Verdict -Capability $c).reasonCodes -contains "vision_unknown") "Unknown vision"
    Assert-True (($cap | ConvertTo-Json -Compress) -ceq $before) "Capability mutated"
}
Run-Test "Resolved context tier and uncached price are explicit" {
    $v=Verdict -Context "long_context"
    Assert-True ($v.pricing.inputPerMillion -eq 8 -and $v.pricing.tier -eq "long_context") "Wrong tier"
    Assert-True (-not (Verdict -Verified $false).admissible) "Unverified availability"
}
Run-Test "Invalid prices never become free models" {
    foreach ($bad in @($null, -1, [double]::NaN, [double]::PositiveInfinity, "2")) {
        $p=@{verifiedAtUtc="2026-09-01";tiers=@{default=@{inputPerMillion=$bad;outputPerMillion=10}}}
        Assert-True ((Verdict -Price $p).reasonCodes -contains "pricing_invalid") "Invalid price accepted"
    }
}
. (Join-Path $PSScriptRoot "model-profile-selection.ps1")
$policy=@{profileRequirements=@{test=$req};selectionPolicy=@{version=1;referenceInputTokens=1000000;referenceOutputTokens=100000}}
$profile=@{key="test";model="unknown-incumbent";effort="medium";context="default"}
function Record($Model, $Score, $Source="artificialAnalysis", $Version="v1") {
    [pscustomobject]@{model=$Model;score=$Score;source=$Source;metric="codingIndex";alias="$Model-medium";effort="medium";sourceVersion=$Version;sourceDate=$null;publicationAgeUnknown=$true;cached=$false}
}
function Select-Models($Records, $Verdicts=@((Verdict)), $Profile=$profile) {
    Get-ProfileSelection -Profile $Profile -Evidence $Records -Verdicts $Verdicts -Policy $policy -Aliases @{}
}
Run-Test "Scored pool can replace an unscored incumbent" {
    $r=Select-Models @((Record one 50))
    Assert-True ($r.winner.model -eq "one") "Unscored incumbent blocked challenger"
}
Run-Test "AA is primary; LB disagreement is reported not a veto" {
    $v2=Verdict; $v2.modelId="two"
    $r=Select-Models @((Record one 50),(Record two 60),(Record one 90 liveBench),(Record two 20 liveBench)) @((Verdict),$v2) @{key="test";model="one";effort="medium";context="default"}
    Assert-True ($r.winner.model -eq "two" -and $r.contested) "AA primary or disagreement lost"
}
Run-Test "Cost breaks quality ties only; exact ties prefer incumbent" {
    $v2=Verdict;$v2.modelId="two";$v2.pricing.outputPerMillion=1
    $r=Select-Models @((Record one 50),(Record two 50)) @((Verdict),$v2)
    Assert-True ($r.winner.model -eq "two") "Cost tie"
    $r=Select-Models @((Record one 51),(Record two 50)) @((Verdict),$v2)
    Assert-True ($r.winner.model -eq "one") "Cheap model displaced quality"
    $v2=Verdict;$v2.modelId="two"
    $r=Select-Models @((Record one 50),(Record two 50)) @((Verdict),$v2) @{key="test";model="two";effort="medium";context="default"}
    Assert-True ($r.winner.model -eq "two") "Equal price churn"
}
Run-Test "LB-only pool is a labelled fallback" {
    $r=Select-Models @((Record one 80 liveBench))
    Assert-True ($r.winner.model -eq "one" -and $r.reason -eq "livebench_fallback") "Fallback"
}
Run-Test "Empty pool is explicit; blocked models cannot win" {
    $bad=Verdict -Verified $false
    $r=Select-Models @((Record one 99)) @($bad)
    Assert-True ($null -eq $r.winner -and $r.reason -eq "retained_insufficient_evidence") "Unsafe promotion"
}
Run-Test "Confirmation requires distinct deciding-source observations" {
    $s=Select-Models @((Record one 50))
    $a=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s -NowUtc $now
    Assert-True ($a.finalModel -eq "old" -and $a.state.pending.count -eq 1) "Initial pending"
    $b=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s -State $a.state -NowUtc $now
    Assert-True ($b.state.pending.count -eq 1) "Repeated observation advanced"
    $s2=Select-Models @((Record one 51 artificialAnalysis v2))
    $c=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s2 -State $b.state -NowUtc $now
    Assert-True ($c.finalModel -eq "one" -and $c.applied) "New observation did not apply"
}
Run-Test "Corroborating-source churn cannot confirm a winner" {
    $a=Select-Models @((Record one 50),(Record one 80 liveBench lb1))
    $first=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $a
    $b=Select-Models @((Record one 50))
    $second=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $b -State $first.state
    Assert-True ($second.state.pending.count -eq 1 -and -not $second.applied) "LB failure confirmed unchanged AA"
}
Run-Test "Force cannot bypass no eligible candidate or cached evidence" {
    $none=Select-Models @() @()
    $r=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $none -ForceImmediateApply
    Assert-True ($r.finalModel -eq "old" -and -not $r.applied) "Empty profile/unsafe force"
    $s=Select-Models @((Record one 50));$s.freshObservation=$false
    $r=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s -ForceImmediateApply
    Assert-True (-not $r.applied) "Cached observation forced"
    $s.freshObservation=$true
    Assert-True (Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s -ForceImmediateApply).applied "Valid force blocked"
}
Run-Test "Policy migration and source switches reset pending evidence" {
    $s=Select-Models @((Record one 50))
    $a=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s
    $s.policyFingerprint="new-policy"
    $b=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s -State $a.state
    Assert-True ($b.state.pending.count -eq 1) "Policy change reused count"
    $lb=Select-Models @((Record one 80 liveBench))
    $c=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $lb -State $a.state
    Assert-True ($c.state.pending.count -eq 1) "Source switch reused count"
    $legacy=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s -State @{activeOverride=@{model="legacy"}}
    Assert-True ($legacy.finalModel -eq "old") "Legacy migration reverted model"
}
Run-Test "Older publication cannot confirm even with a new content fingerprint" {
    $s=Select-Models @((Record one 50));$s.winner.sourceDate="2026-09-02"
    $a=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s
    $s2=Select-Models @((Record one 51 artificialAnalysis v2));$s2.winner.sourceDate="2026-09-01"
    $b=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s2 -State $a.state
    Assert-True (-not $b.applied -and $b.finalModel -eq "old") "Source rollback confirmed"
}
Run-Test "Price or eligibility changes do not create a new source observation" {
    $v2=Verdict;$v2.modelId="two"
    $a=Select-Models @((Record one 70),(Record two 60)) @((Verdict),$v2)
    $first=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $a
    $b=Select-Models @((Record one 70),(Record two 60)) @((Verdict))
    $second=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $b -State $first.state
    Assert-True (-not $second.applied -and $second.state.pending.count -eq 1) "Eligibility churn confirmed unchanged source"
}
Run-Test "Corroboration requires fresh comparable candidates and agreement" {
    $one=Record one 80 liveBench; $one.publicationAgeUnknown=$false
    $aaOne=Record one 60; $aaOne.publicationAgeUnknown=$false
    $single=Select-Models @($aaOne,$one)
    Assert-True ($single.confidence -eq "reduced") "Single overlapping model is not corroboration"
    $v2=Verdict;$v2.modelId="two"
    $other=Record two 90 liveBench;$other.publicationAgeUnknown=$false
    $r=Select-Models @($aaOne,(Record two 50),$one,$other) @((Verdict),$v2)
    Assert-True ($r.contested -and $r.confidence -eq "reduced") "Non-incumbent disagreement hidden"
}
Run-Test "Temporary evidence loss freezes rather than erases confirmation" {
    $s=Select-Models @((Record one 50))
    $a=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s
    $missing=Select-Models @() @()
    $b=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $missing -State $a.state
    Assert-True ($b.state.pending.count -eq 1 -and $b.finalModel -eq "old") "Temporary outage erased pending evidence"
    $c=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s -State $b.state
    Assert-True ($c.state.pending.count -eq 1 -and -not $c.applied) "Recovery reused observation"
}
Run-Test "A bounded default price is not a price for undocumented long-context usage" {
    $p=@{verifiedAtUtc="2026-09-01";tiers=@{default=@{inputPerMillion=1;outputPerMillion=5;thresholdInputTokens=200000}}}
    Assert-True ((Verdict -Price $p -Context "long_context").reasonCodes -contains "pricing_missing") "Bounded default used for long context"
}
Run-Test "Fresh fallback can decide when primary evidence is cached" {
    $aa=Record one 90
    $aa.cached=$true
    $lb=Record two 50 "liveBench"
    $v2=Verdict; $v2.modelId="two"
    $s=Select-Models @($aa,$lb) @((Verdict),$v2)
    Assert-True ($s.winner.model -eq "two" -and $s.decidingSource -eq "liveBench" -and $s.freshObservation) "Cached primary froze fresh fallback"
}
if ($script:Failed) { exit 1 }
