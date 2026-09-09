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
function Select-Models($Records, $Verdicts=@((Verdict)), $Profile=$profile, $Strategy="quality_first",
    $Bands=@{"artificialAnalysis.codingIndex"=3;"liveBench.codingIndex"=3}, $Budget=$req) {
    $configuredPolicy = $policy.Clone()
    $configuredPolicy.profileRequirements = @{test=$Budget}
    $configuredPolicy.selectionPolicy = $policy.selectionPolicy.Clone()
    $configuredPolicy.selectionPolicy.profiles = @{test=@{strategy=$Strategy;qualityBands=$Bands}}
    Get-ProfileSelection -Profile $Profile -Evidence $Records -Verdicts $Verdicts -Policy $configuredPolicy -Aliases @{}
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
Run-Test "Incumbent-winning observations still protect against publication rollback" {
    $s=Select-Models @((Record one 50));$s.winner.sourceDate="2026-09-01"
    $first=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s
    $latest=Select-Models @((Record one 60 artificialAnalysis v5))
    $latest.winner.model="old";$latest.winner.sourceDate="2026-09-05"
    $retained=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $latest -State $first.state
    Assert-True ($null -eq $retained.state.pending -and $retained.state.latestSourceDates.artificialAnalysis -eq "2026-09-05") "Incumbent win lost latest publication"
    foreach ($day in @(2,3)) {
        $rollback=Select-Models @((Record one 55 artificialAnalysis "v$day"));$rollback.winner.sourceDate="2026-09-0$day"
        $retained=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $rollback -State $retained.state -ForceImmediateApply
        Assert-True (-not $retained.applied -and $retained.status -eq "retained_source_regression") "Older publication applied after incumbent win"
    }
}
Run-Test "Preauthorized promotions retain publication rollback protection" {
    $s=Select-Models @((Record one 50));$s.winner.sourceDate="2026-09-01"
    $first=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s
    $latest=Select-Models @((Record one 60 artificialAnalysis v5))
    $latest.winner.sourceDate="2026-09-05"
    $applied=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $latest -State $first.state -ForceImmediateApply
    Assert-True ($applied.applied -and $null -eq $applied.state.pending) "Authorized observation did not apply"
    Assert-True ($applied.state.latestSourceDates.artificialAnalysis -eq "2026-09-05") "Promotion lost publication date"
    $rollback=Select-Models @((Record one 55 artificialAnalysis v2));$rollback.winner.sourceDate="2026-09-02"
    $rejected=Resolve-ProfileSelectionState -CurrentModel "one" -Selection $rollback -State $applied.state
    Assert-True ($rejected.status -eq "retained_source_regression" -and -not $rejected.applied) "Rollback bypassed the latest promotion"
}
Run-Test "Cached or regressed incumbent wins cannot erase pending confirmation" {
    $s=Select-Models @((Record one 50));$s.winner.sourceDate="2026-09-05"
    $first=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $s
    foreach ($cached in @($true,$false)) {
        $older=Select-Models @((Record one 40 artificialAnalysis older))
        $older.winner.model="old";$older.winner.sourceDate="2026-09-01";$older.freshObservation=-not $cached
        $retained=Resolve-ProfileSelectionState -CurrentModel "old" -Selection $older -State $first.state
        Assert-True ($retained.state.pending.count -eq 1 -and $retained.state.latestSourceDates.artificialAnalysis -eq "2026-09-05") "Unusable incumbent observation mutated confirmation"
    }
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
Run-Test "Value ranking picks cheapest qualified model, including the exact band boundary" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.outputPerMillion = 1
    $three = Verdict; $three.modelId = "three"; $three.pricing.inputPerMillion = 1; $three.pricing.outputPerMillion = 1
    $current = @{key="test";model="one";effort="medium";context="default"}
    $s = Select-Models @((Record one 70),(Record two 67),(Record three 66.999)) @((Verdict),$two,$three) $current value_balanced
    Assert-True ($s.winner.model -eq "two") "Band boundary or cheapest-qualified selection failed"
    Assert-True ($s.qualityWinner.model -eq "one" -and $s.reason -eq "value_balanced_choice") "Value sacrifice was mislabeled as a budget exclusion"
    Assert-True ($s.valueDecision.scoreGap -eq 3 -and $s.valueDecision.maxScoreGap -eq 3) "Missing qualification provenance"
}
Run-Test "An equal-cost incumbent within the band stays despite a small score disadvantage" {
    $two = Verdict; $two.modelId = "two"
    $current = @{key="test";model="two";effort="medium";context="default"}
    $s = Select-Models @((Record one 70),(Record two 67)) @((Verdict),$two) $current value_balanced
    Assert-True ($s.winner.model -eq "two") "Equal-cost score noise caused churn"
}
Run-Test "Value fallback uses its own metric band rather than the primary source tolerance" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.outputPerMillion = 1
    $current = @{key="test";model="one";effort="medium";context="default"}
    $records = @((Record one 70 liveBench),(Record two 68 liveBench))
    $s = Select-Models $records @((Verdict),$two) $current value_balanced @{"artificialAnalysis.codingIndex"=1;"liveBench.codingIndex"=3}
    Assert-True ($s.winner.model -eq "two" -and $s.reason -eq "livebench_fallback") "Fallback source policy was not used"
}
Run-Test "An unscored incumbent does not veto an authorized premium" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.inputPerMillion = 5; $two.pricing.outputPerMillion = 25
    $current = @{key="test";model="one";effort="medium";context="default"}
    $s = Select-Models @((Record two 70)) @((Verdict),$two) $current value_balanced
    $r = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply
    Assert-True ($r.applied -and $r.finalModel -eq "two") "Unscored incumbent blocked an authorized candidate"
    Assert-True (-not $s.valueDecision.incumbentEvidenceAvailable -and $null -eq $s.valueDecision.incumbentScore) "Missing incumbent evidence was hidden"
    Assert-True ($s.valueDecision.referenceAic -eq 750 -and $s.valueDecision.incumbentReferenceAic -eq 600) "Reference AIC comparison wrong"
}
Run-Test "Incomparable incumbent evidence is disclosed without vetoing a qualified candidate" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.outputPerMillion = 25
    $current = @{key="test";model="one";effort="medium";context="default"}
    foreach ($mutate in @(
        { param($r) $r.source = "liveBench" },
        { param($r) $r.metric = "intelligenceIndex" },
        { param($r) $r.effort = "high" },
        { param($r) $r.cached = $true },
        { param($r) $r.sourceVersion = "older" }
    )) {
        $old = Record one 60
        & $mutate $old
        $s = Select-Models @($old,(Record two 70)) @((Verdict),$two) $current value_balanced
        $r = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply
        Assert-True ($r.applied -and -not $s.valueDecision.incumbentEvidenceAvailable) "Incomparable incumbent blocked or falsely corroborated the candidate"
    }
}
Run-Test "A cheaper qualified challenger can replace an unscored incumbent after two observations" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.outputPerMillion = 1
    $current = @{key="test";model="one";effort="medium";context="default"}
    $s = Select-Models @((Record two 70)) @((Verdict),$two) $current value_balanced
    $a = Resolve-ProfileSelectionState -CurrentModel one -Selection $s
    Assert-True ($a.state.pending.count -eq 1 -and -not $a.applied) "Cheaper candidate did not enter confirmation"
    $s = Select-Models @((Record two 71 artificialAnalysis v2)) @((Verdict),$two) $current value_balanced
    $b = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -State $a.state
    Assert-True ($b.applied -and $b.finalModel -eq "two") "Unscored incumbent froze a cheaper candidate"
    Assert-True ($s.valueDecision.incumbentReferenceAic -gt $s.valueDecision.referenceAic) "Saving was not based on incumbent prices"
}
Run-Test "Unknown incumbent prices do not block known-price candidates or invent savings" {
    $two = Verdict; $two.modelId = "two"
    $current = @{key="test";model="one";effort="medium";context="default"}
    $stale = $prices.Clone(); $stale.verifiedAtUtc = "2026-01-01"
    $invalid = @{verifiedAtUtc="2026-09-01";tiers=@{default=@{inputPerMillion="4";outputPerMillion=20}}}
    foreach ($old in @($null,(Verdict -Price $null),(Verdict -Price $stale),(Verdict -Price $invalid))) {
        $verdicts = @(@($old) | Where-Object { $null -ne $_ }) + @($two)
        $s = Select-Models @((Record two 70)) $verdicts $current value_balanced
        $r = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply
        Assert-True $r.applied "Unknown incumbent pricing blocked an authorized candidate"
        Assert-True ($null -eq $s.valueDecision.incumbentReferenceAic -and $null -eq $s.valueDecision.costIncreasePercent) "Missing price became zero or implied savings"
    }
}
Run-Test "A scored incumbent outside the band allows a justified premium; no-effort models remain comparable" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.outputPerMillion = 25
    $current = @{key="test";model="one";effort="medium";context="default"}
    foreach ($effortMode in @("supported", "unsupported")) {
        $old = Verdict; $old.capabilities = $cap.Clone(); $old.capabilities.effortMode = $effortMode
        $record = Record one 66.9
        if ($effortMode -eq "unsupported") { $record.effort = "none" }
        $s = Select-Models @($record,(Record two 70)) @($old,$two) $current value_balanced
        Assert-True (Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply).applied "Justified premium was blocked"
        Assert-True ($s.valueDecision.incumbentEvidenceAvailable -and $s.valueDecision.incumbentScore -eq 66.9) "Matched incumbent evidence lost"
    }
}
Run-Test "Value bands use the eligible leader and never undo hard-budget exclusions" {
    $hard = $req.Clone(); $hard.costSensitive = $true
    $cheap = @{verifiedAtUtc="2026-09-01";tiers=@{default=@{inputPerMillion=1;outputPerMillion=5}}}
    $one = Verdict -Requirement $hard -Price $cheap
    $two = Verdict -Requirement $hard -Price $cheap; $two.modelId = "two"; $two.pricing.outputPerMillion = 1
    $over = Verdict -Requirement $hard; $over.modelId = "over"
    $current = @{key="test";model="one";effort="medium";context="default"}
    $s = Select-Models @((Record one 70),(Record two 67),(Record over 99)) @($one,$two,$over) $current value_balanced
    Assert-True ($s.winner.model -eq "two" -and $s.qualityWinner.model -eq "over") "Hard cap or pre-budget leader lost"
    Assert-True ($s.valueDecision.qualityReference.model -eq "one" -and $s.reason -eq "budget_constrained_choice") "Ineligible leader made the value band unusable"
}
Run-Test "Zero-width bands preserve quality and missing value evidence cannot be forced" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.outputPerMillion = 1
    $current = @{key="test";model="one";effort="medium";context="default"}
    $s = Select-Models @((Record one 70),(Record two 69.999)) @((Verdict),$two) $current value_balanced @{"artificialAnalysis.codingIndex"=0}
    Assert-True ($s.winner.model -eq "one") "Zero-width band lost quality"
    $cached = Record two 80; $cached.cached = $true
    foreach ($records in @(@($cached),@())) {
        $s = Select-Models $records @((Verdict),$two) $current value_balanced
        Assert-True (-not (Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply).applied) "Force bypassed missing/fresh evidence"
    }
}
Run-Test "Strategy and tolerance changes invalidate pending confirmations" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.outputPerMillion = 1
    $current = @{key="test";model="one";effort="medium";context="default"}
    $records = @((Record two 70))
    $s = Select-Models $records @((Verdict),$two) $current
    $state = (Resolve-ProfileSelectionState -CurrentModel one -Selection $s).state
    foreach ($band in @(3,4)) {
        $s = Select-Models $records @((Verdict),$two) $current value_balanced @{"artificialAnalysis.codingIndex"=$band}
        $r = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -State $state
        Assert-True ($r.state.pending.count -eq 1 -and -not $r.applied) "Changed policy reused confirmation"
        $state = $r.state
    }
}
Run-Test "Value corroboration allows the LiveBench band, not just an exact quality leader" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.outputPerMillion = 1
    $current = @{key="test";model="one";effort="medium";context="default"}
    $records = @((Record one 70),(Record two 67),(Record one 80 liveBench),(Record two 77 liveBench))
    foreach ($record in $records) { $record.publicationAgeUnknown = $false }
    $s = Select-Models $records @((Verdict),$two) $current value_balanced
    Assert-True ($s.winner.model -eq "two" -and -not $s.contested -and $s.confidence -eq "corroborated") "Agreed value qualification was mislabeled disagreement"
    $records[3].score = 76.999
    $s = Select-Models $records @((Verdict),$two) $current value_balanced
    Assert-True ($s.contested -and $s.confidence -eq "reduced") "LiveBench qualification disagreement was hidden"
}
Run-Test "Equal monetary costs do not churn because of floating-point arithmetic" {
    $one = Verdict; $one.pricing.inputPerMillion = 0.3; $one.pricing.outputPerMillion = 6
    $two = Verdict; $two.modelId = "two"; $two.pricing.inputPerMillion = 0.8; $two.pricing.outputPerMillion = 1
    $current = @{key="test";model="two";effort="medium";context="default"}
    $s = Select-Models @((Record one 70),(Record two 67)) @($one,$two) $current value_balanced
    Assert-True ($s.winner.model -eq "two") "Equal 90-AIC prices triggered a false saving"
}
Run-Test "Zero incumbent cost is known but does not veto a preauthorized paid candidate" {
    $one = Verdict; $one.pricing.inputPerMillion = 0; $one.pricing.outputPerMillion = 0
    $two = Verdict; $two.modelId = "two"
    $current = @{key="test";model="one";effort="medium";context="default"}
    $s = Select-Models @((Record two 70)) @($one,$two) $current value_balanced
    Assert-True ($s.valueDecision.incumbentReferenceAic -eq 0 -and $null -eq $s.valueDecision.costIncreasePercent) "Free incumbent was treated as unpriced or given a defined percentage"
    Assert-True (Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply).applied "Free incumbent froze an authorized candidate"
}
Run-Test "An over-budget leader cannot inflate the eligible quality bar or force spending" {
    $gemini = Verdict; $gemini.modelId="gemini"; $gemini.pricing.inputPerMillion=0.75; $gemini.pricing.outputPerMillion=3.75
    $opus = Verdict; $opus.modelId="opus"; $opus.pricing.inputPerMillion=5; $opus.pricing.outputPerMillion=25
    $astra = Verdict; $astra.modelId="astra"; $astra.pricing.inputPerMillion=10; $astra.pricing.outputPerMillion=50
    $astra.admissible=$false; $astra.reasonCodes=@("pricing_input_exceeds_ceiling","pricing_output_exceeds_ceiling")
    $current = @{key="test";model="gemini";effort="medium";context="default"}
    $records = @((Record gemini 46.8),(Record opus 49.5),(Record astra 52.2))
    $s = Select-Models $records[0..1] @($gemini,$opus) $current value_balanced
    Assert-True ($s.winner.model -eq "gemini") "Initial cheap qualified incumbent changed"
    $s = Select-Models $records @($gemini,$opus,$astra) $current value_balanced
    $r = Resolve-ProfileSelectionState -CurrentModel gemini -Selection $s -ForceImmediateApply
    Assert-True ($s.winner.model -eq "gemini" -and -not $r.applied) "Ineligible Astra inflated the quality bar"
    Assert-True ($s.qualityWinner.model -eq "astra" -and $s.valueDecision.qualityReference.model -eq "opus") "Excluded global leader and eligible reference were conflated"
}
Run-Test "A large price increase inside the authorized budget still requires distinct observations" {
    $gemini = Verdict; $gemini.modelId="gemini"; $gemini.pricing.inputPerMillion=0.75; $gemini.pricing.outputPerMillion=3.75
    $opus = Verdict; $opus.modelId="opus"; $opus.pricing.inputPerMillion=5; $opus.pricing.outputPerMillion=25
    $astra = Verdict; $astra.modelId="astra"; $astra.pricing.inputPerMillion=10; $astra.pricing.outputPerMillion=50
    $current = @{key="test";model="gemini";effort="medium";context="default"}
    $records = @((Record gemini 46.8),(Record opus 49.5),(Record astra 52.2))
    $state=$null
    foreach ($version in @("v1","v1","v2")) {
        foreach ($record in $records) { $record.sourceVersion=$version }
        $s = Select-Models $records @($gemini,$opus,$astra) $current value_balanced
        $r = Resolve-ProfileSelectionState -CurrentModel gemini -Selection $s -State $state
        Assert-True ($s.winner.model -eq "opus" -and $r.applied -eq ($version -eq "v2")) "Authorized increase bypassed or was blocked by confirmation"
        Assert-True ($s.valueDecision.costIncreasePercent -gt 566) "Missing informational cost change"
        $state = $r.state
    }
}
Run-Test "Absolute cost ceilings have inclusive boundaries and cannot be forced" {
    $hard=$req.Clone(); $hard.costSensitive=$true; $hard.inputCeilingPerMillion=1.25; $hard.outputCeilingPerMillion=0
    $price=@{verifiedAtUtc="2026-09-01";tiers=@{default=@{inputPerMillion=1;outputPerMillion=0}}}
    $one=Verdict -Requirement $hard -Price $price
    $current = @{key="test";model="one";effort="medium";context="default"}
    foreach ($cost in @(0.9,1,1.25,1.250001)) {
        $price.tiers.default.inputPerMillion=$cost
        $two=Verdict -Requirement $hard -Price $price; $two.modelId="two"
        $s = Select-Models @((Record one 60),(Record two 70)) @($one,$two) $current value_balanced -Budget $hard
        $r = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply
        Assert-True ($r.applied -eq ($cost -le 1.25)) "Wrong absolute cost boundary: $cost"
    }
}
Run-Test "A scored free incumbent can upgrade without inventing a percentage cost change" {
    $one = Verdict; $one.pricing.inputPerMillion=0; $one.pricing.outputPerMillion=0
    $two = Verdict; $two.modelId="two"
    $current = @{key="test";model="one";effort="medium";context="default"}
    $s = Select-Models @((Record one 60),(Record two 70)) @($one,$two) $current value_balanced
    Assert-True (Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply).applied "Free-to-paid authorization was blocked"
    Assert-True ($null -eq $s.valueDecision.costIncreasePercent) "Undefined percentage became finite"
}
Run-Test "Cost-policy changes reset confirmation and price jumps cannot bypass it" {
    $hard=$req.Clone(); $hard.costSensitive=$true; $hard.inputCeilingPerMillion=1.25; $hard.outputCeilingPerMillion=0
    $price=@{verifiedAtUtc="2026-09-01";tiers=@{default=@{inputPerMillion=1.25;outputPerMillion=0}}}
    $two=Verdict -Requirement $hard -Price $price; $two.modelId="two"
    $current = @{key="test";model="one";effort="medium";context="default"}
    $records = @((Record two 70))
    $s = Select-Models $records @($two) $current value_balanced -Budget $hard
    $first = Resolve-ProfileSelectionState -CurrentModel one -Selection $s
    Assert-True ($first.state.pending.count -eq 1) "Allowed premium did not start confirmation"
    $tighter=$hard.Clone(); $tighter.inputCeilingPerMillion=1.2
    $two=Verdict -Requirement $tighter -Price $price; $two.modelId="two"
    $s = Select-Models $records @($two) $current value_balanced -Budget $tighter
    $blocked = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -State $first.state -ForceImmediateApply
    Assert-True (-not $blocked.applied -and $null -eq $blocked.state.pending) "Tighter policy reused pending authorization"
    $price.tiers.default.inputPerMillion=1.26
    $two=Verdict -Requirement $hard -Price $price; $two.modelId="two"
    $s = Select-Models $records @($two) $current value_balanced -Budget $hard
    $blocked = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -State $first.state -ForceImmediateApply
    Assert-True (-not $blocked.applied -and $blocked.state.pending.count -eq 1) "Price jump bypassed guard or advanced confirmation"
    $price.tiers.default.inputPerMillion=1.25
    $two=Verdict -Requirement $hard -Price $price; $two.modelId="two"
    $s = Select-Models $records @($two) $current value_balanced -Budget $hard
    $restored = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -State $blocked.state
    Assert-True (-not $restored.applied -and $restored.state.pending.count -eq 1) "Price-only recovery confirmed unchanged source"
}
Run-Test "Eligibility and quality ranking distinguish efforts of the same model" {
    $high=Verdict; $high | Add-Member -NotePropertyName effort -NotePropertyValue high -Force
    $high.admissible=$false; $high.reasonCodes=@("effort_unsupported")
    $xhigh=Verdict; $xhigh | Add-Member -NotePropertyName effort -NotePropertyValue xhigh -Force
    $max=Verdict; $max | Add-Member -NotePropertyName effort -NotePropertyValue max -Force
    $a=Record one 99; $a.effort="high"
    $b=Record one 70; $b.effort="xhigh"
    $c=Record one 69; $c.effort="max"
    $current=@{key="test";model="one";effort="high";context="default"}
    $s=Select-Models @($a,$b,$c) @($high,$xhigh,$max) $current
    Assert-True ($s.winner.effort -eq "xhigh" -and $s.winner.score -eq 70) "Model-only eligibility admitted a blocked effort or max was preferred blindly"
    Assert-True ($s.winner.configurationId -ne $s.currentConfiguration.configurationId) "Incumbent effort conflated with winner"
}
Run-Test "Exact configuration wins ties and LiveBench cannot corroborate another effort" {
    $high=Verdict; $high | Add-Member -NotePropertyName effort -NotePropertyValue high -Force
    $xhigh=Verdict; $xhigh | Add-Member -NotePropertyName effort -NotePropertyValue xhigh -Force
    $two=Verdict; $two.modelId="two"; $two | Add-Member -NotePropertyName effort -NotePropertyValue high -Force
    $a=Record one 70; $a.effort="high"; $a.publicationAgeUnknown=$false
    $b=Record one 70; $b.effort="xhigh"; $b.publicationAgeUnknown=$false
    $lb=Record one 80 liveBench; $lb.effort="xhigh"; $lb.publicationAgeUnknown=$false
    $other=Record two 60; $other.effort="high"; $other.publicationAgeUnknown=$false
    $lbOther=Record two 60 liveBench; $lbOther.effort="high"; $lbOther.publicationAgeUnknown=$false
    $current=@{key="test";model="one";effort="high";context="default"}
    $s=Select-Models @($b,$a,$other,$lb,$lbOther) @($high,$xhigh,$two) $current
    Assert-True ($s.winner.effort -eq "high") "Equal-score different effort displaced incumbent"
    Assert-True ($s.confidence -eq "reduced" -and -not $s.contested) "Different effort counted as corroboration"
}
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
Run-Test "Multiple effort variants of one model do not inflate independent corroboration" {
    $verdicts=@();$records=@()
    foreach ($effort in @("high","xhigh")) {
        $verdict=Verdict; $verdict | Add-Member -NotePropertyName effort -NotePropertyValue $effort -Force
        $verdicts+=@($verdict)
        foreach ($source in @("artificialAnalysis","liveBench")) {
            $record=Record one 70 $source; $record.effort=$effort; $record.publicationAgeUnknown=$false
            $records+=@($record)
        }
    }
    $s=Select-Models $records $verdicts @{key="test";model="one";effort="high";context="default"}
    Assert-True ($s.confidence -eq "reduced" -and -not $s.contested) "Two efforts of one model were treated as independent coverage"
}
function Agentic-Selection($CurrentModel="one", $CurrentEffort="high", $WinnerModel="two", $WinnerEffort="xhigh", $Version="v1") {
    $p=Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
    $current=@{key="agentic-implementation";model=$CurrentModel;effort=$CurrentEffort;context="default"}
    $old=Verdict; $old.modelId=$CurrentModel; $old | Add-Member -NotePropertyName effort -NotePropertyValue $CurrentEffort -Force
    $candidate=Verdict; $candidate.modelId=$WinnerModel; $candidate | Add-Member -NotePropertyName effort -NotePropertyValue $WinnerEffort -Force
    $a=Record $CurrentModel 60 artificialAnalysis $Version; $a.effort=$CurrentEffort
    $b=Record $WinnerModel 70 artificialAnalysis $Version; $b.effort=$WinnerEffort
    Get-ProfileSelection -Profile $current -Verdicts @($old,$candidate) -Evidence @($a,$b) -Policy $p -Aliases @{}
}
Run-Test "Preauthorized effort changes apply after confirmation or force, including within one model" {
    foreach ($model in @("one","two")) {
        foreach ($force in @($false,$true)) {
            $state=$null
            $versions=if ($force) { @("v1") } else { @("v1","v2") }
            foreach ($version in $versions) {
                $s=Agentic-Selection -WinnerModel $model -Version $version
                $r=Resolve-ProfileSelectionState -CurrentModel one -Selection $s -State $state -ForceImmediateApply:$force
                Assert-True ($r.applied -eq ($force -or $version -eq "v2")) "Effort authorization or confirmation failed"
                if ($r.applied) {
                    Assert-True ($r.finalModel -eq $model -and $r.finalConfiguration.effort -eq "xhigh") "Model-effort pair was not applied together"
                } else {
                    Assert-True ($r.finalConfiguration.effort -eq "high" -and $r.state.pending.count -eq 1) "Pending effort was applied prematurely"
                }
                Assert-True ($s.winner.model -eq $model -and $s.winner.effort -eq "xhigh") "Best recommendation hidden behind same-effort fallback"
                $state=$r.state
            }
        }
    }
}
Run-Test "Configuration state migrates model-only counts and records complete pending and active pairs" {
    $s=Agentic-Selection -WinnerEffort high
    $first=Resolve-ProfileSelectionState -CurrentModel one -Selection $s
    Assert-True ($first.state.schemaVersion -eq 2 -and $first.state.pending.effort -eq "high" -and $first.state.pending.context -eq "default") "Pending pair absent"
    $legacy=ConvertTo-CanonicalModelData $first.state
    $legacy.schemaVersion=1; $legacy.pending.count=99
    $secondSelection=Agentic-Selection -WinnerEffort high -Version v2
    $migrated=Resolve-ProfileSelectionState -CurrentModel one -Selection $secondSelection -State $legacy
    Assert-True (-not $migrated.applied -and $migrated.state.pending.count -eq 1) "Legacy model-only counts promoted a pair"
    $applied=Resolve-ProfileSelectionState -CurrentModel one -Selection $secondSelection -State $first.state
    Assert-True ($applied.applied -and $applied.finalConfiguration.model -eq "two" -and $applied.finalConfiguration.effort -eq "high") "Same-effort replacement no longer confirms"
    Assert-True ($applied.state.activeOverride.configurationId -eq $secondSelection.winner.configurationId) "Active override lost configuration identity"
}
Run-Test "Changing the candidate effort starts a new confirmation count" {
    $first=Resolve-ProfileSelectionState -CurrentModel one -Selection (Agentic-Selection -WinnerEffort high)
    $changed=Resolve-ProfileSelectionState -CurrentModel one -Selection (Agentic-Selection -Version v2) -State $first.state
    Assert-True (-not $changed.applied -and $changed.state.pending.count -eq 1 -and $changed.state.pending.effort -eq "xhigh") "Different effort reused a pending count"
    $confirmed=Resolve-ProfileSelectionState -CurrentModel one -Selection (Agentic-Selection -Version v3) -State $changed.state
    Assert-True ($confirmed.applied -and $confirmed.finalConfiguration.model -eq "two" -and $confirmed.finalConfiguration.effort -eq "xhigh") "New pair did not confirm"
}
Run-Test "Bounded selection rejects unlabelled effort rather than assuming the profile baseline" {
    $p=Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
    $profile=@{key="agentic-implementation";model="one";effort="high";context="default"}
    $verdict=Verdict; $verdict.effort="high"
    $record=Record one 70; $record.PSObject.Properties.Remove("effort")
    $threw=$false
    try { Get-ProfileSelection -Profile $profile -Verdicts @($verdict) -Evidence @($record) -Policy $p -Aliases @{} | Out-Null }
    catch { $threw=$_.Exception.Message -match "explicit effort" }
    Assert-True $threw "Unlabelled benchmark was silently treated as high"
}
Run-Test "All profiles reject out-of-range efforts and contexts even with force" {
    $p=Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
    foreach ($key in $p.selectionPolicy.profiles.Keys) {
        $range=$p.selectionPolicy.profiles[$key].configurationSelection.allowedEfforts
        $outside=@(@("max","low","high") | Where-Object {$_ -notin $range})[0]
        $current=@{key=$key;model="one";effort=$range[0];context="default"}
        $verdicts=@(); $records=@()
        foreach ($configuration in @(@("one",$range[0],"default",60),@("two",$range[-1],"default",70),
            @("outside",$outside,"default",99),@("context",$range[-1],"long_context",100))) {
            $v=Verdict; $v.modelId=$configuration[0]; $v.effort=$configuration[1]; $v.context=$configuration[2]
            $r=Record $configuration[0] $configuration[3]; $r.effort=$configuration[1]
            $r.metric="$($p.profileArtificialAnalysisMetrics[$key])Index"
            $r | Add-Member -NotePropertyName context -NotePropertyValue $configuration[2]
            $verdicts+=@($v); $records+=@($r)
        }
        $s=Get-ProfileSelection -Profile $current -Verdicts $verdicts -Evidence $records -Policy $p -Aliases @{}
        $result=Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply
        Assert-True ($result.applied -and $result.finalModel -eq "two" -and $result.finalConfiguration.effort -eq $range[-1]) "Unauthorized effort/context selected for $key"
        Assert-True ($s.qualityWinner.model -eq "two") "Unauthorized configuration set the quality reference for $key"
        $native=Verdict; $native.modelId="native"; $native.effort="none"
        $native.capabilities=$cap.Clone(); $native.capabilities.effortMode="unsupported"
        $nativeRecord=Record native 98; $nativeRecord.effort="none"
        $nativeRecord.metric="$($p.profileArtificialAnalysisMetrics[$key])Index"
        $s=Get-ProfileSelection -Profile $current -Verdicts (@($verdicts)+@($native)) -Evidence (@($records)+@($nativeRecord)) -Policy $p -Aliases @{}
        Assert-True ($s.winner.model -eq "native" -and $s.winner.effort -eq "none") "Native effort configuration was excluded for $key"
    }
}
Run-Test "Agentic bands use the 0-1 index and include the exact 0.03 boundary" {
    $p=Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
    $current=@{key="agentic-implementation";model="one";effort="high";context="default"}
    $records=@();$verdicts=@()
    foreach ($configuration in @(@("one",0.68,5),@("two",0.65,2),@("outside",0.649999,1))) {
        $r=Record $configuration[0] $configuration[1] artificialAnalysisCodingAgents
        $r.effort="high";$r.metric="codingAgentIndex";$records+=@($r)
        $v=Verdict;$v.modelId=$configuration[0];$v.effort="high";$v.pricing.inputPerMillion=$configuration[2]
        $verdicts+=@($v)
    }
    $s=Get-ProfileSelection -Profile $current -Verdicts $verdicts -Evidence $records -Policy $p -Aliases @{}
    Assert-True ($s.winner.model -eq "two" -and $s.valueDecision.maxScoreGap -eq 0.03) "Agentic tolerance used the wrong scale or boundary"
}
Run-Test "Cached evidence cannot inflate the reported fresh quality leader" {
    $old=Record one 99; $old.cached=$true
    $two=Verdict;$two.modelId="two"
    $s=Select-Models @($old,(Record two 70)) @((Verdict),$two)
    Assert-True ($s.winner.model -eq "two" -and $s.qualityWinner.model -eq "two") "Cached score was treated as the fresh quality leader"
}
if ($script:Failed) { exit 1 }
