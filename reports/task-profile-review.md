# Monthly task profile review (2026-09-22)

Availability: **True** (copilot help config); manual confirmation override: **True**.

## Profile decisions

| Profile | Strategy | Current configuration | Recommended configuration | Applied/current after run | Outcome | Confidence |
|---|---|---|---|---|---|---|
| orchestrator | value_balanced | gemini-3.8-flash / high / default | gemini-3.7-flash / high / default | gemini-3.7-flash / high / default | applied_budget_constrained_choice | reduced |
| quick | value_balanced | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | budget_constrained_choice | reduced |
| default-development | value_balanced | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | value_balanced_choice | reduced |
| agentic-implementation | value_balanced | claude-opus-5 / max / default | claude-opus-5 / max / default | claude-opus-5 / max / default | value_balanced_choice | reduced |
| deep-reasoning | value_balanced | claude-opus-5 / high / long_context | claude-opus-5 / high / long_context | claude-opus-5 / high / long_context | budget_constrained_choice | reduced |
| review | value_balanced | claude-opus-5 / high / default | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | applied_value_balanced_choice | reduced |
| visual-ui | value_balanced | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | gemini-3.8-flash / high / default | value_balanced_choice | reduced |
| mechanical | value_balanced | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | gemini-3.8-flash / low / default | budget_constrained_choice | reduced |
| triage | value_balanced | gemini-3.7-flash / low / default | gemini-3.7-flash / low / default | gemini-3.7-flash / low / default | budget_constrained_choice | reduced |

Recommendations rank eligible configurations using each profile's explicit metric routes, not a global model ranking. Supporting scores never blend, rank or veto; overlapping benchmark lineage is not independent corroboration. Unknown publication age, cached evidence, single-source coverage and external harnesses reduce confidence. A context capability is not a benchmark measurement at that context length.
Value-balanced profiles minimize reference AIC within a source-specific gap of their best eligible score, under fixed hard input/output price ceilings. Bands are policy tolerances, not capability percentages or proof of task success. Token-price ceilings are not total session-spend limits.
New workflow metrics start with zero score tolerance: highest published eligible score wins, then cost breaks exact ties. This is a conservative pilot, not a statistical significance claim. Fallback replacements require comparable incumbent evidence and cannot weaken an established selection basis.
Configuration cells show model / effective effort / context; 'none' means the model exposes no effort control. Allowed effort ranges are standing authorization: model and effort changes apply together after confirmation. Force bypasses only the confirmation wait, never hard budgets, allowed ranges, availability, capabilities or evidence requirements.

## Pricing refresh

- Status: **partial**. Source: https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing
- Last successful page fetch: 2026-09-22T13:41:24.8732520Z. Per-model verification ages govern eligibility.
- Freshness limit: 45 days. Missing rows retain their original timestamps. Capabilities are never refreshed by pricing.
- Reference-cost comparison: Aggregate uncached usage across requests within the selected context tier, not a single 1M-token request or predicted task cost. Cache reads/writes are excluded.
- Reference tokens: input 1000000, output 100000.

| Changed model | Tier | Previous input / output USD per M | Current input / output USD per M | Previous cached input / cache write | Current cached input / cache write |
|---|---|---|---|---|---|

- Warning: Missing pricing row: mai-code-1-flash-picker (MAI-Code-1-Flash); retaining original verification timestamp if available.
- Warning: Unmapped GitHub pricing model: Claude Sonnet 4
- Warning: Unmapped GitHub pricing model: GPT-5.4 nano
- Warning: Unmapped GitHub pricing model: Grok 4.7

## Benchmark sources

| Source | Status | Results published | Suite label | Artifact updated | Retrieved | Raw observation identity |
|---|---|---|---|---|---|---|
| artificialAnalysis | ok | n/a | n/a | n/a | 2026-09-22T13:41:31.1158516Z | bf7b90718111f82460a2994adb6bde7a153cec80a78a838663d5da6a731d3eb0&#124;84914393bb4a6e0c43146e57e3ca7f786aaad5d6d3ba0c77edf3270bc3f96d9d |
| artificialAnalysisCodingAgents | ok | n/a | n/a | n/a | 2026-09-22T13:41:32.8277983Z | 468b3c0fdfa17e647398852b59fd03013a572c6959ff09aaa706f12012e40176 |
| artificialAnalysisComponents | ok | n/a | n/a | n/a | 2026-09-22T13:41:33.6368728Z | bdc4cd3fa278bf6a68ef1875fa09422ed24d1620fb449cfe3ccfce6fac66943f |
| liveBench | ok | n/a | 2026-06-25 | 2026-09-22T05:38:00.0000000Z | 2026-09-22T13:41:36.3314279Z | 23db751e33f631944d9d84b764885a786aa783bc47ee247c90a6629d5502ca43 |

Confirmation uses metric-scoped observations, not the raw page fingerprint. Suite labels, artifact updates, row evaluation ages and retrieval times are distinct: an artifact update does not make every row newly evaluated. Unknown dates or methodology versions are not fabricated. AA public components remain separate from API aggregates; public pricing is never imported. Data attribution: https://artificialanalysis.ai and https://github.com/LiveBench/new-livebench.


## Coverage and exclusions

366 distinct exclusions, advisory warnings and evidence gaps. Repeated findings are listed once with every affected profile; full eligibility and scores remain available below.

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
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: f927d9c41b5c3021996eb14c3dd1341e: model_identity_unresolved_or_ambiguous 'Grok 4.7 (xhigh)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: fa2595093fa640e73d072e7d1aa7df82: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-high: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-low: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-medium: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-xhigh: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-fable-5.1: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysis.codingIndex 'claude-4-5-haiku' score_missing_or_invalid | default-development, mechanical, quick, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisComponents.automationBench 'claude-4-5-haiku' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-4-5-haiku' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'max' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisComponents effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.7: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'max' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'max' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-xhigh' score_missing_or_invalid | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'max' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.codingIndex 'claude-sonnet-5-high' score_missing_or_invalid | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.codingIndex 'claude-sonnet-5-low' score_missing_or_invalid | mechanical, quick |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.codingIndex 'claude-sonnet-5-medium' score_missing_or_invalid | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.5-flash: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.6-flash: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: artificialAnalysisComponents.automationBench 'gemini-3-7-flash-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: artificialAnalysisComponents.enterpriseOpsGym 'gemini-3-7-flash-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: artificialAnalysisComponents.enterpriseOpsGym 'gemini-3-7-flash' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: artificialAnalysisComponents.ifbench 'gemini-3-7-flash-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: artificialAnalysisComponents.ifbench 'gemini-3-7-flash-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: artificialAnalysisComponents.ifbench 'gemini-3-7-flash' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.7-flash: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysisComponents.enterpriseOpsGym 'gemini-3-8-flash-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysisComponents.enterpriseOpsGym 'gemini-3-8-flash' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysisComponents.ifbench 'gemini-3-8-flash-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysisComponents.ifbench 'gemini-3-8-flash-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysisComponents.ifbench 'gemini-3-8-flash' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5-mini: no supported effort within the configured range | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4-mini: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.4: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.4: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.4: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-xhigh' score_missing_or_invalid | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-xhigh' score_missing_or_invalid | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-xhigh' score_missing_or_invalid | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra-xhigh' score_missing_or_invalid | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra' score_missing_or_invalid | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisComponents.ifbench 'grok-4-5' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'xhigh' not_in_requested_configurations | agentic-implementation |
| evidence gap | n/a / n/a / n/a | kimi-k2.7-code: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | kimi-k3: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
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

Budget: **hard**, input 3 / output 15 USD per million. Deciding source: artificialAnalysisComponents.
Quality leader before hard-budget exclusions: gpt-6-astra / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AutomationBench-AA > EnterpriseOps-Gym-AA**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **applied_budget_constrained_choice**. Deciding metric: artificialAnalysisComponents.automationBench.
Incumbent selection basis (applied/current after run): artificialAnalysisComponents.automationBench.
AutomationBench-AA (guardrail-adjusted objective fraction): Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA (strict pass@1 fraction): AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.
Configuration selection: **automatic bounded effort**; authorized efforts: high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gemini-3.7-flash / high / default (0.620274929205). Candidate gap: **0 / 0** absolute automationBench score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **0.599300943212**.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| AA-LCR | gemini-3.7-flash / high / default | gemini-3-7-flash | 0.816666666667 | accuracy fraction | n/a | 2026-09-22T13:41:33.6368728Z | False |
| IFBench (AA) | gemini-3.7-flash / high / default | n/a | n/a (missing or invalid) | accuracy fraction | n/a | n/a | n/a |
| LiveBench Instruction Following | gemini-3.7-flash / high / default | n/a | n/a (missing or invalid) | percentage points | n/a | n/a | n/a |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
AA-LCR: Long-document reasoning, not conversational retention.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.7 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | automationBench | 0.535640105154 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | automationBench | 0.320966388144 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.7-flash | artificialAnalysisComponents | gemini-3-7-flash | high | automationBench | 0.620274929205 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysisComponents | gemini-3-8-flash | high | automationBench | 0.599300943212 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | automationBench | 0.355879429306 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | automationBench | 0.553122035739 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | automationBench | 0.420203829518 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | automationBench | 0.666122174975 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | automationBench | 0.579348603508 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | lcr | 0.496666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.7-flash | artificialAnalysisComponents | gemini-3-7-flash | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.8-flash | artificialAnalysisComponents | gemini-3-8-flash | high | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | ifbench | 0.691836734694 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | ifbench | 0.644217687075 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | instructionFollowing | 81.4125 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### quick

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / low / default. Family fallback (informational, not a winner): claude-haiku-4.5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AA Coding Index > LiveBench Coding**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **budget_constrained_choice**. Deciding metric: artificialAnalysis.codingIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.codingIndex.
AA Coding Index (index points): Coding aggregate; not direct evidence of review or UI implementation quality.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
Configuration selection: **automatic bounded effort**; authorized efforts: low. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gemini-3.8-flash / low / default (73.5). Candidate gap: **0 / 3** absolute codingIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **73.5**.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| IFBench (AA) | gemini-3.8-flash / low / default | n/a | n/a (missing or invalid) | accuracy fraction | n/a | n/a | n/a |
| LiveBench Instruction Following | gemini-3.8-flash / low / default | n/a | n/a (missing or invalid) | percentage points | n/a | n/a | n/a |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.7 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-4.6 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.5-flash / low / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.6-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | codingIndex | 66.9 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | codingIndex | 71 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | codingIndex | 73.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | codingIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | codingIndex | 69.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | codingIndex | 58.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | codingIndex | 75.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### default-development

Budget: **hard**, input 4 / output 20 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-5.6-sol / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AA Coding Index > LiveBench Coding**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: artificialAnalysis.codingIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.codingIndex.
AA Coding Index (index points): Coding aggregate; not direct evidence of review or UI implementation quality.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-5.6-sol / high / default (77.2). Candidate gap: **0.9 / 3** absolute codingIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **76.3**.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| IFBench (AA) | gemini-3.8-flash / high / default | n/a | n/a (missing or invalid) | accuracy fraction | n/a | n/a | n/a |
| LiveBench Instruction Following | gemini-3.8-flash / high / default | gemini-3.8-flash-high | 81.4125 | percentage points | n/a | 2026-09-22T13:41:36.3314279Z | False |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.7 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.7 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.5-flash / medium / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.6-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / medium / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / medium / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | codingIndex | 76.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | codingIndex | 74.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | codingIndex | 76.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | codingIndex | 74.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | codingIndex | 63.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | codingIndex | 50.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | codingIndex | 77.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | codingIndex | 67.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | codingIndex | 64.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | codingIndex | 77.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | codingIndex | 76.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | codingIndex | 72.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | coding | 72.489 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | ifbench | 0.691836734694 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | ifbench | 0.695918367347 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | ifbench | 0.644217687075 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | ifbench | 0.621768707483 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | instructionFollowing | 63.22075 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | instructionFollowing | 81.4125 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### agentic-implementation

Budget: **hard**, input 10 / output 50 USD per million. Deciding source: artificialAnalysisCodingAgents.
Quality leader before hard-budget exclusions: gpt-6-astra / max / default. Family fallback (informational, not a winner): gpt-5.3-codex.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AA Coding Agent Index > LiveBench Agentic Coding**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: artificialAnalysisCodingAgents.codingAgentIndex.
Incumbent selection basis (applied/current after run): artificialAnalysisCodingAgents.codingAgentIndex.
AA Coding Agent Index (fraction): External coding-agent harness, not Copilot CLI.
LiveBench Agentic Coding (percentage points): External agentic coding evaluation, not the local orchestration workflow.
Configuration selection: **automatic bounded effort**; authorized efforts: high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **750 AIC**; incumbent **750 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-6-astra / max / default (0.616450449879). Candidate gap: **0.0191867768945 / 0.03** absolute codingAgentIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **750 AIC**; incumbent **750 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **0.597263672984**.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| AutomationBench-AA | claude-opus-5 / max / default | claude-opus-5 | 0.565735557649 | guardrail-adjusted objective fraction | n/a | 2026-09-22T13:41:33.6368728Z | False |
| EnterpriseOps-Gym-AA | claude-opus-5 / max / default | claude-opus-5 | 0.474783646673 | strict pass@1 fraction | n/a | 2026-09-22T13:41:33.6368728Z | False |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
AutomationBench-AA: Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA: AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.7 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.7 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.7 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | True | n/a | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / max / default | True | n/a | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / xhigh / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / xhigh / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / high / default | True | n/a | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / xhigh / default | True | n/a | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / high / default | True | n/a | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / max / default | True | n/a | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysisCodingAgents | Claude Code - Opus 5 (max) | max | codingAgentIndex | 0.597263672984 | True | False | Claude Code; variant 409518818f1e9ad21995d70631ab05b6; external agent harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysisCodingAgents | Antigravity SDK - Gemini 3.8 Flash (high) | high | codingAgentIndex | 0.418631552945 | True | False | Antigravity SDK v0.1.12; variant d1003684d8f29b95a3b14d2a7722221a; external agent harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisCodingAgents | Codex - GPT-5.6 Sol (max) ({'reasoning_effort': 'max'}) | max | codingAgentIndex | 0.545591272896 | True | False | Codex; variant 709f801275dedae5675b1f56e97c9df3; external agent harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisCodingAgents | Codex - GPT-6 Astra (max) ({'reasoning_effort': 'max'}) | max | codingAgentIndex | 0.616450449879 | True | False | Codex; variant 9e810ff3c6cce5ebaaff7c744c687a47; external agent harness, not Copilot CLI | deciding |
| claude-opus-4.7 | liveBench | claude-opus-4-7-xhigh-effort | xhigh | agenticCoding | 50.6563333333 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | agenticCoding | 50.505 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | agenticCoding | 65.202 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | agenticCoding | 59.394 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | agenticCoding | 54.2423333333 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.4 | liveBench | gpt-5.4-xhigh | xhigh | agenticCoding | 53.8383333333 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.4-mini | liveBench | gpt-5.4-mini-xhigh | xhigh | agenticCoding | 41.6666666667 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.5 | liveBench | gpt-5.5-xhigh | xhigh | agenticCoding | 53.9896666667 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | agenticCoding | 48.4343333333 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | agenticCoding | 56.212 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | agenticCoding | 54.9496666667 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | automationBench | 0.535640105154 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | automationBench | 0.565735557649 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | automationBench | 0.532191921095 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | automationBench | 0.320966388144 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | automationBench | 0.36512675717 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | automationBench | 0.344762688906 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.7-flash | artificialAnalysisComponents | gemini-3-7-flash | high | automationBench | 0.620274929205 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.8-flash | artificialAnalysisComponents | gemini-3-8-flash | high | automationBench | 0.599300943212 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | automationBench | 0.355879429306 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | automationBench | 0.502086176376 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | automationBench | 0.425977673743 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | automationBench | 0.553122035739 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | automationBench | 0.600811499628 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | automationBench | 0.553116726933 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | automationBench | 0.420203829518 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | automationBench | 0.596499580253 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | automationBench | 0.47136313406 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | automationBench | 0.666122174975 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | automationBench | 0.684917480669 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | automationBench | 0.671777802022 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | automationBench | 0.579348603508 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | enterpriseOpsGym | 0.474783646673 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | enterpriseOpsGym | 0.446732318711 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | enterpriseOpsGym | 0.438675022381 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | enterpriseOpsGym | 0.429125634139 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | enterpriseOpsGym | 0.384959713518 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### deep-reasoning

Budget: **hard**, input 10 / output 45 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / max / long_context. Family fallback (informational, not a winner): claude-opus-5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AA Intelligence Index > LiveBench Reasoning**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **budget_constrained_choice**. Deciding metric: artificialAnalysis.intelligenceIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.intelligenceIndex.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning (percentage points): Reasoning proxy; does not establish interactive triage skill.
Configuration selection: **automatic bounded effort**; authorized efforts: high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **750 AIC**; incumbent **750 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-opus-5 / max / long_context (50.8). Candidate gap: **2.7 / 3** absolute intelligenceIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **750 AIC**; incumbent **750 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **48.1**.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| AA-LCR | claude-opus-5 / high / long_context | claude-opus-5-high | 0.79 | accuracy fraction | n/a | 2026-09-22T13:41:33.6368728Z | False |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
AA-LCR: Long-document reasoning, not conversational retention.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / long_context | False | context_unsupported | n/a | default | 1 / 5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.7 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.7 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.7 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.8 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / high / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / max / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / xhigh / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-4.6 / high / long_context | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-4.6 / max / long_context | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-5 / high / long_context | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-5 / max / long_context | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-5 / xhigh / long_context | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.5-flash / high / long_context | True | n/a | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.6-flash / high / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / high / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / high / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / high / long_context | False | context_unsupported | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / long_context | False | context_unsupported | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / high / long_context | True | n/a | n/a | long_context | 5 / 22.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / xhigh / long_context | True | n/a | n/a | long_context | 5 / 22.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / high / long_context | False | context_unsupported | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / xhigh / long_context | False | context_unsupported | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / high / long_context | True | n/a | n/a | long_context | 10 / 45 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / xhigh / long_context | True | n/a | n/a | long_context | 10 / 45 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / high / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / max / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / xhigh / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / high / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / max / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / xhigh / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / high / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / max / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / xhigh / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / high / long_context | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | long_context | 20 / 75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / max / long_context | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | long_context | 20 / 75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / xhigh / long_context | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | long_context | 20 / 75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / high / long_context | True | n/a | n/a | long_context | 4 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / high / long_context | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 15.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | intelligenceIndex | 48.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | intelligenceIndex | 50.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysis | claude-opus-5-xhigh | xhigh | intelligenceIndex | 49.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-high | high | intelligenceIndex | 31.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5 | max | intelligenceIndex | 38.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-xhigh | xhigh | intelligenceIndex | 34.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | intelligenceIndex | 39.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | intelligenceIndex | 40.9 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | intelligenceIndex | 32.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | intelligenceIndex | 37.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-xhigh | xhigh | intelligenceIndex | 34.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | intelligenceIndex | 42.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol | max | intelligenceIndex | 47 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-xhigh | xhigh | intelligenceIndex | 44 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | intelligenceIndex | 34.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | intelligenceIndex | 42.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-xhigh | xhigh | intelligenceIndex | 38 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 50.9 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra | max | intelligenceIndex | 52.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-xhigh | xhigh | intelligenceIndex | 52.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | intelligenceIndex | 38.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-4.7 | liveBench | claude-opus-4-7-xhigh-effort | xhigh | reasoning | 87.19225 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | reasoning | 89.19225 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | reasoning | 91.2115 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | reasoning | 88.69225 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | reasoning | 89.29325 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.4 | liveBench | gpt-5.4-xhigh | xhigh | reasoning | 88.1155 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.4-mini | liveBench | gpt-5.4-mini-xhigh | xhigh | reasoning | 71.32375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.5 | liveBench | gpt-5.5-xhigh | xhigh | reasoning | 89.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | reasoning | 85.64425 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | reasoning | 91.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | reasoning | 90.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | lcr | 0.496666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | lcr | 0.82 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.7-flash | artificialAnalysisComponents | gemini-3-7-flash | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.8-flash | artificialAnalysisComponents | gemini-3-8-flash | high | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | lcr | 0.84 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | lcr | 0.806666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### review

Budget: **hard**, input 5 / output 30 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-5.6-sol / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AA Coding Index > LiveBench Coding**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **applied_value_balanced_choice**. Deciding metric: artificialAnalysis.codingIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.codingIndex.
AA Coding Index (index points): Coding aggregate; not direct evidence of review or UI implementation quality.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **750 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-5.6-sol / high / default (77.2). Candidate gap: **0.9 / 3** absolute codingIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **750 AIC** (1 AIC = USD 0.01).
Candidate cost change: **-85%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **76.5**.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| LiveBench Reasoning | gemini-3.8-flash / high / default | gemini-3.8-flash-high | 89.29325 | percentage points | n/a | 2026-09-22T13:41:36.3314279Z | False |
| AA-LCR | gemini-3.8-flash / high / default | gemini-3-8-flash | 0.813333333333 | accuracy fraction | n/a | 2026-09-22T13:41:33.6368728Z | False |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
LiveBench Reasoning: Reasoning proxy; does not establish interactive triage skill.
AA-LCR: Long-document reasoning, not conversational retention.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.7 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.7 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.5-flash / high / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.5-flash / medium / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.6-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.6-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | True | n/a | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / high / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / medium / default | True | n/a | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / high / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / medium / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / high / default | True | n/a | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / medium / default | True | n/a | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | codingIndex | 76.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | codingIndex | 74.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | codingIndex | 76.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | codingIndex | 74.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | codingIndex | 63.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | codingIndex | 50.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | codingIndex | 77.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | codingIndex | 67.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | codingIndex | 64.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | codingIndex | 77.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | codingIndex | 76.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | codingIndex | 72.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | coding | 72.489 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | reasoning | 84.76925 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | reasoning | 89.29325 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | lcr | 0.496666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | lcr | 0.82 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-medium | medium | lcr | 0.736666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.7-flash | artificialAnalysisComponents | gemini-3-7-flash | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.7-flash | artificialAnalysisComponents | gemini-3-7-flash-medium | medium | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.8-flash | artificialAnalysisComponents | gemini-3-8-flash | high | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.8-flash | artificialAnalysisComponents | gemini-3-8-flash-medium | medium | lcr | 0.84 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | lcr | 0.75 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | lcr | 0.74 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### visual-ui

Budget: **hard**, input 5 / output 25 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-5.6-sol / high / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AA Coding Index > LiveBench Coding**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: artificialAnalysis.codingIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.codingIndex.
AA Coding Index (index points): Coding aggregate; not direct evidence of review or UI implementation quality.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-5.6-sol / high / default (77.2). Candidate gap: **0.9 / 3** absolute codingIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **76.3**.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| MMMU Pro (AA) | gemini-3.8-flash / high / default | gemini-3-8-flash | 0.856069364162 | accuracy fraction | n/a | 2026-09-22T13:41:33.6368728Z | False |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
MMMU Pro (AA): Visual understanding, not UI implementation fidelity.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | False | vision_unknown | n/a | default | 1 / 5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.7 / high / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.7 / medium / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.8 / high / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8 / medium / default | False | vision_unknown | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / high / default | False | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / medium / default | False | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-4.6 / high / default | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | True | n/a | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.5-flash / high / default | False | vision_unknown | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.5-flash / medium / default | False | vision_unknown | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.6-flash / high / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.6-flash / medium / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / high / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / medium / default | False | vision_unknown | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / high / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / medium / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / high / default | False | vision_unknown | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | vision_unknown | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / high / default | False | vision_unknown | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / medium / default | False | vision_unknown | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / high / default | False | vision_unknown | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / medium / default | False | vision_unknown | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / high / default | False | vision_unknown, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / medium / default | False | vision_unknown, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / high / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / medium / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / high / default | False | vision_unknown | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / medium / default | False | vision_unknown | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / high / default | False | vision_unknown | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / medium / default | False | vision_unknown | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / medium / default | False | vision_unknown | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysis | claude-opus-5-high | high | codingIndex | 76.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysis | claude-opus-5-medium | medium | codingIndex | 74.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash | high | codingIndex | 76.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-medium | medium | codingIndex | 71.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash | high | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-medium | medium | codingIndex | 74.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-high | high | codingIndex | 63.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-medium | medium | codingIndex | 50.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-high | high | codingIndex | 77.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-medium | medium | codingIndex | 76.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-high | high | codingIndex | 67.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-medium | medium | codingIndex | 64.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | codingIndex | 77.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | codingIndex | 76.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.5 | artificialAnalysis | grok-4-5 | high | codingIndex | 72.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gemini-3.8-flash | liveBench | gemini-3.8-flash-high | high | coding | 72.489 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | mmmuPro | 0.551445086705 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | mmmuPro | 0.824277456647 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | mmmuPro | 0.816184971098 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.7-flash | artificialAnalysisComponents | gemini-3-7-flash | high | mmmuPro | 0.854913294798 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.7-flash | artificialAnalysisComponents | gemini-3-7-flash-medium | medium | mmmuPro | 0.847398843931 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.8-flash | artificialAnalysisComponents | gemini-3-8-flash | high | mmmuPro | 0.856069364162 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gemini-3.8-flash | artificialAnalysisComponents | gemini-3-8-flash-medium | medium | mmmuPro | 0.842196531792 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | mmmuPro | 0.775722543353 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | mmmuPro | 0.75838150289 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | mmmuPro | 0.818497109827 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | mmmuPro | 0.81387283237 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | mmmuPro | 0.790751445087 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | mmmuPro | 0.767630057803 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | mmmuPro | 0.864161849711 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | mmmuPro | 0.850867052023 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | mmmuPro | 0.804046242775 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### mechanical

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysisComponents.
Quality leader before hard-budget exclusions: gpt-6-astra / low / default. Family fallback (informational, not a winner): claude-haiku-4.5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AutomationBench-AA > AA Coding Index > LiveBench Coding**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **budget_constrained_choice**. Deciding metric: artificialAnalysisComponents.automationBench.
Incumbent selection basis (applied/current after run): artificialAnalysisComponents.automationBench.
AutomationBench-AA (guardrail-adjusted objective fraction): Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
AA Coding Index (index points): Coding aggregate; not direct evidence of review or UI implementation quality.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
Configuration selection: **automatic bounded effort**; authorized efforts: low. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gemini-3.8-flash / low / default (0.365094046149). Candidate gap: **0 / 0** absolute automationBench score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **0.365094046149**.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| IFBench (AA) | gemini-3.8-flash / low / default | n/a | n/a (missing or invalid) | accuracy fraction | n/a | n/a | n/a |
| LiveBench Instruction Following | gemini-3.8-flash / low / default | n/a | n/a (missing or invalid) | percentage points | n/a | n/a | n/a |
| EnterpriseOps-Gym-AA | gemini-3.8-flash / low / default | n/a | n/a (missing or invalid) | strict pass@1 fraction | n/a | n/a | n/a |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.
EnterpriseOps-Gym-AA: AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.7 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-4.6 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.5-flash / low / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.6-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-low | low | automationBench | 0.51790662987 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-low | low | automationBench | 0.19901936569 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysisComponents | gemini-3-8-flash-low | low | automationBench | 0.365094046149 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-low | low | automationBench | 0.116921622583 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | automationBench | 0.409856701134 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | automationBench | 0.29106376138 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-low | low | automationBench | 0.590967261045 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | codingIndex | 66.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | codingIndex | 71 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | codingIndex | 73.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | codingIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | codingIndex | 69.7 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | codingIndex | 58.1 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | codingIndex | 75.7 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### triage

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / low / default. Family fallback (informational, not a winner): claude-sonnet-5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AA Intelligence Index > LiveBench Reasoning**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **budget_constrained_choice**. Deciding metric: artificialAnalysis.intelligenceIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.intelligenceIndex.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning (percentage points): Reasoning proxy; does not establish interactive triage skill.
Configuration selection: **automatic bounded effort**; authorized efforts: low. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gemini-3.7-flash / low / default (36.9). Candidate gap: **0 / 3** absolute intelligenceIndex score points.
Lowest reference cost within the band wins; an equally priced, qualified incumbent configuration stays. Reference usage: candidate **112.5 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **36.9**.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| IFBench (AA) | gemini-3.7-flash / low / default | n/a | n/a (missing or invalid) | accuracy fraction | n/a | n/a | n/a |
| LiveBench Instruction Following | gemini-3.7-flash / low / default | n/a | n/a (missing or invalid) | percentage points | n/a | n/a | n/a |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.7 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| claude-sonnet-4.6 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 3 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.5-flash / low / default | True | n/a | n/a | default | 1.5 / 9 | 2026-09-22T13:41:24.8732520Z | 2026-07-30 |
| gemini-3.6-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.7-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gemini-3.8-flash / low / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 2.5 / 15 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.4-mini / low / default | True | n/a | n/a | default | 0.75 / 4.5 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 30 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-09-22T13:41:24.8732520Z | 2026-09-08 |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 | artificialAnalysis | claude-4-5-haiku | none | intelligenceIndex | 15.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysis | claude-opus-5-low | low | intelligenceIndex | 39.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysis | claude-sonnet-5-low | low | intelligenceIndex | 24.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.7-flash | artificialAnalysis | gemini-3-7-flash-low | low | intelligenceIndex | 36.9 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gemini-3.8-flash | artificialAnalysis | gemini-3-8-flash-low | low | intelligenceIndex | 33.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna-low | low | intelligenceIndex | 21 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysis | gpt-5-6-sol-low | low | intelligenceIndex | 33.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra-low | low | intelligenceIndex | 27.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | intelligenceIndex | 45.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>
