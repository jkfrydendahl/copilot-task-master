# Monthly task profile review (2026-11-16)

Availability: **True** (local model-discovery snapshot; status=valid; observed=2026-11-12T08:21:43.184Z; validity=7 days; not live-verified by this review; recorded runtime reconciled); manual confirmation override: **True**.

## Model discovery and onboarding

Recorded authenticated runtime metadata usable: **True**; status **ok**; runtime 1.0.106. This review does not authenticate to a user's account.
Local discovery snapshot: **valid**; observed **2026-11-12T08:21:43.184Z**; validity **7 days**. Availability was verified locally, not live-verified by this review.
Local model-discovery snapshot is valid (validity: 7 days).
Runtime and help catalogs are reconciled, not assumed exhaustive. Absence is not an explicit denial; runtime-disabled, ambiguous, denylisted and virtual routing models cannot enter selection. Public pricing/benchmark rows alone do not prove Copilot availability.
Help-only entries are CLI-catalog evidence, not proof of per-account entitlement. The source columns distinguish these from recorded authenticated runtime entries.
Official retirement evidence: **ok**; retrieved **2026-11-12T08:21:47.0593930Z**; source https://docs.github.com/en/copilot/reference/ai-models/supported-models. Effective, unconditional retirements override stale help entries. Scheduled dates are evaluated in UTC; documented exceptions remain conditional, not blanket denials. Suggested alternatives are migration guidance, not qualified winners.
Verified catalog facts are updated before comparison. Ready for comparison is not role qualification: each profile still requires its exact configuration evidence, budget, bands and confirmation.
- Warning: claude-opus-4.8-fast: conflicting runtime/pricing identities; retirement scope is not assumed.

<details>
<summary>Discovered models, verified additions and remaining blockers</summary>

| Model | Runtime listed | Help listed | Lifecycle | Retirement date | Onboarding status | Blockers / limitations |
|---|---|---|---|---|---|---|
| auto | True | False | not_listed | n/a | blocked | denylisted_disabled_virtual_or_ambiguous; capabilities_missing; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| claude-fable-5 | False | True | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; benchmark_aliases_missing; structured agent evidence is resolved separately |
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
| gemini-3.7-flash | False | False | retired | 2026-10-19 | blocked | officially_retired_on_2026-10-19 |
| gemini-3.8-flash | False | True | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates |
| gemini-4-argon | False | True | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; benchmark_aliases_missing; structured agent evidence is resolved separately |
| gemini-4-carbon | True | False | not_listed | n/a | blocked | enabled_runtime_metadata_missing; existing facts retain their original verification dates; capabilities_missing; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| gpt-5-mini | False | False | retired | 2026-10-19 | blocked | officially_retired_on_2026-10-19; benchmark_aliases_missing; structured agent evidence is resolved separately |
| gpt-5.2 | False | False | unknown | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| gpt-5.2-codex | False | False | unknown | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| gpt-5.3-codex | True | True | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates |
| gpt-5.4 | False | False | retired | 2026-10-19 | blocked | officially_retired_on_2026-10-19 |
| gpt-5.4-mini | False | False | retired | 2026-10-19 | blocked | officially_retired_on_2026-10-19 |
| gpt-5.5 | False | False | retired | 2026-10-19 | blocked | officially_retired_on_2026-10-19 |
| gpt-5.6-luna | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-5.6-sol | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-5.6-terra | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-6-astra | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-6-luna | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-6-sol | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-6.1-sol | True | True | not_listed | n/a | ready_for_comparison | n/a |
| gpt-6.1-terra | True | True | not_listed | n/a | blocked | enabled_runtime_metadata_missing; existing facts retain their original verification dates; capabilities_missing; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| grok-4.5 | False | False | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates |
| grok-4.6 | True | True | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates |
| grok-4.7 | True | True | not_listed | n/a | blocked | enabled_runtime_metadata_missing; existing facts retain their original verification dates; capabilities_missing; pricing_alias_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| kimi-k3 | False | True | not_listed | n/a | blocked | enabled_runtime_metadata_missing; existing facts retain their original verification dates; capabilities_missing; benchmark_aliases_missing; structured agent evidence is resolved separately |
| mai-code-1-flash-picker | False | False | retired | 2026-09-10 | blocked | officially_retired_on_2026-09-10; benchmark_aliases_missing; structured agent evidence is resolved separately |
| mai-code-1.1-flash | True | True | not_listed | n/a | partial | benchmark_aliases_missing; structured agent evidence is resolved separately |
| Claude Fable 5.2 | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| Claude Sonnet 4 | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| Gemini 4 Carbon | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| Gemini 4 Hydrogen | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| GPT-5.4 nano | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| GPT-6.1 Terra | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| Grok 4.7 | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |

Catalog changes: 0. Unmapped benchmark variants: 55; complete discovery details are retained in `data/model-onboarding-snapshot.json`. Such variants may be unrelated to Copilot and are not automatically admitted.
</details>


## Profile decisions

| Profile | Strategy | Current configuration | Recommended configuration | Applied/current after run | Outcome | Confidence |
|---|---|---|---|---|---|---|
| orchestrator | value_balanced | gpt-6.1-sol / xhigh / default | n/a | gpt-6.1-sol / xhigh / default | retained_insufficient_role_evidence | none |
| quick | value_balanced | claude-sonnet-5.5 / max / default | claude-sonnet-5.5 / max / default | claude-sonnet-5.5 / max / default | value_balanced_choice | reduced |
| default-development | value_balanced | claude-sonnet-5.5 / xhigh / default | claude-sonnet-5.5 / xhigh / default | claude-sonnet-5.5 / xhigh / default | value_balanced_choice | reduced |
| agentic-implementation | value_balanced | gpt-6.1-sol / max / default | gpt-6.1-sol / max / default | gpt-6.1-sol / max / default | value_balanced_choice | reduced |
| deep-reasoning | value_balanced | gpt-6.1-sol / max / long_context | gpt-6.1-sol / max / long_context | gpt-6.1-sol / max / long_context | value_balanced_choice | reduced |
| review | value_balanced | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | value_balanced_choice | reduced |
| visual-ui | value_balanced | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | value_balanced_choice | reduced |
| mechanical | value_balanced | gpt-6.1-sol / xhigh / default | n/a | gpt-6.1-sol / xhigh / default | retained_insufficient_role_evidence | none |
| triage | value_balanced | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | budget_constrained_choice | reduced |

Normal recommendations require the intersection of each profile's explicit qualification dimensions, not one global model ranking. Price decides only among configurations passing every required band. Every comparison needs at least two distinct eligible models; multiple efforts do not inflate coverage. Empty intersections or insufficient evidence retain a non-retired current configuration without certifying it. Supporting-only scores never blend, rank or veto; overlapping benchmark lineage is not independent corroboration. Unknown publication age, cached evidence, single-source coverage and external harnesses reduce confidence. A context capability is not a benchmark measurement at that context length.
An effectively retired incumbent triggers mandatory recovery without waiting for confirmation or comparable incumbent evidence: a fully qualified winner first, otherwise the existing primary benchmark/value rules, otherwise an exact GitHub-suggested successor. Emergency migrations are not certified role-qualified winners. All hard admissibility and authorized configuration limits remain binding; no safe replacement fails the review instead of publishing a retained retired model.
Value-balanced profiles minimize reference AIC within a source-specific gap of their best eligible score, under fixed hard input/output price ceilings. Bands are policy tolerances, not capability percentages or proof of task success. Token-price ceilings are not total session-spend limits.
Cost basis is decided per profile, once, over its qualified configurations: when every one has valid, fresh, comparable measured input/output token totals on the same pinned benchmark workload, ranking uses those totals repriced as uncached tokens at current GitHub rates (reasoning is already inside output; no effort multiplier). If any qualified configuration lacks such usage, the entire profile uses the fixed reference basket and says why; measured and fixed costs are never mixed, and unqualified configurations cannot disable measured ranking. Measured cost is an external benchmark-workload proxy, not predicted Copilot task spend, latency or cache behavior. It never lowers a quality band or bypasses a safeguard.
Orchestrator workflow metrics allow a 0.03 absolute gap; Mechanical allows 0.01. For normal optimization every other required dimension must also pass, so the intersection may be empty. These are policy tolerances, not statistical significance claims. Missing incumbent evidence reduces confidence, not candidate requirements, and does not alone block a qualified fallback replacement. An established stronger primary or qualification basis remains protected.
Configuration cells show model / effective effort / context; 'none' means the model exposes no effort control. Allowed effort ranges are standing authorization: model and effort changes apply together after confirmation, except mandatory retirement recovery. Force bypasses only the normal confirmation wait, never hard budgets, allowed ranges, availability, capabilities or evidence requirements.

## Pricing refresh

- Status: **partial**. Source: https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing
- Last successful page fetch: 2026-11-16T08:28:09.4939090Z. Per-model verification ages govern eligibility.
- Freshness limit: 45 days. Missing rows retain their original timestamps. Capabilities are never refreshed by pricing.
- Reference-cost comparison: Aggregate uncached usage across requests within the selected context tier, not a single 1M-token request or predicted task cost. Cache reads/writes are excluded.
- Reference tokens: input 1000000, output 100000.
- Measured-cost basis: enabled; workload `aa-intelligence-index-canonical-v1`; missing-usage policy `profile_fallback` (the fixed reference basket above applies to the entire profile). Among configurations that already pass every quality requirement, rank by the measured input/output tokens each consumed on one common Artificial Analysis whole-suite benchmark workload, repriced uncached at current GitHub rates (reasoning is already part of output and is not charged again). This is an external benchmark-workload cost proxy, not predicted Copilot task spend, latency or quality, and it never relaxes a quality band. If any qualified competitor lacks valid, fresh, comparable measured usage, the entire profile uses the fixed reference basket instead; measured and fixed costs are never mixed.

| Changed model | Tier | Previous input / output USD per M | Current input / output USD per M | Previous cached input / cache write | Current cached input / cache write |
|---|---|---|---|---|---|

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
- Warning: Unmapped GitHub pricing model: Claude Fable 5.2
- Warning: Unmapped GitHub pricing model: Claude Sonnet 4
- Warning: Unmapped GitHub pricing model: Gemini 4 Carbon
- Warning: Unmapped GitHub pricing model: Gemini 4 Hydrogen
- Warning: Unmapped GitHub pricing model: GPT-5.4 nano
- Warning: Unmapped GitHub pricing model: GPT-6.1 Terra
- Warning: Unmapped GitHub pricing model: Grok 4.7

## Benchmark sources

| Source | Status | Results published | Suite label | Artifact updated | Retrieved | Raw observation identity |
|---|---|---|---|---|---|---|
| artificialAnalysis | ok | n/a | n/a | n/a | 2026-11-16T08:28:04.8080735Z | f062949133e864325058f170281206b695fa83051c8eee36a01db15727e43192&#124; |
| artificialAnalysisCodingAgents | ok | n/a | n/a | n/a | 2026-11-16T08:28:06.4361321Z | 1d285b782fdc50570f87e395ff00a81f924903e739e24f7d01de1715ee12a516 |
| artificialAnalysisComponents | ok | n/a | n/a | n/a | 2026-11-16T08:28:08.2660135Z | 10c661522b9a0772dd14c777b1cd9b728891863b83ca9bfb0d8d649a22b32a96 |
| liveBench | ok | n/a | 2026-06-25 | 2026-11-12T21:36:17.0000000Z | 2026-11-16T08:28:08.6278707Z | a8d2183fc195b3177c396c0fbe6ac80040e2a4090717d391c9a2c6ec3243207d |

Confirmation uses metric-scoped observations, not the raw page fingerprint. Suite labels, artifact updates, row evaluation ages and retrieval times are distinct: an artifact update does not make every row newly evaluated. Unknown dates or methodology versions are not fabricated. AA public components remain separate from API aggregates; public pricing is never imported. Data attribution: https://artificialanalysis.ai and https://livebench.ai (LiveBench 1.x data; not LiveBench 2.0).


## Coverage and exclusions

701 distinct exclusions, advisory warnings and evidence gaps. Repeated findings are listed once with every affected profile; full eligibility and scores remain available below.

<details>
<summary>Grouped coverage details</summary>

| Kind | Configuration (model / effort / context) | Finding | Affected profiles |
|---|---|---|---|
| advisory warning | claude-sonnet-4.6 / high / default | model_retirement_scope_unconfirmed | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| advisory warning | claude-sonnet-4.6 / high / long_context | model_retirement_scope_unconfirmed | deep-reasoning |
| advisory warning | claude-sonnet-4.6 / low / default | model_retirement_scope_unconfirmed | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| advisory warning | claude-sonnet-4.6 / low / long_context | model_retirement_scope_unconfirmed | deep-reasoning |
| advisory warning | claude-sonnet-4.6 / max / default | model_retirement_scope_unconfirmed | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| advisory warning | claude-sonnet-4.6 / max / long_context | model_retirement_scope_unconfirmed | deep-reasoning |
| advisory warning | claude-sonnet-4.6 / medium / default | model_retirement_scope_unconfirmed | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| advisory warning | claude-sonnet-4.6 / medium / long_context | model_retirement_scope_unconfirmed | deep-reasoning |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 09e56f8cd938c59b1a9a600141535ab0: composite_or_ambiguous_model_label 'Claude Fable 5.2 (Low, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 1fece3eef716cd9668b972cced54606c: model_identity_unresolved_or_ambiguous 'GPT-6.1 Terra (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 291529f5989be92da6395f4bb93da395: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 37d7db5622db33bcc5c6824d564246e7: composite_or_ambiguous_model_label 'Claude Fable 5.2 (High, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 4553886307abc03b6a785a5e0a54bcec: model_identity_unresolved_or_ambiguous 'DeepSeek V4.1 Flash 1017 (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 4d278d53a18fbdcb5138d11466ea0b1b: composite_or_ambiguous_model_label 'Claude Sonnet 5.5 (Max, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 5188996d2a6dad5165cdeebb51f983fe: model_identity_unresolved_or_ambiguous 'GLM-5.3 (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 5dfda0c81da51afcbeb49869c14445b2: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 6e872dc3aa0bc90635d8ae831e28f074: model_identity_unresolved_or_ambiguous 'Qwen3.8 Max' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 7814cb87040ea234c69eca79cd85486d: model_identity_unresolved_or_ambiguous 'Gemini 4 Carbon (High)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 78442b1eea1f0b696ab08b6d12ec9354: composite_or_ambiguous_model_label 'Claude Fable 5.2 (Max, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 7989f86ae8d744efb7608655672ab296: model_identity_unresolved_or_ambiguous 'Grok 4.7 (Xhigh)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 8180f45e6f53fc70033de79909aa3b6c: model_identity_unresolved_or_ambiguous 'Muse Spark 1.3 (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 9820ee072540fb8c51becfc2b1f274c8: composite_or_ambiguous_model_label 'Claude Fable 5.2 (Xhigh, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 98e53b1f02eee089dc8221078e300b3e: composite_or_ambiguous_model_label 'Claude Fable 5.1 (Max, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: ab4f6cb89f990484067eca06109875b3: model_identity_unresolved_or_ambiguous 'Muse Ember (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: ad1f505937d9446886b286573593bd42: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: b02d0ed1020688cc426aebb910ee1cd8: composite_or_ambiguous_model_label 'Claude Fable 5.2 (Medium, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: b4fbcf18275aad4049cd12448d37af9f: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: bdeb89e3a86551106e671c63fa1415bc: explicit_effort_conflicts_with_native_model | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: da3088d1680debe97b7b536e6908c548: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: e00a520b90336304cd56ead289bb59f2: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: e594775f1aa1026d8fa9385fa35f68b4: composite_or_ambiguous_model_label 'Claude Opus 5.5 (Max, Default Fallback)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: e9150db5061429910b5341e4f8bdc7a1: variant_unavailable_or_unknown | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: f83b8dc1b834e06b1dd1142e29bc77fc: model_identity_unresolved_or_ambiguous 'Muse Wonder (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-2-high: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-2-low: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-2-medium: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-2-xhigh: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-2: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-opus-5-5-high: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-opus-5-5-medium: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-opus-5-5-xhigh: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-opus-5-5: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-sonnet-5-5-xhigh: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-sonnet-5-5: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents.automationBench: insufficient_comparison_models (1/2) | mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-fable-5: no supported effort within the configured range | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-fable-5.1: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysis.intelligenceIndex 'claude-4-5-haiku' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisComponents.automationBench 'claude-4-5-haiku' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-4-5-haiku' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-4.5: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.automationBench 'claude-haiku-5-5-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.automationBench 'claude-haiku-5-5-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.automationBench 'claude-haiku-5-5-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.automationBench 'claude-haiku-5-5-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.automationBench 'claude-haiku-5-5' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-haiku-5-5-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-haiku-5-5-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-haiku-5-5-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-haiku-5-5-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.enterpriseOpsGym 'claude-haiku-5-5' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.ifbench 'claude-haiku-5-5-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.ifbench 'claude-haiku-5-5-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.ifbench 'claude-haiku-5-5-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.ifbench 'claude-haiku-5-5-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.ifbench 'claude-haiku-5-5' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.lcr 'claude-haiku-5-5-high' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.lcr 'claude-haiku-5-5-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.lcr 'claude-haiku-5-5-medium' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.lcr 'claude-haiku-5-5-xhigh' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.lcr 'claude-haiku-5-5' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.mmmuPro 'claude-haiku-5-5-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.mmmuPro 'claude-haiku-5-5-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.mmmuPro 'claude-haiku-5-5-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.mmmuPro 'claude-haiku-5-5-xhigh' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisComponents.mmmuPro 'claude-haiku-5-5' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'low' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'max' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'medium' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'max' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8-fast: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'low' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'medium' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysis.intelligenceIndex 'claude-opus-4-8' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents.automationBench 'claude-opus-4-8' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-4-8' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents.ifbench 'claude-opus-4-8' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents.lcr 'claude-opus-4-8' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: artificialAnalysisComponents.mmmuPro 'claude-opus-4-8' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-4.8: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysis.intelligenceIndex 'claude-opus-5-high' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysis.intelligenceIndex 'claude-opus-5-low' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysis.intelligenceIndex 'claude-opus-5-medium' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysis.intelligenceIndex 'claude-opus-5-xhigh' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.automationBench 'claude-opus-5-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.automationBench 'claude-opus-5-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.automationBench 'claude-opus-5-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.automationBench 'claude-opus-5-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.automationBench 'claude-opus-5' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.lcr 'claude-opus-5-high' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.lcr 'claude-opus-5-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.lcr 'claude-opus-5-medium' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.lcr 'claude-opus-5-xhigh' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.lcr 'claude-opus-5' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.mmmuPro 'claude-opus-5-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.mmmuPro 'claude-opus-5-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.mmmuPro 'claude-opus-5-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.mmmuPro 'claude-opus-5-xhigh' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.mmmuPro 'claude-opus-5' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysis effort 'low' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysis effort 'max' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysis effort 'medium' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisComponents effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisComponents effort 'max' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisComponents effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-opus-5.5: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'low' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis effort 'medium' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysis.intelligenceIndex 'claude-sonnet-4-6-adaptive' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents.automationBench 'claude-sonnet-4-6-adaptive' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-4-6-adaptive' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents.ifbench 'claude-sonnet-4-6-adaptive' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents.lcr 'claude-sonnet-4-6-adaptive' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents.mmmuPro 'claude-sonnet-4-6-adaptive' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.intelligenceIndex 'claude-sonnet-5-high' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.intelligenceIndex 'claude-sonnet-5-low' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.intelligenceIndex 'claude-sonnet-5-medium' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.intelligenceIndex 'claude-sonnet-5-xhigh' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysis.intelligenceIndex 'claude-sonnet-5' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.automationBench 'claude-sonnet-5-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.automationBench 'claude-sonnet-5-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.automationBench 'claude-sonnet-5-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.automationBench 'claude-sonnet-5-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.automationBench 'claude-sonnet-5' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.lcr 'claude-sonnet-5-high' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.lcr 'claude-sonnet-5-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.lcr 'claude-sonnet-5-medium' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.lcr 'claude-sonnet-5-xhigh' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.lcr 'claude-sonnet-5' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-xhigh' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'max' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysis effort 'low' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysis effort 'max' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysis effort 'medium' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysis effort 'xhigh' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisComponents effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisComponents effort 'max' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisComponents effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: artificialAnalysisComponents effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5.5: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysis effort 'none' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: artificialAnalysisComponents effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-3.8-flash: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-4-argon: artificialAnalysis effort 'none' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-4-argon: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gemini-4-argon: artificialAnalysisComponents effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gemini-4-argon: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'low' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis effort 'medium' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysis.intelligenceIndex 'gpt-5-3-codex' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents.automationBench 'gpt-5-3-codex' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-3-codex' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents.ifbench 'gpt-5-3-codex' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents.lcr 'gpt-5-3-codex' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: artificialAnalysisComponents.mmmuPro 'gpt-5-3-codex' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.3-codex: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysis effort 'none' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysis.intelligenceIndex 'gpt-5-6-luna-high' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysis.intelligenceIndex 'gpt-5-6-luna-low' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysis.intelligenceIndex 'gpt-5-6-luna-medium' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysis.intelligenceIndex 'gpt-5-6-luna-xhigh' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.automationBench 'gpt-5-6-luna-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.automationBench 'gpt-5-6-luna-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.automationBench 'gpt-5-6-luna-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.automationBench 'gpt-5-6-luna-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.automationBench 'gpt-5-6-luna' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.lcr 'gpt-5-6-luna-high' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.lcr 'gpt-5-6-luna-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.lcr 'gpt-5-6-luna-medium' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.lcr 'gpt-5-6-luna-xhigh' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.lcr 'gpt-5-6-luna' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.mmmuPro 'gpt-5-6-luna-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.mmmuPro 'gpt-5-6-luna-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.mmmuPro 'gpt-5-6-luna-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.mmmuPro 'gpt-5-6-luna-xhigh' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.mmmuPro 'gpt-5-6-luna' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysis effort 'none' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysis.intelligenceIndex 'gpt-5-6-sol-high' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysis.intelligenceIndex 'gpt-5-6-sol-low' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysis.intelligenceIndex 'gpt-5-6-sol-medium' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysis.intelligenceIndex 'gpt-5-6-sol-xhigh' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysis.intelligenceIndex 'gpt-5-6-sol' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.automationBench 'gpt-5-6-sol-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.automationBench 'gpt-5-6-sol-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.automationBench 'gpt-5-6-sol-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.automationBench 'gpt-5-6-sol-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.automationBench 'gpt-5-6-sol' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.ifbench 'gpt-5-6-sol-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.ifbench 'gpt-5-6-sol-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.ifbench 'gpt-5-6-sol-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.ifbench 'gpt-5-6-sol-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.ifbench 'gpt-5-6-sol' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.lcr 'gpt-5-6-sol-high' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.lcr 'gpt-5-6-sol-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.lcr 'gpt-5-6-sol-medium' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.lcr 'gpt-5-6-sol-xhigh' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.lcr 'gpt-5-6-sol' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.mmmuPro 'gpt-5-6-sol-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.mmmuPro 'gpt-5-6-sol-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.mmmuPro 'gpt-5-6-sol-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.mmmuPro 'gpt-5-6-sol-xhigh' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.mmmuPro 'gpt-5-6-sol' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysis effort 'none' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysis.intelligenceIndex 'gpt-5-6-terra-high' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysis.intelligenceIndex 'gpt-5-6-terra-low' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysis.intelligenceIndex 'gpt-5-6-terra-medium' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysis.intelligenceIndex 'gpt-5-6-terra-xhigh' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.automationBench 'gpt-5-6-terra-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.automationBench 'gpt-5-6-terra-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.automationBench 'gpt-5-6-terra-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.automationBench 'gpt-5-6-terra-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.automationBench 'gpt-5-6-terra' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.ifbench 'gpt-5-6-terra-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.ifbench 'gpt-5-6-terra-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.ifbench 'gpt-5-6-terra-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.ifbench 'gpt-5-6-terra-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.ifbench 'gpt-5-6-terra' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.lcr 'gpt-5-6-terra-high' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.lcr 'gpt-5-6-terra-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.lcr 'gpt-5-6-terra-medium' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.lcr 'gpt-5-6-terra-xhigh' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.lcr 'gpt-5-6-terra' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.mmmuPro 'gpt-5-6-terra-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.mmmuPro 'gpt-5-6-terra-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.mmmuPro 'gpt-5-6-terra-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.mmmuPro 'gpt-5-6-terra-xhigh' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.mmmuPro 'gpt-5-6-terra' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.automationBench 'gpt-6-astra-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-astra' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.ifbench 'gpt-6-astra' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.lcr 'gpt-6-astra-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisComponents.mmmuPro 'gpt-6-astra-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysis effort 'none' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.automationBench 'gpt-6-luna-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.automationBench 'gpt-6-luna-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.automationBench 'gpt-6-luna-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.automationBench 'gpt-6-luna-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.automationBench 'gpt-6-luna' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-luna-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-luna-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-luna-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-luna-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-luna' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.ifbench 'gpt-6-luna-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.ifbench 'gpt-6-luna-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.ifbench 'gpt-6-luna-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.ifbench 'gpt-6-luna-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.ifbench 'gpt-6-luna' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.lcr 'gpt-6-luna-high' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.lcr 'gpt-6-luna-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.lcr 'gpt-6-luna-medium' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.lcr 'gpt-6-luna-xhigh' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.lcr 'gpt-6-luna' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.mmmuPro 'gpt-6-luna-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.mmmuPro 'gpt-6-luna-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.mmmuPro 'gpt-6-luna-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.mmmuPro 'gpt-6-luna-xhigh' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: artificialAnalysisComponents.mmmuPro 'gpt-6-luna' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-luna: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysis effort 'none' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysis.intelligenceIndex 'gpt-6-sol-high' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysis.intelligenceIndex 'gpt-6-sol-low' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysis.intelligenceIndex 'gpt-6-sol-medium' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysis.intelligenceIndex 'gpt-6-sol-xhigh' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisCodingAgents effort 'max' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisCodingAgents effort 'none' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.automationBench 'gpt-6-sol-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.automationBench 'gpt-6-sol-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.automationBench 'gpt-6-sol-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.automationBench 'gpt-6-sol-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.automationBench 'gpt-6-sol' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-sol-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-sol-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-sol-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-sol-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-sol' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.ifbench 'gpt-6-sol-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.ifbench 'gpt-6-sol-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.ifbench 'gpt-6-sol-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.ifbench 'gpt-6-sol-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.ifbench 'gpt-6-sol' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.lcr 'gpt-6-sol-high' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.lcr 'gpt-6-sol-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.lcr 'gpt-6-sol-medium' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.lcr 'gpt-6-sol-xhigh' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.lcr 'gpt-6-sol' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.mmmuPro 'gpt-6-sol-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.mmmuPro 'gpt-6-sol-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.mmmuPro 'gpt-6-sol-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.mmmuPro 'gpt-6-sol-xhigh' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: artificialAnalysisComponents.mmmuPro 'gpt-6-sol' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.automationBench 'gpt-6-1-sol-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.automationBench 'gpt-6-1-sol-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-1-sol-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-1-sol-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-1-sol-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-1-sol-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-6-1-sol' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.ifbench 'gpt-6-1-sol-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.ifbench 'gpt-6-1-sol-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.ifbench 'gpt-6-1-sol-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.ifbench 'gpt-6-1-sol-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.ifbench 'gpt-6-1-sol' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.lcr 'gpt-6-1-sol-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.lcr 'gpt-6-1-sol-medium' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.mmmuPro 'gpt-6-1-sol-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisComponents.mmmuPro 'gpt-6-1-sol-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6.1-terra: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysis.intelligenceIndex 'grok-4-6-low' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysis.intelligenceIndex 'grok-4-6-medium' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysis.intelligenceIndex 'grok-4-6' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.automationBench 'grok-4-6-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.automationBench 'grok-4-6-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.automationBench 'grok-4-6-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.automationBench 'grok-4-6' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.enterpriseOpsGym 'grok-4-6-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.enterpriseOpsGym 'grok-4-6-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.enterpriseOpsGym 'grok-4-6-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.enterpriseOpsGym 'grok-4-6' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.lcr 'grok-4-6-low' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.lcr 'grok-4-6-medium' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.lcr 'grok-4-6-xhigh' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.lcr 'grok-4-6' score_missing_or_invalid | deep-reasoning, orchestrator, review |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.mmmuPro 'grok-4-6-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.mmmuPro 'grok-4-6-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.mmmuPro 'grok-4-6-xhigh' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.mmmuPro 'grok-4-6' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.7: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | instruction-following: artificialAnalysisComponents.ifbench: insufficient_comparison_models (1/2) | mechanical, triage |
| evidence gap | n/a / n/a / n/a | kimi-k3: configuration capabilities_missing | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'high' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'low' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysis effort 'medium' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisComponents effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisComponents effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: artificialAnalysisComponents effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | mai-code-1.1-flash: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | primary: artificialAnalysisComponents.automationBench: insufficient_comparison_models (1/2) | mechanical, orchestrator |
| exclusion | claude-haiku-4.5 / none / long_context | context_unsupported | deep-reasoning |
| exclusion | claude-opus-4.8-fast / high / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-opus-4.8-fast / high / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-opus-4.8-fast / low / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-opus-4.8-fast / low / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-opus-4.8-fast / max / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-opus-4.8-fast / max / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-opus-4.8-fast / medium / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-opus-4.8-fast / medium / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-opus-4.8-fast / xhigh / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-opus-4.8-fast / xhigh / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-opus-4.8 / high / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / high / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / low / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / low / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / max / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / max / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / medium / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / medium / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / xhigh / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-4.8 / xhigh / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / high / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / high / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / low / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / low / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / max / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / max / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / medium / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / medium / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / xhigh / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5 / xhigh / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5.5 / high / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5.5 / high / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5.5 / low / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5.5 / low / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5.5 / max / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5.5 / max / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5.5 / medium / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5.5 / medium / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5.5 / xhigh / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-opus-5.5 / xhigh / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | claude-sonnet-4.6 / high / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-sonnet-4.6 / high / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / high / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / high / long_context | capabilities_stale | deep-reasoning |
| exclusion | claude-sonnet-4.6 / low / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-sonnet-4.6 / low / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / low / long_context | capabilities_stale | deep-reasoning |
| exclusion | claude-sonnet-4.6 / max / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-sonnet-4.6 / max / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / max / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / max / long_context | capabilities_stale | deep-reasoning |
| exclusion | claude-sonnet-4.6 / medium / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | claude-sonnet-4.6 / medium / default | pricing_input_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / medium / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | claude-sonnet-4.6 / medium / long_context | capabilities_stale | deep-reasoning |
| exclusion | gpt-5.3-codex / high / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-5.3-codex / high / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.3-codex / high / default | vision_unknown | visual-ui |
| exclusion | gpt-5.3-codex / high / long_context | capabilities_stale | deep-reasoning |
| exclusion | gpt-5.3-codex / high / long_context | context_unsupported | deep-reasoning |
| exclusion | gpt-5.3-codex / low / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-5.3-codex / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.3-codex / low / default | vision_unknown | visual-ui |
| exclusion | gpt-5.3-codex / low / long_context | capabilities_stale | deep-reasoning |
| exclusion | gpt-5.3-codex / low / long_context | context_unsupported | deep-reasoning |
| exclusion | gpt-5.3-codex / medium / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-5.3-codex / medium / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.3-codex / medium / default | vision_unknown | visual-ui |
| exclusion | gpt-5.3-codex / medium / long_context | capabilities_stale | deep-reasoning |
| exclusion | gpt-5.3-codex / medium / long_context | context_unsupported | deep-reasoning |
| exclusion | gpt-5.3-codex / xhigh / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-5.3-codex / xhigh / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.3-codex / xhigh / default | vision_unknown | visual-ui |
| exclusion | gpt-5.3-codex / xhigh / long_context | capabilities_stale | deep-reasoning |
| exclusion | gpt-5.3-codex / xhigh / long_context | context_unsupported | deep-reasoning |
| exclusion | gpt-5.6-sol / high / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / high / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / low / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / low / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / max / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / max / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / medium / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / medium / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / none / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / none / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / xhigh / default | pricing_input_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-sol / xhigh / default | pricing_output_exceeds_ceiling | mechanical, orchestrator, quick, triage |
| exclusion | gpt-5.6-terra / high / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-terra / low / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-terra / max / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-terra / medium / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-terra / none / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-5.6-terra / xhigh / default | pricing_output_exceeds_ceiling | mechanical, quick, triage |
| exclusion | gpt-6-astra / high / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-6-astra / high / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-6-astra / low / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-6-astra / low / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-6-astra / max / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-6-astra / max / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-6-astra / medium / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-6-astra / medium / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-6-astra / xhigh / default | pricing_input_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | gpt-6-astra / xhigh / default | pricing_output_exceeds_ceiling | default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | grok-4.6 / high / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | grok-4.6 / high / long_context | capabilities_stale | deep-reasoning |
| exclusion | grok-4.6 / low / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | grok-4.6 / low / long_context | capabilities_stale | deep-reasoning |
| exclusion | grok-4.6 / medium / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | grok-4.6 / medium / long_context | capabilities_stale | deep-reasoning |
| exclusion | grok-4.6 / xhigh / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | grok-4.6 / xhigh / long_context | capabilities_stale | deep-reasoning |
| exclusion | mai-code-1.1-flash / high / long_context | context_unsupported | deep-reasoning |
| exclusion | mai-code-1.1-flash / low / long_context | context_unsupported | deep-reasoning |
| exclusion | mai-code-1.1-flash / medium / long_context | context_unsupported | deep-reasoning |

</details>

## Profile evidence

### orchestrator

Budget: **hard**, input 3 / output 15 USD per million. Deciding source: n/a.
Quality leader before hard-budget exclusions: n/a. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket.** No qualified configuration was ranked, so no measured comparison applies.
Authorized deciding routes, strongest first: **AutomationBench-AA > EnterpriseOps-Gym-AA**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **retained_insufficient_role_evidence**. Deciding metric: n/a.
Incumbent selection basis (applied/current after run): artificialAnalysisComponents.automationBench.
AutomationBench-AA (guardrail-adjusted objective fraction): Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA (strict pass@1 fraction): AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **n/a AIC**; incumbent **300 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.

**Role qualification:** retained_insufficient_role_evidence. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | n/a | 0 | n/a | n/a | n/a | n/a | n/a | n/a |
| long-context | artificialAnalysisComponents.lcr | 2 | gpt-6.1-sol / max / default | 0.83 | 0.05 | 0.78 | False | n/a |
| instruction-following | liveBench.instructionFollowing | 8 | gpt-6.1-sol / max / default | 74.15425 | 3 | 71.15425 | False | n/a |

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
| claude-haiku-5.5 / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 66.4665 (outside_quality_band) |
| gpt-6-sol / medium / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 70.5165 (outside_quality_band) |
| mai-code-1.1-flash / low / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 56.78775 (outside_quality_band) |
| claude-haiku-5.5 / low / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / none / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); long-context: 0.796666666667 (passed); instruction-following: 71.325 (passed) |
| claude-haiku-5.5 / max / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 54.65825 (outside_quality_band) |
| gpt-6-sol / none / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (insufficient_comparison_evidence); long-context: 0.496666666667 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 68.57475 (outside_quality_band) |
| mai-code-1.1-flash / high / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 63.8585 (outside_quality_band) |
| claude-sonnet-5 / high / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / max / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 64.6165 (outside_quality_band) |
| claude-haiku-5.5 / medium / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 60.121 (outside_quality_band) |
| gpt-6.1-sol / high / default | False | primary: n/a (insufficient_comparison_evidence); long-context: 0.823333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 55.93325 (outside_quality_band) |
| gpt-6-sol / low / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | False | primary: n/a (insufficient_comparison_evidence); long-context: 0.83 (passed); instruction-following: 74.15425 (passed) |
| gpt-6-luna / high / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / low / default | False | primary: n/a (insufficient_comparison_evidence); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |

**Current configuration retained, not certified:** no role-qualified recommendation is available. No requirements are relaxed to fill the profile, and force cannot bypass missing coverage or an empty intersection.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / none / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / none / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | automationBench | 0.666122174975 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | automationBench | 0.684917480669 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | automationBench | 0.645949885056 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | automationBench | 0.671777802022 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | automationBench | 0.644952373218 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | automationBench | 0.64868448824 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | automationBench | 0.665737214136 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | lcr | 0.496666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | lcr | 0.806666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | instructionFollowing | 54.65825 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | instructionFollowing | 66.4665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | instructionFollowing | 72.0335 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | instructionFollowing | 63.7665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | instructionFollowing | 65.73775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | instructionFollowing | 67.04975 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | instructionFollowing | 63.22075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | instructionFollowing | 63.8585 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | instructionFollowing | 56.78775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | instructionFollowing | 70.5165 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | instructionFollowing | 60.121 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | instructionFollowing | 71.846 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | instructionFollowing | 64.6165 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | instructionFollowing | 75.579 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | instructionFollowing | 55.93325 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | instructionFollowing | 68.57475 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | instructionFollowing | 74.15425 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | instructionFollowing | 71.325 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### quick

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: liveBench.
Quality leader before hard-budget exclusions: claude-sonnet-5.5 / max / default. Family fallback (informational, not a winner): claude-haiku-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket (profile fallback).** Measured benchmark-workload usage (`aa-intelligence-index-canonical-v1`) is unavailable or not comparable for at least one qualified configuration (usage_alias_not_configured), so the entire profile is ranked on the fixed basket. Measured and fixed costs are never mixed, and no qualified configuration is dropped to improve coverage.
Qualified configurations without valid measured usage: claude-sonnet-5.5 / xhigh / default (usage_alias_not_configured); claude-sonnet-5.5 / max / default (usage_alias_not_configured).
Authorized deciding routes, strongest first: **LiveBench Coding > AA Intelligence Index**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: liveBench.coding.
Incumbent selection basis (applied/current after run): liveBench.coding.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **300 AIC**; incumbent **300 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-sonnet-5.5 / max / default (91.366). Candidate gap: **0 / 3** absolute coding score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **300 AIC**; incumbent **300 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **91.366**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | liveBench.coding | 7 | claude-sonnet-5.5 / max / default | 91.366 | 3 | 88.366 | False | n/a |

primary routes: LiveBench Coding > AA Intelligence Index.
LiveBench Coding: Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: 76.393 (outside_quality_band) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | True | primary: 88.8705 (passed) |
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | True | primary: 91.366 (passed) |
| claude-haiku-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | False | primary: 80.741 (outside_quality_band) |
| claude-haiku-5.5 / max / default | False | primary: 77.863 (outside_quality_band) |
| gpt-6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: 81.767 (outside_quality_band) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: 80.68 (outside_quality_band) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / default | False | primary: 82.915 (outside_quality_band) |
| gpt-6.1-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: 78.95 (outside_quality_band) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | False | primary: 80.3585 (outside_quality_band) |
| gpt-6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| IFBench (AA) | claude-sonnet-5.5 / max / default | n/a | n/a (missing or invalid) | accuracy fraction | n/a | n/a | n/a |
| LiveBench Instruction Following | claude-sonnet-5.5 / max / default | claude-sonnet-5-5-max-effort | 56.78775 | percentage points | n/a | 2026-11-16T08:28:08.6278707Z | False |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / none / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / high / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / max / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / medium / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / none / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / xhigh / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | coding | 77.863 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | coding | 76.393 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | coding | 81.828 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | coding | 81.4455 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | coding | 89.253 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | coding | 89.253 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | coding | 80.68 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | coding | 91.366 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | coding | 88.8705 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | coding | 82.915 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | coding | 83.941 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | coding | 78.2455 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | coding | 80.3585 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | coding | 78.95 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | coding | 81.767 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | coding | 80.3585 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | coding | 80.741 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-high | high | intelligenceIndex | 29.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-low | low | intelligenceIndex | 18.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5 | max | intelligenceIndex | 36.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-medium | medium | intelligenceIndex | 24.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-xhigh | xhigh | intelligenceIndex | 34.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | intelligenceIndex | 23.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | intelligenceIndex | 32.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 54.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | intelligenceIndex | 43.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra | max | intelligenceIndex | 56.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | intelligenceIndex | 51.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-xhigh | xhigh | intelligenceIndex | 55.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-high | high | intelligenceIndex | 21.4 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-low | low | intelligenceIndex | 9.7 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna | max | intelligenceIndex | 27.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-medium | medium | intelligenceIndex | 18.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-xhigh | xhigh | intelligenceIndex | 23.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-sol | artificialAnalysis | gpt-6-sol | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-high | high | intelligenceIndex | 50.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-low | low | intelligenceIndex | 34.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol | max | intelligenceIndex | 54.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-medium | medium | intelligenceIndex | 46.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-xhigh | xhigh | intelligenceIndex | 52.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.6 | artificialAnalysis | grok-4-6-xhigh | xhigh | intelligenceIndex | 31 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | instructionFollowing | 54.65825 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | instructionFollowing | 66.4665 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | instructionFollowing | 72.0335 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | instructionFollowing | 63.7665 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | instructionFollowing | 65.73775 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | instructionFollowing | 67.04975 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | instructionFollowing | 63.22075 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | instructionFollowing | 63.8585 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | instructionFollowing | 56.78775 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | instructionFollowing | 70.5165 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | instructionFollowing | 60.121 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | instructionFollowing | 71.846 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | instructionFollowing | 64.6165 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | instructionFollowing | 75.579 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | instructionFollowing | 55.93325 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | instructionFollowing | 68.57475 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | instructionFollowing | 74.15425 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | instructionFollowing | 71.325 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### default-development

Budget: **hard**, input 4 / output 20 USD per million. Deciding source: liveBench.
Quality leader before hard-budget exclusions: claude-sonnet-5.5 / max / default. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket (profile fallback).** Measured benchmark-workload usage (`aa-intelligence-index-canonical-v1`) is unavailable or not comparable for at least one qualified configuration (usage_alias_not_configured), so the entire profile is ranked on the fixed basket. Measured and fixed costs are never mixed, and no qualified configuration is dropped to improve coverage.
Qualified configurations without valid measured usage: claude-sonnet-5.5 / xhigh / default (usage_alias_not_configured).
Authorized deciding routes, strongest first: **LiveBench Coding > AA Intelligence Index**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: liveBench.coding.
Incumbent selection basis (applied/current after run): liveBench.coding.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **300 AIC**; incumbent **300 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-sonnet-5.5 / max / default (91.366). Candidate gap: **2.4955 / 3** absolute coding score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **300 AIC**; incumbent **300 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **88.8705**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | liveBench.coding | 10 | claude-sonnet-5.5 / max / default | 91.366 | 3 | 88.366 | False | n/a |
| instruction-following | liveBench.instructionFollowing | 10 | gpt-6.1-sol / max / default | 74.15425 | 4 | 70.15425 | False | n/a |

primary routes: LiveBench Coding > AA Intelligence Index.
LiveBench Coding: Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.

instruction-following routes: LiveBench Instruction Following > IFBench (AA).
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.
IFBench (AA): Single-turn instruction following, not multi-turn retention.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: 76.393 (outside_quality_band); instruction-following: 66.4665 (outside_quality_band) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / max / default | False | primary: 89.253 (passed); instruction-following: 65.73775 (outside_quality_band) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | True | primary: 88.8705 (passed); instruction-following: 70.5165 (passed) |
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: 91.366 (passed); instruction-following: 56.78775 (outside_quality_band) |
| claude-haiku-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | False | primary: 80.741 (outside_quality_band); instruction-following: 71.325 (passed) |
| gpt-5.6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / max / default | False | primary: 77.863 (outside_quality_band); instruction-following: 54.65825 (outside_quality_band) |
| gpt-5.6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: 81.767 (outside_quality_band); instruction-following: 68.57475 (outside_quality_band) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: 80.68 (outside_quality_band); instruction-following: 63.8585 (outside_quality_band) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / max / default | False | primary: 78.2455 (outside_quality_band); instruction-following: 64.6165 (outside_quality_band) |
| claude-haiku-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / max / default | False | primary: 83.941 (outside_quality_band); instruction-following: 71.846 (passed) |
| gpt-6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / default | False | primary: 82.915 (outside_quality_band); instruction-following: 60.121 (outside_quality_band) |
| gpt-6.1-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / xhigh / default | False | primary: 89.253 (passed); instruction-following: 67.04975 (outside_quality_band) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: 78.95 (outside_quality_band); instruction-following: 55.93325 (outside_quality_band) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | False | primary: 80.3585 (outside_quality_band); instruction-following: 74.15425 (passed) |
| gpt-6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / none / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / none / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | coding | 77.863 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | coding | 76.393 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | coding | 81.828 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | coding | 81.4455 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | coding | 89.253 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | coding | 89.253 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | coding | 80.68 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | coding | 91.366 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | coding | 88.8705 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | coding | 82.915 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | coding | 83.941 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | coding | 78.2455 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | coding | 80.3585 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | coding | 78.95 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | coding | 81.767 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | coding | 80.3585 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | coding | 80.741 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-high | high | intelligenceIndex | 29.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-low | low | intelligenceIndex | 18.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5 | max | intelligenceIndex | 36.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-medium | medium | intelligenceIndex | 24.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-xhigh | xhigh | intelligenceIndex | 34.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | intelligenceIndex | 23.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | intelligenceIndex | 32.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 54.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | intelligenceIndex | 43.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra | max | intelligenceIndex | 56.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | intelligenceIndex | 51.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-xhigh | xhigh | intelligenceIndex | 55.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-high | high | intelligenceIndex | 21.4 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-low | low | intelligenceIndex | 9.7 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna | max | intelligenceIndex | 27.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-medium | medium | intelligenceIndex | 18.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-xhigh | xhigh | intelligenceIndex | 23.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-sol | artificialAnalysis | gpt-6-sol | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-high | high | intelligenceIndex | 50.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-low | low | intelligenceIndex | 34.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol | max | intelligenceIndex | 54.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-medium | medium | intelligenceIndex | 46.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-xhigh | xhigh | intelligenceIndex | 52.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.6 | artificialAnalysis | grok-4-6-xhigh | xhigh | intelligenceIndex | 31 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | instructionFollowing | 54.65825 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | instructionFollowing | 66.4665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | instructionFollowing | 72.0335 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | instructionFollowing | 63.7665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | instructionFollowing | 65.73775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | instructionFollowing | 67.04975 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | instructionFollowing | 63.22075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | instructionFollowing | 63.8585 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | instructionFollowing | 56.78775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | instructionFollowing | 70.5165 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | instructionFollowing | 60.121 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | instructionFollowing | 71.846 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | instructionFollowing | 64.6165 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | instructionFollowing | 75.579 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | instructionFollowing | 55.93325 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | instructionFollowing | 68.57475 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | instructionFollowing | 74.15425 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | instructionFollowing | 71.325 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### agentic-implementation

Budget: **hard**, input 10 / output 50 USD per million. Deciding source: artificialAnalysisCodingAgents.
Quality leader before hard-budget exclusions: gpt-6-astra / max / default. Family fallback (informational, not a winner): gpt-5.6-terra.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket (profile fallback).** Measured benchmark-workload usage (`aa-intelligence-index-canonical-v1`) is unavailable or not comparable for at least one qualified configuration (usage_workload_mismatch), so the entire profile is ranked on the fixed basket. Measured and fixed costs are never mixed, and no qualified configuration is dropped to improve coverage.
Qualified configurations without valid measured usage: gpt-6.1-sol / max / default (usage_workload_mismatch); gpt-6-astra / max / default (usage_workload_mismatch).
Authorized deciding routes, strongest first: **AA Coding Agent Index > LiveBench Agentic Coding**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: artificialAnalysisCodingAgents.codingAgentIndex.
Incumbent selection basis (applied/current after run): artificialAnalysisCodingAgents.codingAgentIndex.
AA Coding Agent Index (fraction): External coding-agent harness, not Copilot CLI.
LiveBench Agentic Coding (percentage points): External agentic coding evaluation, not the local orchestration workflow.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **300 AIC**; incumbent **300 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-6-astra / max / default (0.530999198979). Candidate gap: **0.00940029597046 / 0.03** absolute codingAgentIndex score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **300 AIC**; incumbent **300 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **0.521598903009**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysisCodingAgents.codingAgentIndex | 4 | gpt-6-astra / max / default | 0.530999198979 | 0.03 | 0.500999198979 | False | n/a |

primary routes: AA Coding Agent Index > LiveBench Agentic Coding.
AA Coding Agent Index: External coding-agent harness, not Copilot CLI.
LiveBench Agentic Coding: External agentic coding evaluation, not the local orchestration workflow.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / max / default | False | primary: 0.295910380689 (outside_quality_band) |
| gpt-5.6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: 0.258937884219 (outside_quality_band) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | True | primary: 0.521598903009 (passed) |
| gpt-6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / max / default | True | primary: 0.530999198979 (passed) |
| claude-opus-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / medium / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / low / default | False | primary: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):

| Metric | Configuration (model / effort / context) | Exact alias | Score | Native units | Results published | Retrieved | Cached |
|---|---|---|---|---|---|---|---|
| AutomationBench-AA | gpt-6.1-sol / max / default | gpt-6-1-sol | 0.64868448824 | guardrail-adjusted objective fraction | n/a | 2026-11-16T08:28:08.2660135Z | False |
| EnterpriseOps-Gym-AA | gpt-6.1-sol / max / default | n/a | n/a (missing or invalid) | strict pass@1 fraction | n/a | n/a | n/a |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
AutomationBench-AA: Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA: AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / high / default | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / low / default | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / max / default | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / medium / default | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / none / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / none / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / high / default | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / low / default | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / max / default | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / medium / default | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysisCodingAgents | Claude Code - Claude Haiku 5.5 (Max) | max | codingAgentIndex | 0.295910380689 | True | False | Claude Code; variant 2b8b120200b4dc63bb579d5a53b52b70; external agent harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisCodingAgents | Codex - GPT-6 Astra (Max) | max | codingAgentIndex | 0.530999198979 | True | False | Codex; variant 97f24b3f300fe06034101d053f3a894b; external agent harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisCodingAgents | Codex - GPT-6 Luna (Max) | max | codingAgentIndex | 0.258937884219 | True | False | Codex; variant 44059b1749b7773326c3ee04acbfaba2; external agent harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisCodingAgents | Codex - GPT-6.1 Sol (Max) | max | codingAgentIndex | 0.521598903009 | True | False | Codex; variant 5146f276cbceb4e9fdeb5834609f805b; external agent harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | agenticCoding | 57.1716666667 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | agenticCoding | 51.3636666667 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | agenticCoding | 50.505 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | agenticCoding | 65.202 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | agenticCoding | 71.717 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | agenticCoding | 65.3533333333 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | agenticCoding | 42.626 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | agenticCoding | 59.394 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | agenticCoding | 56.3133333333 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | agenticCoding | 39.3436666667 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | agenticCoding | 48.4343333333 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | agenticCoding | 56.212 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | agenticCoding | 54.9496666667 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | agenticCoding | 57.323 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | agenticCoding | 51.212 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | agenticCoding | 52.8786666667 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | agenticCoding | 54.5453333333 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | agenticCoding | 56.7676666667 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | automationBench | 0.666122174975 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | automationBench | 0.684917480669 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | automationBench | 0.645949885056 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | automationBench | 0.671777802022 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | automationBench | 0.644952373218 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | automationBench | 0.64868448824 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | automationBench | 0.665737214136 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### deep-reasoning

Budget: **hard**, input 20 / output 75 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / max / long_context. Family fallback (informational, not a winner): claude-opus-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket (profile fallback).** Measured benchmark-workload usage (`aa-intelligence-index-canonical-v1`) is unavailable or not comparable for at least one qualified configuration (usage_workload_mismatch), so the entire profile is ranked on the fixed basket. Measured and fixed costs are never mixed, and no qualified configuration is dropped to improve coverage.
Qualified configurations without valid measured usage: gpt-6-astra / max / long_context (usage_workload_mismatch); gpt-6-astra / xhigh / long_context (usage_workload_mismatch); gpt-6-astra / high / long_context (usage_workload_mismatch); gpt-6.1-sol / max / long_context (usage_workload_mismatch).
Authorized deciding routes, strongest first: **AA Intelligence Index > LiveBench Reasoning**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: artificialAnalysis.intelligenceIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.intelligenceIndex.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning (percentage points): Reasoning proxy; does not establish interactive triage skill.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **550 AIC**; incumbent **550 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-6-astra / max / long_context (56.9). Candidate gap: **2.3 / 3** absolute intelligenceIndex score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **550 AIC**; incumbent **550 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **54.6**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysis.intelligenceIndex | 8 | gpt-6-astra / max / long_context | 56.9 | 3 | 53.9 | False | n/a |
| long-context | artificialAnalysisComponents.lcr | 2 | gpt-6.1-sol / max / long_context | 0.83 | 0.05 | 0.78 | False | n/a |

primary routes: AA Intelligence Index > LiveBench Reasoning.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning: Reasoning proxy; does not establish interactive triage skill.

long-context routes: AA-LCR.
AA-LCR: Long-document reasoning, not conversational retention.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| gpt-5.6-terra / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / xhigh / long_context | False | primary: 34.6 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / max / long_context | False | primary: 36.5 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / max / long_context | True | primary: 56.9 (passed); long-context: 0.806666666667 (passed) |
| gpt-6-astra / xhigh / long_context | True | primary: 55.3 (passed); long-context: 0.8 (passed) |
| gpt-5.6-sol / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / high / long_context | True | primary: 54.8 (passed); long-context: 0.8 (passed) |
| claude-opus-4.8-fast / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / high / long_context | False | primary: 50.3 (outside_quality_band); long-context: 0.823333333333 (passed) |
| claude-sonnet-5.5 / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / max / long_context | False | primary: 44.2 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / long_context | False | primary: 27.9 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / long_context | False | primary: 46.3 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / long_context | False | primary: 34.8 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / low / long_context | False | primary: 43.3 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / long_context | False | primary: 18.5 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / long_context | True | primary: 54.6 (passed); long-context: 0.83 (passed) |
| claude-haiku-5.5 / low / long_context | False | primary: 18.6 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / long_context | False | primary: 23.8 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / long_context | False | primary: 23.5 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / long_context | False | primary: 24.6 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / long_context | False | primary: 44.2 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8-fast / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / long_context | False | primary: 52.5 (outside_quality_band); long-context: 0.796666666667 (passed) |
| claude-opus-5.5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / max / long_context | False | primary: 32.3 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / long_context | False | primary: 29.9 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / medium / long_context | False | primary: 51.6 (outside_quality_band); long-context: 0.796666666667 (passed) |
| gpt-6-luna / low / long_context | False | primary: 9.7 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / high / long_context | False | primary: 21.4 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / long_context | False | context_unsupported | n/a | default | 1 / 5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / high / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / low / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / max / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / medium / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / xhigh / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / low / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / medium / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / high / long_context | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / low / long_context | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / max / long_context | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / medium / long_context | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / xhigh / long_context | True | n/a | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / low / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / medium / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / high / long_context | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / low / long_context | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / max / long_context | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / medium / long_context | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / xhigh / long_context | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-4.6 / high / long_context | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / low / long_context | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / max / long_context | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / long_context | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-5 / high / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / low / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / max / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / medium / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / xhigh / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / high / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / low / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / max / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / medium / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / xhigh / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gemini-3.8-flash / none / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / long_context | False | capabilities_stale, context_unsupported | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / low / long_context | False | capabilities_stale, context_unsupported | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / medium / long_context | False | capabilities_stale, context_unsupported | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / long_context | False | capabilities_stale, context_unsupported | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.6-luna / high / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / low / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / max / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / medium / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / none / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / xhigh / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / high / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / low / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / max / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / medium / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / none / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / xhigh / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / high / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / low / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / max / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / medium / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / none / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / xhigh / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / high / long_context | True | n/a | n/a | long_context | 20 / 75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / low / long_context | True | n/a | n/a | long_context | 20 / 75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / max / long_context | True | n/a | n/a | long_context | 20 / 75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / medium / long_context | True | n/a | n/a | long_context | 20 / 75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / xhigh / long_context | True | n/a | n/a | long_context | 20 / 75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / high / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / low / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / max / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / medium / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / none / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / xhigh / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / high / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / low / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / max / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / medium / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / none / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / xhigh / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / high / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / low / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / max / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / medium / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / xhigh / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| grok-4.6 / high / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / low / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / medium / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / xhigh / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| mai-code-1.1-flash / high / long_context | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / low / long_context | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / medium / long_context | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-high | high | intelligenceIndex | 29.9 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-low | low | intelligenceIndex | 18.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5 | max | intelligenceIndex | 36.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-medium | medium | intelligenceIndex | 24.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-xhigh | xhigh | intelligenceIndex | 34.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | intelligenceIndex | 23.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | intelligenceIndex | 32.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 54.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | intelligenceIndex | 43.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra | max | intelligenceIndex | 56.9 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | intelligenceIndex | 51.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-xhigh | xhigh | intelligenceIndex | 55.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-high | high | intelligenceIndex | 21.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-low | low | intelligenceIndex | 9.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna | max | intelligenceIndex | 27.9 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-medium | medium | intelligenceIndex | 18.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-xhigh | xhigh | intelligenceIndex | 23.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysis | gpt-6-sol | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-high | high | intelligenceIndex | 50.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-low | low | intelligenceIndex | 34.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol | max | intelligenceIndex | 54.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-medium | medium | intelligenceIndex | 46.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-xhigh | xhigh | intelligenceIndex | 52.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysis | grok-4-6-xhigh | xhigh | intelligenceIndex | 31 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | reasoning | 84.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | reasoning | 81.23075 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | reasoning | 89.19225 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | reasoning | 91.2115 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | reasoning | 92.15375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | reasoning | 90.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | reasoning | 84.76925 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | reasoning | 88.69225 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | reasoning | 91.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | reasoning | 86.80775 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | reasoning | 85.64425 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | reasoning | 91.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | reasoning | 90.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | reasoning | 92.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | reasoning | 81.76925 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | reasoning | 88.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | reasoning | 92.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | reasoning | 91.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | lcr | 0.496666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | lcr | 0.806666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### review

Budget: **hard**, input 5 / output 30 USD per million. Deciding source: liveBench.
Quality leader before hard-budget exclusions: claude-sonnet-5.5 / max / default. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket (profile fallback).** Measured benchmark-workload usage (`aa-intelligence-index-canonical-v1`) is unavailable or not comparable for at least one qualified configuration (usage_workload_mismatch), so the entire profile is ranked on the fixed basket. Measured and fixed costs are never mixed, and no qualified configuration is dropped to improve coverage.
Qualified configurations without valid measured usage: gpt-6.1-sol / xhigh / default (usage_workload_mismatch); gpt-6.1-sol / max / default (usage_workload_mismatch).
Authorized deciding routes, strongest first: **LiveBench Coding > AA Intelligence Index**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: liveBench.coding.
Incumbent selection basis (applied/current after run): liveBench.coding.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **300 AIC**; incumbent **300 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-sonnet-5.5 / max / default (91.366). Candidate gap: **10.625 / 12** absolute coding score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **300 AIC**; incumbent **300 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **80.741**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | liveBench.coding | 12 | claude-sonnet-5.5 / max / default | 91.366 | 12 | 79.366 | False | n/a |
| reasoning | liveBench.reasoning | 12 | gpt-6.1-sol / max / default | 92.6345 | 3 | 89.6345 | False | n/a |
| long-context | artificialAnalysisComponents.lcr | 2 | gpt-6.1-sol / max / default | 0.83 | 0.05 | 0.78 | False | n/a |

primary routes: LiveBench Coding > AA Intelligence Index.
LiveBench Coding: Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.

reasoning routes: LiveBench Reasoning.
LiveBench Reasoning: Reasoning proxy; does not establish interactive triage skill.

long-context routes: AA-LCR.
AA-LCR: Long-document reasoning, not conversational retention.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: 76.393 (outside_quality_band); reasoning: 81.23075 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / max / default | False | primary: 89.253 (passed); reasoning: 92.15375 (passed); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | False | primary: 88.8705 (passed); reasoning: 86.80775 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: 91.366 (passed); reasoning: 91.6345 (passed); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | True | primary: 80.741 (passed); reasoning: 91.6345 (passed); long-context: 0.796666666667 (passed) |
| gpt-5.6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / max / default | False | primary: 77.863 (outside_quality_band); reasoning: 84.6345 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / max / default | False | primary: 81.828 (passed); reasoning: 89.19225 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.496666666667 (outside_quality_band) |
| claude-opus-5 / max / default | False | primary: 81.4455 (passed); reasoning: 91.2115 (passed); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: 81.767 (passed); reasoning: 88.65375 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: 80.68 (passed); reasoning: 88.69225 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / max / default | False | primary: 78.2455 (outside_quality_band); reasoning: 90.6345 (passed); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / max / default | False | primary: 83.941 (passed); reasoning: 91.65375 (passed); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / default | False | primary: 82.915 (passed); reasoning: 85.64425 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.823333333333 (passed) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / xhigh / default | False | primary: 89.253 (passed); reasoning: 90.65375 (passed); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: 78.95 (outside_quality_band); reasoning: 81.76925 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | True | primary: 80.3585 (passed); reasoning: 92.6345 (passed); long-context: 0.83 (passed) |
| gpt-6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / none / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / none / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | coding | 77.863 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | coding | 76.393 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | coding | 81.828 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | coding | 81.4455 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | coding | 89.253 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | coding | 89.253 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | coding | 80.68 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | coding | 91.366 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | coding | 88.8705 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | coding | 82.915 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | coding | 83.941 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | coding | 78.2455 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | coding | 80.3585 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | coding | 78.95 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | coding | 81.767 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | coding | 80.3585 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | coding | 80.741 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-high | high | intelligenceIndex | 29.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-low | low | intelligenceIndex | 18.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5 | max | intelligenceIndex | 36.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-medium | medium | intelligenceIndex | 24.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-xhigh | xhigh | intelligenceIndex | 34.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | intelligenceIndex | 23.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | intelligenceIndex | 32.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 54.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | intelligenceIndex | 43.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra | max | intelligenceIndex | 56.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | intelligenceIndex | 51.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-xhigh | xhigh | intelligenceIndex | 55.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-high | high | intelligenceIndex | 21.4 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-low | low | intelligenceIndex | 9.7 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna | max | intelligenceIndex | 27.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-medium | medium | intelligenceIndex | 18.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-xhigh | xhigh | intelligenceIndex | 23.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-sol | artificialAnalysis | gpt-6-sol | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-high | high | intelligenceIndex | 50.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-low | low | intelligenceIndex | 34.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol | max | intelligenceIndex | 54.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-medium | medium | intelligenceIndex | 46.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-xhigh | xhigh | intelligenceIndex | 52.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.6 | artificialAnalysis | grok-4-6-xhigh | xhigh | intelligenceIndex | 31 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | reasoning | 84.6345 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | reasoning | 81.23075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | reasoning | 89.19225 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | reasoning | 91.2115 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | reasoning | 92.15375 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | reasoning | 90.65375 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | reasoning | 84.76925 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | reasoning | 88.69225 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | reasoning | 91.6345 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | reasoning | 86.80775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | reasoning | 85.64425 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | reasoning | 91.65375 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | reasoning | 90.6345 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | reasoning | 92.65375 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | reasoning | 81.76925 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | reasoning | 88.65375 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | reasoning | 92.6345 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | reasoning | 91.6345 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | lcr | 0.496666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | lcr | 0.806666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### visual-ui

Budget: **hard**, input 5 / output 25 USD per million. Deciding source: liveBench.
Quality leader before hard-budget exclusions: claude-sonnet-5.5 / max / default. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket (profile fallback).** Measured benchmark-workload usage (`aa-intelligence-index-canonical-v1`) is unavailable or not comparable for at least one qualified configuration (usage_workload_mismatch), so the entire profile is ranked on the fixed basket. Measured and fixed costs are never mixed, and no qualified configuration is dropped to improve coverage.
Qualified configurations without valid measured usage: gpt-6.1-sol / xhigh / default (usage_workload_mismatch); gpt-6.1-sol / max / default (usage_workload_mismatch).
Authorized deciding routes, strongest first: **LiveBench Coding > AA Intelligence Index**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: liveBench.coding.
Incumbent selection basis (applied/current after run): liveBench.coding.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **300 AIC**; incumbent **300 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: claude-sonnet-5.5 / max / default (91.366). Candidate gap: **10.625 / 12** absolute coding score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **300 AIC**; incumbent **300 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **80.741**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | liveBench.coding | 12 | claude-sonnet-5.5 / max / default | 91.366 | 12 | 79.366 | False | n/a |
| visual-understanding | artificialAnalysisComponents.mmmuPro | 2 | gpt-6.1-sol / max / default | 0.859537572254 | 0.03 | 0.829537572254 | False | n/a |

primary routes: LiveBench Coding > AA Intelligence Index.
LiveBench Coding: Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.

visual-understanding routes: MMMU Pro (AA).
MMMU Pro (AA): Visual understanding, not UI implementation fidelity.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: 76.393 (outside_quality_band); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / max / default | False | primary: 89.253 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | False | primary: 88.8705 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: 91.366 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | True | primary: 80.741 (passed); visual-understanding: 0.850867052023 (passed) |
| gpt-5.6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / max / default | False | primary: 77.863 (outside_quality_band); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / max / default | False | primary: 81.828 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.551445086705 (outside_quality_band) |
| claude-opus-5 / max / default | False | primary: 81.4455 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: 81.767 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: 80.68 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / max / default | False | primary: 78.2455 (outside_quality_band); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / max / default | False | primary: 83.941 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / default | False | primary: 82.915 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.849132947977 (passed) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / xhigh / default | False | primary: 89.253 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: 78.95 (outside_quality_band); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | True | primary: 80.3585 (passed); visual-understanding: 0.859537572254 (passed) |
| gpt-6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale, vision_unknown | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale, vision_unknown | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale, vision_unknown | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale, vision_unknown | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / none / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / none / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | coding | 77.863 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | coding | 76.393 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | coding | 81.828 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | coding | 81.4455 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | coding | 89.253 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | coding | 89.253 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | coding | 80.68 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | coding | 91.366 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | coding | 88.8705 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | coding | 82.915 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | coding | 83.941 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | coding | 78.2455 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | coding | 80.3585 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | coding | 78.95 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | coding | 81.767 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | coding | 80.3585 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | coding | 80.741 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-high | high | intelligenceIndex | 29.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-low | low | intelligenceIndex | 18.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5 | max | intelligenceIndex | 36.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-medium | medium | intelligenceIndex | 24.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-xhigh | xhigh | intelligenceIndex | 34.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | intelligenceIndex | 23.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | intelligenceIndex | 32.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 54.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | intelligenceIndex | 43.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra | max | intelligenceIndex | 56.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | intelligenceIndex | 51.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-xhigh | xhigh | intelligenceIndex | 55.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-high | high | intelligenceIndex | 21.4 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-low | low | intelligenceIndex | 9.7 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna | max | intelligenceIndex | 27.9 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-medium | medium | intelligenceIndex | 18.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-xhigh | xhigh | intelligenceIndex | 23.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-sol | artificialAnalysis | gpt-6-sol | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-high | high | intelligenceIndex | 50.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-low | low | intelligenceIndex | 34.8 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol | max | intelligenceIndex | 54.6 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-medium | medium | intelligenceIndex | 46.3 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-xhigh | xhigh | intelligenceIndex | 52.5 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.6 | artificialAnalysis | grok-4-6-xhigh | xhigh | intelligenceIndex | 31 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | mmmuPro | 0.551445086705 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | mmmuPro | 0.864161849711 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | mmmuPro | 0.868786127168 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | mmmuPro | 0.850867052023 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | mmmuPro | 0.862427745665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | mmmuPro | 0.849132947977 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | mmmuPro | 0.859537572254 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | mmmuPro | 0.850867052023 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### mechanical

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: n/a.
Quality leader before hard-budget exclusions: n/a. Family fallback (informational, not a winner): claude-haiku-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket.** No qualified configuration was ranked, so no measured comparison applies.
Authorized deciding routes, strongest first: **AutomationBench-AA > EnterpriseOps-Gym-AA**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **retained_insufficient_role_evidence**. Deciding metric: n/a.
Incumbent selection basis (applied/current after run): artificialAnalysisComponents.automationBench.
AutomationBench-AA (guardrail-adjusted objective fraction): Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA (strict pass@1 fraction): AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **n/a AIC**; incumbent **300 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.

**Role qualification:** retained_insufficient_role_evidence. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | n/a | 0 | n/a | n/a | n/a | n/a | n/a | n/a |
| instruction-following | liveBench.instructionFollowing | 7 | gpt-6.1-sol / max / default | 74.15425 | 3 | 71.15425 | False | n/a |

primary routes: AutomationBench-AA > EnterpriseOps-Gym-AA.
AutomationBench-AA: Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA: AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.

instruction-following routes: IFBench (AA) > LiveBench Instruction Following.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: 66.4665 (outside_quality_band) |
| gpt-6-sol / medium / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: 70.5165 (outside_quality_band) |
| mai-code-1.1-flash / low / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: 56.78775 (outside_quality_band) |
| claude-haiku-5.5 / low / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: 71.325 (passed) |
| claude-haiku-5.5 / max / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: 54.65825 (outside_quality_band) |
| gpt-6-sol / none / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: 68.57475 (outside_quality_band) |
| mai-code-1.1-flash / high / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: 63.8585 (outside_quality_band) |
| claude-sonnet-5 / high / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: 60.121 (outside_quality_band) |
| gpt-6.1-sol / high / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: 55.93325 (outside_quality_band) |
| gpt-6-sol / low / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: 74.15425 (passed) |
| gpt-6-luna / high / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (insufficient_comparison_evidence); instruction-following: n/a (exact_configuration_evidence_missing) |

**Current configuration retained, not certified:** no role-qualified recommendation is available. No requirements are relaxed to fill the profile, and force cannot bypass missing coverage or an empty intersection.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / none / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / high / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / max / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / medium / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / none / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / xhigh / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | automationBench | 0.666122174975 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | automationBench | 0.684917480669 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | automationBench | 0.645949885056 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | automationBench | 0.671777802022 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | automationBench | 0.644952373218 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | automationBench | 0.64868448824 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | automationBench | 0.665737214136 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | instructionFollowing | 54.65825 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | instructionFollowing | 66.4665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | instructionFollowing | 72.0335 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | instructionFollowing | 63.7665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | instructionFollowing | 65.73775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | instructionFollowing | 67.04975 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | instructionFollowing | 63.22075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | instructionFollowing | 63.8585 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | instructionFollowing | 56.78775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | instructionFollowing | 70.5165 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | instructionFollowing | 60.121 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | instructionFollowing | 71.846 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | instructionFollowing | 64.6165 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | instructionFollowing | 75.579 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | instructionFollowing | 55.93325 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | instructionFollowing | 68.57475 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | instructionFollowing | 74.15425 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | instructionFollowing | 71.325 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### triage

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / max / default. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket (profile fallback).** Measured benchmark-workload usage (`aa-intelligence-index-canonical-v1`) is unavailable or not comparable for at least one qualified configuration (usage_workload_mismatch), so the entire profile is ranked on the fixed basket. Measured and fixed costs are never mixed, and no qualified configuration is dropped to improve coverage.
Qualified configurations without valid measured usage: gpt-6.1-sol / xhigh / default (usage_workload_mismatch); gpt-6.1-sol / max / default (usage_workload_mismatch).
Authorized deciding routes, strongest first: **AA Intelligence Index > LiveBench Reasoning**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **budget_constrained_choice**. Deciding metric: artificialAnalysis.intelligenceIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.intelligenceIndex.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning (percentage points): Reasoning proxy; does not establish interactive triage skill.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **300 AIC**; incumbent **300 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.
Eligible quality reference: gpt-6.1-sol / max / default (54.6). Candidate gap: **2.1 / 3** absolute intelligenceIndex score points.
Lowest reference cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Reference usage: candidate **300 AIC**; incumbent **300 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **52.5**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysis.intelligenceIndex | 5 | gpt-6.1-sol / max / default | 54.6 | 3 | 51.6 | False | n/a |
| instruction-following | liveBench.instructionFollowing | 7 | gpt-6.1-sol / max / default | 74.15425 | 3 | 71.15425 | False | n/a |

primary routes: AA Intelligence Index > LiveBench Reasoning.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning: Reasoning proxy; does not establish interactive triage skill.

instruction-following routes: IFBench (AA) > LiveBench Instruction Following.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: 34.6 (outside_quality_band); instruction-following: 66.4665 (outside_quality_band) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: 29.9 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: 70.5165 (outside_quality_band) |
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: 56.78775 (outside_quality_band) |
| claude-haiku-5.5 / low / default | False | primary: 18.6 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | True | primary: 52.5 (passed); instruction-following: 71.325 (passed) |
| claude-haiku-5.5 / max / default | False | primary: 36.5 (outside_quality_band); instruction-following: 54.65825 (outside_quality_band) |
| gpt-6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: 44.2 (outside_quality_band); instruction-following: 68.57475 (outside_quality_band) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: 9.7 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / default | False | primary: 34.8 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / default | False | primary: 18.5 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: 63.8585 (outside_quality_band) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: 46.3 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / default | False | primary: 24.6 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: 23.5 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / default | False | primary: 23.8 (outside_quality_band); instruction-following: 60.121 (outside_quality_band) |
| gpt-6.1-sol / high / default | False | primary: 50.3 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: 27.9 (outside_quality_band); instruction-following: 55.93325 (outside_quality_band) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | True | primary: 54.6 (passed); instruction-following: 74.15425 (passed) |
| gpt-6-luna / high / default | False | primary: 21.4 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-opus-5.5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-16T08:28:09.4939090Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / none / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-sol / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / high / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / max / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / medium / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / none / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-5.6-terra / xhigh / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-16T08:28:09.4939090Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-16T08:28:09.4939090Z | 2026-11-12T08:21:43.184Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-high | high | intelligenceIndex | 29.9 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-low | low | intelligenceIndex | 18.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5 | max | intelligenceIndex | 36.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-medium | medium | intelligenceIndex | 24.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysis | claude-haiku-5-5-xhigh | xhigh | intelligenceIndex | 34.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysis | claude-opus-5 | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysis | gpt-5-6-luna | max | intelligenceIndex | 23.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysis | gpt-5-6-terra | max | intelligenceIndex | 32.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-high | high | intelligenceIndex | 54.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-low | low | intelligenceIndex | 43.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra | max | intelligenceIndex | 56.9 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-medium | medium | intelligenceIndex | 51.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysis | gpt-6-astra-xhigh | xhigh | intelligenceIndex | 55.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-high | high | intelligenceIndex | 21.4 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-low | low | intelligenceIndex | 9.7 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna | max | intelligenceIndex | 27.9 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-medium | medium | intelligenceIndex | 18.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysis | gpt-6-luna-xhigh | xhigh | intelligenceIndex | 23.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysis | gpt-6-sol | max | intelligenceIndex | 44.2 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-high | high | intelligenceIndex | 50.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-low | low | intelligenceIndex | 34.8 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol | max | intelligenceIndex | 54.6 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-medium | medium | intelligenceIndex | 46.3 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysis | gpt-6-1-sol-xhigh | xhigh | intelligenceIndex | 52.5 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysis | grok-4-6-xhigh | xhigh | intelligenceIndex | 31 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | reasoning | 84.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | reasoning | 81.23075 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | reasoning | 89.19225 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | reasoning | 91.2115 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | reasoning | 92.15375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | reasoning | 90.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | reasoning | 84.76925 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | reasoning | 88.69225 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | reasoning | 91.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | reasoning | 86.80775 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | reasoning | 85.64425 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | reasoning | 91.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | reasoning | 90.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | reasoning | 92.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | reasoning | 81.76925 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | reasoning | 88.65375 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | reasoning | 92.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | reasoning | 91.6345 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | instructionFollowing | 54.65825 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | instructionFollowing | 66.4665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | instructionFollowing | 72.0335 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | instructionFollowing | 63.7665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | instructionFollowing | 65.73775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | instructionFollowing | 67.04975 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | instructionFollowing | 63.22075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | instructionFollowing | 63.8585 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | instructionFollowing | 56.78775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | instructionFollowing | 70.5165 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | instructionFollowing | 60.121 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | instructionFollowing | 71.846 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | instructionFollowing | 64.6165 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | instructionFollowing | 75.579 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | instructionFollowing | 55.93325 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | instructionFollowing | 68.57475 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | instructionFollowing | 74.15425 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | instructionFollowing | 71.325 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>
