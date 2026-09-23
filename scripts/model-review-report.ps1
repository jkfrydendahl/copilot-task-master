Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

function Format-ModelReportValue {
    param($Value)
    if ($null -eq $Value -or [string]::IsNullOrWhiteSpace([string]$Value)) { return "n/a" }
    if ($Value -is [double] -or $Value -is [decimal]) {
        return $Value.ToString("0.####", [System.Globalization.CultureInfo]::InvariantCulture)
    }
    return ([string]$Value -replace '[\r\n]+', ' ' -replace '\|', '&#124;')
}

function Format-ModelReportRow {
    param([object[]]$Values)
    $cells = @($Values | ForEach-Object { Format-ModelReportValue $_ })
    return "| $($cells -join ' | ') |"
}

function Format-ModelReportConfiguration {
    param($Configuration)
    if ($null -eq $Configuration) { return "n/a" }
    $model = Get-ObjectMemberValue $Configuration "model"
    if ($null -eq $model) { $model = Get-ObjectMemberValue $Configuration "modelId" }
    return @($model, (Get-ObjectMemberValue $Configuration "effort"), (Get-ObjectMemberValue $Configuration "context") |
        ForEach-Object { Format-ModelReportValue $_ }) -join " / "
}

function Format-ModelReportPrices {
    param($Price, [switch]$Cache)
    $fields = if ($Cache) {
        @("cachedInputPerMillion", "cacheWritePerMillion")
    } else {
        @("inputPerMillion", "outputPerMillion")
    }
    $values = @($fields | ForEach-Object {
        Format-ModelReportValue (Get-ObjectMemberValue $Price $_)
    })
    return $values -join " / "
}

function Get-ModelReviewCoverage {
    param([AllowEmptyCollection()][object[]]$Results)
    $entries = @(foreach ($result in $Results) {
        foreach ($verdict in $result.verdicts) {
            foreach ($kind in @("exclusion", "advisory warning")) {
                $codes = if ($kind -eq "exclusion") { $verdict.reasonCodes } else { $verdict.warningCodes }
                foreach ($code in $codes) {
                    [pscustomobject]@{kind=$kind;model=$verdict.modelId;effort=(Get-ObjectMemberValue $verdict "effort");
                        context=(Get-ObjectMemberValue $verdict "context");message=$code;profile=$result.key}
                }
            }
        }
        foreach ($diagnostic in $result.evidence.diagnostics) {
            [pscustomobject]@{kind="evidence gap";model="";effort="";context="";message=$diagnostic;profile=$result.key}
        }
    })
    foreach ($group in @($entries | Group-Object kind, model, effort, context, message | Sort-Object Name)) {
        $entry = $group.Group[0]
        [pscustomobject]@{
            kind = $entry.kind
            model = $entry.model
            effort = $entry.effort
            context = $entry.context
            message = $entry.message
            profiles = @($group.Group.profile | Sort-Object -Unique)
        }
    }
}

function Format-ModelReportNumber {
    param($Value)
    if ($null -eq $Value) { return "n/a" }
    return ([double]$Value).ToString("G12", [Globalization.CultureInfo]::InvariantCulture)
}

function Get-RoleSupportingEvidenceReportLines {
    param($Result)
    $lines = [System.Collections.Generic.List[string]]::new()
    $winner = $Result.selection.winner
    $lines.Add("")
    $lines.Add("**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):")
    if (-not $Result.selection.supportingMetrics.Count) {
        $lines.Add("None: the configured role dimensions are binding qualification requirements.")
        return @($lines)
    }
    if ($null -eq $winner) {
        $lines.Add("Unavailable: no eligible recommendation to match.")
        return @($lines)
    }
    $lines.Add("")
    $lines.Add("| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |")
    $lines.Add("|---|---|---|---|---|---|---|---|")
    foreach ($key in $Result.selection.supportingMetrics) {
        $definition = $Result.selection.metricDefinitions[$key]
        $matched = @($Result.evidence.records | Where-Object {
            $_.source -eq $definition.source -and $_.metric -eq $definition.metric -and
            $_.model -eq $winner.model -and $_.effort -eq $winner.effort -and
            (Get-ObjectMemberValue $_ "context") -eq $winner.context
        })
        $record = if ($matched.Count -eq 1) { $matched[0] } else { $null }
        $score = Get-ObjectMemberValue $record "score"
        $valid = Test-ModelScore $score $definition.min $definition.max
        $lines.Add((Format-ModelReportRow @(
            $definition.label, (Format-ModelReportConfiguration $winner), (Get-ObjectMemberValue $record "alias"),
            $(if ($valid) { Format-ModelReportNumber $score } else { "n/a (missing or invalid)" }),
            $definition.scale, (Get-ObjectMemberValue $record "sourceDate"),
            (Get-ObjectMemberValue $record "fetchedAtUtc"), (Get-ObjectMemberValue $record "cached")
        )))
    }
    $lines.Add("")
    $lines.Add("Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.")
    foreach ($key in $Result.selection.supportingMetrics) {
        $definition = $Result.selection.metricDefinitions[$key]
        $lines.Add("$($definition.label): $($definition.limitation)")
    }
    return @($lines)
}

function Get-RoleQualificationReportLines {
    param($Result)
    $qualification = Get-ObjectMemberValue $Result.selection "qualification"
    if ($null -eq $qualification -or -not $qualification.enabled) { return @() }
    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add("")
    $lines.Add("**Role qualification:** $($qualification.status). Every required dimension must pass independently; then the cheapest qualified configuration wins. At least $($qualification.minimumModels) distinct eligible models are required per comparison, not per surviving intersection.")
    $lines.Add("References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.")
    $lines.Add("")
    $lines.Add("| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |")
    $lines.Add("|---|---|---|---|---|---|---|---|---|")
    foreach ($dimension in $qualification.dimensions) {
        $lines.Add((Format-ModelReportRow @(
            $dimension.key, $dimension.metricKey, $dimension.modelCount,
            (Format-ModelReportConfiguration $dimension.reference),
            (Format-ModelReportNumber (Get-ObjectMemberValue $dimension.reference "score")),
            (Format-ModelReportNumber $dimension.maxScoreGap), (Format-ModelReportNumber $dimension.minimumScore),
            (Get-ObjectMemberValue $dimension.reference "cached"), (Get-ObjectMemberValue $dimension.reference "sourceDate")
        )))
    }
    foreach ($dimension in $qualification.dimensions) {
        $routes = @($dimension.evidenceRoutes | ForEach-Object { $Result.selection.metricDefinitions[$_].label })
        $lines.Add("")
        $lines.Add("$($dimension.key) routes: $($routes -join ' > ').")
        foreach ($key in $dimension.evidenceRoutes) {
            $lines.Add("$($Result.selection.metricDefinitions[$key].label): $($Result.selection.metricDefinitions[$key].limitation)")
        }
    }
    $lines.Add("")
    $lines.Add("| Budget/capability-eligible configuration | Role qualified | Required evidence checks |")
    $lines.Add("|---|---|---|")
    foreach ($candidate in $qualification.candidates) {
        $checks = @($candidate.checks | ForEach-Object {
            "$($_.dimension): $(Format-ModelReportNumber (Get-ObjectMemberValue $_.record 'score')) ($($_.status))"
        })
        $lines.Add((Format-ModelReportRow @((Format-ModelReportConfiguration $candidate), $candidate.qualified, ($checks -join "; "))))
    }
    if ($qualification.status -ne "qualified") {
        $lines.Add("")
        $lines.Add("**Current configuration retained, not certified:** no role-qualified recommendation is available. No requirements are relaxed to fill the profile, and force cannot bypass missing coverage or an empty intersection.")
    }
    return @($lines)
}

function Get-ProfileReviewReportLines {
    param($Result)
    $r = $Result
    $lines = [System.Collections.Generic.List[string]]::new()
    $mode = if ($r.requirement.costSensitive) { "hard" } else { "advisory" }
    $leader = Format-ModelReportConfiguration $r.selection.qualityWinner
    $source = Format-ModelReportValue $r.selection.decidingSource
    $fallback = Format-ModelReportValue $r.fallback

    $lines.Add("")
    $lines.Add("### $($r.key)")
    $lines.Add("")
    $lines.Add("Budget: **$mode**, input $($r.requirement.inputCeilingPerMillion) / output $($r.requirement.outputCeilingPerMillion) USD per million. Deciding source: $source.")
    $lines.Add("Quality leader before hard-budget exclusions: $leader. Family fallback (informational, not a winner): $fallback.")
    $lines.Add("Strategy: **$($r.selection.strategy)**.")
    $promotionBlockReason = Get-ObjectMemberValue $r.selection "promotionBlockReason"
    $routes = @($r.selection.evidenceRoutes | ForEach-Object { $r.selection.metricDefinitions[$_].label })
    $lines.Add("Authorized deciding routes, strongest first: **$($routes -join ' > ')**. Supporting metrics are informational only.")
    $lines.Add("Task fit: external-harness proxy, not a measurement of Copilot CLI task success.")
    $lines.Add("Decision status: **$($r.resolution.status)**. Deciding metric: $(Format-ModelReportValue $r.selection.metricKey).")
    $basis = Get-ObjectMemberValue $r.resolution.state "incumbentBasis"
    $lines.Add("Incumbent selection basis (applied/current after run): $(if ($null -ne $basis) { Format-ModelReportValue $basis.metricKey } else { 'unknown; no historical provenance inferred' }).")
    foreach ($key in $r.selection.evidenceRoutes) {
        $definition = $r.selection.metricDefinitions[$key]
        $lines.Add("$($definition.label) ($($definition.scale)): $($definition.limitation)")
    }
    if ($null -ne $promotionBlockReason -or $r.resolution.status -match "retained_stronger_incumbent_basis") {
        $lines.Add("**Fallback replacement blocked:** comparable exact-incumbent evidence is required, and a weaker route cannot displace an established stronger basis. The candidate is informational only; force cannot bypass this requirement.")
    }
    if ($r.selection.configurationMode -eq "bounded_effort") {
        $candidateAic = Format-ModelReportNumber $r.selection.candidateReferenceAic
        $incumbentAic = Format-ModelReportNumber $r.selection.incumbentReferenceAic
        $efforts = $r.selection.allowedEfforts -join ", "
        $lines.Add("Configuration selection: **automatic bounded effort**; authorized efforts: $efforts. Models without effort controls use their native configuration; context remains fixed.")
        $lines.Add("Reference usage: candidate **$candidateAic AIC**; incumbent **$incumbentAic AIC**.")
        $lines.Add("Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.")
    }
    if ($null -ne $r.selection.valueDecision) {
        $value = $r.selection.valueDecision
        $referenceModel = Format-ModelReportConfiguration $value.qualityReference
        $referenceScore = Format-ModelReportNumber $value.qualityReference.score
        $gap = Format-ModelReportNumber $value.scoreGap
        $maximum = Format-ModelReportNumber $value.maxScoreGap
        $candidateAic = Format-ModelReportNumber $value.referenceAic
        $incumbentAic = Format-ModelReportNumber $value.incumbentReferenceAic
        $lines.Add("Eligible quality reference: $referenceModel ($referenceScore). Candidate gap: **$gap / $maximum** absolute $($value.qualityReference.metric) score points.")
        $lines.Add("Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **$candidateAic AIC**; incumbent **$incumbentAic AIC** (1 AIC = USD 0.01).")
        $recency = Get-ObjectMemberValue $value "recencyDecision"
        if ($null -ne $recency -and $recency.status -ne "not_needed") {
            $explanation = switch ($recency.status) {
                "newest_release" { "Newest verified release day wins, even when qualified scores differ within their bands." }
                "same_release_day" { "Release days are equal; use the exact incumbent configuration, then primary score and deterministic IDs." }
                default { "Recency unavailable for at least one contender; use the exact incumbent configuration, then primary score and deterministic IDs. Unknown dates are not treated as older." }
            }
            $lines.Add("**Equal-cost tie:** $explanation Effort variants are not different model releases.")
            $lines.Add("")
            $lines.Add("| Model | Verified release day | Recency status | Release metadata |")
            $lines.Add("|---|---|---|---|")
            foreach ($contender in $recency.contenders) {
                $date = if ($null -ne $contender.date) { $contender.date } else { "n/a" }
                $source = if ($null -ne $contender.sourceUrl) { "[AA model page]($($contender.sourceUrl))" } else { "n/a" }
                $lines.Add((Format-ModelReportRow @($contender.model, $date, $contender.status, $source)))
            }
            $lines.Add("")
            $lines.Add("Release dates are separate from benchmark publication/retrieval dates and do not count as new confirmation observations.")
        }
        $costChange = Format-ModelReportNumber $value.costIncreasePercent
        $lines.Add("Candidate cost change: **$costChange%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.")
        if ($null -eq $value.incumbentReferenceAic) {
            $lines.Add("**Cost comparison unavailable:** fresh, valid incumbent pricing is missing; savings or a premium cannot be established. The candidate's own fresh pricing and hard-budget eligibility still govern promotion.")
        }
        if (-not $value.incumbentEvidenceAvailable) {
            $action = if ($null -ne $promotionBlockReason) { "The fallback replacement is blocked." } else { "An authorized candidate may proceed." }
            $lines.Add("**Incumbent evidence gap:** no configuration-matched score in this deciding-source observation. $action No measured quality improvement over the incumbent is claimed.")
        } else {
            $incumbentScore = Format-ModelReportNumber $value.incumbentScore
            $lines.Add("Matched incumbent score in this deciding-source observation: **$incumbentScore**.")
        }
    }
    if ($r.selection.contested) {
        $lines.Add("**Warning: an independent fallback metric disagrees under this profile's quality rule; the authorized primary route still decides.**")
    }
    $lines.AddRange([string[]]@(Get-RoleQualificationReportLines -Result $r))
    $lines.AddRange([string[]](Get-RoleSupportingEvidenceReportLines -Result $r))
    if ($r.resolution.state.pending) {
        $pending = $r.resolution.state.pending
        $pendingModel = Format-ModelReportConfiguration $pending
        $pendingSource = Format-ModelReportValue $pending.decidingSource
        $lines.Add("Pending distinct decision-evidence observations for $pendingModel ($pendingSource): $($pending.count) / 2.")
    }
    $lines.Add("")
    $lines.Add("<details>")
    $lines.Add("<summary>Eligibility and exact benchmark evidence</summary>")
    $lines.Add("")
    $lines.Add("| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |")
    $lines.Add("|---|---|---|---|---|---|---|---|")
    foreach ($verdict in $r.verdicts) {
        $price = $verdict.pricing
        $lines.Add((Format-ModelReportRow @(
            (Format-ModelReportConfiguration $verdict)
            $verdict.admissible
            ($verdict.reasonCodes -join ", ")
            ($verdict.warningCodes -join ", ")
            (Get-ObjectMemberValue $price "tier")
            (Format-ModelReportPrices $price)
            (Get-ObjectMemberValue $price "verifiedAtUtc")
            (Get-ObjectMemberValue $verdict.capabilities "asOf")
        )))
    }
    $lines.Add("")
    $lines.Add("| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |")
    $lines.Add("|---|---|---|---|---|---|---|---|---|---|")
    foreach ($evidence in $r.evidence.records) {
        $lines.Add((Format-ModelReportRow @(
            $evidence.model, $evidence.source, $evidence.alias, $evidence.effort,
            $evidence.metric, (Format-ModelReportNumber $evidence.score), $evidence.publicationAgeUnknown,
            $evidence.cached, $evidence.harness,
            $(if ((Get-ObjectMemberValue $evidence "evidenceRole") -eq "qualification") { "qualification route" }
                elseif ("$($evidence.source).$($evidence.metric)" -in $r.selection.supportingMetrics) { "supporting only" }
                elseif ("$($evidence.source).$($evidence.metric)" -eq $r.selection.metricKey) { "deciding" } else { "authorized fallback" })
        )))
    }
    $lines.Add("")
    $lines.Add("Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).")
    $lines.Add("")
    $lines.Add("</details>")
    return @($lines)
}

function Get-TaskProfileReviewReport {
    param(
        $Results,
        $Pricing,
        $Sources,
        $SourceDiagnostics,
        $Policy,
        $Availability,
        [datetime]$NowUtc,
        [bool]$Forced,
        $Onboarding = $null
    )
    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add("# Monthly task profile review ($($NowUtc.ToString('yyyy-MM-dd')))")
    $lines.Add("")
    $lines.Add("Availability: **$($Availability.verified)** ($(Format-ModelReportValue $Availability.source)); manual confirmation override: **$Forced**.")
    if ($null -ne $Onboarding) {
        $lines.Add("")
        $lines.Add("## Model discovery and onboarding")
        $lines.Add("")
        $lines.Add("Recorded authenticated runtime metadata usable: **$($Onboarding.runtimeAuthenticated)**; status **$($Onboarding.runtimeStatus)**; runtime $(Format-ModelReportValue $Onboarding.runtimeVersion). This review does not authenticate to a user's account.")
        $discovery=Get-ObjectMemberValue $Onboarding "discoverySnapshot"
        if($null -ne $discovery){
            $lines.Add("Local discovery snapshot: **$($discovery.status)**; observed **$(Format-ModelReportValue $discovery.observedAtUtc)**; validity **$($discovery.maxAgeDays) days**. Availability was verified locally, not live-verified by this review.")
            $lines.Add((Format-ModelReportValue $discovery.message))
        }
        $lines.Add("Runtime and help catalogs are reconciled, not assumed exhaustive. Absence is not an explicit denial; runtime-disabled, ambiguous, denylisted and virtual routing models cannot enter selection. Public pricing/benchmark rows alone do not prove Copilot availability.")
        $lines.Add("Help-only entries are CLI-catalog evidence, not proof of per-account entitlement. The source columns distinguish these from recorded authenticated runtime entries.")
        $lines.Add("Verified catalog facts are updated before comparison. Ready for comparison is not role qualification: each profile still requires its exact configuration evidence, budget, bands and confirmation.")
        foreach ($message in $Onboarding.diagnostics) { $lines.Add("- Warning: $(Format-ModelReportValue $message)") }
        $lines.Add("")
        $lines.Add("<details>")
        $lines.Add("<summary>Discovered models, verified additions and remaining blockers</summary>")
        $lines.Add("")
        $lines.Add("| Model | Runtime listed | Help listed | Onboarding status | Blockers / limitations |")
        $lines.Add("|---|---|---|---|---|")
        foreach ($model in $Onboarding.models) {
            $lines.Add((Format-ModelReportRow @($model.model,$model.runtimeListed,$model.helpListed,$model.status,($model.reasons -join "; "))))
        }
        $lines.Add("")
        $lines.Add("Catalog changes: $($Onboarding.changes.Count). Unmapped benchmark variants: $($Onboarding.unmappedBenchmarkVariants.Count); complete discovery details are retained in ``data/model-onboarding-snapshot.json``. Such variants may be unrelated to Copilot and are not automatically admitted.")
        $lines.Add("</details>")
        $lines.Add("")
    }
    $lines.Add("")
    $lines.Add("## Profile decisions")
    $lines.Add("")
    $lines.Add("| Profile | Strategy | Current configuration | Recommended configuration | Applied/current after run | Outcome | Confidence |")
    $lines.Add("|---|---|---|---|---|---|---|")
    foreach ($result in $Results) {
        $lines.Add((Format-ModelReportRow @(
            $result.key, $result.selection.strategy, (Format-ModelReportConfiguration $result.currentConfiguration),
            (Format-ModelReportConfiguration $result.selection.winner), (Format-ModelReportConfiguration $result.finalConfiguration),
            $result.resolution.status, $result.selection.confidence
        )))
    }
    $lines.Add("")
    $lines.Add("Recommendations require the intersection of each profile's explicit qualification dimensions, not one global model ranking. Price decides only among configurations passing every required band. Every comparison needs at least two distinct eligible models; multiple efforts do not inflate coverage. Empty intersections or insufficient evidence retain the current configuration without certifying it. Supporting-only scores never blend, rank or veto; overlapping benchmark lineage is not independent corroboration. Unknown publication age, cached evidence, single-source coverage and external harnesses reduce confidence. A context capability is not a benchmark measurement at that context length.")
    $lines.Add("Value-balanced profiles minimize reference AIC within a source-specific gap of their best eligible score, under fixed hard input/output price ceilings. Bands are policy tolerances, not capability percentages or proof of task success. Token-price ceilings are not total session-spend limits.")
    $lines.Add("Orchestrator workflow metrics allow a 0.03 absolute gap; Mechanical retains zero workflow tolerance. Every other required dimension must also pass, so the intersection may be empty. These are policy tolerances, not statistical significance claims. Fallback replacements require comparable incumbent evidence and cannot weaken an established primary or qualification basis.")
    $lines.Add("Configuration cells show model / effective effort / context; 'none' means the model exposes no effort control. Allowed effort ranges are standing authorization: model and effort changes apply together after confirmation. Force bypasses only the confirmation wait, never hard budgets, allowed ranges, availability, capabilities or evidence requirements.")
    $lines.Add("")
    $lines.Add("## Pricing refresh")
    $lines.Add("")
    $lines.Add("- Status: **$($Pricing.status)**. Source: https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing")
    $lines.Add("- Last successful page fetch: $(Format-ModelReportValue (Get-ObjectMemberValue $Pricing.snapshot 'fetchedAtUtc')). Per-model verification ages govern eligibility.")
    $lines.Add("- Freshness limit: $($Policy.consensusPolicy.pricingFreshnessDays) days. Missing rows retain their original timestamps. Capabilities are never refreshed by pricing.")
    $lines.Add("- Reference-cost comparison: $($Policy.selectionPolicy.referenceUsageDescription)")
    $lines.Add("- Reference tokens: input $($Policy.selectionPolicy.referenceInputTokens), output $($Policy.selectionPolicy.referenceOutputTokens).")
    $lines.Add("")
    $lines.Add("| Changed model | Tier | Previous input / output USD per M | Current input / output USD per M | Previous cached input / cache write | Current cached input / cache write |")
    $lines.Add("|---|---|---|---|---|---|")
    foreach ($change in $Pricing.changes) {
        foreach ($tier in @($change.current.Keys | Sort-Object)) {
            $old = Get-ObjectMemberValue $change.previous $tier
            $new = $change.current[$tier]
            $lines.Add((Format-ModelReportRow @(
                $change.model, $tier,
                (Format-ModelReportPrices $old), (Format-ModelReportPrices $new),
                (Format-ModelReportPrices $old -Cache), (Format-ModelReportPrices $new -Cache)
            )))
        }
    }
    $lines.Add("")
    foreach ($warning in $Pricing.diagnostics) {
        $lines.Add("- Warning: $(Format-ModelReportValue $warning)")
    }
    $lines.Add("")
    $lines.Add("## Benchmark sources")
    $lines.Add("")
    $lines.Add("| Source | Status | Results published | Suite label | Artifact updated | Retrieved | Raw observation identity |")
    $lines.Add("|---|---|---|---|---|---|---|")
    foreach ($name in @($Sources.Keys | Sort-Object)) {
        $source = $Sources[$name]
        $lines.Add((Format-ModelReportRow @(
            $name, (Get-ObjectMemberValue $source "status"),
            (Get-ObjectMemberValue $source "sourceDate"), (Get-ObjectMemberValue $source "datasetVersion"),
            (Get-ObjectMemberValue $source "artifactPublishedAtUtc"), (Get-ObjectMemberValue $source "fetchedAtUtc"),
            (Get-ObjectMemberValue $source "sourceVersion")
        )))
    }
    $lines.Add("")
    $lines.Add("Confirmation uses metric-scoped observations, not the raw page fingerprint. Suite labels, artifact updates, row evaluation ages and retrieval times are distinct: an artifact update does not make every row newly evaluated. Unknown dates or methodology versions are not fabricated. AA public components remain separate from API aggregates; public pricing is never imported. Data attribution: https://artificialanalysis.ai and https://github.com/LiveBench/new-livebench.")
    $lines.Add("")
    foreach ($warning in $SourceDiagnostics) {
        $lines.Add("- Source warning: $(Format-ModelReportValue $warning)")
    }

    $coverage = @(Get-ModelReviewCoverage -Results $Results)
    $lines.Add("")
    $lines.Add("## Coverage and exclusions")
    $lines.Add("")
    $lines.Add("$($coverage.Count) distinct exclusions, advisory warnings and evidence gaps. Repeated findings are listed once with every affected profile; full eligibility and scores remain available below.")
    $lines.Add("")
    $lines.Add("<details>")
    $lines.Add("<summary>Grouped coverage details</summary>")
    $lines.Add("")
    $lines.Add("| Kind | Configuration (model / effort / context) | Finding | Affected profiles |")
    $lines.Add("|---|---|---|---|")
    foreach ($entry in $coverage) {
        $lines.Add((Format-ModelReportRow @($entry.kind, (Format-ModelReportConfiguration $entry), $entry.message, ($entry.profiles -join ", "))))
    }
    $lines.Add("")
    $lines.Add("</details>")
    $lines.Add("")
    $lines.Add("## Profile evidence")
    foreach ($result in $Results) {
        $lines.AddRange([string[]](Get-ProfileReviewReportLines -Result $result))
    }
    return @($lines)
}
