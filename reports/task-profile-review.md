# Monthly task profile review (2026-10-30)

Availability: **True** (local model-discovery snapshot; status=valid; observed=2026-10-30T08:37:00.782Z; validity=7 days; not live-verified by this review; recorded runtime reconciled); manual confirmation override: **True**.

## Model discovery and onboarding

Recorded authenticated runtime metadata usable: **True**; status **ok**; runtime 1.0.62. This review does not authenticate to a user's account.
Local discovery snapshot: **valid**; observed **2026-10-30T08:37:00.782Z**; validity **7 days**. Availability was verified locally, not live-verified by this review.
Local model-discovery snapshot is valid (validity: 7 days).
Runtime and help catalogs are reconciled, not assumed exhaustive. Absence is not an explicit denial; runtime-disabled, ambiguous, denylisted and virtual routing models cannot enter selection. Public pricing/benchmark rows alone do not prove Copilot availability.
Help-only entries are CLI-catalog evidence, not proof of per-account entitlement. The source columns distinguish these from recorded authenticated runtime entries.
Official retirement evidence: **ok**; retrieved **2026-10-30T08:37:01.8961632Z**; source https://docs.github.com/en/copilot/reference/ai-models/supported-models. Effective, unconditional retirements override stale help entries. Scheduled dates are evaluated in UTC; documented exceptions remain conditional, not blanket denials. Suggested alternatives are migration guidance, not qualified winners.
Verified catalog facts are updated before comparison. Ready for comparison is not role qualification: each profile still requires its exact configuration evidence, budget, bands and confirmation.
- Warning: claude-opus-4.8-fast: conflicting runtime/pricing identities; retirement scope is not assumed.

<details>
<summary>Discovered models, verified additions and remaining blockers</summary>

| Model | Runtime listed | Help listed | Lifecycle | Retirement date | Onboarding status | Blockers / limitations |
|---|---|---|---|---|---|---|
| auto | True | False | not_listed | n/a | blocked | denylisted_disabled_virtual_or_ambiguous; capabilities_missing; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| claude-fable-5 | False | True | not_listed | n/a | blocked | denylisted_disabled_virtual_or_ambiguous; benchmark_aliases_missing; structured agent evidence is resolved separately |
| claude-fable-5.1 | False | True | not_listed | n/a | blocked | enabled_runtime_metadata_missing; existing facts retain their original verification dates; capabilities_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| claude-haiku-4.5 | True | True | not_listed | n/a | ready_for_comparison | n/a |
| claude-haiku-5.5 | True | True | not_listed | n/a | ready_for_comparison | n/a |
| claude-opus-4.5 | False | False | unknown | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| claude-opus-4.6 | False | False | unknown | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| claude-opus-4.7 | False | False | retired | 2026-10-02 | blocked | officially_retired_on_2026-10-02 |
| claude-opus-4.8 | True | True | not_listed | n/a | ready_for_comparison | n/a |
| claude-opus-4.8-fast | True | True | unknown | n/a | partial | exact_pricing_identity_missing_or_conflicting; benchmark_aliases_missing; structured agent evidence is resolved separately |
| claude-opus-5 | True | True | not_listed | n/a | ready_for_comparison | n/a |
| claude-opus-5.5 | True | True | not_listed | n/a | ready_for_comparison | n/a |
| claude-sonnet-4.5 | False | False | unknown | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| claude-sonnet-4.6 | False | True | conditional | 2026-09-01 | partial | retirement_scope_unconfirmed; Claude Sonnet 4.6 remains available to individual Copilot subscribers on annual plans. The retirement of Claude Sonnet 4.6 does not apply to these subscribers.; enabled_runtime_metadata_missing; existing facts retain their original verification dates |
| claude-sonnet-5 | True | True | not_listed | n/a | ready_for_comparison | n/a |
| claude-sonnet-5.5 | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gemini-3.1-pro-preview | False | False | unknown | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| gemini-3.5-flash | False | False | retired | 2026-10-02 | blocked | officially_retired_on_2026-10-02 |
| gemini-3.6-flash | False | False | retired | 2026-10-02 | blocked | officially_retired_on_2026-10-02 |
| gemini-3.7-flash | False | True | retired | 2026-10-19 | blocked | officially_retired_on_2026-10-19 |
| gemini-3.8-flash | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gemini-4-argon | True | True | not_listed | n/a | partial | benchmark_aliases_missing; structured agent evidence is resolved separately |
| gpt-5-mini | False | True | retired | 2026-10-19 | blocked | officially_retired_on_2026-10-19; benchmark_aliases_missing; structured agent evidence is resolved separately |
| gpt-5.2 | False | False | unknown | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| gpt-5.2-codex | False | False | unknown | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| gpt-5.3-codex | True | True | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates |
| gpt-5.4 | False | True | retired | 2026-10-19 | blocked | officially_retired_on_2026-10-19 |
| gpt-5.4-mini | False | True | retired | 2026-10-19 | blocked | officially_retired_on_2026-10-19 |
| gpt-5.5 | False | True | retired | 2026-10-19 | blocked | officially_retired_on_2026-10-19 |
| gpt-5.6-luna | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-5.6-sol | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-5.6-terra | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-6-astra | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-6-luna | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-6-sol | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-6.1-sol | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-6.1-terra | True | False | not_listed | n/a | blocked | enabled_runtime_metadata_missing; existing facts retain their original verification dates; capabilities_missing; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| grok-4.5 | False | True | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates |
| grok-4.6 | True | True | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates |
| grok-4.7 | True | True | not_listed | n/a | blocked | enabled_runtime_metadata_missing; existing facts retain their original verification dates; capabilities_missing; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| kimi-k3 | False | True | not_listed | n/a | blocked | enabled_runtime_metadata_missing; existing facts retain their original verification dates; capabilities_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| mai-code-1-flash-picker | False | False | retired | 2026-09-10 | blocked | officially_retired_on_2026-09-10; benchmark_aliases_missing; structured agent evidence is resolved separately |
| mai-code-1.1-flash | True | True | not_listed | n/a | partial | benchmark_aliases_missing; structured agent evidence is resolved separately |
| Claude Sonnet 4 | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| GPT-5.4 nano | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| GPT-6.1 Terra | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| Grok 4.7 | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |

Catalog changes: 1. Unmapped benchmark variants: 574; complete discovery details are retained in `data/model-onboarding-snapshot.json`. Such variants may be unrelated to Copilot and are not automatically admitted.
</details>


## Profile decisions

| Profile | Strategy | Current configuration | Recommended configuration | Applied/current after run | Outcome | Confidence |
|---|---|---|---|---|---|---|
| orchestrator | value_balanced | grok-4.6 / high / default | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | applied_budget_constrained_choice | reduced |
| quick | value_balanced | gemini-3.8-flash / none / default | gpt-6.1-sol / low / default | gemini-3.8-flash / none / default | retained_fallback_incumbent_evidence_missing | reduced |
| default-development | value_balanced | gemini-3.8-flash / none / default | n/a | gemini-3.8-flash / none / default | retained_no_role_qualified_candidate | none |
| agentic-implementation | value_balanced | claude-sonnet-5.5 / max / default | claude-opus-5.5 / max / default | claude-sonnet-5.5 / max / default | retained_stronger_incumbent_basis | reduced |
| deep-reasoning | value_balanced | gpt-6.1-sol / xhigh / long_context | gpt-6.1-sol / xhigh / long_context | gpt-6.1-sol / xhigh / long_context | budget_constrained_choice | reduced |
| review | value_balanced | claude-opus-5 / high / default | n/a | claude-opus-5 / high / default | retained_insufficient_role_evidence | none |
| visual-ui | value_balanced | gemini-3.8-flash / none / default | gpt-6.1-sol / high / default | gemini-3.8-flash / none / default | retained_fallback_incumbent_evidence_missing | reduced |
| mechanical | value_balanced | gemini-3.8-flash / none / default | n/a | gemini-3.8-flash / none / default | retained_insufficient_role_evidence | none |
| triage | value_balanced | gpt-6.1-sol / low / default | n/a | gpt-6.1-sol / low / default | retained_insufficient_role_evidence | none |

Normal recommendations require the intersection of each profile's explicit qualification dimensions, not one global model ranking. Price decides only among configurations passing every required band. Every comparison needs at least two distinct eligible models; multiple efforts do not inflate coverage. Empty intersections or insufficient evidence retain a non-retired current configuration without certifying it. Supporting-only scores never blend, rank or veto; overlapping benchmark lineage is not independent corroboration. Unknown publication age, cached evidence, single-source coverage and external harnesses reduce confidence. A context capability is not a benchmark measurement at that context length.
An effectively retired incumbent triggers mandatory recovery without waiting for confirmation or comparable incumbent evidence: a fully qualified winner first, otherwise the existing primary benchmark/value rules, otherwise an exact GitHub-suggested successor. Emergency migrations are not certified role-qualified winners. All hard admissibility and authorized configuration limits remain binding; no safe replacement fails the review instead of publishing a retained retired model.
Value-balanced profiles minimize reference AIC within a source-specific gap of their best eligible score, under fixed hard input/output price ceilings. Bands are policy tolerances, not capability percentages or proof of task success. Token-price ceilings are not total session-spend limits.
Orchestrator workflow metrics allow a 0.03 absolute gap; Mechanical retains zero workflow tolerance. For normal optimization every other required dimension must also pass, so the intersection may be empty. These are policy tolerances, not statistical significance claims. Normal fallback replacements require comparable incumbent evidence and cannot weaken an established primary or qualification basis.
Configuration cells show model / effective effort / context; 'none' means the model exposes no effort control. Allowed effort ranges are standing authorization: model and effort changes apply together after confirmation, except mandatory retirement recovery. Force bypasses only the normal confirmation wait, never hard budgets, allowed ranges, availability, capabilities or evidence requirements.

## Pricing refresh

- Status: **partial**. Source: https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing
- Last successful page fetch: 2026-10-30T14:10:58.8450985Z. Per-model verification ages govern eligibility.
- Freshness limit: 45 days. Missing rows retain their original timestamps. Capabilities are never refreshed by pricing.
- Reference-cost comparison: Aggregate uncached usage across requests within the selected context tier, not a single 1M-token request or predicted task cost. Cache reads/writes are excluded.
- Reference tokens: input 1000000, output 100000.

| Changed model | Tier | Previous input / output USD per M | Current input / output USD per M | Previous cached input / cache write | Current cached input / cache write |
|---|---|---|---|---|---|
| gemini-4-argon | default | n/a / n/a | 2 / 10 | n/a / n/a | 0.1 / n/a |

- Warning: Missing pricing row: claude-opus-4.7 (Claude Opus 4.7); retaining original verification timestamp if available.
- Warning: Missing pricing row: gemini-3.5-flash (Gemini 3.5 Flash); retaining original verification timestamp if available.
- Warning: Missing pricing row: gemini-3.6-flash (Gemini 3.6 Flash); retaining original verification timestamp if available.
- Warning: Missing pricing row: gemini-3.7-flash (Gemini 3.7 Flash); retaining original verification timestamp if available.
- Warning: Missing pricing row: gpt-5-mini (GPT-5 mini); retaining original verification timestamp if available.
- Warning: Missing pricing row: gpt-5.4 (GPT-5.4); retaining original verification timestamp if available.
- Warning: Missing pricing row: gpt-5.4-mini (GPT-5.4 mini); retaining original verification timestamp if available.
- Warning: Missing pricing row: gpt-5.5 (GPT-5.5); retaining original verification timestamp if available.
- Warning: Missing pricing row: kimi-k2.7-code (Kimi K2.7 Code); retaining original verification timestamp if available.
- Warning: Missing pricing row: mai-code-1-flash-picker (MAI-Code-1-Flash); retaining original verification timestamp if available.
- Warning: Unmapped GitHub pricing model: Claude Sonnet 4
- Warning: Unmapped GitHub pricing model: GPT-5.4 nano
- Warning: Unmapped GitHub pricing model: GPT-6.1 Terra
- Warning: Unmapped GitHub pricing model: Grok 4.7

## Benchmark sources

| Source | Status | Results published | Suite label | Artifact updated | Retrieved | Raw observation identity |
|---|---|---|---|---|---|---|
| artificialAnalysis | ok | n/a | n/a | n/a | 2026-10-30T14:10:53.3261426Z | 44eb3d63920077970cbb2a61674917e03da78e6c1712188b68900d52a3f7a63f&#124; |
| artificialAnalysisCodingAgents | ok | n/a | n/a | n/a | 2026-10-30T14:10:54.8148219Z | 496ece77d36aa0f436dbf59d3243de7b678eecab476330cffd04d90a782cd592 |
| artificialAnalysisComponents | ok | n/a | n/a | n/a | 2026-10-30T14:10:56.0706358Z | 2b246d99f32b30acf8d0d598070be64ae24f73adcacf1c3524fa595d03cfb03e |
| liveBench | ok | n/a | 2026-06-25 | 2026-10-30T05:36:39.0000000Z | 2026-10-30T14:10:57.9654633Z | a8d2183fc195b3177c396c0fbe6ac80040e2a4090717d391c9a2c6ec3243207d |

Confirmation uses metric-scoped observations, not the raw page fingerprint. Suite labels, artifact updates, row evaluation ages and retrieval times are distinct: an artifact update does not make every row newly evaluated. Unknown dates or methodology versions are not fabricated. AA public components remain separate from API aggregates; public pricing is never imported. Data attribution: https://artificialanalysis.ai and https://livebench.ai (LiveBench 1.x data; not LiveBench 2.0).


## Coverage and exclusions

427 distinct exclusions, advisory warnings and evidence gaps. Repeated findings are listed once with every affected profile; full eligibility and scores remain available below.

<details>
<summary>Grouped coverage details</summary>

| Kind | Configuration (model / effort / context) | Finding | Affected profiles |
|---|---|---|---|
| advisory warning | claude-sonnet-4.6 / high / default | model_retirement_scope_unconfirmed | agentic-implementation, default-development, orchestrator, review, visual-ui |
| advisory warning | claude-sonnet-4.6 / high / long_context | model_retirement_scope_unconfirmed | deep-reasoning |
| advisory warning | claude-sonnet-4.6 / low / default | model_retirement_scope_unconfirmed | mechanical, quick, triage |
| advisory warning | claude-sonnet-4.6 / max / default | model_retirement_scope_unconfirmed | agentic-implementation |
| advisory warning | claude-sonnet-4.6 / max / long_context | model_retirement_scope_unconfirmed | deep-reasoning |
| advisory warning | claude-sonnet-4.6 / medium / default | model_retirement_scope_unconfirmed | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 047ef12b001416f72e30e1ad633988e2: model_identity_unresolved_or_ambiguous 'Muse Wonder Full (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 06c2cfad6e3aba9000f2dd5e429d4407: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 1630d319b5e4dc5183cb88a2b2af1646: model_identity_unresolved_or_ambiguous 'Qwen3.8 Max' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 24c98f188d41522a849006ac453fdebe: model_identity_unresolved_or_ambiguous 'DeepSeek V4.1 Flash 1017 (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 24cd2ab21d1cf5161ddd831f0949bff4: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 41bcc9881ff1465f62e417e5a7535e20: model_identity_unresolved_or_ambiguous 'GPT-6.1 Terra (High)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 52f72f7f3393c5edf92b32326e7a678d: model_identity_unresolved_or_ambiguous 'Muse Wonder (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 5bc9ed9064c8cd589bfd3aaad4bbebf8: model_identity_unresolved_or_ambiguous 'GPT-6.1 Terra (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 5c82a7985b08f35190cc0db574fd1773: composite_or_ambiguous_model_label 'Claude Fable 5.1 (Max, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 615aa2e21916e4843210a552131d95b7: variant_unavailable_or_unknown | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 730b8ffd93e83875305984c999467c69: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 736e1c6006fd243c9cc384b61c478e97: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 88c83705811535bca8ee000bfd3a256c: model_identity_unresolved_or_ambiguous 'Kimi K3 (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 96d7404e06194027474a6cc3bb31c068: model_identity_unresolved_or_ambiguous 'GLM-5.3 (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 9983e10d68576074ad63407d0ca81e4b: composite_or_ambiguous_model_label 'Claude Sonnet 5.5 (Max, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 9b52f0eb016964fb4421a352b9c9518c: model_identity_unresolved_or_ambiguous 'GPT-6.1 Terra (Xhigh)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 9fcf1e000a8ac75cca614977bcac25da: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: a3eeef492929228973b8da75e051291d: model_identity_unresolved_or_ambiguous 'GPT-6.1 Terra (Medium)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: a92c8b68f37df782f0e978e0e302b023: model_identity_unresolved_or_ambiguous 'Grok 4.7 (Xhigh)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: accfbb12d349c0f2c93547ce814534b2: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: b54e883be1cff7a6a43a737ee106011c: model_identity_unresolved_or_ambiguous 'GPT-6.1 Terra (Low)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: d843fce803ff4f84ababc47040306116: model_identity_unresolved_or_ambiguous 'Muse Spark Open (Xhigh)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: dabb064c01568bc018ba730cc39c4a96: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: e17ee3a79eab160154a92f31c6c2b1fa: explicit_effort_conflicts_with_native_model | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: ee13e548b65eeee544cd5b0c6068a4f5: composite_or_ambiguous_model_label 'GPT-6.1 Terra (Non-reasoning)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: ee454ece0aab8dacb7127770643dcb6b: explicit_effort_conflicts_with_native_model | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: ef847aa89b4f0471ffe5275ba2f11771: model_identity_unresolved_or_ambiguous 'DeepSeek V4.1 Flash (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: f09fd629724ff1b103982a6158d00183: model_identity_unresolved_or_ambiguous 'Muse Spark 1.3 (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: f8b3c23615b8b60e23364c27e8494d6d: composite_or_ambiguous_model_label 'Claude Opus 5.5 (Max, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: fe6df4d0f0b5360790e73d6d8830d7a0: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents.codingAgentIndex: insufficient_comparison_models (1/2) | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-high: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-low: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-medium: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-xhigh: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-opus-5-5-high: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-opus-5-5-low: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-opus-5-5-medium: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-opus-5-5-xhigh: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-opus-5-5: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-sonnet-5-5-high: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-sonnet-5-5-low: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-sonnet-5-5-medium: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-sonnet-5-5-xhigh: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-sonnet-5-5: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-fable-5.1: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysis.intelligenceIndex 'claude-4-5-haiku' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisComponents.automationBench 'claude-4-5-haiku' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-4-5-haiku' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-haiku-5-5-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-haiku-5-5-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-haiku-5-5-xhigh' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-haiku-5-5' score_missing_or_invalid | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.ifbench 'claude-haiku-5-5-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.ifbench 'claude-haiku-5-5-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.ifbench 'claude-haiku-5-5-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.ifbench 'claude-haiku-5-5-xhigh' score_missing_or_invalid | orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.mmmuPro 'claude-haiku-5-5-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.mmmuPro 'claude-haiku-5-5-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'low' alias_not_configured | quick, triage |
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
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'low' alias_not_configured | quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis.intelligenceIndex 'claude-opus-4-8' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysis.intelligenceIndex 'claude-opus-5-high' score_missing_or_invalid | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysis.intelligenceIndex 'claude-opus-5-low' score_missing_or_invalid | quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysis.intelligenceIndex 'claude-opus-5-medium' score_missing_or_invalid | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysis.intelligenceIndex 'claude-opus-5-xhigh' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysis.intelligenceIndex 'claude-opus-5' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-xhigh' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-xhigh' score_missing_or_invalid | orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysis effort 'low' alias_not_configured | quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysis effort 'max' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisComponents effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'low' alias_not_configured | quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis.intelligenceIndex 'claude-sonnet-4-6-adaptive' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-4-6-adaptive' score_missing_or_invalid | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.intelligenceIndex 'claude-sonnet-5-high' score_missing_or_invalid | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.intelligenceIndex 'claude-sonnet-5-low' score_missing_or_invalid | quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.intelligenceIndex 'claude-sonnet-5-medium' score_missing_or_invalid | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.intelligenceIndex 'claude-sonnet-5-xhigh' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.intelligenceIndex 'claude-sonnet-5' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-xhigh' score_missing_or_invalid | orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysis effort 'low' alias_not_configured | quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysis effort 'max' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisComponents effort 'max' alias_not_configured | agentic-implementation, deep-reasoning |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysis effort 'none' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysisComponents effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-4-argon: artificialAnalysis effort 'none' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-4-argon: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-4-argon: artificialAnalysisComponents effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-4-argon: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'low' alias_not_configured | quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis.intelligenceIndex 'gpt-5-3-codex' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents.automationBench 'gpt-5-3-codex' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-3-codex' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysis.intelligenceIndex 'gpt-5-6-luna-high' score_missing_or_invalid | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysis.intelligenceIndex 'gpt-5-6-luna-low' score_missing_or_invalid | quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysis.intelligenceIndex 'gpt-5-6-luna-medium' score_missing_or_invalid | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysis.intelligenceIndex 'gpt-5-6-luna-xhigh' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-xhigh' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-xhigh' score_missing_or_invalid | orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysis.intelligenceIndex 'gpt-5-6-sol-high' score_missing_or_invalid | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysis.intelligenceIndex 'gpt-5-6-sol-low' score_missing_or_invalid | quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysis.intelligenceIndex 'gpt-5-6-sol-medium' score_missing_or_invalid | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysis.intelligenceIndex 'gpt-5-6-sol-xhigh' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-xhigh' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysis.intelligenceIndex 'gpt-5-6-terra-high' score_missing_or_invalid | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysis.intelligenceIndex 'gpt-5-6-terra-low' score_missing_or_invalid | quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysis.intelligenceIndex 'gpt-5-6-terra-medium' score_missing_or_invalid | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysis.intelligenceIndex 'gpt-5-6-terra-xhigh' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-xhigh' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'max' not_in_requested_configurations | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra-xhigh' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-xhigh' score_missing_or_invalid | orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisCodingAgents effort 'max' not_in_requested_configurations | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-luna-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-luna-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-luna-xhigh' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.ifbench 'gpt-6-luna-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.ifbench 'gpt-6-luna-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.ifbench 'gpt-6-luna-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.ifbench 'gpt-6-luna-xhigh' score_missing_or_invalid | orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysis.intelligenceIndex 'gpt-6-sol-high' score_missing_or_invalid | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysis.intelligenceIndex 'gpt-6-sol-low' score_missing_or_invalid | quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysis.intelligenceIndex 'gpt-6-sol-medium' score_missing_or_invalid | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysis.intelligenceIndex 'gpt-6-sol-xhigh' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-sol-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-sol-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-sol-xhigh' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.ifbench 'gpt-6-sol-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.ifbench 'gpt-6-sol-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.ifbench 'gpt-6-sol-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.ifbench 'gpt-6-sol-xhigh' score_missing_or_invalid | orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'max' not_in_requested_configurations | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-1-sol-high' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-1-sol-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-1-sol-xhigh' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.ifbench 'gpt-6-1-sol-high' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.ifbench 'gpt-6-1-sol-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.ifbench 'gpt-6-1-sol-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.ifbench 'gpt-6-1-sol-xhigh' score_missing_or_invalid | orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis effort 'low' alias_not_configured | quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis.intelligenceIndex 'grok-4-5' score_missing_or_invalid | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisComponents.ifbench 'grok-4-5' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysis.intelligenceIndex 'grok-4-6-low' score_missing_or_invalid | quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysis.intelligenceIndex 'grok-4-6-medium' score_missing_or_invalid | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysis.intelligenceIndex 'grok-4-6-xhigh' score_missing_or_invalid | deep-reasoning |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysis.intelligenceIndex 'grok-4-6' score_missing_or_invalid | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.enterpriseOpsGym 'grok-4-6-low' score_missing_or_invalid | mechanical |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.enterpriseOpsGym 'grok-4-6-xhigh' score_missing_or_invalid | agentic-implementation, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6-low' score_missing_or_invalid | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6-medium' score_missing_or_invalid | default-development |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6-xhigh' score_missing_or_invalid | orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6' score_missing_or_invalid | default-development, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.mmmuPro 'grok-4-6-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.mmmuPro 'grok-4-6' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.6: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.7: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | instruction-following: artificialAnalysisComponents.ifbench: insufficient_comparison_models (1/2) | mechanical, triage |
| evidence gap | n/a / n/a / n/a | kimi-k3: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'low' alias_not_configured | quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisComponents effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisComponents effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, orchestrator, review, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'low' alias_not_configured | mechanical, quick, triage |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'medium' alias_not_configured | default-development, review, visual-ui |
| evidence gap | n/a / n/a / n/a | primary: artificialAnalysisCodingAgents.codingAgentIndex: insufficient_comparison_models (1/2) | agentic-implementation |
| exclusion | claude-haiku-4.5 / none / long_context | context_unsupported | deep-reasoning |
| exclusion | claude-opus-4.8-fast / high / default | pricing_input_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| exclusion | claude-opus-4.8-fast / high / default | pricing_output_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| exclusion | claude-opus-4.8-fast / high / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | claude-opus-4.8-fast / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8-fast / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8-fast / max / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | claude-opus-4.8-fast / medium / default | pricing_input_exceeds_ceiling | default-development, review, visual-ui |
| exclusion | claude-opus-4.8-fast / medium / default | pricing_output_exceeds_ceiling | default-development, review, visual-ui |
| exclusion | claude-opus-4.8-fast / xhigh / default | pricing_input_exceeds_ceiling | orchestrator |
| exclusion | claude-opus-4.8-fast / xhigh / default | pricing_output_exceeds_ceiling | orchestrator |
| exclusion | claude-opus-4.8-fast / xhigh / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | claude-opus-4.8 / high / default | pricing_input_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-4.8 / high / default | pricing_output_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-4.8 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-4.8 / medium / default | pricing_input_exceeds_ceiling | default-development |
| exclusion | claude-opus-4.8 / medium / default | pricing_output_exceeds_ceiling | default-development |
| exclusion | claude-opus-4.8 / xhigh / default | pricing_input_exceeds_ceiling | orchestrator |
| exclusion | claude-opus-4.8 / xhigh / default | pricing_output_exceeds_ceiling | orchestrator |
| exclusion | claude-opus-5 / high / default | pricing_input_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-5 / high / default | pricing_output_exceeds_ceiling | default-development, orchestrator |
| exclusion | claude-opus-5 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-5 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-5 / medium / default | pricing_input_exceeds_ceiling | default-development |
| exclusion | claude-opus-5 / medium / default | pricing_output_exceeds_ceiling | default-development |
| exclusion | claude-opus-5 / xhigh / default | pricing_input_exceeds_ceiling | orchestrator |
| exclusion | claude-opus-5 / xhigh / default | pricing_output_exceeds_ceiling | orchestrator |
| exclusion | claude-opus-5.5 / high / default | pricing_input_exceeds_ceiling | orchestrator |
| exclusion | claude-opus-5.5 / high / default | pricing_output_exceeds_ceiling | orchestrator |
| exclusion | claude-opus-5.5 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-5.5 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-opus-5.5 / xhigh / default | pricing_input_exceeds_ceiling | orchestrator |
| exclusion | claude-opus-5.5 / xhigh / default | pricing_output_exceeds_ceiling | orchestrator |
| exclusion | claude-sonnet-4.6 / high / default | capabilities_stale | agentic-implementation, default-development, orchestrator, review, visual-ui |
| exclusion | claude-sonnet-4.6 / high / long_context | capabilities_stale | deep-reasoning |
| exclusion | claude-sonnet-4.6 / low / default | capabilities_stale | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / max / default | capabilities_stale | agentic-implementation |
| exclusion | claude-sonnet-4.6 / max / long_context | capabilities_stale | deep-reasoning |
| exclusion | claude-sonnet-4.6 / medium / default | capabilities_stale | default-development, review, visual-ui |
| exclusion | gpt-5.3-codex / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.3-codex / high / long_context | context_unsupported | deep-reasoning |
| exclusion | gpt-5.3-codex / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.3-codex / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-5.3-codex / xhigh / long_context | context_unsupported | deep-reasoning |
| exclusion | gpt-5.6-sol / high / default | pricing_input_exceeds_ceiling | orchestrator |
| exclusion | gpt-5.6-sol / high / default | pricing_output_exceeds_ceiling | orchestrator |
| exclusion | gpt-5.6-sol / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-sol / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-sol / xhigh / default | pricing_input_exceeds_ceiling | orchestrator |
| exclusion | gpt-5.6-sol / xhigh / default | pricing_output_exceeds_ceiling | orchestrator |
| exclusion | gpt-5.6-terra / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-6-astra / high / default | pricing_input_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| exclusion | gpt-6-astra / high / default | pricing_output_exceeds_ceiling | default-development, orchestrator, review, visual-ui |
| exclusion | gpt-6-astra / high / long_context | pricing_input_exceeds_ceiling | deep-reasoning |
| exclusion | gpt-6-astra / high / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | gpt-6-astra / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-6-astra / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-6-astra / medium / default | pricing_input_exceeds_ceiling | default-development, review, visual-ui |
| exclusion | gpt-6-astra / medium / default | pricing_output_exceeds_ceiling | default-development, review, visual-ui |
| exclusion | gpt-6-astra / xhigh / default | pricing_input_exceeds_ceiling | orchestrator |
| exclusion | gpt-6-astra / xhigh / default | pricing_output_exceeds_ceiling | orchestrator |
| exclusion | gpt-6-astra / xhigh / long_context | pricing_input_exceeds_ceiling | deep-reasoning |
| exclusion | gpt-6-astra / xhigh / long_context | pricing_output_exceeds_ceiling | deep-reasoning |
| exclusion | grok-4.5 / high / default | vision_unknown | visual-ui |
| exclusion | grok-4.5 / medium / default | vision_unknown | visual-ui |
| exclusion | mai-code-1.1-flash / high / long_context | context_unsupported | deep-reasoning |

</details>

## Profile evidence

### orchestrator

Budget: **hard**, input 3 / output 15 USD per million. Deciding source: artificialAnalysisComponents.
Quality leader before hard-budget exclusions: gpt-6-astra / xhigh / default. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AutomationBench-AA > EnterpriseOps-Gym-AA**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **applied_budget_constrained_choice**. Deciding metric: artificialAnalysisComponents.automationBench.
Incumbent selection basis (applied/current after run): artificialAnalysisComponents.automationBench.
AutomationBench-AA (guardrail-adjusted objective fraction): Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA (strict pass@1 fraction): AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.
Configuration selection: **automatic bounded effort**; authorized efforts: high, xhigh. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **300 AIC**; incumbent **260 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: grok-4.6 / xhigh / default (0.669973683618). Candidate gap: **0.00423646948189 / 0.03** absolute automationBench score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **300 AIC**; incumbent **260 AIC** (1 AIC = USD 0.01).
Candidate cost change: **15.3846153846%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **0.666784963812**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysisComponents.automationBench | 9 | grok-4.6 / xhigh / default | 0.669973683618 | 0.03 | 0.639973683618 | False | n/a |
| long-context | artificialAnalysisComponents.lcr | 11 | gpt-6-sol / high / default | 0.836666666667 | 0.05 | 0.786666666667 | False | n/a |
| instruction-following | liveBench.instructionFollowing | 4 | gpt-6.1-sol / xhigh / default | 71.325 | 3 | 68.325 | False | n/a |

primary routes: AutomationBench-AA > EnterpriseOps-Gym-AA.
AutomationBench-AA: Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA: AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.

long-context routes: AA-LCR.
AA-LCR: Long-document reasoning, not conversational retention.

instruction-following routes: LiveBench Instruction Following > IFBench (AA).
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.
IFBench (AA): Single-turn instruction following, not multi-turn retention.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: 0.359538897734 (outside_quality_band); long-context: 0.783333333333 (outside_quality_band); instruction-following: 66.4665 (outside_quality_band) |
| grok-4.6 / high / default | False | primary: 0.666784963812 (passed); long-context: 0.803333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: 0.337268531177 (outside_quality_band); long-context: 0.773333333333 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: 0.425977673743 (outside_quality_band); long-context: 0.816666666667 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 70.5165 (passed) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| grok-4.6 / xhigh / default | False | primary: 0.669973683618 (passed); long-context: 0.81 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: 0.355879429306 (outside_quality_band); long-context: 0.803333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | True | primary: 0.665737214136 (passed); long-context: 0.796666666667 (passed); instruction-following: 71.325 (passed) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.496666666667 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: 0.616942351159 (outside_quality_band); long-context: 0.813333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.3-codex / high / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| grok-4.5 / high / default | False | primary: 0.579348603508 (outside_quality_band); long-context: 0.793333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: 0.344762688906 (outside_quality_band); long-context: 0.766666666667 (outside_quality_band); instruction-following: 63.8585 (outside_quality_band) |
| claude-sonnet-5 / high / default | False | primary: 0.320966388144 (outside_quality_band); long-context: 0.766666666667 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.3-codex / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.833333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: 0.478006867676 (outside_quality_band); long-context: 0.8 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / high / default | False | primary: 0.644952373218 (passed); long-context: 0.823333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: 0.601258409113 (outside_quality_band); long-context: 0.836666666667 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / default | False | primary: 0.420203829518 (outside_quality_band); long-context: 0.776666666667 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / high / default | False | primary: 0.478244913992 (outside_quality_band); long-context: 0.793333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / xhigh / default | False | primary: 0.47136313406 (outside_quality_band); long-context: 0.79 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | True | n/a | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / xhigh / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | automationBench | 0.337268531177 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-xhigh | xhigh | automationBench | 0.359538897734 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | automationBench | 0.535640105154 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | automationBench | 0.532191921095 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | automationBench | 0.320966388144 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | automationBench | 0.344762688906 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | automationBench | 0.355879429306 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | automationBench | 0.425977673743 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | automationBench | 0.553122035739 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | automationBench | 0.553116726933 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | automationBench | 0.420203829518 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | automationBench | 0.47136313406 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | automationBench | 0.666122174975 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | automationBench | 0.671777802022 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | automationBench | 0.478244913992 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | automationBench | 0.478006867676 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | automationBench | 0.601258409113 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | automationBench | 0.616942351159 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | automationBench | 0.644952373218 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | automationBench | 0.665737214136 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | automationBench | 0.579348603508 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | automationBench | 0.666784963812 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-xhigh | xhigh | automationBench | 0.669973683618 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | enterpriseOpsGym | 0.438675022381 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | enterpriseOpsGym | 0.483437779767 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | lcr | 0.496666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | lcr | 0.773333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-xhigh | xhigh | lcr | 0.783333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-xhigh | xhigh | lcr | 0.81 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | instructionFollowing | 66.4665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | instructionFollowing | 67.04975 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | instructionFollowing | 63.8585 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | instructionFollowing | 70.5165 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | instructionFollowing | 71.325 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | ifbench | 0.753741496599 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | ifbench | 0.691836734694 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | ifbench | 0.710204081633 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | ifbench | 0.644217687075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | ifbench | 0.662585034014 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### quick

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / low / default. Family fallback (informational, not a winner): claude-haiku-5.5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **LiveBench Coding > AA Intelligence Index**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **retained_fallback_incumbent_evidence_missing**. Deciding metric: artificialAnalysis.intelligenceIndex.
Incumbent selection basis (applied/current after run): unknown; no historical provenance inferred.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
**Fallback replacement blocked:** comparable exact-incumbent evidence is required, and a weaker route cannot displace an established stronger basis. The candidate is informational only; force cannot bypass this requirement.
Configuration selection: **automatic bounded effort**; authorized efforts: low. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **300 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-6.1-sol / low / default (34.5). Candidate gap: **0 / 3** absolute intelligenceIndex score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **300 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **166.666666667%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
**Incumbent evidence gap:** no configuration-matched score in this deciding-source observation. The fallback replacement is blocked. No measured quality improvement over the incumbent is claimed.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysis.intelligenceIndex | 3 | gpt-6.1-sol / low / default | 34.5 | 3 | 31.5 | False | n/a |

primary routes: LiveBench Coding > AA Intelligence Index.
LiveBench Coding: Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / low / default | False | primary: 18.6 (outside_quality_band) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: 9.7 (outside_quality_band) |
| gpt-6.1-sol / low / default | True | primary: 34.5 (passed) |
| gpt-5.6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| grok-4.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| grok-4.6 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| IFBench (AA) | gpt-6.1-sol / low / default | n/a | n/a (missing or invalid) | accuracy fraction | n/a | n/a | n/a |
| LiveBench Instruction Following | gpt-6.1-sol / low / default | n/a | n/a (missing or invalid) | percentage points | n/a | n/a | n/a |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-4.6 / low / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-low | low | intelligenceIndex | 18.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | intelligenceIndex | 43 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-low | low | intelligenceIndex | 9.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-low | low | intelligenceIndex | 34.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### default-development

Budget: **hard**, input 4 / output 20 USD per million. Deciding source: n/a.
Quality leader before hard-budget exclusions: n/a. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **LiveBench Coding > AA Intelligence Index**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **retained_no_role_qualified_candidate**. Deciding metric: n/a.
Incumbent selection basis (applied/current after run): unknown; no historical provenance inferred.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **n/a AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.

**Role qualification:** retained_no_role_qualified_candidate. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysis.intelligenceIndex | 3 | gpt-6.1-sol / high / default | 50.2 | 3 | 47.2 | False | n/a |
| instruction-following | artificialAnalysisComponents.ifbench | 3 | gpt-5.6-sol / medium / default | 0.695918367347 | 0.03 | 0.665918367347 | False | n/a |

primary routes: LiveBench Coding > AA Intelligence Index.
LiveBench Coding: Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.

instruction-following routes: LiveBench Instruction Following > IFBench (AA).
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.
IFBench (AA): Single-turn instruction following, not multi-turn retention.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| grok-4.6 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: 29.6 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: 0.695918367347 (passed) |
| grok-4.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: 0.420408163265 (outside_quality_band) |
| gpt-5.3-codex / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| grok-4.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: 0.621768707483 (outside_quality_band) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: 0.691836734694 (passed) |
| gpt-6-luna / medium / default | False | primary: 18.3 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| grok-4.6 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: 46.1 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / default | False | primary: 24.6 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / high / default | False | primary: 50.2 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.3-codex / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: 0.644217687075 (outside_quality_band) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / high / default | False | primary: 21.4 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |

**Current configuration retained, not certified:** no role-qualified recommendation is available. No requirements are relaxed to fill the profile, and force cannot bypass missing coverage or an empty intersection.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | True | n/a | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.5 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-high | high | intelligenceIndex | 29.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-medium | medium | intelligenceIndex | 24.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 54.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | intelligenceIndex | 51.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-high | high | intelligenceIndex | 21.4 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-medium | medium | intelligenceIndex | 18.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-high | high | intelligenceIndex | 50.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-medium | medium | intelligenceIndex | 46.1 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | instructionFollowing | 63.22075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | ifbench | 0.691836734694 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | ifbench | 0.695918367347 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | ifbench | 0.644217687075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | ifbench | 0.621768707483 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### agentic-implementation

Budget: **hard**, input 10 / output 50 USD per million. Deciding source: liveBench.
Quality leader before hard-budget exclusions: claude-opus-5.5 / max / default. Family fallback (informational, not a winner): gpt-5.3-codex.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AA Coding Agent Index > LiveBench Agentic Coding**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **retained_stronger_incumbent_basis**. Deciding metric: liveBench.agenticCoding.
Incumbent selection basis (applied/current after run): artificialAnalysisCodingAgents.codingAgentIndex.
AA Coding Agent Index (fraction): External coding-agent harness, not Copilot CLI.
LiveBench Agentic Coding (percentage points): External agentic coding evaluation, not the local orchestration workflow.
**Fallback replacement blocked:** comparable exact-incumbent evidence is required, and a weaker route cannot displace an established stronger basis. The candidate is informational only; force cannot bypass this requirement.
Configuration selection: **automatic bounded effort**; authorized efforts: high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **600 AIC**; incumbent **300 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-opus-5.5 / max / default (71.717). Candidate gap: **0 / 3** absolute agenticCoding score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **600 AIC**; incumbent **300 AIC** (1 AIC = USD 0.01).
Candidate cost change: **100%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **56.3133333333**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | liveBench.agenticCoding | 7 | claude-opus-5.5 / max / default | 71.717 | 3 | 68.717 | False | n/a |

primary routes: AA Coding Agent Index > LiveBench Agentic Coding.
AA Coding Agent Index: External coding-agent harness, not Copilot CLI.
LiveBench Agentic Coding: External agentic coding evaluation, not the local orchestration workflow.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: 51.3636666667 (outside_quality_band) |
| grok-4.6 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / max / default | True | primary: 71.717 (passed) |
| claude-opus-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | False | primary: 39.3436666667 (outside_quality_band) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: 56.3133333333 (outside_quality_band) |
| grok-4.6 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | False | primary: 56.7676666667 (outside_quality_band) |
| claude-haiku-5.5 / max / default | False | primary: 57.1716666667 (outside_quality_band) |
| claude-opus-4.8-fast / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / max / default | False | primary: 50.505 (outside_quality_band) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / max / default | False | primary: 65.202 (outside_quality_band) |
| gpt-6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.3-codex / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| grok-4.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: 59.394 (outside_quality_band) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.3-codex / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / xhigh / default | False | primary: 65.3533333333 (outside_quality_band) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| AutomationBench-AA | claude-opus-5.5 / max / default | n/a | n/a (missing or invalid) | guardrail-adjusted objective fraction | n/a | n/a | n/a |
| EnterpriseOps-Gym-AA | claude-opus-5.5 / max / default | n/a | n/a (missing or invalid) | strict pass@1 fraction | n/a | n/a | n/a |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
AutomationBench-AA: Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA: AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / high / default | True | n/a | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / max / default | True | n/a | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / max / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | True | n/a | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / high / default | True | n/a | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / xhigh / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysisCodingAgents | Claude Code - Claude Haiku 5.5 (Max) | max | codingAgentIndex | 0.373496050722 | True | False | Claude Code; variant 2a2fed494e0d1343b14efe96e6bc3669; external agent harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | agenticCoding | 57.1716666667 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | agenticCoding | 51.3636666667 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | agenticCoding | 50.505 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | agenticCoding | 65.202 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | agenticCoding | 71.717 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | agenticCoding | 65.3533333333 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | agenticCoding | 59.394 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | agenticCoding | 56.3133333333 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | agenticCoding | 39.3436666667 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | agenticCoding | 56.7676666667 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | automationBench | 0.337268531177 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5 | max | automationBench | 0.354110151328 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-xhigh | xhigh | automationBench | 0.359538897734 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | automationBench | 0.455934369153 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | automationBench | 0.535640105154 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | automationBench | 0.565735557649 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | automationBench | 0.532191921095 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | automationBench | 0.200980736645 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | automationBench | 0.320966388144 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | automationBench | 0.36512675717 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | automationBench | 0.344762688906 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | automationBench | 0.355879429306 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | automationBench | 0.425977673743 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | automationBench | 0.553122035739 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | automationBench | 0.553116726933 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | automationBench | 0.420203829518 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | automationBench | 0.47136313406 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | automationBench | 0.666122174975 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | automationBench | 0.671777802022 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | automationBench | 0.478244913992 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | automationBench | 0.478006867676 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | automationBench | 0.601258409113 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | automationBench | 0.616942351159 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | automationBench | 0.644952373218 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | automationBench | 0.665737214136 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | automationBench | 0.579348603508 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | automationBench | 0.666784963812 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-xhigh | xhigh | automationBench | 0.669973683618 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | enterpriseOpsGym | 0.439570277529 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | enterpriseOpsGym | 0.474783646673 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | enterpriseOpsGym | 0.446732318711 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | enterpriseOpsGym | 0.438675022381 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | enterpriseOpsGym | 0.483437779767 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### deep-reasoning

Budget: **hard**, input 10 / output 45 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / xhigh / long_context. Family fallback (informational, not a winner): claude-opus-5.5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AA Intelligence Index > LiveBench Reasoning**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **budget_constrained_choice**. Deciding metric: artificialAnalysis.intelligenceIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.intelligenceIndex.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning (percentage points): Reasoning proxy; does not establish interactive triage skill.
Configuration selection: **automatic bounded effort**; authorized efforts: high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **550 AIC**; incumbent **550 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-6.1-sol / xhigh / long_context (52.3). Candidate gap: **0 / 3** absolute intelligenceIndex score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **550 AIC**; incumbent **550 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **52.3**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysis.intelligenceIndex | 3 | gpt-6.1-sol / xhigh / long_context | 52.3 | 3 | 49.3 | False | n/a |
| long-context | artificialAnalysisComponents.lcr | 12 | gpt-6-sol / high / long_context | 0.836666666667 | 0.05 | 0.786666666667 | False | n/a |

primary routes: AA Intelligence Index > LiveBench Reasoning.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning: Reasoning proxy; does not establish interactive triage skill.

long-context routes: AA-LCR.
AA-LCR: Long-document reasoning, not conversational retention.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| gpt-5.6-terra / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.79 (passed) |
| claude-haiku-5.5 / xhigh / long_context | False | primary: 34.3 (outside_quality_band); long-context: 0.783333333333 (outside_quality_band) |
| claude-sonnet-5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.766666666667 (outside_quality_band) |
| claude-haiku-5.5 / max / long_context | False | primary: 36.2 (outside_quality_band); long-context: 0.826666666667 (passed) |
| claude-opus-5.5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.803333333333 (passed) |
| gpt-6.1-sol / high / long_context | True | primary: 50.2 (passed); long-context: 0.823333333333 (passed) |
| gpt-6-sol / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.836666666667 (passed) |
| claude-opus-5 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.793333333333 (passed) |
| gpt-5.6-sol / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.816666666667 (passed) |
| claude-sonnet-5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.766666666667 (outside_quality_band) |
| grok-4.5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.793333333333 (passed) |
| gpt-5.6-sol / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.823333333333 (passed) |
| gpt-5.6-luna / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.816666666667 (passed) |
| claude-sonnet-5.5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.776666666667 (outside_quality_band) |
| claude-opus-4.8 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / long_context | False | primary: 23.3 (outside_quality_band); long-context: 0.8 (passed) |
| grok-4.6 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.81 (passed) |
| grok-4.6 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.803333333333 (passed) |
| claude-sonnet-5 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.82 (passed) |
| claude-sonnet-5.5 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.79 (passed) |
| gemini-4-argon / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.776666666667 (outside_quality_band) |
| claude-opus-5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.803333333333 (passed) |
| gpt-6.1-sol / xhigh / long_context | True | primary: 52.3 (passed); long-context: 0.796666666667 (passed) |
| claude-opus-5.5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / long_context | False | primary: 29.6 (outside_quality_band); long-context: 0.773333333333 (outside_quality_band) |
| gemini-3.8-flash / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / high / long_context | False | primary: 21.4 (outside_quality_band); long-context: 0.793333333333 (passed) |
| gpt-6-sol / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.813333333333 (passed) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / long_context | False | context_unsupported | n/a | default | 1 / 5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / high / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / max / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / xhigh / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / high / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / max / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / xhigh / long_context | False | pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / high / long_context | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / max / long_context | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / xhigh / long_context | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-4.6 / high / long_context | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-4.6 / max / long_context | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-5 / high / long_context | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5 / max / long_context | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5 / xhigh / long_context | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / high / long_context | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / max / long_context | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / xhigh / long_context | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-3.8-flash / none / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / long_context | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / long_context | False | context_unsupported | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / long_context | False | context_unsupported | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.6-luna / high / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-luna / xhigh / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / high / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / xhigh / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / high / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / xhigh / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / high / long_context | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | long_context | 20 / 75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / xhigh / long_context | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | long_context | 20 / 75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / high / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / xhigh / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / high / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / xhigh / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / high / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / xhigh / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| grok-4.5 / high / long_context | True | n/a | n/a | long_context | 4 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / high / long_context | True | n/a | n/a | long_context | 4 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / xhigh / long_context | True | n/a | n/a | long_context | 4 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| mai-code-1.1-flash / high / long_context | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-high | high | intelligenceIndex | 29.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5 | max | intelligenceIndex | 36.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-xhigh | xhigh | intelligenceIndex | 34.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 54.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-xhigh | xhigh | intelligenceIndex | 55.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-high | high | intelligenceIndex | 21.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-xhigh | xhigh | intelligenceIndex | 23.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-high | high | intelligenceIndex | 50.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-xhigh | xhigh | intelligenceIndex | 52.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | reasoning | 84.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | reasoning | 81.23075 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | reasoning | 89.19225 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | reasoning | 91.2115 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | reasoning | 92.15375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | reasoning | 90.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | reasoning | 88.69225 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | reasoning | 91.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | reasoning | 86.80775 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | reasoning | 91.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | lcr | 0.496666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | lcr | 0.773333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5 | max | lcr | 0.826666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-xhigh | xhigh | lcr | 0.783333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | lcr | 0.82 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-xhigh | xhigh | lcr | 0.81 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### review

Budget: **hard**, input 5 / output 30 USD per million. Deciding source: n/a.
Quality leader before hard-budget exclusions: n/a. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **LiveBench Coding > AA Intelligence Index**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **retained_insufficient_role_evidence**. Deciding metric: n/a.
Incumbent selection basis (applied/current after run): artificialAnalysis.codingIndex.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **n/a AIC**; incumbent **750 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.

**Role qualification:** retained_insufficient_role_evidence. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysis.intelligenceIndex | 3 | gpt-6.1-sol / high / default | 50.2 | 3 | 47.2 | False | n/a |
| reasoning | n/a | 0 | n/a | n/a | n/a | n/a | n/a | n/a |
| long-context | artificialAnalysisComponents.lcr | 12 | gpt-6-sol / high / default | 0.836666666667 | 0.05 | 0.786666666667 | False | n/a |

primary routes: LiveBench Coding > AA Intelligence Index.
LiveBench Coding: Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.

reasoning routes: LiveBench Reasoning.
LiveBench Reasoning: Reasoning proxy; does not establish interactive triage skill.

long-context routes: AA-LCR.
AA-LCR: Long-document reasoning, not conversational retention.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| grok-4.6 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.803333333333 (passed) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.823333333333 (passed) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.736666666667 (outside_quality_band) |
| claude-haiku-5.5 / high / default | False | primary: 29.6 (outside_quality_band); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.773333333333 (outside_quality_band) |
| claude-opus-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.79 (passed) |
| claude-opus-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.803333333333 (passed) |
| gpt-5.6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.803333333333 (passed) |
| grok-4.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.496666666667 (outside_quality_band) |
| claude-opus-4.8 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.3-codex / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| grok-4.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.793333333333 (passed) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.74 (outside_quality_band) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.816666666667 (passed) |
| gpt-6-luna / medium / default | False | primary: 18.3 (outside_quality_band); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.783333333333 (outside_quality_band) |
| grok-4.6 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.81 (passed) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.766666666667 (outside_quality_band) |
| claude-opus-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: 46.1 (outside_quality_band); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.833333333333 (passed) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / default | False | primary: 24.6 (outside_quality_band); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.773333333333 (outside_quality_band) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.75 (outside_quality_band) |
| gpt-6.1-sol / high / default | False | primary: 50.2 (passed); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.823333333333 (passed) |
| gpt-5.3-codex / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.836666666667 (passed) |
| gpt-5.6-terra / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.776666666667 (outside_quality_band) |
| claude-opus-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.82 (passed) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / high / default | False | primary: 21.4 (outside_quality_band); reasoning: n/a (insufficient_comparison_evidence); long-context: 0.793333333333 (passed) |

**Current configuration retained, not certified:** no role-qualified recommendation is available. No requirements are relaxed to fill the profile, and force cannot bypass missing coverage or an empty intersection.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | True | n/a | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | True | n/a | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| grok-4.5 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.5 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-high | high | intelligenceIndex | 29.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-medium | medium | intelligenceIndex | 24.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 54.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | intelligenceIndex | 51.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-high | high | intelligenceIndex | 21.4 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-medium | medium | intelligenceIndex | 18.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-high | high | intelligenceIndex | 50.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-medium | medium | intelligenceIndex | 46.1 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | reasoning | 84.76925 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | lcr | 0.496666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | lcr | 0.773333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-medium | medium | lcr | 0.773333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | lcr | 0.82 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-medium | medium | lcr | 0.736666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | lcr | 0.75 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | lcr | 0.74 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-medium | medium | lcr | 0.783333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-medium | medium | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-medium | medium | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-medium | medium | lcr | 0.81 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### visual-ui

Budget: **hard**, input 5 / output 25 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / high / default. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **LiveBench Coding > AA Intelligence Index**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **retained_fallback_incumbent_evidence_missing**. Deciding metric: artificialAnalysis.intelligenceIndex.
Incumbent selection basis (applied/current after run): unknown; no historical provenance inferred.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
**Fallback replacement blocked:** comparable exact-incumbent evidence is required, and a weaker route cannot displace an established stronger basis. The candidate is informational only; force cannot bypass this requirement.
Configuration selection: **automatic bounded effort**; authorized efforts: medium, high. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **300 AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-6.1-sol / high / default (50.2). Candidate gap: **0 / 3** absolute intelligenceIndex score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **300 AIC**; incumbent **112.5 AIC** (1 AIC = USD 0.01).
Candidate cost change: **166.666666667%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
**Incumbent evidence gap:** no configuration-matched score in this deciding-source observation. The fallback replacement is blocked. No measured quality improvement over the incumbent is claimed.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysis.intelligenceIndex | 3 | gpt-6.1-sol / high / default | 50.2 | 3 | 47.2 | False | n/a |
| visual-understanding | artificialAnalysisComponents.mmmuPro | 8 | gpt-6.1-sol / high / default | 0.849132947977 | 0.03 | 0.819132947977 | False | n/a |

primary routes: LiveBench Coding > AA Intelligence Index.
LiveBench Coding: Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.

visual-understanding routes: MMMU Pro (AA).
MMMU Pro (AA): Visual understanding, not UI implementation fidelity.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| grok-4.6 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.804046242775 (outside_quality_band) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: 29.6 (outside_quality_band); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.824277456647 (passed) |
| claude-opus-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.775722543353 (outside_quality_band) |
| gpt-5.6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.81387283237 (outside_quality_band) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.551445086705 (outside_quality_band) |
| claude-opus-4.8 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.767630057803 (outside_quality_band) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.818497109827 (outside_quality_band) |
| gpt-6-luna / medium / default | False | primary: 18.3 (outside_quality_band); visual-understanding: 0.778612716763 (outside_quality_band) |
| grok-4.6 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: 46.1 (outside_quality_band); visual-understanding: 0.839306358382 (passed) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / default | False | primary: 24.6 (outside_quality_band); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.75838150289 (outside_quality_band) |
| gpt-6.1-sol / high / default | True | primary: 50.2 (passed); visual-understanding: 0.849132947977 (passed) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.819653179191 (passed) |
| gpt-5.6-terra / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.790751445087 (outside_quality_band) |
| claude-opus-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.816184971098 (outside_quality_band) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / high / default | False | primary: 21.4 (outside_quality_band); visual-understanding: 0.775144508671 (outside_quality_band) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | vision_unknown | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | vision_unknown | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| grok-4.5 / high / default | False | vision_unknown | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.5 / medium / default | False | vision_unknown | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / high / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / medium / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-high | high | intelligenceIndex | 29.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-medium | medium | intelligenceIndex | 24.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 54.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | intelligenceIndex | 51.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-high | high | intelligenceIndex | 21.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-medium | medium | intelligenceIndex | 18.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-high | high | intelligenceIndex | 50.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-medium | medium | intelligenceIndex | 46.1 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | mmmuPro | 0.551445086705 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | mmmuPro | 0.824277456647 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | mmmuPro | 0.816184971098 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | mmmuPro | 0.775722543353 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | mmmuPro | 0.75838150289 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | mmmuPro | 0.818497109827 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | mmmuPro | 0.81387283237 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | mmmuPro | 0.790751445087 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | mmmuPro | 0.767630057803 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | mmmuPro | 0.864161849711 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | mmmuPro | 0.850867052023 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | mmmuPro | 0.775144508671 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-medium | medium | mmmuPro | 0.778612716763 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | mmmuPro | 0.819653179191 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-medium | medium | mmmuPro | 0.804046242775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | mmmuPro | 0.849132947977 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-medium | medium | mmmuPro | 0.839306358382 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | mmmuPro | 0.804046242775 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### mechanical

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: n/a.
Quality leader before hard-budget exclusions: n/a. Family fallback (informational, not a winner): claude-haiku-5.5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AutomationBench-AA > EnterpriseOps-Gym-AA**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **retained_insufficient_role_evidence**. Deciding metric: n/a.
Incumbent selection basis (applied/current after run): unknown; no historical provenance inferred.
AutomationBench-AA (guardrail-adjusted objective fraction): Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA (strict pass@1 fraction): AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.
Configuration selection: **automatic bounded effort**; authorized efforts: low. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **n/a AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.

**Role qualification:** retained_insufficient_role_evidence. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysisComponents.automationBench | 7 | gpt-6-sol / low / default | 0.538899927847 | 0 | 0.538899927847 | False | n/a |
| instruction-following | n/a | 0 | n/a | n/a | n/a | n/a | n/a | n/a |

primary routes: AutomationBench-AA > EnterpriseOps-Gym-AA.
AutomationBench-AA: Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA: AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.

instruction-following routes: IFBench (AA) > LiveBench Instruction Following.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| claude-haiku-5.5 / low / default | False | primary: 0.229108121811 (outside_quality_band); instruction-following: n/a (insufficient_comparison_evidence) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| gpt-6-luna / low / default | False | primary: 0.120491872727 (outside_quality_band); instruction-following: n/a (insufficient_comparison_evidence) |
| gpt-6.1-sol / low / default | False | primary: 0.525708896475 (outside_quality_band); instruction-following: n/a (insufficient_comparison_evidence) |
| gpt-5.6-luna / low / default | False | primary: 0.116921622583 (outside_quality_band); instruction-following: n/a (insufficient_comparison_evidence) |
| claude-sonnet-5 / low / default | False | primary: 0.19901936569 (outside_quality_band); instruction-following: n/a (insufficient_comparison_evidence) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| grok-4.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| grok-4.6 / low / default | False | primary: 0.534454005903 (outside_quality_band); instruction-following: n/a (insufficient_comparison_evidence) |
| gpt-6-sol / low / default | False | primary: 0.538899927847 (passed); instruction-following: n/a (insufficient_comparison_evidence) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |

**Current configuration retained, not certified:** no role-qualified recommendation is available. No requirements are relaxed to fill the profile, and force cannot bypass missing coverage or an empty intersection.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-4.6 / low / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-low | low | automationBench | 0.229108121811 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-low | low | automationBench | 0.51790662987 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-low | low | automationBench | 0.19901936569 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-low | low | automationBench | 0.116921622583 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | automationBench | 0.409856701134 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | automationBench | 0.29106376138 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-low | low | automationBench | 0.590967261045 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-low | low | automationBench | 0.120491872727 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-low | low | automationBench | 0.538899927847 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-low | low | automationBench | 0.525708896475 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-low | low | automationBench | 0.534454005903 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### triage

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: n/a.
Quality leader before hard-budget exclusions: n/a. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
Authorized deciding routes, strongest first: **AA Intelligence Index > LiveBench Reasoning**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **retained_insufficient_role_evidence**. Deciding metric: n/a.
Incumbent selection basis (applied/current after run): artificialAnalysis.intelligenceIndex.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning (percentage points): Reasoning proxy; does not establish interactive triage skill.
Configuration selection: **automatic bounded effort**; authorized efforts: low. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **n/a AIC**; incumbent **300 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.

**Role qualification:** retained_insufficient_role_evidence. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysis.intelligenceIndex | 3 | gpt-6.1-sol / low / default | 34.5 | 3 | 31.5 | False | n/a |
| instruction-following | n/a | 0 | n/a | n/a | n/a | n/a | n/a | n/a |

primary routes: AA Intelligence Index > LiveBench Reasoning.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning: Reasoning proxy; does not establish interactive triage skill.

instruction-following routes: IFBench (AA) > LiveBench Instruction Following.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| claude-haiku-5.5 / low / default | False | primary: 18.6 (outside_quality_band); instruction-following: n/a (insufficient_comparison_evidence) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| gpt-6-luna / low / default | False | primary: 9.7 (outside_quality_band); instruction-following: n/a (insufficient_comparison_evidence) |
| gpt-6.1-sol / low / default | False | primary: 34.5 (passed); instruction-following: n/a (insufficient_comparison_evidence) |
| gpt-5.6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| claude-sonnet-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| grok-4.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| grok-4.6 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (insufficient_comparison_evidence) |

**Current configuration retained, not certified:** no role-qualified recommendation is available. No requirements are relaxed to fill the profile, and force cannot bypass missing coverage or an empty intersection.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-4.6 / low / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-10-30T14:10:58.8450985Z | 2026-07-30 |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |
| grok-4.5 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| grok-4.6 / low / default | True | n/a | n/a | default | 2 / 6 | 2026-10-30T14:10:58.8450985Z | 2026-09-08 |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-10-30T14:10:58.8450985Z | 2026-10-30T08:37:00.782Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-low | low | intelligenceIndex | 18.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | intelligenceIndex | 43 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-low | low | intelligenceIndex | 9.7 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-low | low | intelligenceIndex | 34.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>
