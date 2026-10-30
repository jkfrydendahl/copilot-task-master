Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
. (Join-Path $PSScriptRoot "model-profile-selection.ps1")
. (Join-Path $PSScriptRoot "model-review-report.ps1")
$script:Failed = 0
function Assert-True($Condition, $Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name, [scriptblock]$Action) {
    try { & $Action; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $_"; Write-Host $_.ScriptStackTrace }
}
function New-QualificationFixture($Key = "review") {
    $policy = Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
    $contract = $policy.selectionPolicy.profiles[$Key]
    $effort = $contract.configurationSelection.allowedEfforts[0]
    $profile = @{key=$Key;model="incumbent";effort=$effort;context="default"}
    $metrics = @($contract.evidenceRoutes[0]) + @($contract.qualification.dimensions | ForEach-Object { $_.evidenceRoutes[0] })
    $records = @(foreach ($model in @("cheap","strong","incumbent")) {
        foreach ($key in $metrics) {
            $definition = $policy.evidenceMetrics[$key]
            $score = 0.8 * $definition.max
            if ($key -eq $contract.evidenceRoutes[0] -and $model -eq "cheap") { $score -= 0.005 * $definition.max }
            @{
                model=$model;effort=$effort;context="default";source=$definition.source;metric=$definition.metric
                metricKey=$key;metricIdentity=$key;sourceVersion="v1";sourceDate="2026-09-22"
                score=$score;alias="$model-$effort";cached=$false;publicationAgeUnknown=$false
            }
        }
    })
    $verdicts = @(foreach ($model in @("cheap","strong","incumbent")) {
        $price = @{cheap=0.5;strong=1;incumbent=2}[$model]
        @{modelId=$model;effort=$effort;context="default";admissible=$true;reasonCodes=@();
            pricing=@{inputPerMillion=$price;outputPerMillion=5*$price}}
    })
    return @{Profile=$profile;Policy=$policy;Evidence=$records;Verdicts=$verdicts;Aliases=@{}}
}
function Set-FixtureScore($Fixture, $Model, $Metric, $Score) {
    foreach ($record in @($Fixture.Evidence | Where-Object { $_.model -eq $Model -and $_.metric -eq $Metric })) {
        $record.score = $Score
    }
}
function Use-ReasoningFallback($Fixture) {
    foreach ($record in @($Fixture.Evidence | Where-Object metric -eq "intelligenceIndex")) {
        $record.source="liveBench";$record.metric="reasoning";$record.metricKey="liveBench.reasoning"
        $record.metricIdentity="liveBench.reasoning"
    }
}
function Set-RetiredFixtureIncumbent($Fixture) {
    foreach ($verdict in $Fixture.Verdicts) {
        $verdict.lifecycle=@{status="not_listed";name=$verdict.modelId}
    }
    $incumbent=$Fixture.Verdicts | Where-Object modelId -eq incumbent
    $incumbent.admissible=$false
    $incumbent.reasonCodes=@("model_retired")
    $incumbent.lifecycle=@{
        status="retired";name="incumbent";retirementDate="2026-09-21";suggestedAlternative="strong"
        sourceUrl="https://docs.github.com/en/copilot/reference/ai-models/supported-models"
    }
}
Run-Test "All nine production contracts qualify before price selection" {
    $expected = @{
        quick="";"default-development"="instruction-following";"agentic-implementation"=""
        "deep-reasoning"="long-context";review="reasoning,long-context";"visual-ui"="visual-understanding"
        mechanical="instruction-following";orchestrator="long-context,instruction-following";triage="instruction-following"
    }
    foreach ($key in $expected.Keys) {
        $f = New-QualificationFixture $key
        Assert-True ((@($f.Policy.selectionPolicy.profiles[$key].qualification.dimensions | ForEach-Object key) -join ",") -eq $expected[$key]) "Wrong dimensions for $key"
        $s = Get-ProfileSelection @f
        Assert-True ($s.qualification.status -eq "qualified" -and $null -ne $s.winner) "No qualified selection for $key"
        Assert-True (Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s -ForceImmediateApply).applied "Qualified $key did not apply"
    }
}
Run-Test "Weak reasoning excludes a cheap coding contender from Review" {
    $f = New-QualificationFixture
    Set-FixtureScore $f cheap reasoning 50
    $s = Get-ProfileSelection @f
    Assert-True ($s.winner.model -eq "strong") "Price bypassed reasoning"
    Assert-True (-not ($s.qualification.candidates | Where-Object model -eq cheap).qualified) "Weak reviewer qualified"
}
Run-Test "One survivor can win when each comparison had multiple eligible models" {
    $f = New-QualificationFixture
    Set-FixtureScore $f cheap reasoning 50
    Set-FixtureScore $f incumbent lcr 0.5
    $s = Get-ProfileSelection @f
    Assert-True ($s.qualification.pool.Count -eq 1 -and $s.winner.model -eq "strong") "Single qualified survivor blocked"
}
Run-Test "Empty intersections retain the incumbent even with force" {
    $f = New-QualificationFixture
    Set-FixtureScore $f cheap coding 60
    Set-FixtureScore $f strong reasoning 50
    Set-FixtureScore $f incumbent reasoning 50
    $s = Get-ProfileSelection @f
    $r = Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s -ForceImmediateApply
    Assert-True ($null -eq $s.winner -and -not $r.applied -and $r.status -eq "retained_no_role_qualified_candidate") "Conflicting leaders were blended or requirements relaxed"
    $text = (Get-RoleQualificationReportLines @{selection=$s}) -join "`n"
    Assert-True ($text.Contains("not certified") -and $text.Contains("outside_quality_band")) "Retention/failures not explained"
}
Run-Test "Missing role evidence excludes that candidate without freezing valid alternatives" {
    $f = New-QualificationFixture "visual-ui"
    $f.Evidence = @($f.Evidence | Where-Object { -not ($_.model -eq "cheap" -and $_.metric -eq "mmmuPro") })
    $s = Get-ProfileSelection @f
    Assert-True ($s.winner.model -eq "strong") "Missing visual evidence was substituted or froze qualified peer"
}
Run-Test "Admissible configurations with no benchmark evidence remain visible as unqualified" {
    $f=New-QualificationFixture
    $unmeasured=$f.Verdicts[0].Clone();$unmeasured.modelId="unmeasured";$f.Verdicts+=@($unmeasured)
    $s=Get-ProfileSelection @f
    $check=@($s.qualification.candidates | Where-Object model -eq unmeasured)
    Assert-True ($check.Count -eq 1 -and -not $check[0].qualified -and
        @($check[0].checks | Where-Object status -eq "exact_configuration_evidence_missing").Count -eq 3) "Unmeasured candidate disappeared or qualified"
}
Run-Test "Quality references never shrink after another dimension excludes their leader" {
    $f = New-QualificationFixture "visual-ui"
    Set-FixtureScore $f cheap coding 70
    Set-FixtureScore $f strong mmmuPro 0.5
    Set-FixtureScore $f incumbent mmmuPro 0.5
    $s = Get-ProfileSelection @f
    Assert-True ($null -eq $s.winner -and $s.qualification.dimensions[0].reference.score -eq 80) "Filtering silently lowered the coding bar"
}
Run-Test "Role exclusions are not misreported as budget exclusions" {
    $f=New-QualificationFixture "visual-ui"
    Set-FixtureScore $f strong mmmuPro 0.5
    Set-FixtureScore $f incumbent mmmuPro 0.5
    $s=Get-ProfileSelection @f
    Assert-True ($s.winner.model -eq "cheap" -and $s.reason -eq "value_balanced_choice") "Role exclusion labelled budget-constrained"
    Assert-True ($s.valueDecision.qualityReference.score -eq 80 -and $s.valueDecision.scoreGap -eq 0.5) "Original reference/gap lost"
}
Run-Test "Sparse required comparisons cannot crown their lone observed model" {
    $f = New-QualificationFixture
    $f.Evidence = @($f.Evidence | Where-Object { $_.metric -ne "lcr" -or $_.model -eq "cheap" })
    $s = Get-ProfileSelection @f
    Assert-True ($null -eq $s.winner -and $s.reason -eq "retained_insufficient_role_evidence") "Single-model long-context coverage qualified"
    Assert-True ($s.roleDiagnostics -match "insufficient_comparison_models") "Sparse coverage hidden"
}
Run-Test "Multiple efforts of one model cannot satisfy minimum comparison coverage" {
    $f = New-QualificationFixture
    $f.Evidence = @($f.Evidence | Where-Object model -eq strong)
    $f.Verdicts = @($f.Verdicts | Where-Object modelId -eq strong)
    $copy = @($f.Evidence | ForEach-Object { $r=$_.Clone();$r.effort="high";$r })
    $v=$f.Verdicts[0].Clone();$v.effort="high"
    $f.Evidence += $copy;$f.Verdicts += $v
    Assert-True ($null -eq (Get-ProfileSelection @f).winner) "Efforts counted as independent models"
}
Run-Test "Budget-excluded configurations never set qualification floors" {
    $f = New-QualificationFixture
    ($f.Verdicts | Where-Object modelId -eq incumbent).admissible=$false
    ($f.Verdicts | Where-Object modelId -eq incumbent).reasonCodes=@("pricing_input_exceeds_ceiling")
    Set-FixtureScore $f incumbent coding 99
    Set-FixtureScore $f incumbent reasoning 99
    Set-FixtureScore $f incumbent lcr 0.99
    Assert-True ((Get-ProfileSelection @f).winner.model -eq "cheap") "Excluded model raised a required threshold"
}
Run-Test "Required fraction and index bands include their exact boundaries" {
    $f = New-QualificationFixture
    Set-FixtureScore $f cheap reasoning 77
    Set-FixtureScore $f cheap lcr 0.75
    Assert-True ((Get-ProfileSelection @f).winner.model -eq "cheap") "Boundary excluded"
    Set-FixtureScore $f cheap lcr 0.749999
    Assert-True ((Get-ProfileSelection @f).winner.model -eq "strong") "Below-boundary value admitted"
}
Run-Test "Other efforts or contexts cannot satisfy a candidate's required dimension" {
    foreach ($field in @("effort","context")) {
        $f=New-QualificationFixture
        $record=$f.Evidence | Where-Object { $_.model -eq "cheap" -and $_.metric -eq "lcr" }
        $record[$field]=if($field -eq "effort"){"high"}else{"long_context"}
        Assert-True ((Get-ProfileSelection @f).winner.model -eq "strong") "Borrowed $field evidence"
    }
}
Run-Test "Invalid required scores are missing evidence, not cheap qualification" {
    foreach ($score in @($null,"0.9",-1,1.01,[double]::NaN,[double]::PositiveInfinity)) {
        $f=New-QualificationFixture
        Set-FixtureScore $f cheap lcr $score
        Assert-True ((Get-ProfileSelection @f).winner.model -eq "strong") "Invalid score admitted"
    }
}
Run-Test "A usable required route cannot be bypassed by a better fallback result" {
    $f=New-QualificationFixture
    Set-FixtureScore $f cheap reasoning 50
    foreach ($record in @($f.Evidence | Where-Object metric -eq reasoning)) {
        $fallback=$record.Clone();$fallback.source="artificialAnalysis";$fallback.metric="intelligenceIndex"
        $fallback.metricKey="artificialAnalysis.intelligenceIndex";$fallback.metricIdentity="artificialAnalysis.intelligenceIndex";$fallback.score=99
        $f.Evidence+=@($fallback)
    }
    Assert-True ((Get-ProfileSelection @f).winner.model -eq "strong") "Cherry-picked deciding intelligence rescued failed reasoning"
}
Run-Test "Cached qualification evidence cannot authorize a fresh primary winner" {
    $f = New-QualificationFixture
    foreach ($record in @($f.Evidence | Where-Object metric -eq lcr)) { $record.cached=$true }
    $s = Get-ProfileSelection @f
    $r = Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s -ForceImmediateApply
    Assert-True ($null -ne $s.winner -and -not $r.applied -and $r.status -eq "retained_cached_evidence") "Cached gate promoted"
}
Run-Test "Incomparable qualification observations cannot be mixed" {
    $f = New-QualificationFixture
    ($f.Evidence | Where-Object { $_.metric -eq "lcr" -and $_.model -eq "cheap" }).sourceVersion="different"
    $s = Get-ProfileSelection @f
    Assert-True ($null -eq $s.winner -and $s.roleDiagnostics -match "incomparable_observations") "Mixed observations accepted"
}
Run-Test "Required-evidence changes confirm; repeated observations do not" {
    $f = New-QualificationFixture
    $s = Get-ProfileSelection @f
    $first = Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s
    $same = Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s -State $first.state
    Assert-True ($same.state.pending.count -eq 1 -and -not $same.applied) "Repeated observation counted"
    foreach ($record in @($f.Evidence | Where-Object metric -eq lcr)) { $record.sourceVersion="v2" }
    $next = Resolve-ProfileSelectionState -CurrentModel incumbent -Selection (Get-ProfileSelection @f) -State $same.state
    Assert-True ($next.applied -and $next.finalModel -eq "cheap") "Required-evidence changes ignored"
}
Run-Test "Supporting-only changes cannot confirm a Quick recommendation" {
    $f = New-QualificationFixture quick
    $support=$f.Evidence[0].Clone();$support.source="artificialAnalysisComponents";$support.metric="ifbench";$support.score=0.8
    $f.Evidence += $support
    $first=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection (Get-ProfileSelection @f)
    $support.sourceVersion="v2";$support.score=0.99
    $same=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection (Get-ProfileSelection @f) -State $first.state
    Assert-True ($same.state.pending.count -eq 1 -and -not $same.applied) "Informational evidence confirmed"
}
Run-Test "Qualification fallback needs comparable incumbent evidence" {
    $f=New-QualificationFixture
    $f.Evidence=@($f.Evidence | Where-Object { -not ($_.model -eq "incumbent" -and $_.metric -eq "reasoning") })
    $s=Get-ProfileSelection @f
    Assert-True ($s.winner.model -eq "cheap" -and -not ($s.qualification.candidates | Where-Object model -eq incumbent).qualified) "Incumbent missing reasoning froze the pool"
}
Run-Test "Changing a required route resets pending confirmation" {
    $f=New-QualificationFixture
    $first=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection (Get-ProfileSelection @f)
    foreach ($record in @($f.Evidence | Where-Object metric -eq reasoning)) { $record.sourceVersion="v2" }
    $next=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection (Get-ProfileSelection @f) -State $first.state
    Assert-True ($next.applied -and $next.finalModel -eq "cheap") "Required reasoning change ignored"
}
Run-Test "An established stronger qualification route cannot be downgraded even with force" {
    $f=New-QualificationFixture
    foreach ($v in $f.Verdicts) { $v.pricing.inputPerMillion=2;$v.pricing.outputPerMillion=10 }
    $basis=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection (Get-ProfileSelection @f)
    Assert-True ($basis.state.incumbentBasis.qualificationRoutes.reasoning -eq "liveBench.reasoning") "Basis not established"
}
Run-Test "Publication rollback on any required metric blocks force" {
    $f=New-QualificationFixture
    $first=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection (Get-ProfileSelection @f)
    foreach ($record in @($f.Evidence | Where-Object metric -eq lcr)) { $record.sourceDate="2026-09-21";$record.sourceVersion="v2" }
    $next=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection (Get-ProfileSelection @f) -State $first.state -ForceImmediateApply
    Assert-True (-not $next.applied -and $next.status -eq "retained_source_regression") "Required publication rollback forced"
}
Run-Test "Schema migration resets old single-metric counts without inventing qualification" {
    $f=New-QualificationFixture
    $s=Get-ProfileSelection @f
    $first=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s
    $first.state.schemaVersion=3;$first.state.pending.count=99
    $migrated=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s -State $first.state
    Assert-True ($migrated.state.schemaVersion -eq 4 -and $migrated.state.pending.count -eq 1 -and -not $migrated.applied) "Old counts authorized role qualification"
}
Run-Test "Failed qualification clears a pending recommendation" {
    $f=New-QualificationFixture
    $first=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection (Get-ProfileSelection @f)
    $f.Evidence=@($f.Evidence | Where-Object metric -ne lcr)
    $failed=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection (Get-ProfileSelection @f) -State $first.state
    Assert-True ($null -eq $failed.state.pending -and $failed.finalModel -eq "incumbent") "Invalid pending qualification retained"
}
Run-Test "Orchestrator workflow tolerates exactly 0.03, never more" {
    $f=New-QualificationFixture "orchestrator"
    Set-FixtureScore $f cheap automationBench 0.77
    Assert-True ((Get-ProfileSelection @f).winner.model -eq "cheap") "Exact workflow boundary rejected"
    Set-FixtureScore $f cheap automationBench 0.769999
    Assert-True ((Get-ProfileSelection @f).winner.model -ne "cheap") "Workflow tolerance widened"
}
Run-Test "Retirement immediately applies a qualified winner without incumbent comparison or confirmation" {
    $f=New-QualificationFixture
    Set-RetiredFixtureIncumbent $f
    Use-ReasoningFallback $f
    $f.Evidence=@($f.Evidence | Where-Object model -ne incumbent)
    $s=Get-ProfileSelection @f
    $state=@{schemaVersion=4;incumbentBasis=@{
        configurationId=$s.currentConfiguration.configurationId
        metricKey="liveBench.coding"
        qualificationRoutes=@{reasoning="liveBench.reasoning"}
    }}
    $r=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s -State $state
    Assert-True ($r.applied -and $r.finalModel -eq "cheap" -and $null -eq $r.state.pending) "Retirement waited or required retired-incumbent evidence"
    Assert-True ($r.status -eq "applied_retirement_qualified_replacement" -and $s.retirementRecovery.mode -eq "qualified") "Qualified repair not distinguished"
    Assert-True ($r.state.retirementRecovery.retiredModel -eq "incumbent" -and $r.state.retirementRecovery.roleQualified) "Retirement provenance lost"
}
Run-Test "Retirement uses primary value ranking before the official successor without certifying missing dimensions" {
    $f=New-QualificationFixture triage
    Set-RetiredFixtureIncumbent $f
    $f.Evidence=@($f.Evidence | Where-Object metric -eq intelligenceIndex)
    $s=Get-ProfileSelection @f
    $r=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s
    Assert-True ($r.applied -and $r.finalModel -eq "cheap" -and $r.status -eq "applied_retirement_primary_fallback") "Benchmark-led recovery did not use primary value rules"
    Assert-True ($s.retirementRecovery.mode -eq "primary_benchmark" -and -not $s.retirementRecovery.roleQualified) "Partial evidence certified"
    Assert-True ($s.qualification.status -eq "retained_insufficient_role_evidence" -and
        -not ($s.qualification.candidates | Where-Object model -eq cheap).qualified) "Normal role requirements relaxed"
    Assert-True ($null -eq (Get-ObjectMemberValue $r.state.incumbentBasis "qualificationRoutes")) "Failed dimensions became an established qualification basis"
    $text=(Get-RoleQualificationReportLines @{selection=$s}) -join "`n"
    Assert-True ($text.Contains("Emergency replacement, not certified") -and -not $text.Contains("Current configuration retained")) "Emergency migration misreported as ordinary retention"
    $f.Profile.model="cheap"
    $next=Resolve-ProfileSelectionState -CurrentModel cheap -Selection (Get-ProfileSelection @f) -State $r.state
    Assert-True (-not $next.applied -and $next.finalModel -eq "cheap" -and
        $next.state.retirementRecovery.retiredModel -eq "incumbent") "Emergency recovery repeated or lost its history"
}
Run-Test "An exact official successor repairs retirement only when benchmark ranking is unavailable" {
    $f=New-QualificationFixture triage
    Set-RetiredFixtureIncumbent $f
    $f.Evidence=@()
    $s=Get-ProfileSelection @f
    $r=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s
    Assert-True ($r.applied -and $r.finalModel -eq "strong" -and $r.status -eq "applied_retirement_official_successor") "Official successor did not recover unrankable retirement"
    Assert-True ($null -eq $s.winner -and $null -eq $r.state.incumbentBasis -and
        $s.retirementRecovery.mode -eq "official_successor" -and -not $s.retirementRecovery.roleQualified) "Successor guidance became synthetic benchmark evidence"
    Assert-True ($s.candidateReferenceAic -eq 150 -and $r.finalConfiguration.effort -eq "low") "Successor price or authorized configuration lost"
}
Run-Test "Retirement can use admissible cached primary evidence without claiming fresh qualification" {
    $f=New-QualificationFixture triage
    Set-RetiredFixtureIncumbent $f
    $f.Evidence=@($f.Evidence | Where-Object metric -eq intelligenceIndex)
    foreach ($record in $f.Evidence) { $record.cached=$true }
    $s=Get-ProfileSelection @f
    $r=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s
    Assert-True ($r.applied -and $r.finalModel -eq "cheap" -and -not $s.freshObservation -and
        $s.confidence -eq "reduced" -and -not $s.retirementRecovery.roleQualified) "Cached retirement repair was blocked or certified as fresh"
}
Run-Test "A native no-effort official successor remains a native configuration" {
    $f=New-QualificationFixture triage
    Set-RetiredFixtureIncumbent $f
    $f.Evidence=@()
    $successor=$f.Verdicts | Where-Object modelId -eq strong
    $successor.effort="none";$successor.capabilities=@{effortMode="unsupported"}
    $s=Get-ProfileSelection @f
    $r=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s
    Assert-True ($r.applied -and $r.finalConfiguration.effort -eq "none") "Native successor acquired invented effort control"
}
Run-Test "Retirement recovery never admits a hard-excluded or unauthorized successor" {
    foreach ($reason in @("pricing_input_exceeds_ceiling","pricing_output_exceeds_ceiling","not_available",
        "capabilities_stale","pricing_stale","vision_unsupported","model_retired","wrong_effort","wrong_context")) {
        $f=New-QualificationFixture triage
        Set-RetiredFixtureIncumbent $f
        $f.Evidence=@()
        ($f.Verdicts | Where-Object modelId -eq cheap).admissible=$false
        $successor=$f.Verdicts | Where-Object modelId -eq strong
        if ($reason -eq "wrong_effort") { $successor.effort="max" }
        elseif ($reason -eq "wrong_context") { $successor.context="long_context" }
        else { $successor.admissible=$false;$successor.reasonCodes=@($reason) }
        $failed=$false
        try { Get-ProfileSelection @f | Out-Null }
        catch [InvalidOperationException] { $failed=$_.Exception.Message.Contains("No admissible retirement replacement") }
        Assert-True $failed "Retirement recovery bypassed $reason or silently retained the retired model"
    }
}
Run-Test "Ambiguous and approximate successor names cannot authorize retirement migration" {
    foreach ($alternative in @("latest strong model","duplicate")) {
        $f=New-QualificationFixture triage
        Set-RetiredFixtureIncumbent $f
        $f.Evidence=@()
        ($f.Verdicts | Where-Object modelId -eq incumbent).lifecycle.suggestedAlternative=$alternative
        if ($alternative -eq "duplicate") {
            foreach ($v in @($f.Verdicts | Where-Object modelId -ne incumbent)) { $v.lifecycle.name="duplicate" }
        }
        $failed=$false
        try { Get-ProfileSelection @f | Out-Null }
        catch [InvalidOperationException] { $failed=$_.Exception.Message.Contains("No admissible retirement replacement") }
        Assert-True $failed "Ambiguous or approximate successor identity guessed"
    }
}
Run-Test "Scheduled and conditional lifecycle warnings do not activate mandatory recovery" {
    foreach ($status in @("scheduled","conditional")) {
        $f=New-QualificationFixture triage
        foreach ($v in $f.Verdicts) { $v.lifecycle=@{status=$status;retirementDate="2026-09-21"} }
        $f.Evidence=@($f.Evidence | Where-Object metric -eq intelligenceIndex)
        $s=Get-ProfileSelection @f
        $r=Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s -ForceImmediateApply
        Assert-True ($null -eq $s.retirementRecovery -and -not $r.applied -and $r.finalModel -eq "incumbent") "Non-retired incumbent received emergency migration"
    }
}
Run-Test "Retirement cannot successfully retain an incumbent after publication rollback" {
    $f=New-QualificationFixture triage
    Set-RetiredFixtureIncumbent $f
    $f.Evidence=@($f.Evidence | Where-Object metric -eq intelligenceIndex)
    $s=Get-ProfileSelection @f
    $state=@{schemaVersion=4;latestSourceDates=@{"artificialAnalysis.intelligenceIndex"="2026-09-23"}}
    $failed=$false
    try { Resolve-ProfileSelectionState -CurrentModel incumbent -Selection $s -State $state | Out-Null }
    catch [InvalidOperationException] { $failed=$_.Exception.Message.Contains("regressed") }
    Assert-True $failed "Publication rollback left a retired configuration in a successful review"
}
if ($script:Failed) { exit 1 }
