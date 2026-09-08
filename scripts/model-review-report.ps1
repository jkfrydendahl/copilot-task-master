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
                    [pscustomobject]@{kind=$kind; model=$verdict.modelId; message=$code; profile=$result.key}
                }
            }
        }
        foreach ($diagnostic in $result.evidence.diagnostics) {
            [pscustomobject]@{kind="evidence gap"; model=""; message=$diagnostic; profile=$result.key}
        }
    })
    foreach ($group in @($entries | Group-Object kind, model, message | Sort-Object Name)) {
        $entry = $group.Group[0]
        [pscustomobject]@{
            kind = $entry.kind
            model = $entry.model
            message = $entry.message
            profiles = @($group.Group.profile | Sort-Object -Unique)
        }
    }
}

function Get-ProfileReviewReportLines {
    param($Result)
    $r = $Result
    $lines = [System.Collections.Generic.List[string]]::new()
    $mode = if ($r.requirement.costSensitive) { "hard" } else { "advisory" }
    $leader = Format-ModelReportValue (Get-ObjectMemberValue $r.selection.qualityWinner "model")
    $source = Format-ModelReportValue $r.selection.decidingSource
    $fallback = Format-ModelReportValue $r.fallback

    $lines.Add("")
    $lines.Add("### $($r.key)")
    $lines.Add("")
    $lines.Add("Budget: **$mode**, input $($r.requirement.inputCeilingPerMillion) / output $($r.requirement.outputCeilingPerMillion) USD per million. Deciding source: $source.")
    $lines.Add("Quality leader before hard-budget exclusions: $leader. Family fallback (informational, not a winner): $fallback.")
    if ($r.selection.contested) {
        $lines.Add("**Warning: LiveBench ranks the recommendation below another comparable candidate; AA remains primary.**")
    }
    if ($r.resolution.state.pending) {
        $lines.Add("Pending distinct deciding-source observations: $($r.resolution.state.pending.count) / 2.")
    }
    $lines.Add("")
    $lines.Add("<details>")
    $lines.Add("<summary>Eligibility and exact benchmark evidence</summary>")
    $lines.Add("")
    $lines.Add("| Model | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |")
    $lines.Add("|---|---|---|---|---|---|---|---|")
    foreach ($verdict in $r.verdicts) {
        $price = $verdict.pricing
        $lines.Add((Format-ModelReportRow @(
            $verdict.modelId
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
    $lines.Add("| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |")
    $lines.Add("|---|---|---|---|---|---|---|---|---|")
    foreach ($evidence in $r.evidence.records) {
        $lines.Add((Format-ModelReportRow @(
            $evidence.model, $evidence.source, $evidence.alias, $evidence.effort,
            $evidence.metric, $evidence.score, $evidence.publicationAgeUnknown,
            $evidence.cached, $evidence.harness
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
    $lines.Add("| Profile | Current | Recommended | Applied/current after run | Effort / context | Outcome | Confidence |")
    $lines.Add("|---|---|---|---|---|---|---|")
    foreach ($result in $Results) {
        $lines.Add((Format-ModelReportRow @(
            $result.key, $result.currentModel, (Get-ObjectMemberValue $result.selection.winner "model"),
            $result.finalModel, "$($result.effort) / $($result.context)",
            $result.resolution.status, $result.selection.confidence
        )))
    }
    $lines.Add("")
    $lines.Add("Recommendations rank eligible configurations, not all models globally. AA is primary; LiveBench is corroboration or a labelled fallback. Unknown publication age, cached evidence, single-source coverage and external agent harnesses reduce confidence. A context capability is not a benchmark measurement at that context length.")
    $lines.Add("")
    $lines.Add("## Pricing refresh")
    $lines.Add("")
    $lines.Add("- Status: **$($Pricing.status)**. Source: https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing")
    $lines.Add("- Last successful page fetch: $(Format-ModelReportValue (Get-ObjectMemberValue $Pricing.snapshot 'fetchedAtUtc')). Per-model verification ages govern eligibility.")
    $lines.Add("- Freshness limit: $($Policy.consensusPolicy.pricingFreshnessDays) days. Missing rows retain their original timestamps. Capabilities are never refreshed by pricing.")
    $lines.Add("- Tie-break illustration: $($Policy.selectionPolicy.referenceUsageDescription)")
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
    $lines.Add("| Source | Status | Published | Retrieved | Observation identity |")
    $lines.Add("|---|---|---|---|---|")
    foreach ($name in @($Sources.Keys | Sort-Object)) {
        $source = $Sources[$name]
        $lines.Add((Format-ModelReportRow @(
            $name, (Get-ObjectMemberValue $source "status"),
            (Get-ObjectMemberValue $source "sourceDate"), (Get-ObjectMemberValue $source "fetchedAtUtc"),
            (Get-ObjectMemberValue $source "sourceVersion")
        )))
    }
    $lines.Add("")
    $lines.Add("Source fingerprints identify observations, not benchmark methodology versions. Unknown publication dates are not replaced with fetch dates. AA API scores are not replaced by public-page scores. Data attribution: https://artificialanalysis.ai and https://github.com/LiveBench/new-livebench.")
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
    $lines.Add("| Kind | Model | Finding | Affected profiles |")
    $lines.Add("|---|---|---|---|")
    foreach ($entry in $coverage) {
        $lines.Add((Format-ModelReportRow @($entry.kind, $entry.model, $entry.message, ($entry.profiles -join ", "))))
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
