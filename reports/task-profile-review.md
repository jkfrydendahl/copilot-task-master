# Monthly task profile review (2026-09-08)

Availability: **True** (copilot help config); manual confirmation override: **False**.

## Profile decisions

| Profile | Current | Recommended | Applied/current after run | Effort / context | Outcome | Confidence |
|---|---|---|---|---|---|---|
| orchestrator | claude-sonnet-5 | claude-opus-5 | claude-sonnet-5 | medium / default | pending_quality_winner | reduced |
| quick | claude-haiku-4.5 | gemini-3.8-flash | claude-haiku-4.5 | low / default | pending_quality_winner | reduced |
| default-development | claude-sonnet-5 | gpt-5.6-sol | claude-sonnet-5 | medium / default | pending_quality_winner | reduced |
| agentic-implementation | gpt-5.3-codex | gpt-5.6-sol | gpt-5.3-codex | high / default | pending_aa_coding_fallback | reduced |
| deep-reasoning | claude-opus-5 | claude-opus-5 | claude-opus-5 | high / long_context | quality_winner | reduced |
| review | gpt-5.6-sol | claude-opus-5 | gpt-5.6-sol | medium / default | pending_quality_winner | reduced |
| visual-ui | claude-sonnet-5 | claude-opus-5 | claude-sonnet-5 | medium / default | pending_quality_winner | reduced |
| mechanical | claude-haiku-4.5 | gemini-3.8-flash | claude-haiku-4.5 | low / default | pending_quality_winner | reduced |
| triage | claude-sonnet-5 | gemini-3.7-flash | claude-sonnet-5 | low / default | pending_budget_constrained_choice | reduced |

Recommendations rank eligible configurations, not all models globally. AA is primary; LiveBench is corroboration or a labelled fallback. Unknown publication age, cached evidence, single-source coverage and external agent harnesses reduce confidence. A context capability is not a benchmark measurement at that context length.

## Pricing refresh

- Status: **partial**. Source: https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing
- Last successful page fetch: 2026-09-08T13:51:54.6105833Z. Per-model verification ages govern eligibility.
- Freshness limit: 45 days. Missing rows retain their original timestamps. Capabilities are never refreshed by pricing.
- Tie-break illustration: Aggregate uncached usage across requests within the selected context tier, not a single 1M-token request or predicted task cost. Cache reads/writes are excluded.
- Reference tokens: input 1000000, output 100000.

| Changed model | Tier | Previous input / output USD per M | Current input / output USD per M | Previous cached input / cache write | Current cached input / cache write |
|---|---|---|---|---|---|

- Warning: Unmapped GitHub pricing model: Claude Sonnet 4
- Warning: Unmapped GitHub pricing model: GPT-5.4 nano

## Benchmark sources

| Source | Status | Published | Retrieved | Observation identity |
|---|---|---|---|---|
| artificialAnalysis | ok | n/a | 2026-09-08T13:52:01.3629234Z | 506d3c93a96a673e63414dcfe067268e8547db84f9ee318a15e83658958ffa0d&#124;d05c150ea87c63259c6fa3bdafa35331c973c75286876b90ab11eb0e66ed30af |
| artificialAnalysisCodingAgents | ok | n/a | 2026-09-08T13:52:02.8543063Z | 7da45df0f719be322977d4c08e09c2d75c37fddeb5d5205f8d106ec66676fb54 |
| liveBench | ok | 2026-06-25 | 2026-09-08T13:52:02.9680321Z | 6389c04aca01a1b8c020c9cf92df2731fc206ae6d73e4767fbf11732bb688360 |

Source fingerprints identify observations, not benchmark methodology versions. Unknown publication dates are not replaced with fetch dates. AA API scores are not replaced by public-page scores. Data attribution: https://artificialanalysis.ai and https://github.com/LiveBench/new-livebench.


## Coverage and exclusions

214 distinct exclusions, advisory warnings and evidence gaps. Repeated findings are listed once with every affected profile; full eligibility and scores remain available below.

<details>
<summary>Grouped coverage details</summary>

| Kind | Model | Finding | Affected profiles |
|---|---|---|---|
| advisory warning | claude-fable-5.1 | pricing_input_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| advisory warning | claude-fable-5.1 | pricing_output_exceeds_ceiling | deep-reasoning, default-development, orchestrator, review, visual-ui |
| advisory warning | claude-opus-4.7 | pricing_input_exceeds_ceiling | default-development, orchestrator, visual-ui |
| advisory warning | claude-opus-4.7 | pricing_output_exceeds_ceiling | default-development, orchestrator, visual-ui |
| advisory warning | claude-opus-4.8-fast | pricing_input_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| advisory warning | claude-opus-4.8-fast | pricing_output_exceeds_ceiling | deep-reasoning, default-development, orchestrator, review, visual-ui |
| advisory warning | claude-opus-4.8 | pricing_input_exceeds_ceiling | default-development, orchestrator, visual-ui |
| advisory warning | claude-opus-4.8 | pricing_output_exceeds_ceiling | default-development, orchestrator, visual-ui |
| advisory warning | claude-opus-5 | pricing_input_exceeds_ceiling | default-development, orchestrator, visual-ui |
| advisory warning | claude-opus-5 | pricing_output_exceeds_ceiling | default-development, orchestrator, visual-ui |
| advisory warning | gpt-5.5 | pricing_input_exceeds_ceiling | default-development, orchestrator, visual-ui |
| advisory warning | gpt-5.5 | pricing_output_exceeds_ceiling | default-development, orchestrator, visual-ui |
| advisory warning | gpt-5.6-sol | pricing_input_exceeds_ceiling | default-development, orchestrator, visual-ui |
| advisory warning | gpt-5.6-sol | pricing_output_exceeds_ceiling | default-development, orchestrator, visual-ui |
| evidence gap | n/a | claude-fable-5.1: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-fable-5.1: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-fable-5.1: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-fable-5.1: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | claude-fable-5.1: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-fable-5.1: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-fable-5.1: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-haiku-4.5: artificialAnalysis 'claude-4-5-haiku' score_missing_or_invalid | agentic-implementation, default-development, mechanical, quick, visual-ui |
| evidence gap | n/a | claude-haiku-4.5: artificialAnalysisCodingAgents effort 'none' alias_not_configured | agentic-implementation |
| evidence gap | n/a | claude-haiku-4.5: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a | claude-opus-4.7: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-opus-4.7: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-opus-4.7: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-opus-4.7: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | claude-opus-4.7: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-opus-4.7: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-opus-4.7: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-opus-4.8-fast: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-opus-4.8-fast: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-opus-4.8-fast: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | claude-opus-4.8-fast: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-opus-4.8-fast: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-opus-4.8-fast: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-opus-4.8: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-opus-4.8: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-opus-4.8: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | claude-opus-4.8: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-opus-4.8: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-opus-4.8: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | claude-opus-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-opus-5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-opus-5: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-sonnet-4.6: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-sonnet-4.6: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-sonnet-4.6: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | claude-sonnet-4.6: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-sonnet-4.6: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-high' score_missing_or_invalid | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-medium' score_missing_or_invalid | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | claude-sonnet-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | claude-sonnet-5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | claude-sonnet-5: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gemini-3.5-flash: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gemini-3.5-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gemini-3.5-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gemini-3.5-flash: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gemini-3.5-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gemini-3.5-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gemini-3.5-flash: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gemini-3.6-flash: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gemini-3.6-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gemini-3.6-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gemini-3.6-flash: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gemini-3.6-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gemini-3.6-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gemini-3.6-flash: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gemini-3.7-flash: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gemini-3.7-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gemini-3.7-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gemini-3.7-flash: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gemini-3.8-flash: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gemini-3.8-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gemini-3.8-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gemini-3.8-flash: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5-mini: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5-mini: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5-mini: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5-mini: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gpt-5-mini: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5-mini: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5-mini: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.3-codex: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.3-codex: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.3-codex: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gpt-5.3-codex: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.3-codex: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.3-codex: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.4-mini: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.4-mini: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.4-mini: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.4-mini: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gpt-5.4-mini: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.4-mini: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.4-mini: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.4: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.4: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.4: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.4: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gpt-5.4: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.4: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.4: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.5: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.5: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.5: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gpt-5.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.5: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gpt-5.6-luna: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.6-luna: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.6-luna: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gpt-5.6-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.6-sol: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.6-sol: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | gpt-5.6-terra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | gpt-5.6-terra: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | gpt-5.6-terra: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | grok-4.5: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | grok-4.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | grok-4.5: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | grok-4.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | grok-4.5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | grok-4.5: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | kimi-k2.7-code: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | kimi-k2.7-code: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | kimi-k2.7-code: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | kimi-k2.7-code: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | kimi-k2.7-code: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | kimi-k2.7-code: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | kimi-k2.7-code: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | kimi-k3: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | kimi-k3: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | kimi-k3: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | kimi-k3: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | kimi-k3: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | kimi-k3: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | kimi-k3: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | mai-code-1-flash-picker: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | mai-code-1-flash-picker: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | mai-code-1-flash-picker: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | mai-code-1-flash-picker: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | mai-code-1-flash-picker: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | mai-code-1-flash-picker: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | mai-code-1-flash-picker: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | mai-code-1.1-flash: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | mai-code-1.1-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | mai-code-1.1-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| evidence gap | n/a | mai-code-1.1-flash: artificialAnalysisCodingAgents effort 'high' alias_not_configured | agentic-implementation |
| evidence gap | n/a | mai-code-1.1-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a | mai-code-1.1-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a | mai-code-1.1-flash: liveBench effort 'medium' alias_not_configured | default-development, orchestrator, review, visual-ui |
| exclusion | claude-fable-5.1 | capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-fable-5.1 | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-fable-5.1 | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-haiku-4.5 | context_unsupported | deep-reasoning |
| exclusion | claude-haiku-4.5 | vision_unknown | visual-ui |
| exclusion | claude-opus-4.7 | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.7 | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.7 | vision_unknown | visual-ui |
| exclusion | claude-opus-4.8-fast | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8-fast | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8-fast | vision_unknown | visual-ui |
| exclusion | claude-opus-4.8 | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8 | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8 | vision_unknown | visual-ui |
| exclusion | claude-opus-5 | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-5 | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gemini-3.5-flash | vision_unknown | visual-ui |
| exclusion | gemini-3.6-flash | vision_unknown | visual-ui |
| exclusion | gemini-3.7-flash | vision_unknown | visual-ui |
| exclusion | gpt-5-mini | context_unsupported | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-5-mini | effort_unsupported | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-5.3-codex | context_unsupported | deep-reasoning |
| exclusion | gpt-5.3-codex | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.3-codex | vision_unknown | visual-ui |
| exclusion | gpt-5.4-mini | context_unsupported | deep-reasoning |
| exclusion | gpt-5.4-mini | vision_unknown | visual-ui |
| exclusion | gpt-5.4 | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.4 | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.4 | vision_unknown | visual-ui |
| exclusion | gpt-5.5 | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.5 | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.5 | vision_unknown | visual-ui |
| exclusion | gpt-5.6-luna | vision_unknown | visual-ui |
| exclusion | gpt-5.6-sol | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-sol | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-sol | vision_unknown | visual-ui |
| exclusion | gpt-5.6-terra | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-terra | vision_unknown | visual-ui |
| exclusion | grok-4.5 | vision_unknown | visual-ui |
| exclusion | kimi-k2.7-code | capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | kimi-k3 | capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | kimi-k3 | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | kimi-k3 | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | mai-code-1-flash-picker | context_unsupported | deep-reasoning |
| exclusion | mai-code-1-flash-picker | vision_unknown | visual-ui |
| exclusion | mai-code-1.1-flash | context_unsupported | deep-reasoning |
| exclusion | mai-code-1.1-flash | vision_unknown | visual-ui |

</details>

## Profile evidence

### orchestrator

Budget: **advisory**, input 3 / output 15 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: claude-opus-5. Family fallback (informational, not a winner): claude-sonnet-5.
Pending distinct deciding-source observations: 1 / 2.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Model | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-fable-5.1 | False | capabilities_missing | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | n/a |
| claude-haiku-4.5 | True | n/a | n/a | default | 1 / 5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.7 | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-opus-4.8 | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.8-fast | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-5 | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-sonnet-4.6 | True | n/a | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-sonnet-5 | True | n/a | n/a | default | 2 / 10 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.5-flash | True | n/a | n/a | default | 1.5 / 9 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gemini-3.6-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.7-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.8-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5-mini | False | context_unsupported, effort_unsupported | n/a | default | 0.25 / 2 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gpt-5.3-codex | True | n/a | n/a | default | 1.75 / 14 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4 | True | n/a | n/a | default | 2.5 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4-mini | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.5 | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 30 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-luna | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-sol | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 4 / 20 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-terra | True | n/a | n/a | default | 2 / 12 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| grok-4.5 | True | n/a | n/a | default | 2 / 6 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| kimi-k2.7-code | False | capabilities_missing | n/a | default | 0.95 / 4 | 2026-09-08T13:51:54.6105833Z | n/a |
| kimi-k3 | False | capabilities_missing | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | n/a |
| mai-code-1-flash-picker | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| mai-code-1.1-flash | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 17.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | intelligenceIndex | 49.5 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | intelligenceIndex | 43.4 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | intelligenceIndex | 46.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | intelligenceIndex | 30.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | intelligenceIndex | 46 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | intelligenceIndex | 37.2 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | instructionFollowing | 63.2208 | False | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### quick

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gemini-3.8-flash. Family fallback (informational, not a winner): claude-haiku-4.5.
Pending distinct deciding-source observations: 1 / 2.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Model | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-fable-5.1 | False | capabilities_missing, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | n/a |
| claude-haiku-4.5 | True | n/a | n/a | default | 1 / 5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.7 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-opus-4.8 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.8-fast | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-5 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-sonnet-4.6 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-sonnet-5 | True | n/a | n/a | default | 2 / 10 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.5-flash | True | n/a | n/a | default | 1.5 / 9 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gemini-3.6-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.7-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.8-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5-mini | False | context_unsupported, effort_unsupported | n/a | default | 0.25 / 2 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gpt-5.3-codex | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4-mini | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.5 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-luna | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-sol | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-terra | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| grok-4.5 | True | n/a | n/a | default | 2 / 6 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| kimi-k2.7-code | False | capabilities_missing | n/a | default | 0.95 / 4 | 2026-09-08T13:51:54.6105833Z | n/a |
| kimi-k3 | False | capabilities_missing, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | n/a |
| mai-code-1-flash-picker | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| mai-code-1.1-flash | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |

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

Budget: **advisory**, input 3 / output 15 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-5.6-sol. Family fallback (informational, not a winner): claude-sonnet-5.
Pending distinct deciding-source observations: 1 / 2.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Model | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-fable-5.1 | False | capabilities_missing | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | n/a |
| claude-haiku-4.5 | True | n/a | n/a | default | 1 / 5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.7 | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-opus-4.8 | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.8-fast | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-5 | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-sonnet-4.6 | True | n/a | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-sonnet-5 | True | n/a | n/a | default | 2 / 10 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.5-flash | True | n/a | n/a | default | 1.5 / 9 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gemini-3.6-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.7-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.8-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5-mini | False | context_unsupported, effort_unsupported | n/a | default | 0.25 / 2 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gpt-5.3-codex | True | n/a | n/a | default | 1.75 / 14 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4 | True | n/a | n/a | default | 2.5 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4-mini | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.5 | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 30 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-luna | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-sol | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 4 / 20 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-terra | True | n/a | n/a | default | 2 / 12 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| grok-4.5 | True | n/a | n/a | default | 2 / 6 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| kimi-k2.7-code | False | capabilities_missing | n/a | default | 0.95 / 4 | 2026-09-08T13:51:54.6105833Z | n/a |
| kimi-k3 | False | capabilities_missing | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | n/a |
| mai-code-1-flash-picker | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| mai-code-1.1-flash | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | codingIndex | 74.3 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | codingIndex | 74.1 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | codingIndex | 50.7 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | codingIndex | 64.7 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | False | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### agentic-implementation

Budget: **advisory**, input 10 / output 50 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-5.6-sol. Family fallback (informational, not a winner): gpt-5.3-codex.
Pending distinct deciding-source observations: 1 / 2.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Model | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-fable-5.1 | False | capabilities_missing | n/a | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | n/a |
| claude-haiku-4.5 | True | n/a | n/a | default | 1 / 5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.7 | True | n/a | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-opus-4.8 | True | n/a | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.8-fast | True | n/a | n/a | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-5 | True | n/a | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-sonnet-4.6 | True | n/a | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-sonnet-5 | True | n/a | n/a | default | 2 / 10 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.5-flash | True | n/a | n/a | default | 1.5 / 9 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gemini-3.6-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.7-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.8-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5-mini | False | context_unsupported, effort_unsupported | n/a | default | 0.25 / 2 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gpt-5.3-codex | True | n/a | n/a | default | 1.75 / 14 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4 | True | n/a | n/a | default | 2.5 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4-mini | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.5 | True | n/a | n/a | default | 5 / 30 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-luna | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-sol | True | n/a | n/a | default | 4 / 20 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-terra | True | n/a | n/a | default | 2 / 12 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| grok-4.5 | True | n/a | n/a | default | 2 / 6 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| kimi-k2.7-code | False | capabilities_missing | n/a | default | 0.95 / 4 | 2026-09-08T13:51:54.6105833Z | n/a |
| kimi-k3 | False | capabilities_missing | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | n/a |
| mai-code-1-flash-picker | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| mai-code-1.1-flash | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | codingIndex | 76.5 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | codingIndex | 76.1 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | codingIndex | 63.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | codingIndex | 77.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | codingIndex | 67.1 | True | False | source benchmark harness, not Copilot CLI |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | codingIndex | 72.4 | True | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### deep-reasoning

Budget: **advisory**, input 10 / output 45 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: claude-opus-5. Family fallback (informational, not a winner): claude-opus-5.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Model | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-fable-5.1 | False | capabilities_missing | pricing_output_exceeds_ceiling | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | n/a |
| claude-haiku-4.5 | False | context_unsupported | n/a | default | 1 / 5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.7 | True | n/a | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-opus-4.8 | True | n/a | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.8-fast | True | n/a | pricing_output_exceeds_ceiling | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-5 | True | n/a | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-sonnet-4.6 | True | n/a | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-sonnet-5 | True | n/a | n/a | default | 2 / 10 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.5-flash | True | n/a | n/a | default | 1.5 / 9 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gemini-3.6-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.7-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.8-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5-mini | False | context_unsupported, effort_unsupported | n/a | default | 0.25 / 2 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gpt-5.3-codex | False | context_unsupported | n/a | default | 1.75 / 14 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4 | True | n/a | n/a | long_context | 5 / 22.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4-mini | False | context_unsupported | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.5 | True | n/a | n/a | long_context | 10 / 45 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-luna | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-sol | True | n/a | n/a | long_context | 8 / 30 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-terra | True | n/a | n/a | long_context | 4 / 18 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| grok-4.5 | True | n/a | n/a | long_context | 4 / 12 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| kimi-k2.7-code | False | capabilities_missing | n/a | default | 0.95 / 4 | 2026-09-08T13:51:54.6105833Z | n/a |
| kimi-k3 | False | capabilities_missing | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | n/a |
| mai-code-1-flash-picker | False | context_unsupported | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| mai-code-1.1-flash | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 17.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | intelligenceIndex | 52 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | intelligenceIndex | 45.2 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | intelligenceIndex | 47.1 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | intelligenceIndex | 37.4 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | intelligenceIndex | 48.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | intelligenceIndex | 41.3 | True | False | source benchmark harness, not Copilot CLI |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | intelligenceIndex | 45.5 | True | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### review

Budget: **advisory**, input 5 / output 30 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: claude-opus-5. Family fallback (informational, not a winner): claude-sonnet-5.
Pending distinct deciding-source observations: 1 / 2.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Model | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-fable-5.1 | False | capabilities_missing | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | n/a |
| claude-haiku-4.5 | True | n/a | n/a | default | 1 / 5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.7 | True | n/a | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-opus-4.8 | True | n/a | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.8-fast | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-5 | True | n/a | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-sonnet-4.6 | True | n/a | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-sonnet-5 | True | n/a | n/a | default | 2 / 10 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.5-flash | True | n/a | n/a | default | 1.5 / 9 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gemini-3.6-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.7-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.8-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5-mini | False | context_unsupported, effort_unsupported | n/a | default | 0.25 / 2 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gpt-5.3-codex | True | n/a | n/a | default | 1.75 / 14 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4 | True | n/a | n/a | default | 2.5 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4-mini | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.5 | True | n/a | n/a | default | 5 / 30 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-luna | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-sol | True | n/a | n/a | default | 4 / 20 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-terra | True | n/a | n/a | default | 2 / 12 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| grok-4.5 | True | n/a | n/a | default | 2 / 6 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| kimi-k2.7-code | False | capabilities_missing | n/a | default | 0.95 / 4 | 2026-09-08T13:51:54.6105833Z | n/a |
| kimi-k3 | False | capabilities_missing | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | n/a |
| mai-code-1-flash-picker | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| mai-code-1.1-flash | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 17.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | intelligenceIndex | 49.5 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | intelligenceIndex | 43.4 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | intelligenceIndex | 46.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | intelligenceIndex | 30.2 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | intelligenceIndex | 46 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | intelligenceIndex | 37.2 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | reasoning | 84.7693 | False | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### visual-ui

Budget: **advisory**, input 3 / output 15 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: claude-opus-5. Family fallback (informational, not a winner): claude-sonnet-5.
Pending distinct deciding-source observations: 1 / 2.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Model | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-fable-5.1 | False | capabilities_missing | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | n/a |
| claude-haiku-4.5 | False | vision_unknown | n/a | default | 1 / 5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.7 | False | vision_unknown | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-opus-4.8 | False | vision_unknown | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.8-fast | False | vision_unknown | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-5 | True | n/a | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-sonnet-4.6 | True | n/a | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-sonnet-5 | True | n/a | n/a | default | 2 / 10 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.5-flash | False | vision_unknown | n/a | default | 1.5 / 9 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gemini-3.6-flash | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.7-flash | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.8-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5-mini | False | context_unsupported, effort_unsupported | n/a | default | 0.25 / 2 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gpt-5.3-codex | False | vision_unknown | n/a | default | 1.75 / 14 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4 | False | vision_unknown | n/a | default | 2.5 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4-mini | False | vision_unknown | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.5 | False | vision_unknown | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 / 30 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-luna | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-sol | False | vision_unknown | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 4 / 20 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-terra | False | vision_unknown | n/a | default | 2 / 12 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| grok-4.5 | False | vision_unknown | n/a | default | 2 / 6 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| kimi-k2.7-code | False | capabilities_missing | n/a | default | 0.95 / 4 | 2026-09-08T13:51:54.6105833Z | n/a |
| kimi-k3 | False | capabilities_missing | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | n/a |
| mai-code-1-flash-picker | False | vision_unknown | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| mai-code-1.1-flash | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | codingIndex | 74.3 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | codingIndex | 74.1 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | codingIndex | 50.7 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | codingIndex | 64.7 | True | False | source benchmark harness, not Copilot CLI |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | False | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### mechanical

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gemini-3.8-flash. Family fallback (informational, not a winner): claude-haiku-4.5.
Pending distinct deciding-source observations: 1 / 2.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Model | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-fable-5.1 | False | capabilities_missing, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | n/a |
| claude-haiku-4.5 | True | n/a | n/a | default | 1 / 5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.7 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-opus-4.8 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.8-fast | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-5 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-sonnet-4.6 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-sonnet-5 | True | n/a | n/a | default | 2 / 10 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.5-flash | True | n/a | n/a | default | 1.5 / 9 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gemini-3.6-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.7-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.8-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5-mini | False | context_unsupported, effort_unsupported | n/a | default | 0.25 / 2 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gpt-5.3-codex | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4-mini | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.5 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-luna | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-sol | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-terra | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| grok-4.5 | True | n/a | n/a | default | 2 / 6 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| kimi-k2.7-code | False | capabilities_missing | n/a | default | 0.95 / 4 | 2026-09-08T13:51:54.6105833Z | n/a |
| kimi-k3 | False | capabilities_missing, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | n/a |
| mai-code-1-flash-picker | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| mai-code-1.1-flash | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |

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
Quality leader before hard-budget exclusions: claude-opus-5. Family fallback (informational, not a winner): claude-sonnet-5.
Pending distinct deciding-source observations: 1 / 2.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Model | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-fable-5.1 | False | capabilities_missing, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | n/a |
| claude-haiku-4.5 | True | n/a | n/a | default | 1 / 5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.7 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-opus-4.8 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-4.8-fast | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-opus-5 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| claude-sonnet-4.6 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| claude-sonnet-5 | True | n/a | n/a | default | 2 / 10 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.5-flash | True | n/a | n/a | default | 1.5 / 9 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gemini-3.6-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.7-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gemini-3.8-flash | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5-mini | False | context_unsupported, effort_unsupported | n/a | default | 0.25 / 2 | 2026-09-08T13:51:54.6105833Z | 2026-07-30 |
| gpt-5.3-codex | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.4-mini | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.5 | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-luna | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-sol | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| gpt-5.6-terra | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| grok-4.5 | True | n/a | n/a | default | 2 / 6 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| kimi-k2.7-code | False | capabilities_missing | n/a | default | 0.95 / 4 | 2026-09-08T13:51:54.6105833Z | n/a |
| kimi-k3 | False | capabilities_missing, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-08T13:51:54.6105833Z | n/a |
| mai-code-1-flash-picker | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |
| mai-code-1.1-flash | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-08T13:51:54.6105833Z | 2026-09-08 |

| Model | Source | Exact alias | Effort | Metric | Score | Publication age unknown | Cached | Harness |
|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 17.4 | True | False | source benchmark harness, not Copilot CLI |
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | intelligenceIndex | 43.8 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | intelligenceIndex | 41.1 | True | False | source benchmark harness, not Copilot CLI |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | intelligenceIndex | 41 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | intelligenceIndex | 25.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | intelligenceIndex | 40.8 | True | False | source benchmark harness, not Copilot CLI |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | intelligenceIndex | 32.4 | True | False | source benchmark harness, not Copilot CLI |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>
