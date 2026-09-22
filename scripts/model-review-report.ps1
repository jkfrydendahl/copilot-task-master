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
        $lines.Add("Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **$candidateAic AIC**; incumbent **$incumbentAic AIC** (1 AIC = USD 0.01).")
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
    $lines.AddRange([string[]](Get-RoleSupportingEvidenceReportLines -Result $r))
    if ($r.resolution.state.pending) {
        $pending = $r.resolution.state.pending
        $pendingModel = Format-ModelReportConfiguration $pending
        $pendingSource = Format-ModelReportValue $pending.decidingSource
        $lines.Add("Pending distinct deciding-source observations for $pendingModel ($pendingSource): $($pending.count) / 2.")
    }
    $lines.Add("")
    $lines.Add("<details>")
    $lines.Add("<summary>Eligibility and exact benchmark evidence</summary>")
    $lines.Add("")
    $lines.Add("| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |")
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
            $(if ("$($evidence.source).$($evidence.metric)" -in $r.selection.supportingMetrics) { "supporting only" }
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
        [bool]$Forced
    )
    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add("# Monthly task profile review ($($NowUtc.ToString('yyyy-MM-dd')))")
    $lines.Add("")
    $lines.Add("Availability: **$($Availability.verified)** ($(Format-ModelReportValue $Availability.source)); manual confirmation override: **$Forced**.")
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
    $lines.Add("Recommendations rank eligible configurations using each profile's explicit metric routes, not a global model ranking. Supporting scores never blend, rank or veto; overlapping benchmark lineage is not independent corroboration. Unknown publication age, cached evidence, single-source coverage and external harnesses reduce confidence. A context capability is not a benchmark measurement at that context length.")
    $lines.Add("Value-balanced profiles minimize reference AIC within a source-specific gap of their best eligible score, under fixed hard input/output price ceilings. Bands are policy tolerances, not capability percentages or proof of task success. Token-price ceilings are not total session-spend limits.")
    $lines.Add("New workflow metrics start with zero score tolerance: highest published eligible score wins, then cost breaks exact ties. This is a conservative pilot, not a statistical significance claim. Fallback replacements require comparable incumbent evidence and cannot weaken an established selection basis.")
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
