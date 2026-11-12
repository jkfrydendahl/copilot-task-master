Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
. (Join-Path $PSScriptRoot "model-admissibility.ps1")
. (Join-Path $PSScriptRoot "model-profile-selection.ps1")
. (Join-Path $PSScriptRoot "model-review-report.ps1")
$script:Failed = 0
function Assert-True($Condition, $Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name, [scriptblock]$Action) {
    try { & $Action; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $_"; Write-Host $_.ScriptStackTrace }
}

$now = [datetime]"2026-09-22T00:00:00Z"
$policy = Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
$workloadId = $policy.selectionPolicy.measuredCost.workload
$workloadFingerprint = "fixture-workload-fingerprint"
$supportedEfforts = @("none", "minimal", "low", "medium", "high", "xhigh", "max")

function Config-Id([string]$Model, [string]$Effort) {
    (New-ModelConfiguration -Model $Model -Effort $Effort -Context "default").configurationId
}
function New-UsageEntry($Spec) {
    $usage = $Spec.usage
    $reasoning = if ($usage.ContainsKey("reasoning")) { [long]$usage.reasoning } else { 0L }
    @{
        configurationId = Config-Id $Spec.model $Spec.effort
        model = $Spec.model; effort = $Spec.effort; context = "default"; alias = "$($Spec.model)-$($Spec.effort)"
        status = "valid"; reasons = @()
        inputTokens = [long]$usage.in; outputTokens = [long]$usage.out
        answerTokens = [long]$usage.out - $reasoning; reasoningTokens = $reasoning
        workloadId = $workloadId; workloadFingerprint = $workloadFingerprint
    }
}
function New-CostFixture {
    # Specs: model, effort, in/out (USD per million), optional score (primary metric), optional usage {in,out,reasoning}
    # and per-metric score overrides. Verdicts come from the production admissibility gate, so the hard ceilings are the
    # real ones; the usage object has the shape Get-ProfileUsageEvidence produces.
    param(
        [Parameter(Mandatory)][hashtable[]]$Specs,
        [string]$Key = "quick",
        [string]$IncumbentModel = "beta",
        [string]$IncumbentEffort = "high",
        [int]$Route = 0,
        [string]$Version = "v1"
    )
    $contract = $policy.selectionPolicy.profiles[$Key]
    $primary = $contract.evidenceRoutes[$Route]
    $metrics = @($primary) + @($contract.qualification.dimensions | ForEach-Object { $_.evidenceRoutes[0] })
    $records = [System.Collections.Generic.List[object]]::new()
    $verdicts = [System.Collections.Generic.List[object]]::new()
    $entries = @{}
    foreach ($spec in $Specs) {
        $capability = @{asOf = "2026-09-20"; vision = $true; supportedContexts = @("default"); supportedEfforts = $supportedEfforts}
        $price = @{verifiedAtUtc = "2026-09-20"; tiers = @{default = @{inputPerMillion = $spec.in; outputPerMillion = $spec.out}}}
        $lifecycle = if ($spec.ContainsKey("lifecycle")) { $spec.lifecycle } else { $null }
        $verdicts.Add((Get-ModelAdmissibilityVerdict -ModelId $spec.model -ProfileKey $Key -AvailabilityVerified $true `
            -AvailableModels @($spec.model) -LifecycleRecord $lifecycle -CapabilityRecord $capability -PricingRecord $price `
            -ProfileRequirement $policy.profileRequirements[$Key] -ProfileContextTier "default" `
            -ProfileEffort $spec.effort -NowUtc $now))
        if ($spec.ContainsKey("score")) {
            foreach ($metricKey in $metrics) {
                $definition = $policy.evidenceMetrics[$metricKey]
                $score = if ($metricKey -eq $primary) { [double]$spec.score }
                    elseif ($spec.ContainsKey("scores") -and $spec.scores.ContainsKey($metricKey)) { [double]$spec.scores[$metricKey] }
                    else { 0.8 * $definition.max }
                $records.Add(@{
                    model = $spec.model; effort = $spec.effort; context = "default"; source = $definition.source
                    metric = $definition.metric; metricKey = $metricKey; metricIdentity = $metricKey
                    sourceVersion = $Version; sourceDate = "2026-09-22"; score = $score
                    alias = "$($spec.model)-$($spec.effort)"; cached = $false; publicationAgeUnknown = $false; harness = "fixture"
                })
            }
        }
        if ($spec.ContainsKey("usage")) { $entries[(Config-Id $spec.model $spec.effort)] = New-UsageEntry $spec }
    }
    return @{
        Profile = @{key = $Key; model = $IncumbentModel; effort = $IncumbentEffort; context = "default"}
        Policy = $policy
        Evidence = @($records)
        Verdicts = @($verdicts)
        Aliases = @{}
        Usage = @{enabled = $true; workload = @{id = $workloadId; fingerprint = $workloadFingerprint}; configurations = $entries}
    }
}
function Select-Cost($Fixture, [switch]$WithoutUsage) {
    $f = $Fixture.Clone()
    if ($WithoutUsage) { $f.Remove("Usage") }
    Get-ProfileSelection @f
}
function Step($Fixture, $State = $null, [switch]$Force, [switch]$WithoutUsage) {
    $selection = Select-Cost $Fixture -WithoutUsage:$WithoutUsage
    $resolution = Resolve-ProfileSelectionState -CurrentModel $Fixture.Profile.model -Selection $selection -State $State `
        -ForceImmediateApply:$Force -NowUtc $now
    [pscustomobject]@{selection = $selection; resolution = $resolution}
}
function Set-EvidenceVersion($Fixture, [string]$Version) {
    foreach ($record in $Fixture.Evidence) { $record.sourceVersion = $Version }
}
function Copy-PolicyWithMeasuredCost($MeasuredCost) {
    $copy = $policy.Clone()
    $copy.selectionPolicy = $policy.selectionPolicy.Clone()
    if ($null -eq $MeasuredCost) { $copy.selectionPolicy.Remove("measuredCost") } else { $copy.selectionPolicy.measuredCost = $MeasuredCost }
    return $copy
}

# Real AA canonical totals for GPT-6.1-Sol (see the feasibility notes): reasoning is already inside output.
$xhighUsage = @{in = 1612933044; out = 33286283; reasoning = 19088821}
$maxUsage = @{in = 1916169604; out = 63661006; reasoning = 46611559}
function New-EffortPairSpecs($Xhigh = $xhighUsage, $Max = $maxUsage) {
    @(
        @{model = "alpha"; effort = "xhigh"; score = 80; in = 1.5; out = 6; usage = $Xhigh}
        @{model = "alpha"; effort = "max"; score = 82; in = 1.5; out = 6; usage = $Max}
        @{model = "beta"; effort = "high"; score = 50; in = 1.5; out = 6}
    )
}
function New-AgreeingSpecs {
    # xhigh is cheaper than max on BOTH the fixed basket (its rate) and the measured workload (its consumption), so only
    # the cost basis and its identity differ between the two decisions.
    @(
        @{model = "alpha"; effort = "xhigh"; score = 80; in = 1; out = 4; usage = @{in = 1000000000; out = 100000000; reasoning = 60000000}}
        @{model = "alpha"; effort = "max"; score = 82; in = 1.5; out = 6; usage = @{in = 2000000000; out = 200000000; reasoning = 150000000}}
        @{model = "beta"; effort = "high"; score = 50; in = 1.5; out = 6}
    )
}
$maxId = Config-Id alpha max
$xhighId = Config-Id alpha xhigh

Run-Test "Measured monetary ties retain the incumbent with fractional and scientific-notation rates" {
    foreach ($rates in @(@{alpha=0.3;beta=0.1;betaTokens=9},@{alpha=1e-7;beta=3e-7;betaTokens=1})) {
        $f = New-CostFixture @(
            @{model="alpha";effort="high";score=80;in=$rates.alpha;out=0;usage=@{in=3;out=1}}
            @{model="beta";effort="high";score=78;in=$rates.beta;out=0;usage=@{in=$rates.betaTokens;out=1}}
        )
        $s = Select-Cost $f
        Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.winner.model -eq "beta" -and
            $s.candidateReferenceAic -eq $s.incumbentReferenceAic -and
            $s.valueDecision.costIncreasePercent -eq 0) "Equal measured costs caused churn or false savings"
    }
}
Run-Test "Same-model xhigh and max at one GitHub rate: lower measured consumption wins even when max scores higher in the band" {
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    Assert-True ($f.Usage.configurations[$maxId].answerTokens + $f.Usage.configurations[$maxId].reasoningTokens -eq $maxUsage.out -and
        $f.Usage.configurations[$xhighId].answerTokens + $f.Usage.configurations[$xhighId].reasoningTokens -eq $xhighUsage.out) "Fixture output does not include reasoning"
    $s = Select-Cost $f
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and -not $s.costBasis.fallback -and $s.costBasis.reasons.Count -eq 0 -and
        $s.costBasis.competitorCount -eq 2 -and $s.costBasis.workloadId -eq $workloadId) "Both qualified configurations had usage but the basis was not measured"
    Assert-True ($s.winner.model -eq "alpha" -and $s.winner.effort -eq "xhigh") "The lower-consumption effort did not win"
    Assert-True ($s.qualityWinner.effort -eq "max" -and $s.winner.score -lt $s.qualityWinner.score -and $s.valueDecision.scoreGap -eq 2) "Max must score higher inside the band"
    Assert-True ($s.candidateReferenceAic -eq 261911.7264d -and $s.incumbentReferenceAic -eq 325622.0442d) "Wrong GitHub-repriced AIC: $($s.candidateReferenceAic) / $($s.incumbentReferenceAic)"
    $expectedXhigh = 1612933044d * 1.5d / 1000000d + 33286283d * 6d / 1000000d
    Assert-True ($expectedXhigh -eq 2619.117264d -and $s.candidateReferenceAic -eq $expectedXhigh * 100d) "Candidate is not input and output at its own rates"
    $doubleCharged = ($expectedXhigh + 19088821d * 6d / 1000000d) * 100d
    Assert-True ($s.candidateReferenceAic -ne $doubleCharged) "Reasoning tokens were charged on top of the output tokens that already contain them"
    $expectedChange = (261911.7264d - 325622.0442d) / 325622.0442d * 100d
    Assert-True ($s.valueDecision.costIncreasePercent -eq $expectedChange -and $s.valueDecision.costIncreasePercent -lt 0) "Savings were not computed between measured costs"
    $control = Select-Cost $f -WithoutUsage
    Assert-True ($control.costBasis.mode -eq "fixed_basket" -and $control.costBasis.reasons -contains "usage_unavailable" -and
        $control.winner.effort -eq "max" -and $control.candidateReferenceAic -eq 210) "Without usage the fixed basket should tie on rate and keep the incumbent"
}
Run-Test "The measured effort decision is confirmed, forced and written as a complete configuration" {
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    $first = Step $f
    Assert-True (-not $first.resolution.applied -and $first.resolution.state.pending.count -eq 1 -and
        $first.resolution.state.pending.effort -eq "xhigh") "A single observation applied or lost the candidate"
    $same = Step $f -State $first.resolution.state
    Assert-True (-not $same.resolution.applied -and $same.resolution.state.pending.count -eq 1) "A repeated observation advanced confirmation"
    $forced = Step $f -State $same.resolution.state -Force
    Assert-True ($forced.resolution.applied -and $forced.resolution.finalConfiguration.model -eq "alpha" -and
        $forced.resolution.finalConfiguration.effort -eq "xhigh" -and $forced.resolution.finalConfiguration.context -eq "default") "Approved force lost the model/effort/context"
    Set-EvidenceVersion $f "v2"
    $confirmed = Step $f -State $same.resolution.state
    Assert-True ($confirmed.resolution.applied -and $confirmed.resolution.finalConfiguration.effort -eq "xhigh") "A distinct observation did not confirm the measured decision"
}
Run-Test "Measured consumption has no effort preference: the higher effort wins when it consumes less, ties keep the existing order" {
    $swapped = New-CostFixture (New-EffortPairSpecs $maxUsage $xhighUsage) -IncumbentModel alpha -IncumbentEffort xhigh
    $s = Select-Cost $swapped
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.winner.effort -eq "max" -and $s.candidateReferenceAic -eq 261911.7264d) "Higher effort was penalized for being higher effort"
    $equal = @{in = 1000000000; out = 100000000; reasoning = 40000000}
    $f = New-CostFixture (New-EffortPairSpecs $equal $equal) -IncumbentModel alpha -IncumbentEffort xhigh
    $s = Select-Cost $f
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.winner.effort -eq "xhigh") "Equal measured cost abandoned the incumbent configuration"
    $f = New-CostFixture (New-EffortPairSpecs $equal $equal) -IncumbentModel alpha -IncumbentEffort max
    Assert-True ((Select-Cost $f).winner.effort -eq "max") "Equal measured cost did not keep the incumbent"
    $f = New-CostFixture (New-EffortPairSpecs $equal $equal) -IncumbentModel beta -IncumbentEffort high
    Assert-True ((Select-Cost $f).winner.effort -eq "max") "Equal cost without an incumbent did not fall back to the primary score"
}
Run-Test "Measured cost reprices each configuration's own token totals at its own GitHub rates" {
    $specs = @(
        @{model = "alpha"; effort = "xhigh"; score = 80; in = 1.5; out = 6; usage = @{in = 1000000000; out = 100000000; reasoning = 60000000}}
        @{model = "gamma"; effort = "high"; score = 79; in = 1; out = 2; usage = @{in = 1500000000; out = 200000000; reasoning = 150000000}}
    )
    $s = Select-Cost (New-CostFixture $specs -IncumbentModel alpha -IncumbentEffort xhigh)
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.winner.model -eq "gamma" -and $s.winner.effort -eq "high") "Fewer tokens at a higher rate beat the cheaper repriced configuration"
    Assert-True ($s.candidateReferenceAic -eq 190000d -and $s.incumbentReferenceAic -eq 210000d) "Wrong repricing: $($s.candidateReferenceAic) / $($s.incumbentReferenceAic)"
    Assert-True ($s.valueDecision.costIncreasePercent -lt 0) "Measured savings were not reported"
}
Run-Test "A qualified configuration with unusable usage sends the ENTIRE profile to the fixed basket, with explicit reasons and no mixing" {
    $cases = @(
        @{name = "missing row"; reason = "usage_missing"; mutate = { param($u, $id) $u.configurations.Remove($id) }}
        @{name = "cached source"; reason = "usage_source_cached"; invalid = $true}
        @{name = "stale source"; reason = "usage_source_stale"; invalid = $true}
        @{name = "unavailable source"; reason = "usage_source_unavailable"; invalid = $true}
        @{name = "conflicting rows"; reason = "usage_conflicting"; invalid = $true}
        @{name = "ambiguous identity"; reason = "usage_identity_unverified"; invalid = $true}
        @{name = "unmapped alias"; reason = "usage_alias_not_configured"; invalid = $true}
        @{name = "shared alias"; reason = "usage_alias_ambiguous"; invalid = $true}
        @{name = "invalid counts"; reason = "usage_counts_invalid"; invalid = $true}
        @{name = "parser workload mismatch"; reason = "usage_workload_mismatch"; invalid = $true}
        @{name = "invalid without a reason"; reason = "usage_invalid"; mutate = { param($u, $id) $u.configurations[$id].status = "invalid"; $u.configurations[$id].reasons = @() }}
        @{name = "entry workload id"; reason = "usage_workload_mismatch"; mutate = { param($u, $id) $u.configurations[$id].workloadId = "another-workload" }}
        @{name = "entry workload fingerprint"; reason = "usage_workload_mismatch"; mutate = { param($u, $id) $u.configurations[$id].workloadFingerprint = "another" }}
        @{name = "NaN input"; reason = "usage_counts_invalid"; mutate = { param($u, $id) $u.configurations[$id].inputTokens = [double]::NaN }}
        @{name = "infinite input"; reason = "usage_counts_invalid"; mutate = { param($u, $id) $u.configurations[$id].inputTokens = [double]::PositiveInfinity }}
        @{name = "negative input"; reason = "usage_counts_invalid"; mutate = { param($u, $id) $u.configurations[$id].inputTokens = -5 }}
        @{name = "zero input"; reason = "usage_counts_invalid"; mutate = { param($u, $id) $u.configurations[$id].inputTokens = 0 }}
        @{name = "fractional output"; reason = "usage_counts_invalid"; mutate = { param($u, $id) $u.configurations[$id].outputTokens = 1.5 }}
        @{name = "negative output"; reason = "usage_counts_invalid"; mutate = { param($u, $id) $u.configurations[$id].outputTokens = -1 }}
        @{name = "text output"; reason = "usage_counts_invalid"; mutate = { param($u, $id) $u.configurations[$id].outputTokens = "100" }}
        @{name = "null output"; reason = "usage_counts_invalid"; mutate = { param($u, $id) $u.configurations[$id].outputTokens = $null }}
    )
    $baseline = Select-Cost (New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max) -WithoutUsage
    foreach ($targetId in @($maxId, $xhighId)) {
        foreach ($case in $cases) {
            $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
            if ($case.ContainsKey("invalid")) {
                $f.Usage.configurations[$targetId].status = "invalid"
                $f.Usage.configurations[$targetId].reasons = @($case.reason)
                $f.Usage.configurations[$targetId].inputTokens = $null
                $f.Usage.configurations[$targetId].outputTokens = $null
            } else { & $case.mutate $f.Usage $targetId }
            $s = Select-Cost $f
            $label = "$($case.name) on $targetId"
            Assert-True ($s.costBasis.mode -eq "fixed_basket" -and $s.costBasis.fallback -and $s.costBasis.reasons -contains $case.reason) "${label}: expected a fixed fallback for $($case.reason), got '$($s.costBasis.mode)' [$($s.costBasis.reasons -join ',')]"
            Assert-True ($s.costBasis.unavailable.Count -eq 1 -and $s.costBasis.unavailable[0].configurationId -eq $targetId -and
                $s.costBasis.unavailable[0].reasons -contains $case.reason) "${label}: the unusable configuration was not named"
            Assert-True ($s.costBasis.costs.Count -eq 0 -and $null -eq $s.costBasis.identity) "${label}: measured costs survived the fallback"
            Assert-True ($s.winner.effort -eq "max" -and $s.valueDecision.costBasis.mode -eq "fixed_basket") "${label}: the valid configuration decided alone, or the value decision kept a measured basis"
            Assert-True ($s.candidateReferenceAic -eq 210 -and $s.incumbentReferenceAic -eq 210) "${label}: fixed and measured dollars were mixed"
            Assert-True ($s.evidenceIdentity -eq $baseline.evidenceIdentity) "${label}: a fixed decision's identity changed with unusable usage"
        }
    }
}
Run-Test "Missing, disabled or workload-less usage objects fall back for the whole profile" {
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    $variants = @(
        @{name = "no usage"; reason = "usage_unavailable"; mutate = { param($x) $x.Usage = $null }}
        @{name = "disabled"; reason = "usage_unavailable"; mutate = { param($x) $x.Usage.enabled = $false }}
        @{name = "no table"; reason = "usage_unavailable"; mutate = { param($x) $x.Usage.configurations = $null }}
        @{name = "blank fingerprint"; reason = "usage_workload_mismatch"; mutate = { param($x) $x.Usage.workload.fingerprint = " " }}
        @{name = "missing fingerprint"; reason = "usage_workload_mismatch"; mutate = { param($x) $x.Usage.workload = @{id = $workloadId} }}
    )
    foreach ($variant in $variants) {
        $copy = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
        & $variant.mutate $copy
        $s = Select-Cost $copy
        Assert-True ($s.costBasis.mode -eq "fixed_basket" -and $s.costBasis.fallback -and $s.costBasis.reasons -contains $variant.reason -and
            $s.candidateReferenceAic -eq 210) "$($variant.name): did not fall back with $($variant.reason)"
    }
}
Run-Test "Unqualified or hard-excluded configurations cannot disable, enter or win the measured ranking" {
    foreach ($ceiling in @(@{in = 3; out = 6; code = "pricing_input_exceeds_ceiling"}, @{in = 1; out = 11; code = "pricing_output_exceeds_ceiling"})) {
        foreach ($withUsage in @($true, $false)) {
            $specs = @(New-EffortPairSpecs) + @(
                @{model = "delta"; effort = "high"; score = 95; in = $ceiling.in; out = $ceiling.out}
            )
            if ($withUsage) { $specs[3].usage = @{in = 1000; out = 1000; reasoning = 100} }
            $f = New-CostFixture $specs -IncumbentModel alpha -IncumbentEffort max
            $delta = $f.Verdicts | Where-Object modelId -eq delta
            Assert-True (-not $delta.admissible -and $delta.reasonCodes -contains $ceiling.code) "Fixture did not exceed the hard ceiling"
            $s = Select-Cost $f
            Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.costBasis.competitorCount -eq 2) "A hard-excluded configuration changed the measured pool"
            Assert-True ($s.winner.model -eq "alpha" -and $s.winner.effort -eq "xhigh" -and $s.qualityWinner.model -eq "delta") "The hard ceiling was bypassed by a cheaper or better configuration"
            $forced = Resolve-ProfileSelectionState -CurrentModel alpha -Selection $s -ForceImmediateApply -NowUtc $now
            Assert-True ($forced.applied -and $forced.finalConfiguration.model -eq "alpha") "Force chose outside the hard ceiling"
        }
    }
    $specs = New-EffortPairSpecs
    $specs[2].usage = @{in = 1000; out = 1000; reasoning = 0}
    $s = Select-Cost (New-CostFixture $specs -IncumbentModel alpha -IncumbentEffort max)
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.winner.model -eq "alpha" -and $s.costBasis.competitorCount -eq 2) "A tiny-consumption configuration outside the band won on cost"
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    $f.Usage.configurations[(Config-Id beta high)] = @{status = "invalid"; reasons = @("usage_source_cached")}
    $s = Select-Cost $f
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.costBasis.unavailable.Count -eq 0 -and $s.winner.effort -eq "xhigh") "An unqualified configuration's unusable usage disabled measured ranking"
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    $edge = $f.Evidence | Where-Object { $_.model -eq "alpha" -and $_.effort -eq "xhigh" }
    $edge.score = 79
    $s = Select-Cost $f
    Assert-True ($s.costBasis.competitorCount -eq 2 -and $s.winner.effort -eq "xhigh") "The exact 3-point band boundary was rejected"
    $edge.score = 78.999999
    $s = Select-Cost $f
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.costBasis.competitorCount -eq 1 -and $s.winner.effort -eq "max") "Lower cost widened the quality band"
}
Run-Test "Without a role-qualification contract the cost basis still covers only the value band, not every ranked configuration" {
    # Legacy in-memory contracts have no qualification block, so the ranked pool can contain configurations outside the
    # quality band. They are never competitors: their missing usage must not disable measured ranking.
    $legacy = $policy.Clone()
    $legacy.selectionPolicy = $policy.selectionPolicy.Clone()
    $legacy.selectionPolicy.profiles = $policy.selectionPolicy.profiles.Clone()
    $quick = $policy.selectionPolicy.profiles.quick.Clone()
    $quick.Remove("qualification")
    $legacy.selectionPolicy.profiles.quick = $quick
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    $f.Policy = $legacy
    $s = Select-Cost $f
    Assert-True (-not $s.qualification.enabled -and @($s.qualification.pool).Count -eq 3 -and $s.costBasis.mode -eq "measured_workload" -and
        $s.costBasis.competitorCount -eq 2 -and $s.costBasis.unavailable.Count -eq 0) "An out-of-band ranked configuration without usage disabled measured ranking"
    Assert-True ($s.winner.model -eq "alpha" -and $s.winner.effort -eq "xhigh" -and $s.candidateReferenceAic -eq 261911.7264d) "The legacy contract did not rank the value band on measured cost"
    $inBand = New-CostFixture (@(New-EffortPairSpecs) + @(@{model = "gamma"; effort = "high"; score = 79.5; in = 1; out = 4})) -IncumbentModel alpha -IncumbentEffort max
    $inBand.Policy = $legacy
    $s = Select-Cost $inBand
    Assert-True ($s.costBasis.mode -eq "fixed_basket" -and $s.costBasis.fallback -and $s.costBasis.reasons -contains "usage_missing" -and
        $s.costBasis.unavailable.Count -eq 1 -and $s.costBasis.unavailable[0].model -eq "gamma") "An in-band configuration without usage did not trigger the whole-profile fallback"
}
Run-Test "A qualified configuration without usage is never dropped to improve coverage" {
    $specs = @(New-EffortPairSpecs) + @(@{model = "gamma"; effort = "high"; score = 81; in = 1; out = 4})
    $f = New-CostFixture $specs -IncumbentModel alpha -IncumbentEffort max
    $s = Select-Cost $f
    Assert-True ($s.costBasis.mode -eq "fixed_basket" -and $s.costBasis.fallback -and $s.costBasis.reasons -contains "usage_missing" -and
        $s.costBasis.unavailable.Count -eq 1 -and $s.costBasis.unavailable[0].model -eq "gamma" -and $s.costBasis.competitorCount -eq 3) "The qualified configuration was ignored or not named"
    Assert-True ($s.winner.model -eq "gamma" -and $s.candidateReferenceAic -eq 140 -and $s.incumbentReferenceAic -eq 210) "The fixed basket did not rank the full qualified pool"
}
Run-Test "An incumbent without measured usage has unknown cost and savings, never fixed-basket dollars" {
    $specs = @(New-EffortPairSpecs) + @(@{model = "old"; effort = "high"; in = 1.5; out = 6})
    $f = New-CostFixture $specs -IncumbentModel old -IncumbentEffort high
    $s = Select-Cost $f
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.winner.effort -eq "xhigh" -and $s.candidateReferenceAic -eq 261911.7264d) "Competitors were not ranked on measured cost"
    Assert-True ($null -eq $s.incumbentReferenceAic -and $null -eq $s.valueDecision.incumbentReferenceAic -and $null -eq $s.valueDecision.costIncreasePercent) "A measured candidate was compared with the fixed-basket incumbent"
    $first = Step $f
    Assert-True (-not $first.resolution.applied -and $first.resolution.state.pending.count -eq 1) "An unscored incumbent was replaced without confirmation"
    $same = Step $f -State $first.resolution.state
    Assert-True (-not $same.resolution.applied -and $same.resolution.state.pending.count -eq 1) "Repeating one observation confirmed the replacement"
    Set-EvidenceVersion $f "v2"
    Assert-True (Step $f -State $same.resolution.state).resolution.applied "A distinct observation did not replace the unscored incumbent"
    Set-EvidenceVersion $f "v1"
    Assert-True (Step $f -State $same.resolution.state -Force).resolution.applied "Approved force did not replace the unscored incumbent"
    $report = (Get-ProfileReviewReportLines @{
        key = "quick"; selection = $s; resolution = (Step $f).resolution; requirement = $policy.profileRequirements.quick; fallback = $null
        verdicts = $f.Verdicts; evidence = @{records = $f.Evidence}
    }) -join "`n"
    Assert-True ($report.Contains("**Cost comparison unavailable:**") -and $report.Contains("measured costs are never compared with fixed-basket costs") -and
        $report.Contains("**Cost basis: measured benchmark workload**")) "The report did not explain the unknown incumbent comparison"
    $withUsage = @(New-EffortPairSpecs) + @(@{model = "old"; effort = "high"; in = 1.5; out = 6; usage = @{in = 3000000000; out = 300000000; reasoning = 100000000}})
    $s = Select-Cost (New-CostFixture $withUsage -IncumbentModel old -IncumbentEffort high)
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.incumbentReferenceAic -eq 630000d -and $s.valueDecision.costIncreasePercent -lt 0) "A measured incumbent was not compared on the same basis"
}
Run-Test "Every role-qualification dimension and primary band stays binding against cheaper measured configurations" {
    $lcr = "artificialAnalysisComponents.lcr"
    $specs = @(
        @{model = "strong"; effort = "xhigh"; score = 80; in = 1.5; out = 6; usage = $xhighUsage}
        @{model = "strong"; effort = "max"; score = 82; in = 1.5; out = 6; usage = $maxUsage}
        @{model = "lean"; effort = "max"; score = 80; in = 0.5; out = 2.5; scores = @{$lcr = 0.5}; usage = @{in = 1000000000; out = 10000000; reasoning = 1000000}}
        @{model = "thin"; effort = "max"; score = 60; in = 0.5; out = 2.5; usage = @{in = 1000000; out = 100000; reasoning = 10000}}
    )
    $f = New-CostFixture $specs -Key review -IncumbentModel strong -IncumbentEffort max
    $s = Select-Cost $f
    $lean = $s.qualification.candidates | Where-Object model -eq lean
    $thin = $s.qualification.candidates | Where-Object model -eq thin
    Assert-True (-not $lean.qualified -and ($lean.checks | Where-Object dimension -eq "long-context").status -eq "outside_quality_band") "The long-context dimension was bypassed"
    Assert-True (-not $thin.qualified -and ($thin.checks | Where-Object dimension -eq "primary").status -eq "outside_quality_band") "The primary quality band was bypassed"
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.costBasis.competitorCount -eq 2 -and $s.winner.model -eq "strong" -and $s.winner.effort -eq "xhigh") "A cheaper unqualified configuration, or the wrong effort, won"
    $forced = Resolve-ProfileSelectionState -CurrentModel strong -Selection $s -ForceImmediateApply -NowUtc $now
    Assert-True ($forced.applied -and $forced.finalConfiguration.model -eq "strong" -and $forced.finalConfiguration.effort -eq "xhigh") "Force reached an unqualified configuration"
    foreach ($model in @("lean", "thin")) { $f.Usage.configurations.Remove((Config-Id $model max)) }
    $s = Select-Cost $f
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and $s.costBasis.unavailable.Count -eq 0 -and $s.winner.effort -eq "xhigh") "Unqualified configurations without usage disabled the measured basis"
}
Run-Test "A stronger incumbent basis stays binding, even with force, when measured cost prefers the challenger" {
    $favoursMax = New-CostFixture (New-EffortPairSpecs $maxUsage $xhighUsage) -IncumbentModel alpha -IncumbentEffort max
    $established = Step $favoursMax
    Assert-True ($established.selection.winner.effort -eq "max" -and $established.resolution.state.incumbentBasis.metricKey -eq "liveBench.coding") "The stronger incumbent basis was not established"
    $fallbackRoute = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max -Route 1
    $s = Select-Cost $fallbackRoute
    Assert-True ($s.routeIndex -eq 1 -and $s.costBasis.mode -eq "measured_workload" -and $s.winner.effort -eq "xhigh") "The weaker route did not prefer the cheaper configuration"
    foreach ($force in @($false, $true)) {
        $blocked = Resolve-ProfileSelectionState -CurrentModel alpha -Selection $s -State $established.resolution.state `
            -ForceImmediateApply:$force -NowUtc $now
        Assert-True (-not $blocked.applied -and $blocked.status -eq "retained_stronger_incumbent_basis" -and $blocked.finalConfiguration.effort -eq "max") "Measured cost bypassed the stronger incumbent basis (force=$force)"
    }
}
Run-Test "Cached benchmark evidence still cannot be forced when the cost basis is measured" {
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    foreach ($record in $f.Evidence) { $record.cached = $true }
    $s = Select-Cost $f
    $r = Resolve-ProfileSelectionState -CurrentModel alpha -Selection $s -ForceImmediateApply -NowUtc $now
    Assert-True ($s.costBasis.mode -eq "measured_workload" -and -not $r.applied -and $r.status -eq "retained_cached_evidence") "Measured cost made cached evidence promotable"
}
Run-Test "Fixed-to-measured and usage-only changes cannot authorize a different cost decision or manufacture observations" {
    $f = New-CostFixture (New-AgreeingSpecs)
    $fixed = Step $f -WithoutUsage
    Assert-True ($fixed.selection.costBasis.mode -eq "fixed_basket" -and $fixed.selection.winner.effort -eq "xhigh" -and
        $fixed.resolution.state.pending.count -eq 1) "Fixture did not start with a fixed-basket pending decision"
    $measured = Step $f -State $fixed.resolution.state
    Assert-True ($measured.selection.costBasis.mode -eq "measured_workload" -and $measured.selection.winner.effort -eq "xhigh" -and
        $measured.selection.observation -eq $fixed.selection.observation) "Fixture should change only the cost basis"
    Assert-True ($measured.selection.evidenceIdentity -ne $fixed.selection.evidenceIdentity -and
        $measured.selection.policyFingerprint -eq $fixed.selection.policyFingerprint) "Measured and fixed decisions share an identity"
    Assert-True (-not $measured.resolution.applied -and $measured.resolution.state.pending.count -eq 0 -and
        $measured.resolution.state.pending.evidenceIdentity -eq $measured.selection.evidenceIdentity) "A fixed-basket pending count authorized a measured decision"
    $again = Step $f -State $measured.resolution.state
    Assert-True (-not $again.resolution.applied -and $again.resolution.state.pending.count -eq 0) "Retrieving the same measured usage again manufactured an observation"
    $forced = Step $f -State $measured.resolution.state -Force
    Assert-True ($forced.resolution.applied -and $forced.resolution.finalConfiguration.effort -eq "xhigh") "Approved force was blocked by a cost-only identity change"
    Set-EvidenceVersion $f "v2"
    $second = Step $f -State $again.resolution.state
    Assert-True (-not $second.resolution.applied -and $second.resolution.state.pending.count -eq 1) "A distinct observation did not restart confirmation after the cost change"
    $f.Usage.configurations[$xhighId].inputTokens = 1000000001
    $changed = Step $f -State $second.resolution.state
    Assert-True ($changed.selection.observation -eq $second.selection.observation -and
        $changed.selection.evidenceIdentity -ne $second.selection.evidenceIdentity -and -not $changed.resolution.applied -and
        $changed.resolution.state.pending.count -eq 0) "A usage-only change reused old pending evidence or created an observation"
    Set-EvidenceVersion $f "v3"
    $third = Step $f -State $changed.resolution.state
    Assert-True (-not $third.resolution.applied -and $third.resolution.state.pending.count -eq 1) "Confirmation did not restart after the usage change"
    Set-EvidenceVersion $f "v4"
    Assert-True (Step $f -State $third.resolution.state).resolution.applied "Two distinct observations on the new usage did not confirm"
}
Run-Test "Measured identities are deterministic, timestamp-free and appear only in measured decisions" {
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    $a = Select-Cost $f
    $reordered = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    $entries = @{}
    foreach ($id in @($reordered.Usage.configurations.Keys | Sort-Object -Descending)) { $entries[$id] = $reordered.Usage.configurations[$id] }
    $reordered.Usage.configurations = $entries
    $b = Select-Cost $reordered
    Assert-True ($a.costBasis.identity -eq $b.costBasis.identity -and $a.evidenceIdentity -eq $b.evidenceIdentity) "The measured identity depends on retrieval or dictionary order"
    Assert-True ($a.costBasis.identity -notmatch "20\d\d-\d\d-\d\d") "The measured identity contains a timestamp"
    $fixedPolicy = Copy-PolicyWithMeasuredCost $null
    $withoutPolicy = Get-ProfileSelection -Profile $f.Profile -Evidence $f.Evidence -Verdicts $f.Verdicts -Policy $fixedPolicy -Aliases @{} -Usage $f.Usage
    $fallback = Select-Cost $f -WithoutUsage
    Assert-True ($withoutPolicy.costBasis.reasons -contains "measured_cost_disabled" -and -not $withoutPolicy.costBasis.fallback -and
        $withoutPolicy.evidenceIdentity -eq $fallback.evidenceIdentity -and $withoutPolicy.policyFingerprint -ne $fallback.policyFingerprint) "Fixed-basket identities changed"
    Assert-True ($a.evidenceIdentity -ne $fallback.evidenceIdentity) "Measured decisions share the fixed identity"
    Assert-True ($withoutPolicy.winner.effort -eq "max" -and $withoutPolicy.candidateReferenceAic -eq 210) "A policy without measuredCost no longer uses the fixed basket"
}
Run-Test "Changing the measured-cost policy resets pending confirmation" {
    $f = New-CostFixture (New-AgreeingSpecs)
    $first = Step $f
    Assert-True ($first.selection.costBasis.mode -eq "measured_workload" -and $first.resolution.state.pending.count -eq 1) "No pending measured decision to reset"
    Set-EvidenceVersion $f "v2"
    $control = Step $f -State $first.resolution.state
    Assert-True ($control.resolution.applied -and $control.resolution.finalConfiguration.effort -eq "xhigh") "Control: a distinct observation under the same policy should confirm"
    $variants = @(
        (Copy-PolicyWithMeasuredCost @{enabled = $false; workload = $workloadId; missingUsagePolicy = "profile_fallback"; description = "off"}),
        (Copy-PolicyWithMeasuredCost @{enabled = $true; workload = "another-workload"; missingUsagePolicy = "profile_fallback"; description = "other"}),
        (Copy-PolicyWithMeasuredCost $null)
    )
    foreach ($variant in $variants) {
        $s = Get-ProfileSelection -Profile $f.Profile -Evidence $f.Evidence -Verdicts $f.Verdicts -Policy $variant -Aliases @{} -Usage $f.Usage
        Assert-True ($s.winner.effort -eq "xhigh" -and $s.policyFingerprint -ne $first.selection.policyFingerprint) "The policy change did not change the fingerprint"
        $r = Resolve-ProfileSelectionState -CurrentModel alpha -Selection $s -State $first.resolution.state -NowUtc $now
        Assert-True (-not $r.applied -and $r.state.pending.count -eq 1) "Old pending evidence authorized a decision under a different measured-cost policy"
    }
}
Run-Test "Quality-first profiles and disabled policies never consult usage" {
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    $qualityFirst = $policy.Clone()
    $qualityFirst.selectionPolicy = $policy.selectionPolicy.Clone()
    $qualityFirst.selectionPolicy.profiles = $policy.selectionPolicy.profiles.Clone()
    $qualityFirst.selectionPolicy.profiles.quick = $policy.selectionPolicy.profiles.quick.Clone()
    $qualityFirst.selectionPolicy.profiles.quick.strategy = "quality_first"
    $s = Get-ProfileSelection -Profile $f.Profile -Evidence $f.Evidence -Verdicts $f.Verdicts -Policy $qualityFirst -Aliases @{} -Usage $f.Usage
    Assert-True ($s.costBasis.mode -eq "fixed_basket" -and -not $s.costBasis.fallback -and $s.costBasis.reasons -contains "strategy_quality_first" -and
        $s.winner.effort -eq "max" -and $null -eq $s.valueDecision) "Quality-first ranking consulted measured cost"
    $disabled = Copy-PolicyWithMeasuredCost @{enabled = $false; workload = $workloadId; missingUsagePolicy = "profile_fallback"; description = "off"}
    $s = Get-ProfileSelection -Profile $f.Profile -Evidence $f.Evidence -Verdicts $f.Verdicts -Policy $disabled -Aliases @{} -Usage $f.Usage
    Assert-True ($s.costBasis.reasons -contains "measured_cost_disabled" -and $s.candidateReferenceAic -eq 210) "A disabled policy consulted measured cost"
}
Run-Test "Retirement recovery uses the measured basis among qualified configurations and still applies immediately" {
    $retired = @{status = "retired"; name = "old"; retirementDate = "2026-09-21"; suggestedAlternative = "alpha"; sourceUrl = "https://docs.github.com/en/copilot/reference/ai-models/supported-models"}
    $specs = @(New-EffortPairSpecs) + @(@{model = "old"; effort = "high"; in = 1.5; out = 6; lifecycle = $retired})
    $f = New-CostFixture $specs -IncumbentModel old -IncumbentEffort high
    $s = Step $f
    Assert-True ($s.selection.costBasis.mode -eq "measured_workload" -and $s.selection.retirementRecovery.mode -eq "qualified" -and
        $s.resolution.applied -and $s.resolution.finalConfiguration.model -eq "alpha" -and $s.resolution.finalConfiguration.effort -eq "xhigh") "Retirement did not apply the measured lowest-cost qualified configuration"
    Assert-True ($null -eq $s.selection.incumbentReferenceAic -and $s.resolution.status -eq "applied_retirement_qualified_replacement") "A retired incumbent's cost was invented"
    $missing = @(New-EffortPairSpecs) + @(@{model = "old"; effort = "high"; in = 1.5; out = 6; lifecycle = $retired})
    $missing[1].Remove("usage")
    $s = Step (New-CostFixture $missing -IncumbentModel old -IncumbentEffort high)
    Assert-True ($s.selection.costBasis.mode -eq "fixed_basket" -and $s.selection.costBasis.fallback -and $s.resolution.applied) "Retirement recovery stalled instead of falling back"
}
Run-Test "The existing report names the cost basis, the fallback and its reasons without claiming task spend" {
    $report = {
        param($Fixture, $Step, $Policy = $policy)
        (Get-ProfileReviewReportLines @{
            key = $Fixture.Profile.key; selection = $Step.selection; resolution = $Step.resolution
            requirement = $Policy.profileRequirements[$Fixture.Profile.key]; fallback = $null
            verdicts = $Fixture.Verdicts; evidence = @{records = $Fixture.Evidence}
        }) -join "`n"
    }
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    $text = & $report $f (Step $f)
    Assert-True ($text.Contains("**Cost basis: measured benchmark workload** (``$workloadId``)") -and
        $text.Contains("not predicted Copilot task spend, latency or cache behavior") -and
        $text.Contains("Benchmark-workload usage: candidate **261911.7264 AIC**") -and
        $text.Contains("Lowest measured benchmark-workload cost") -and -not $text.Contains("Reference usage:")) "Measured report wording is missing"
    $specs = @(New-EffortPairSpecs) + @(@{model = "gamma"; effort = "high"; score = 81; in = 1; out = 4})
    $f = New-CostFixture $specs -IncumbentModel alpha -IncumbentEffort max
    $text = & $report $f (Step $f)
    Assert-True ($text.Contains("**Cost basis: fixed reference basket (profile fallback).**") -and $text.Contains("usage_missing") -and
        $text.Contains("Qualified configurations without valid measured usage: gamma / high / default") -and
        $text.Contains("never mixed") -and $text.Contains("Reference usage:") -and -not $text.Contains("Benchmark-workload usage:")) "Fallback report wording is missing"
    $fixedPolicy = Copy-PolicyWithMeasuredCost $null
    $f = New-CostFixture (New-EffortPairSpecs) -IncumbentModel alpha -IncumbentEffort max
    $selection = Get-ProfileSelection -Profile $f.Profile -Evidence $f.Evidence -Verdicts $f.Verdicts -Policy $fixedPolicy -Aliases @{} -Usage $f.Usage
    $resolution = Resolve-ProfileSelectionState -CurrentModel alpha -Selection $selection -NowUtc $now
    $text = & $report $f ([pscustomobject]@{selection = $selection; resolution = $resolution}) $fixedPolicy
    Assert-True (-not $text.Contains("Cost basis:") -and $text.Contains("Reference usage:") -and $text.Contains("Lowest reference cost")) "Profiles without a measured-cost policy changed their report"
}
if ($script:Failed) { exit 1 }
