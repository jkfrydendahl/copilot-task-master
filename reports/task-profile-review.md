# Monthly task profile review (2026-09-09)

Availability: **True** (copilot help config); manual confirmation override: **True**.

## Profile decisions

| Profile | Strategy | Current configuration | Recommended configuration | Applied/current after run | Outcome | Confidence |
|---|---|---|---|---|---|---|
| orchestrator | value_balanced | gemini-3.8-flash / medium / default | gemini-3.8-flash / medium / default | gemini-3.8-flash / medium / default | budget_constrained_choice | reduced |
| quick | value_balanced | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | value_balanced_choice | reduced |
| default-development | value_balanced | gpt-5.6-sol / medium / default | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | applied_value_balanced_choice | reduced |
| agentic-implementation | value_balanced | gpt-5.6-sol / high / default | claude-opus-5 / xhigh / default | claude-opus-5 / xhigh / default | applied_value_balanced_choice | reduced |
| deep-reasoning | value_balanced | claude-opus-5 / high / long_context | claude-opus-5 / high / long_context | claude-opus-5 / high / long_context | value_balanced_choice | reduced |
| review | value_balanced | claude-opus-5 / medium / default | claude-opus-5 / high / default | claude-opus-5 / high / default | applied_value_balanced_choice | reduced |
| visual-ui | value_balanced | claude-opus-5 / medium / default | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | applied_value_balanced_choice | reduced |
| mechanical | value_balanced | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | value_balanced_choice | reduced |
| triage | value_balanced | gemini-3.7-flash / low / default | gemini-3.7-flash / low / default | gemini-3.7-flash / low / default | budget_constrained_choice | reduced |

Recommendations rank eligible configurations, not all models globally. AA is primary; LiveBench is corroboration or a labelled fallback. Unknown publication age, cached evidence, single-source coverage and external agent harnesses reduce confidence. A context capability is not a benchmark measurement at that context length.
Value-balanced profiles minimize reference AIC within a source-specific gap of their best eligible score, under fixed hard input/output price ceilings. Bands are policy tolerances, not capability percentages or proof of task success. Token-price ceilings are not total session-spend limits.
Configuration cells show model / effective effort / context; 'none' means the model exposes no effort control. Allowed effort ranges are standing authorization: model and effort changes apply together after confirmation. Force bypasses only the confirmation wait, never hard budgets, allowed ranges, availability, capabilities or evidence requirements.

## Pricing refresh

- Status: **partial**. Source: https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing
- Last successful page fetch: 2026-09-09T14:26:37.6538571Z. Per-model verification ages govern eligibility.
- Freshness limit: 45 days. Missing rows retain their original timestamps. Capabilities are never refreshed by pricing.
- Reference-cost comparison: Aggregate uncached usage across requests within the selected context tier, not a single 1M-token request or predicted task cost. Cache reads/writes are excluded.
- Reference tokens: input 1000000, output 100000.

| Changed model | Tier | Previous input / output USD per M | Current input / output USD per M | Previous cached input / cache write | Current cached input / cache write |
|---|---|---|---|---|---|

- Warning: Unmapped GitHub pricing model: Claude Sonnet 4
- Warning: Unmapped GitHub pricing model: GPT-5.4 nano

## Benchmark sources

| Source | Status | Published | Retrieved | Observation identity |
|---|---|---|---|---|
| artificialAnalysis | ok | n/a | 2026-09-09T14:26:43.2265796Z | a9a325b1aa44d232dc4866ed0510078342e544d98ed5950720f9807391fef30a&#124;62ea27a46f8f084a1b0569ed9b2cef8c1a64a8edf39e6230a2eb88a8f6e06b7b |
| artificialAnalysisCodingAgents | ok | n/a | 2026-09-09T14:26:44.9008128Z | 7da45df0f719be322977d4c08e09c2d75c37fddeb5d5205f8d106ec66676fb54 |
| liveBench | ok | 2026-06-25 | 2026-09-09T14:26:45.0344927Z | 6389c04aca01a1b8c020c9cf92df2731fc206ae6d73e4767fbf11732bb688360 |

Source fingerprints identify observations, not benchmark methodology versions. Unknown publication dates are not replaced with fetch dates. AA API scores are not replaced by public-page scores. Data attribution: https://artificialanalysis.ai and https://github.com/LiveBench/new-livebench.


## Coverage and exclusions

249 distinct exclusions, advisory warnings and evidence gaps. Repeated findings are listed once with every affected profile; full eligibility and scores remain available below.

<details>
<summary>Grouped coverage details</summary>

| Kind | Configuration (model / effort / context) | Finding | Affected profiles |
|---|---|---|---|
| evidence gap | n/a / n/a / n/a | claude-fable-5.1: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysis 'claude-4-5-haiku' score_missing_or_invalid | agentic-implementation, default-development, mechanical, quick, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisCodingAgents effort 'none' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisCodingAgents effort 'max' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'max' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'max' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'max' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'max' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-high' score_missing_or_invalid | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-low' score_missing_or_invalid | mechanical, quick |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-medium' score_missing_or_invalid | default-development, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-xhigh' score_missing_or_invalid | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'max' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5-mini: no supported effort within the configured range | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.5: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'max' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents 'Codex - GPT-5.6 Sol (max)' score_missing_or_invalid | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'max' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'xhigh' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | kimi-k2.7-code: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | kimi-k3: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1-flash-picker: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1-flash-picker: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1-flash-picker: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1-flash-picker: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | mai-code-1-flash-picker: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1-flash-picker: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1-flash-picker: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'low' alias_not_configured | mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| exclusion | claude-haiku-4.5 / none / default | vision_unknown | visual-ui |
| exclusion | claude-haiku-4.5 / none / long_context | context_unsupported | deep-reasoning |
| exclusion | claude-opus-4.7 / high / default | pricing_input_exceeds_ceiling | default-development |
| exclusion | claude-opus-4.7 / high / default | pricing_output_exceeds_ceiling | default-development |
| exclusion | claude-opus-4.7 / high / default | vision_unknown | visual-ui |
| exclusion | claude-opus-4.7 / low / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.7 / low / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.7 / medium / default | pricing_input_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-4.7 / medium / default | pricing_output_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-4.7 / medium / default | vision_unknown | visual-ui |
| exclusion | claude-opus-4.8-fast / high / default | pricing_input_exceeds_ceiling | default-development, review, visual-ui |
| exclusion | claude-opus-4.8-fast / high / default | pricing_output_exceeds_ceiling | default-development, review, visual-ui |
| exclusion | claude-opus-4.8-fast / high / default | vision_unknown | visual-ui |
| exclusion | claude-opus-4.8-fast / high / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | claude-opus-4.8-fast / low / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8-fast / low / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8-fast / max / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | claude-opus-4.8-fast / medium / default | pricing_input_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| exclusion | claude-opus-4.8-fast / medium / default | pricing_output_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| exclusion | claude-opus-4.8-fast / medium / default | vision_unknown | visual-ui |
| exclusion | claude-opus-4.8-fast / xhigh / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | claude-opus-4.8 / high / default | pricing_input_exceeds_ceiling | default-development |
| exclusion | claude-opus-4.8 / high / default | pricing_output_exceeds_ceiling | default-development |
| exclusion | claude-opus-4.8 / high / default | vision_unknown | visual-ui |
| exclusion | claude-opus-4.8 / low / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / low / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / medium / default | pricing_input_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-4.8 / medium / default | pricing_output_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-4.8 / medium / default | vision_unknown | visual-ui |
| exclusion | claude-opus-5 / high / default | pricing_input_exceeds_ceiling | default-development |
| exclusion | claude-opus-5 / high / default | pricing_output_exceeds_ceiling | default-development |
| exclusion | claude-opus-5 / low / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / low / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / medium / default | pricing_input_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-5 / medium / default | pricing_output_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-sonnet-4.6 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gemini-3.5-flash / high / default | vision_unknown | visual-ui |
| exclusion | gemini-3.5-flash / medium / default | vision_unknown | visual-ui |
| exclusion | gemini-3.6-flash / high / default | vision_unknown | visual-ui |
| exclusion | gemini-3.6-flash / medium / default | vision_unknown | visual-ui |
| exclusion | gemini-3.7-flash / high / default | vision_unknown | visual-ui |
| exclusion | gemini-3.7-flash / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-5.3-codex / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.3-codex / high / long_context | context_unsupported | deep-reasoning |
| exclusion | gpt-5.3-codex / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.3-codex / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-5.3-codex / xhigh / long_context | context_unsupported | deep-reasoning |
| exclusion | gpt-5.4-mini / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.4-mini / high / long_context | context_unsupported | deep-reasoning |
| exclusion | gpt-5.4-mini / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-5.4-mini / xhigh / long_context | context_unsupported | deep-reasoning |
| exclusion | gpt-5.4 / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.4 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.4 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.4 / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-5.5 / high / default | pricing_input_exceeds_ceiling | default-development |
| exclusion | gpt-5.5 / high / default | pricing_output_exceeds_ceiling | default-development, visual-ui |
| exclusion | gpt-5.5 / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.5 / low / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.5 / low / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.5 / medium / default | pricing_input_exceeds_ceiling | default-development, orchestrator |
| exclusion | gpt-5.5 / medium / default | pricing_output_exceeds_ceiling | default-development, orchestrator, visual-ui |
| exclusion | gpt-5.5 / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-5.6-luna / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.6-luna / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-5.6-sol / low / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / low / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / medium / default | pricing_input_exceeds_ceiling | orchestrator |
| exclusion | gpt-5.6-sol / medium / default | pricing_output_exceeds_ceiling | orchestrator |
| exclusion | gpt-5.6-terra / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.6-terra / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-terra / medium / default | vision_unknown | visual-ui |
| exclusion | grok-4.5 / high / default | vision_unknown | visual-ui |
| exclusion | grok-4.5 / medium / default | vision_unknown | visual-ui |
| exclusion | mai-code-1-flash-picker / high / default | vision_unknown | visual-ui |
| exclusion | mai-code-1-flash-picker / high / long_context | context_unsupported | deep-reasoning |
| exclusion | mai-code-1-flash-picker / medium / default | vision_unknown | visual-ui |
| exclusion | mai-code-1.1-flash / high / default | vision_unknown | visual-ui |
| exclusion | mai-code-1.1-flash / high / long_context | context_unsupported | deep-reasoning |
| exclusion | mai-code-1.1-flash / medium / default | vision_unknown | visual-ui |

</details>

## Profile evidence

### orchestrator

Budget: **hard**, input 3 / output 15 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: claude-opus-5 / medium / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: low, medium. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gemini-3.8-flash / medium / default (40). Candidate gap: **0 / 3** absolute intelligenceIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **40**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.7 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.7 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-4.6 / low / default | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.5-flash / low / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.5-flash / medium / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.6-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.6-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / low / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / low / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / medium / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / medium / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / medium / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 15.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | intelligenceIndex | 39.8 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | intelligenceIndex | 45.1 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-low | low | intelligenceIndex | 24.7 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-medium | medium | intelligenceIndex | 28.4 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | intelligenceIndex | 36.9 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | intelligenceIndex | 39.6 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | intelligenceIndex | 33.8 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | intelligenceIndex | 40 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | intelligenceIndex | 21.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | intelligenceIndex | 25.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | intelligenceIndex | 33.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | intelligenceIndex | 39.5 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | intelligenceIndex | 27.9 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | intelligenceIndex | 32.8 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | instructionFollowing | 63.2208 | False | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### quick

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gemini-3.8-flash / low / default. Family fallback (informational, not a winner): claude-haiku-4.5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: low. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gemini-3.8-flash / low / default (73.5). Candidate gap: **0 / 3** absolute codingIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **73.5**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.7 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-4.6 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.5-flash / low / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.6-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | codingIndex | 66.9 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | codingIndex | 71 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | codingIndex | 73.5 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | codingIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | codingIndex | 69.7 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | codingIndex | 58.1 | True | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### default-development

Budget: **hard**, input 4 / output 20 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-5.6-sol / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **600 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-5.6-sol / high / default (77.2). Candidate gap: **0.9 / 3** absolute codingIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **600 AIC** (1 AIC = USD 0.01).
Candidate cost change: **-81.25%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **76.3**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.7 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.7 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.5-flash / medium / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.6-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / medium / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / medium / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / medium / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | codingIndex | 74.3 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | codingIndex | 76.5 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | codingIndex | 76.1 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | codingIndex | 74.1 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | codingIndex | 50.7 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | codingIndex | 63.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | codingIndex | 77.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | codingIndex | 64.7 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | codingIndex | 67.1 | True | False | source benchmark harness, not Copilot CLI |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | codingIndex | 72.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | False | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### agentic-implementation

Budget: **hard**, input 10 / output 50 USD per million. Deciding source: artificialAnalysisCodingAgents.
Quality leader before hard-budget exclusions: claude-opus-5 / xhigh / default. Family fallback (informational, not a winner): gpt-5.3-codex.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **750 AIC**; incumbent **600 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-opus-5 / xhigh / default (0.681497542859). Candidate gap: **0 / 0.03** absolute codingAgentIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **750 AIC**; incumbent **600 AIC** (1 AIC = USD 0.01).
Candidate cost change: **25%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
**Incumbent evidence gap:** no configuration-matched score in this deciding-source observation. An authorized candidate may proceed, but no measured quality improvement over the incumbent is claimed.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.7 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.7 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.7 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | True | n/a | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / max / default | True | n/a | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / xhigh / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / xhigh / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / high / default | True | n/a | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / xhigh / default | True | n/a | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysisCodingAgents | Claude Code - Opus 5 (xhigh) | xhigh | codingAgentIndex | 0.6815 | True | False | external agent harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysisCodingAgents | Opencode - Gemini 3.8 Flash (high) | high | codingAgentIndex | 0.6115 | True | False | external agent harness, not Copilot CLI |
| grok-4.5 | artificialAnalysisCodingAgents | Grok Build - Grok 4.5 (high) | high | codingAgentIndex | 0.6409 | True | False | external agent harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | codingIndex | 76.5 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-xhigh | xhigh | codingIndex | 77 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | codingIndex | 78 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5 | max | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | codingIndex | 76.1 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | codingIndex | 63.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-xhigh | xhigh | codingIndex | 68.6 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | codingIndex | 71.4 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | codingIndex | 77.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-xhigh | xhigh | codingIndex | 78.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol | max | codingIndex | 77.4 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | codingIndex | 67.1 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-xhigh | xhigh | codingIndex | 70.6 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | codingIndex | 76.7 | True | False | source benchmark harness, not Copilot CLI |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | codingIndex | 72.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-4.7 | liveBench | claude-opus-4-7-xhigh-effort | xhigh | agenticCoding | 50.6563 | False | False | source benchmark harness, not Copilot CLI |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | agenticCoding | 50.505 | False | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | agenticCoding | 65.202 | False | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | agenticCoding | 59.394 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.4 | liveBench | gpt-5.4-xhigh | xhigh | agenticCoding | 53.8383 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.4-mini | liveBench | gpt-5.4-mini-xhigh | xhigh | agenticCoding | 41.6667 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.5 | liveBench | gpt-5.5-xhigh | xhigh | agenticCoding | 53.9897 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | agenticCoding | 48.4343 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | agenticCoding | 56.212 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | agenticCoding | 54.9497 | False | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### deep-reasoning

Budget: **hard**, input 10 / output 45 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: claude-opus-5 / max / long_context. Family fallback (informational, not a winner): claude-opus-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **750 AIC**; incumbent **750 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-opus-5 / max / long_context (50.7). Candidate gap: **2.5 / 3** absolute intelligenceIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **750 AIC**; incumbent **750 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **48.2**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / long_context | False | context_unsupported | n/a | default | 1 / 5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.7 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.7 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.7 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.8 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / high / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / max / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / xhigh / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-4.6 / high / long_context | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-4.6 / max / long_context | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-5 / high / long_context | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-5 / max / long_context | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-5 / xhigh / long_context | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.5-flash / high / long_context | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.6-flash / high / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / high / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / high / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / high / long_context | False | context_unsupported | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / long_context | False | context_unsupported | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / high / long_context | True | n/a | n/a | long_context | 5 / 22.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / xhigh / long_context | True | n/a | n/a | long_context | 5 / 22.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / high / long_context | False | context_unsupported | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / xhigh / long_context | False | context_unsupported | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / high / long_context | True | n/a | n/a | long_context | 10 / 45 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / xhigh / long_context | True | n/a | n/a | long_context | 10 / 45 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / high / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / max / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / xhigh / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / high / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / max / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / xhigh / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / high / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / max / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / xhigh / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / high / long_context | True | n/a | n/a | long_context | 4 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / high / long_context | False | context_unsupported | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / high / long_context | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 15.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | intelligenceIndex | 48.2 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-xhigh | xhigh | intelligenceIndex | 49.7 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | intelligenceIndex | 50.7 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5 | max | intelligenceIndex | 38.4 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | intelligenceIndex | 39.4 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | intelligenceIndex | 41.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | intelligenceIndex | 32.9 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-xhigh | xhigh | intelligenceIndex | 34.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | intelligenceIndex | 37.5 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | intelligenceIndex | 42.5 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-xhigh | xhigh | intelligenceIndex | 44.1 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol | max | intelligenceIndex | 47.1 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | intelligenceIndex | 34.5 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-xhigh | xhigh | intelligenceIndex | 38.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | intelligenceIndex | 42.3 | True | False | source benchmark harness, not Copilot CLI |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | intelligenceIndex | 39.1 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-4.7 | liveBench | claude-opus-4-7-xhigh-effort | xhigh | reasoning | 87.1923 | False | False | source benchmark harness, not Copilot CLI |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | reasoning | 89.1923 | False | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | reasoning | 91.2115 | False | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | reasoning | 88.6923 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.4 | liveBench | gpt-5.4-xhigh | xhigh | reasoning | 88.1155 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.4-mini | liveBench | gpt-5.4-mini-xhigh | xhigh | reasoning | 71.3238 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.5 | liveBench | gpt-5.5-xhigh | xhigh | reasoning | 89.6538 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | reasoning | 85.6443 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | reasoning | 91.6538 | False | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | reasoning | 90.6345 | False | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### review

Budget: **hard**, input 5 / output 30 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: claude-opus-5 / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **750 AIC**; incumbent **750 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-opus-5 / high / default (48.2). Candidate gap: **0 / 3** absolute intelligenceIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **750 AIC**; incumbent **750 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **45.1**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.7 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.7 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.5-flash / medium / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.6-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / medium / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / medium / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / high / default | True | n/a | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / medium / default | True | n/a | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / medium / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 15.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | intelligenceIndex | 45.1 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | intelligenceIndex | 48.2 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-medium | medium | intelligenceIndex | 28.4 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | intelligenceIndex | 39.6 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | intelligenceIndex | 39.4 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | intelligenceIndex | 40 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | intelligenceIndex | 41.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | intelligenceIndex | 25.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | intelligenceIndex | 32.9 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | intelligenceIndex | 39.5 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | intelligenceIndex | 42.5 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | intelligenceIndex | 32.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | intelligenceIndex | 34.5 | True | False | source benchmark harness, not Copilot CLI |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | intelligenceIndex | 39.1 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | reasoning | 84.7693 | False | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### visual-ui

Budget: **hard**, input 5 / output 25 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-5.6-sol / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **750 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-5.6-sol / high / default (77.2). Candidate gap: **0.9 / 3** absolute codingIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **750 AIC** (1 AIC = USD 0.01).
Candidate cost change: **-85%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **74.3**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | False | vision_unknown | n/a | default | 1 / 5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.7 / high / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.7 / medium / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.8 / high / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8 / medium / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / medium / default | False | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | True | n/a | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.5-flash / high / default | False | vision_unknown | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.5-flash / medium / default | False | vision_unknown | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.6-flash / high / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.6-flash / medium / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / high / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / medium / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / high / default | False | vision_unknown | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | vision_unknown | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / high / default | False | vision_unknown | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / medium / default | False | vision_unknown | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / high / default | False | vision_unknown | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / medium / default | False | vision_unknown | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / high / default | False | vision_unknown, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / medium / default | False | vision_unknown, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / high / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / medium / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / high / default | False | vision_unknown | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / medium / default | False | vision_unknown | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / high / default | False | vision_unknown | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / medium / default | False | vision_unknown | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / high / default | False | vision_unknown | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / medium / default | False | vision_unknown | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / medium / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | codingIndex | 74.3 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | codingIndex | 76.5 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | codingIndex | 76.1 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | codingIndex | 74.1 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | codingIndex | 50.7 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | codingIndex | 63.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | codingIndex | 77.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | codingIndex | 64.7 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | codingIndex | 67.1 | True | False | source benchmark harness, not Copilot CLI |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | codingIndex | 72.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | False | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### mechanical

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gemini-3.8-flash / low / default. Family fallback (informational, not a winner): claude-haiku-4.5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: low. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gemini-3.8-flash / low / default (73.5). Candidate gap: **0 / 3** absolute codingIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **73.5**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.7 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-4.6 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.5-flash / low / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.6-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | codingIndex | 66.9 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | codingIndex | 71 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | codingIndex | 73.5 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | codingIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | codingIndex | 69.7 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | codingIndex | 58.1 | True | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### triage

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: claude-opus-5 / low / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: low. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gemini-3.7-flash / low / default (36.9). Candidate gap: **0 / 3** absolute intelligenceIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **36.9**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.7 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| claude-sonnet-4.6 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.5-flash / low / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-09T14:26:37.6538571Z | 2026-07-30 |
| gemini-3.6-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.7-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gemini-3.8-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.4-mini / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1-flash-picker / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-09T14:26:37.6538571Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 15.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | intelligenceIndex | 39.8 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-low | low | intelligenceIndex | 24.7 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | intelligenceIndex | 36.9 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | intelligenceIndex | 33.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | intelligenceIndex | 21.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | intelligenceIndex | 33.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | intelligenceIndex | 27.9 | True | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>
