# Monthly task profile review (2026-09-21)

Availability: **True** (copilot help config); manual confirmation override: **True**.

## Profile decisions

| Profile | Strategy | Current configuration | Recommended configuration | Applied/current after run | Outcome | Confidence |
|---|---|---|---|---|---|---|
| orchestrator | value_balanced | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | budget_constrained_choice | reduced |
| quick | value_balanced | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | budget_constrained_choice | reduced |
| default-development | value_balanced | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | value_balanced_choice | reduced |
| agentic-implementation | value_balanced | claude-opus-5 / max / default | claude-opus-5 / max / default | claude-opus-5 / max / default | value_balanced_choice | reduced |
| deep-reasoning | value_balanced | claude-opus-5 / high / long_context | claude-opus-5 / high / long_context | claude-opus-5 / high / long_context | budget_constrained_choice | reduced |
| review | value_balanced | claude-opus-5 / high / default | claude-opus-5 / high / default | claude-opus-5 / high / default | budget_constrained_choice | reduced |
| visual-ui | value_balanced | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | value_balanced_choice | reduced |
| mechanical | value_balanced | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | budget_constrained_choice | reduced |
| triage | value_balanced | gemini-3.7-flash / low / default | gemini-3.7-flash / low / default | gemini-3.7-flash / low / default | budget_constrained_choice | reduced |

Recommendations rank eligible configurations, not all models globally. AA is primary; LiveBench is corroboration or a labelled fallback. Unknown publication age, cached evidence, single-source coverage and external agent harnesses reduce confidence. A context capability is not a benchmark measurement at that context length.
Value-balanced profiles minimize reference AIC within a source-specific gap of their best eligible score, under fixed hard input/output price ceilings. Bands are policy tolerances, not capability percentages or proof of task success. Token-price ceilings are not total session-spend limits.
Configuration cells show model / effective effort / context; 'none' means the model exposes no effort control. Allowed effort ranges are standing authorization: model and effort changes apply together after confirmation. Force bypasses only the confirmation wait, never hard budgets, allowed ranges, availability, capabilities or evidence requirements.

## Pricing refresh

- Status: **partial**. Source: https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing
- Last successful page fetch: 2026-09-21T08:51:32.9318304Z. Per-model verification ages govern eligibility.
- Freshness limit: 45 days. Missing rows retain their original timestamps. Capabilities are never refreshed by pricing.
- Reference-cost comparison: Aggregate uncached usage across requests within the selected context tier, not a single 1M-token request or predicted task cost. Cache reads/writes are excluded.
- Reference tokens: input 1000000, output 100000.

| Changed model | Tier | Previous input / output USD per M | Current input / output USD per M | Previous cached input / cache write | Current cached input / cache write |
|---|---|---|---|---|---|

- Warning: Missing pricing row: mai-code-1-flash-picker (MAI-Code-1-Flash); retaining original verification timestamp if available.
- Warning: Unmapped GitHub pricing model: Claude Sonnet 4
- Warning: Unmapped GitHub pricing model: GPT-5.4 nano

## Benchmark sources

| Source | Status | Published | Retrieved | Observation identity |
|---|---|---|---|---|
| artificialAnalysis | ok | n/a | 2026-09-21T08:51:42.5552928Z | 3fdda65f0407339266632ac9df15e71cb303f7df7fac775a3161a25c8f3a8e04&#124;84914393bb4a6e0c43146e57e3ca7f786aaad5d6d3ba0c77edf3270bc3f96d9d |
| artificialAnalysisCodingAgents | ok | n/a | 2026-09-21T08:51:43.6510767Z | 1ff78f904c410fafdd8ea49aebc82fbfea2a7b91f64ce5c633e7b039aafff06b |
| liveBench | ok | 2026-06-25 | 2026-09-21T08:51:44.1166375Z | fe0570267476a7e468b1a1e32c13cd6333358500d6019a0e226db88bd92719bb |

Source fingerprints identify observations, not benchmark methodology versions. Unknown publication dates are not replaced with fetch dates. AA API scores are not replaced by public-page scores. Data attribution: https://artificialanalysis.ai and https://github.com/LiveBench/new-livebench.


## Coverage and exclusions

268 distinct exclusions, advisory warnings and evidence gaps. Repeated findings are listed once with every affected profile; full eligibility and scores remain available below.

<details>
<summary>Grouped coverage details</summary>

| Kind | Configuration (model / effort / context) | Finding | Affected profiles |
|---|---|---|---|
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 28ef65135f08f035dc93a97d324fea73: model_identity_unresolved_or_ambiguous 'DeepSeek V4 Flash 0731 (max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 29a1cdad0d140781d05b9b4746cfdd0d: composite_or_ambiguous_model_label 'Fable 5.1 (max) (with fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 34970c963bdfd318e46205514d46ea4f: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 45493c2782f1bd94f6d30d4911f317a0: model_identity_unresolved_or_ambiguous 'GLM-5.3' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 542590ecc1aa12a718d158565d464daa: model_identity_unresolved_or_ambiguous 'DeepSeek V4 Pro 0813 (max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 55b029d6971b4d378335bb168eb98b3b: model_identity_unresolved_or_ambiguous 'Kimi K3' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: cd4c865dc2f539b650d741fd2ebf7f2d: model_identity_unresolved_or_ambiguous 'Qwen3.8 Max' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: cd60470c35fd626a116af80fd5915dfa: model_identity_unresolved_or_ambiguous 'Muse Spark 1.3 (xhigh)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: f2de07373c3626f1b9269a6ecad7804c: model_identity_unresolved_or_ambiguous 'Muse Spark 1.3 (max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: fa2595093fa640e73d072e7d1aa7df82: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-fable-5.1: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysis 'claude-4-5-haiku' score_missing_or_invalid | agentic-implementation, default-development, mechanical, quick, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-high' score_missing_or_invalid | agentic-implementation, default-development, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-low' score_missing_or_invalid | mechanical, quick |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-medium' score_missing_or_invalid | default-development, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis 'claude-sonnet-5-xhigh' score_missing_or_invalid | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5-mini: no supported effort within the configured range | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'xhigh' not_in_requested_configurations | agentic-implementation |
| evidence gap | n/a / n/a / n/a | kimi-k2.7-code: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | kimi-k3: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| exclusion | claude-haiku-4.5 / none / default | vision_unknown | visual-ui |
| exclusion | claude-haiku-4.5 / none / long_context | context_unsupported | deep-reasoning |
| exclusion | claude-opus-4.7 / high / default | pricing_input_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-4.7 / high / default | pricing_output_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-4.7 / high / default | vision_unknown | visual-ui |
| exclusion | claude-opus-4.7 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.7 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.7 / medium / default | pricing_input_exceeds_ceiling | default-development |
| exclusion | claude-opus-4.7 / medium / default | pricing_output_exceeds_ceiling | default-development |
| exclusion | claude-opus-4.7 / medium / default | vision_unknown | visual-ui |
| exclusion | claude-opus-4.8-fast / high / default | pricing_input_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| exclusion | claude-opus-4.8-fast / high / default | pricing_output_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| exclusion | claude-opus-4.8-fast / high / default | vision_unknown | visual-ui |
| exclusion | claude-opus-4.8-fast / high / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | claude-opus-4.8-fast / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8-fast / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8-fast / max / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | claude-opus-4.8-fast / medium / default | pricing_input_exceeds_ceiling | default-development, review, visual-ui |
| exclusion | claude-opus-4.8-fast / medium / default | pricing_output_exceeds_ceiling | default-development, review, visual-ui |
| exclusion | claude-opus-4.8-fast / medium / default | vision_unknown | visual-ui |
| exclusion | claude-opus-4.8-fast / xhigh / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | claude-opus-4.8 / high / default | pricing_input_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-4.8 / high / default | pricing_output_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-4.8 / high / default | vision_unknown | visual-ui |
| exclusion | claude-opus-4.8 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8 / medium / default | pricing_input_exceeds_ceiling | default-development |
| exclusion | claude-opus-4.8 / medium / default | pricing_output_exceeds_ceiling | default-development |
| exclusion | claude-opus-4.8 / medium / default | vision_unknown | visual-ui |
| exclusion | claude-opus-5 / high / default | pricing_input_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-5 / high / default | pricing_output_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-5 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-5 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-5 / medium / default | pricing_input_exceeds_ceiling | default-development |
| exclusion | claude-opus-5 / medium / default | pricing_output_exceeds_ceiling | default-development |
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
| exclusion | gpt-5.5 / high / default | pricing_input_exceeds_ceiling | default-development, orchestrator |
| exclusion | gpt-5.5 / high / default | pricing_output_exceeds_ceiling | default-development, orchestrator, visual-ui |
| exclusion | gpt-5.5 / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.5 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.5 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.5 / medium / default | pricing_input_exceeds_ceiling | default-development |
| exclusion | gpt-5.5 / medium / default | pricing_output_exceeds_ceiling | default-development, visual-ui |
| exclusion | gpt-5.5 / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-5.6-luna / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.6-luna / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-5.6-sol / high / default | pricing_input_exceeds_ceiling | orchestrator |
| exclusion | gpt-5.6-sol / high / default | pricing_output_exceeds_ceiling | orchestrator |
| exclusion | gpt-5.6-sol / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-sol / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-terra / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.6-terra / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-terra / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-6-astra / high / default | pricing_input_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| exclusion | gpt-6-astra / high / default | pricing_output_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| exclusion | gpt-6-astra / high / long_context | pricing_input_exceeds_ceiling | deep-reasoning |
| exclusion | gpt-6-astra / high / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | gpt-6-astra / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-6-astra / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-6-astra / max / long_context | pricing_input_exceeds_ceiling | deep-reasoning |
| exclusion | gpt-6-astra / max / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | gpt-6-astra / medium / default | pricing_input_exceeds_ceiling | default-development, review, visual-ui |
| exclusion | gpt-6-astra / medium / default | pricing_output_exceeds_ceiling | default-development, review, visual-ui |
| exclusion | gpt-6-astra / xhigh / long_context | pricing_input_exceeds_ceiling | deep-reasoning |
| exclusion | gpt-6-astra / xhigh / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | grok-4.5 / high / default | vision_unknown | visual-ui |
| exclusion | grok-4.5 / medium / default | vision_unknown | visual-ui |
| exclusion | mai-code-1.1-flash / high / default | vision_unknown | visual-ui |
| exclusion | mai-code-1.1-flash / high / long_context | context_unsupported | deep-reasoning |
| exclusion | mai-code-1.1-flash / medium / default | vision_unknown | visual-ui |

</details>

## Profile evidence

### orchestrator

Budget: **hard**, input 3 / output 15 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gemini-3.8-flash / high / default (40.9). Candidate gap: **0 / 3** absolute intelligenceIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **40.9**.

**Orchestrator LiveBench supporting evidence** (for the recommended configuration, not necessarily the applied configuration):

| Configuration (model / effort / context) | Exact LB alias | LB reasoning (0-100) | LB instruction following (0-100) | Published | Retrieved | Cached |
|---|---|---|---|---|---|---|
| gemini-3.8-flash / high / default | gemini-3.8-flash-high | 89.2933 | 81.4125 | 2026-06-25 | 2026-09-21T08:51:44.1166375Z | False |

These are separate LiveBench metrics, not AA Intelligence Index scores or a blended ranking. Reasoning is informational; instruction following retains its existing corroboration/fallback role. AA remains primary when eligible matched AA evidence exists. Cached evidence cannot authorize a switch; an n/a publication date means publication age is unknown.
External benchmark results do not establish reliable Copilot CLI delegation, constraint retention or subagent-result review, or improvement over an unmeasured effort setting.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.7 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 15.4 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | intelligenceIndex | 48.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-high | high | intelligenceIndex | 31.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | intelligenceIndex | 39.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | intelligenceIndex | 40.9 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | intelligenceIndex | 32.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | intelligenceIndex | 42.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | intelligenceIndex | 34.2 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 50.9 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | intelligenceIndex | 38.8 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | instructionFollowing | 81.4125 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### quick

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / low / default. Family fallback (informational, not a winner): claude-haiku-4.5.
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
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.7 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-4.6 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.5-flash / low / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.6-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | codingIndex | 66.9 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | codingIndex | 71 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | codingIndex | 73.5 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | codingIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | codingIndex | 69.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | codingIndex | 58.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | codingIndex | 75.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### default-development

Budget: **hard**, input 4 / output 20 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-5.6-sol / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-5.6-sol / high / default (77.2). Candidate gap: **0.9 / 3** absolute codingIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **76.3**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.7 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.7 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.5-flash / medium / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.6-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / medium / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / medium / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | codingIndex | 74.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | codingIndex | 76.5 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | codingIndex | 76.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | codingIndex | 74.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | codingIndex | 50.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | codingIndex | 63.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | codingIndex | 77.2 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | codingIndex | 64.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | codingIndex | 67.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | codingIndex | 76.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | codingIndex | 77.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | codingIndex | 72.4 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | coding | 72.489 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### agentic-implementation

Budget: **hard**, input 10 / output 50 USD per million. Deciding source: artificialAnalysisCodingAgents.
Quality leader before hard-budget exclusions: gpt-6-astra / max / default. Family fallback (informational, not a winner): gpt-5.3-codex.
Strategy: **value_balanced**.
Agentic selection uses AA Coding Agent Index, then LiveBench Agentic Coding. General AA coding is informational only and cannot authorize a replacement.
AA agent identities are resolved from structured records. Harness/variant and benchmark components are preserved; ambiguous, composite, incomplete or legacy label-only records cannot authorize selection.
Configuration selection: **automatic bounded effort**; authorized efforts: high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **750 AIC**; incumbent **750 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-6-astra / max / default (0.616450449879). Candidate gap: **0.0191867768945 / 0.03** absolute codingAgentIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **750 AIC**; incumbent **750 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **0.597263672984**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.7 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.7 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.7 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | True | n/a | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / max / default | True | n/a | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / xhigh / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / xhigh / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / high / default | True | n/a | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / xhigh / default | True | n/a | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / high / default | True | n/a | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / max / default | True | n/a | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysisCodingAgents | Claude Code - Opus 5 (max) | max | codingAgentIndex | 0.5973 | True | False | Claude Code; variant 409518818f1e9ad21995d70631ab05b6; external agent harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysisCodingAgents | Antigravity SDK - Gemini 3.8 Flash (high) | high | codingAgentIndex | 0.4186 | True | False | Antigravity SDK v0.1.12; variant d1003684d8f29b95a3b14d2a7722221a; external agent harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysisCodingAgents | Codex - GPT-5.6 Sol (max) ({'reasoning_effort': 'max'}) | max | codingAgentIndex | 0.5456 | True | False | Codex; variant 709f801275dedae5675b1f56e97c9df3; external agent harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysisCodingAgents | Codex - GPT-6 Astra (max) ({'reasoning_effort': 'max'}) | max | codingAgentIndex | 0.6165 | True | False | Codex; variant 9e810ff3c6cce5ebaaff7c744c687a47; external agent harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | codingIndex | 76.5 | True | False | source benchmark harness, not Copilot CLI | informational only |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | codingIndex | 78 | True | False | source benchmark harness, not Copilot CLI | informational only |
| claude-opus-5 | artificialAnalysis | claude-opus-5-xhigh | xhigh | codingIndex | 77 | True | False | source benchmark harness, not Copilot CLI | informational only |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5 | max | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | codingIndex | 76.1 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | codingIndex | 63.3 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | codingIndex | 71.4 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-xhigh | xhigh | codingIndex | 68.6 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | codingIndex | 77.2 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol | max | codingIndex | 77.4 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-xhigh | xhigh | codingIndex | 78.3 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | codingIndex | 67.1 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | codingIndex | 76.7 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-xhigh | xhigh | codingIndex | 70.6 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | codingIndex | 77.1 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-6-astra | artificialAnalysis | gpt-6-astra | max | codingIndex | 76.9 | True | False | source benchmark harness, not Copilot CLI | informational only |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-xhigh | xhigh | codingIndex | 75.9 | True | False | source benchmark harness, not Copilot CLI | informational only |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | codingIndex | 72.4 | True | False | source benchmark harness, not Copilot CLI | informational only |
| claude-opus-4.7 | liveBench | claude-opus-4-7-xhigh-effort | xhigh | agenticCoding | 50.6563 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | agenticCoding | 50.505 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | agenticCoding | 65.202 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | agenticCoding | 59.394 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | agenticCoding | 54.2423 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.4 | liveBench | gpt-5.4-xhigh | xhigh | agenticCoding | 53.8383 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.4-mini | liveBench | gpt-5.4-mini-xhigh | xhigh | agenticCoding | 41.6667 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.5 | liveBench | gpt-5.5-xhigh | xhigh | agenticCoding | 53.9897 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | agenticCoding | 48.4343 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | agenticCoding | 56.212 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | agenticCoding | 54.9497 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### deep-reasoning

Budget: **hard**, input 10 / output 45 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / max / long_context. Family fallback (informational, not a winner): claude-opus-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **750 AIC**; incumbent **750 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-opus-5 / max / long_context (50.8). Candidate gap: **2.7 / 3** absolute intelligenceIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **750 AIC**; incumbent **750 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **48.1**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / long_context | False | context_unsupported | n/a | default | 1 / 5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.7 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.7 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.7 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.8 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / high / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / max / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / xhigh / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-4.6 / high / long_context | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-4.6 / max / long_context | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-5 / high / long_context | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-5 / max / long_context | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-5 / xhigh / long_context | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.5-flash / high / long_context | True | n/a | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.6-flash / high / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / high / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / high / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / high / long_context | False | context_unsupported | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / long_context | False | context_unsupported | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / high / long_context | True | n/a | n/a | long_context | 5 / 22.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / xhigh / long_context | True | n/a | n/a | long_context | 5 / 22.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / high / long_context | False | context_unsupported | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / xhigh / long_context | False | context_unsupported | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / high / long_context | True | n/a | n/a | long_context | 10 / 45 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / xhigh / long_context | True | n/a | n/a | long_context | 10 / 45 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / high / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / max / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / xhigh / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / high / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / max / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / xhigh / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / high / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / max / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / xhigh / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / high / long_context | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | long_context | 20 / 75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / max / long_context | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | long_context | 20 / 75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / xhigh / long_context | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | long_context | 20 / 75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / high / long_context | True | n/a | n/a | long_context | 4 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / high / long_context | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 15.4 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | intelligenceIndex | 48.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | artificialAnalysis | claude-opus-5-xhigh | xhigh | intelligenceIndex | 49.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | intelligenceIndex | 50.8 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-high | high | intelligenceIndex | 31.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-xhigh | xhigh | intelligenceIndex | 34.4 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5 | max | intelligenceIndex | 38.2 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | intelligenceIndex | 39.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | intelligenceIndex | 40.9 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | intelligenceIndex | 32.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-xhigh | xhigh | intelligenceIndex | 34.6 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | intelligenceIndex | 37.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | intelligenceIndex | 42.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-xhigh | xhigh | intelligenceIndex | 44 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol | max | intelligenceIndex | 47 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | intelligenceIndex | 34.2 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-xhigh | xhigh | intelligenceIndex | 38 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | intelligenceIndex | 42.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 50.9 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-xhigh | xhigh | intelligenceIndex | 52.4 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra | max | intelligenceIndex | 52.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | intelligenceIndex | 38.8 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-4.7 | liveBench | claude-opus-4-7-xhigh-effort | xhigh | reasoning | 87.1923 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | reasoning | 89.1923 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | reasoning | 91.2115 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | reasoning | 88.6923 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | reasoning | 89.2933 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.4 | liveBench | gpt-5.4-xhigh | xhigh | reasoning | 88.1155 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.4-mini | liveBench | gpt-5.4-mini-xhigh | xhigh | reasoning | 71.3238 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.5 | liveBench | gpt-5.5-xhigh | xhigh | reasoning | 89.6538 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | reasoning | 85.6443 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | reasoning | 91.6538 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | reasoning | 90.6345 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### review

Budget: **hard**, input 5 / output 30 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **750 AIC**; incumbent **750 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-opus-5 / high / default (48.1). Candidate gap: **0 / 3** absolute intelligenceIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **750 AIC**; incumbent **750 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **48.1**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.7 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.7 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.5-flash / medium / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.6-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / medium / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / medium / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / high / default | True | n/a | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / medium / default | True | n/a | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 15.4 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | intelligenceIndex | 44.8 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | intelligenceIndex | 48.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-medium | medium | intelligenceIndex | 28.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-high | high | intelligenceIndex | 31.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | intelligenceIndex | 39.6 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | intelligenceIndex | 39.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | intelligenceIndex | 39.8 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | intelligenceIndex | 40.9 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | intelligenceIndex | 25 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | intelligenceIndex | 32.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | intelligenceIndex | 39.2 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | intelligenceIndex | 42.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | intelligenceIndex | 30.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | intelligenceIndex | 34.2 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | intelligenceIndex | 49.6 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 50.9 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | intelligenceIndex | 38.8 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | reasoning | 84.7693 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | reasoning | 89.2933 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### visual-ui

Budget: **hard**, input 5 / output 25 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-5.6-sol / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-5.6-sol / high / default (77.2). Candidate gap: **0.9 / 3** absolute codingIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **76.3**.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | False | vision_unknown | n/a | default | 1 / 5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.7 / high / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.7 / medium / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.8 / high / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8 / medium / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / medium / default | False | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | True | n/a | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.5-flash / high / default | False | vision_unknown | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.5-flash / medium / default | False | vision_unknown | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.6-flash / high / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.6-flash / medium / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / high / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / medium / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / high / default | False | vision_unknown | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | vision_unknown | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / high / default | False | vision_unknown | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / medium / default | False | vision_unknown | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / high / default | False | vision_unknown | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / medium / default | False | vision_unknown | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / high / default | False | vision_unknown, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / medium / default | False | vision_unknown, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / high / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / medium / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / high / default | False | vision_unknown | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / medium / default | False | vision_unknown | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / high / default | False | vision_unknown | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / medium / default | False | vision_unknown | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / medium / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | codingIndex | 74.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | codingIndex | 76.5 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | codingIndex | 76.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | codingIndex | 74.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | codingIndex | 50.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | codingIndex | 63.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | codingIndex | 77.2 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | codingIndex | 64.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | codingIndex | 67.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | codingIndex | 76.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | codingIndex | 77.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | codingIndex | 72.4 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | coding | 72.489 | False | False | source benchmark harness, not Copilot CLI | selection / corroboration |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### mechanical

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / low / default. Family fallback (informational, not a winner): claude-haiku-4.5.
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
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.7 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-4.6 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.5-flash / low / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.6-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | codingIndex | 66.9 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | codingIndex | 71 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | codingIndex | 73.5 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | codingIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | codingIndex | 69.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | codingIndex | 58.1 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | codingIndex | 75.7 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### triage

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / low / default. Family fallback (informational, not a winner): claude-sonnet-5.
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
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.7 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| claude-sonnet-4.6 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.5-flash / low / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-21T08:51:32.9318304Z | 2026-07-30 |
| gemini-3.6-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.7-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gemini-3.8-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.4-mini / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-21T08:51:32.9318304Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 15.4 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | intelligenceIndex | 39.4 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-low | low | intelligenceIndex | 24.3 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | intelligenceIndex | 36.9 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | intelligenceIndex | 33.5 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | intelligenceIndex | 21 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | intelligenceIndex | 33.5 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | intelligenceIndex | 27.5 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | intelligenceIndex | 45.8 | True | False | source benchmark harness, not Copilot CLI | selection / corroboration |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>
