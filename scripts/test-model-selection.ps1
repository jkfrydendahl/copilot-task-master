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
    $Bands=@{"artificialAnalysis.codingIndex"=3;"liveBench.codingIndex"=3}, $MaxIncrease=0) {
    $configuredPolicy = $policy.Clone()
    $configuredPolicy.selectionPolicy = $policy.selectionPolicy.Clone()
    $configuredPolicy.selectionPolicy.profiles = @{test=@{strategy=$Strategy;qualityBands=$Bands;maxAutomaticCostIncreasePercent=$MaxIncrease}}
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
Run-Test "An unscored incumbent cannot be replaced at a premium, even with force" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.inputPerMillion = 5; $two.pricing.outputPerMillion = 25
    $current = @{key="test";model="one";effort="medium";context="default"}
    $s = Select-Models @((Record two 70)) @((Verdict),$two) $current value_balanced
    $r = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply
    Assert-True (-not $r.applied -and $r.status -eq "retained_unproven_cost_increase") "Unscored incumbent authorized a premium"
    Assert-True ($s.winner.model -eq "two" -and $null -eq $r.state.pending) "Candidate hidden or blocked observation counted"
    Assert-True ($s.valueDecision.referenceAic -eq 750 -and $s.valueDecision.incumbentReferenceAic -eq 600) "Reference AIC comparison wrong"
}
Run-Test "A premium needs fresh incumbent evidence for the same source, metric, effort and observation" {
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
        Assert-True (-not $r.applied -and $r.status -eq "retained_unproven_cost_increase") "Incomparable incumbent authorized premium"
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
Run-Test "Missing, invalid or stale incumbent pricing blocks a value decision without inventing savings" {
    $two = Verdict; $two.modelId = "two"
    $current = @{key="test";model="one";effort="medium";context="default"}
    $stale = $prices.Clone(); $stale.verifiedAtUtc = "2026-01-01"
    $invalid = @{verifiedAtUtc="2026-09-01";tiers=@{default=@{inputPerMillion="4";outputPerMillion=20}}}
    foreach ($old in @($null,(Verdict -Price $null),(Verdict -Price $stale),(Verdict -Price $invalid))) {
        $verdicts = @(@($old) | Where-Object { $null -ne $_ }) + @($two)
        $s = Select-Models @((Record two 70)) $verdicts $current value_balanced
        $r = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply
        Assert-True (-not $r.applied -and $r.status -eq "retained_incumbent_cost_unknown") "Unknown cost was treated as a saving"
        Assert-True ($null -eq $s.valueDecision.incumbentReferenceAic) "Missing price became zero"
    }
}
Run-Test "A scored incumbent outside the band allows a justified premium; no-effort models remain comparable" {
    $two = Verdict; $two.modelId = "two"; $two.pricing.outputPerMillion = 25
    $current = @{key="test";model="one";effort="medium";context="default"}
    foreach ($effortMode in @("supported", "unsupported")) {
        $old = Verdict; $old.capabilities = $cap.Clone(); $old.capabilities.effortMode = $effortMode
        $record = Record one 66.9
        if ($effortMode -eq "unsupported") { $record.effort = "none" }
        $s = Select-Models @($record,(Record two 70)) @($old,$two) $current value_balanced -MaxIncrease 25
        Assert-True (Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply).applied "Justified premium was blocked"
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
Run-Test "Zero incumbent cost is known, not missing, and prevents an unproven premium" {
    $one = Verdict; $one.pricing.inputPerMillion = 0; $one.pricing.outputPerMillion = 0
    $two = Verdict; $two.modelId = "two"
    $current = @{key="test";model="one";effort="medium";context="default"}
    $s = Select-Models @((Record two 70)) @($one,$two) $current value_balanced
    Assert-True ($s.valueDecision.incumbentReferenceAic -eq 0 -and $s.valueDecision.promotionBlockReason -eq "retained_unproven_cost_increase") "Free incumbent was treated as unpriced"
}
Run-Test "Adding Astra cannot automatically escalate a Gemini incumbent to Opus" {
    $gemini = Verdict; $gemini.modelId="gemini"; $gemini.pricing.inputPerMillion=0.75; $gemini.pricing.outputPerMillion=3.75
    $opus = Verdict; $opus.modelId="opus"; $opus.pricing.inputPerMillion=5; $opus.pricing.outputPerMillion=25
    $astra = Verdict; $astra.modelId="astra"; $astra.pricing.inputPerMillion=10; $astra.pricing.outputPerMillion=50
    $current = @{key="test";model="gemini";effort="medium";context="default"}
    $records = @((Record gemini 46.8),(Record opus 49.5),(Record astra 52.2))
    $s = Select-Models $records[0..1] @($gemini,$opus) $current value_balanced
    Assert-True ($s.winner.model -eq "gemini") "Initial cheap qualified incumbent changed"
    $state = $null
    foreach ($version in @("v1","v2","v3")) {
        foreach ($record in $records) { $record.sourceVersion=$version }
        $s = Select-Models $records @($gemini,$opus,$astra) $current value_balanced
        $r = Resolve-ProfileSelectionState -CurrentModel gemini -Selection $s -State $state -ForceImmediateApply
        Assert-True ($s.winner.model -eq "opus" -and $r.finalModel -eq "gemini" -and -not $r.applied) "Leaderboard expansion forced a 6.67x upgrade"
        Assert-True ($r.status -eq "retained_cost_escalation_requires_approval" -and $null -eq $r.state.pending) "Escalation counted as approved observation"
        Assert-True ($s.valueDecision.costIncreasePercent -gt 566 -and $s.valueDecision.maxAutomaticCostIncreasePercent -eq 0) "Missing cost escalation provenance"
        $state = $r.state
    }
}
Run-Test "Explicit cost increase allowance has an inclusive exact boundary" {
    $one = Verdict; $one.pricing.inputPerMillion=1; $one.pricing.outputPerMillion=0
    $two = Verdict; $two.modelId="two"; $two.pricing.outputPerMillion=0
    $current = @{key="test";model="one";effort="medium";context="default"}
    foreach ($limit in @(0,25)) {
        foreach ($cost in @(0.9,1,1.25,1.250001)) {
            $two.pricing.inputPerMillion=$cost
            $s = Select-Models @((Record one 60),(Record two 70)) @($one,$two) $current value_balanced -MaxIncrease $limit
            $r = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -ForceImmediateApply
            Assert-True ($r.applied -eq ($cost -le 1 + $limit / 100)) "Wrong cost boundary: $cost at $limit%"
        }
    }
}
Run-Test "A scored free incumbent cannot auto-upgrade to paid under a percentage allowance" {
    $one = Verdict; $one.pricing.inputPerMillion=0; $one.pricing.outputPerMillion=0
    $two = Verdict; $two.modelId="two"
    $current = @{key="test";model="one";effort="medium";context="default"}
    $s = Select-Models @((Record one 60),(Record two 70)) @($one,$two) $current value_balanced -MaxIncrease 25
    Assert-True ($s.valueDecision.promotionBlockReason -eq "retained_cost_escalation_requires_approval") "Free-to-paid transition bypassed guard"
    Assert-True ($null -eq $s.valueDecision.costIncreasePercent) "Undefined percentage became finite"
}
Run-Test "Cost-policy changes reset confirmation and price jumps cannot bypass it" {
    $one = Verdict; $one.pricing.inputPerMillion=1; $one.pricing.outputPerMillion=0
    $two = Verdict; $two.modelId="two"; $two.pricing.inputPerMillion=1.25; $two.pricing.outputPerMillion=0
    $current = @{key="test";model="one";effort="medium";context="default"}
    $records = @((Record one 60),(Record two 70))
    $s = Select-Models $records @($one,$two) $current value_balanced -MaxIncrease 25
    $first = Resolve-ProfileSelectionState -CurrentModel one -Selection $s
    Assert-True ($first.state.pending.count -eq 1) "Allowed premium did not start confirmation"
    $s = Select-Models $records @($one,$two) $current value_balanced -MaxIncrease 0
    $blocked = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -State $first.state -ForceImmediateApply
    Assert-True (-not $blocked.applied -and $null -eq $blocked.state.pending) "Tighter policy reused pending authorization"
    $two.pricing.inputPerMillion=1.26
    $s = Select-Models $records @($one,$two) $current value_balanced -MaxIncrease 25
    $blocked = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -State $first.state -ForceImmediateApply
    Assert-True (-not $blocked.applied -and $blocked.state.pending.count -eq 1) "Price jump bypassed guard or advanced confirmation"
    $two.pricing.inputPerMillion=1.25
    $s = Select-Models $records @($one,$two) $current value_balanced -MaxIncrease 25
    $restored = Resolve-ProfileSelectionState -CurrentModel one -Selection $s -State $blocked.state
    Assert-True (-not $restored.applied -and $restored.state.pending.count -eq 1) "Price-only recovery confirmed unchanged source"
}
if ($script:Failed) { exit 1 }
