# Monthly task profile review (2026-11-10)

Availability: **True** (local model-discovery snapshot; status=valid; observed=2026-11-04T12:31:37.443Z; validity=7 days; not live-verified by this review; recorded runtime reconciled); manual confirmation override: **True**.

## Model discovery and onboarding

Recorded authenticated runtime metadata usable: **True**; status **ok**; runtime 1.0.105. This review does not authenticate to a user's account.
Local discovery snapshot: **valid**; observed **2026-11-04T12:31:37.443Z**; validity **7 days**. Availability was verified locally, not live-verified by this review.
Local model-discovery snapshot is valid (validity: 7 days).
Runtime and help catalogs are reconciled, not assumed exhaustive. Absence is not an explicit denial; runtime-disabled, ambiguous, denylisted and virtual routing models cannot enter selection. Public pricing/benchmark rows alone do not prove Copilot availability.
Help-only entries are CLI-catalog evidence, not proof of per-account entitlement. The source columns distinguish these from recorded authenticated runtime entries.
Official retirement evidence: **ok**; retrieved **2026-11-04T12:31:38.4483076Z**; source https://docs.github.com/en/copilot/reference/ai-models/supported-models. Effective, unconditional retirements override stale help entries. Scheduled dates are evaluated in UTC; documented exceptions remain conditional, not blanket denials. Suggested alternatives are migration guidance, not qualified winners.
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
| gemini-3.8-flash | False | True | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates |
| gemini-4-argon | False | True | not_listed | n/a | partial | enabled_runtime_metadata_missing; existing facts retain their original verification dates; benchmark_aliases_missing; structured agent evidence is resolved separately |
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
| Claude Fable 5.2 | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| Claude Sonnet 4 | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| GPT-5.4 nano | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| GPT-6.1 Terra | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |
| Grok 4.7 | False | False | n/a | n/a | discovered_only | unmapped_public_pricing_identity; runtime identity required |

Catalog changes: 0. Unmapped benchmark variants: 585; complete discovery details are retained in `data/model-onboarding-snapshot.json`. Such variants may be unrelated to Copilot and are not automatically admitted.
</details>


## Profile decisions

| Profile | Strategy | Current configuration | Recommended configuration | Applied/current after run | Outcome | Confidence |
|---|---|---|---|---|---|---|
| orchestrator | value_balanced | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | budget_constrained_choice | reduced |
| quick | value_balanced | claude-sonnet-5.5 / max / default | claude-sonnet-5.5 / max / default | claude-sonnet-5.5 / max / default | value_balanced_choice | reduced |
| default-development | value_balanced | gemini-3.8-flash / none / default | n/a | gemini-3.8-flash / none / default | retained_no_role_qualified_candidate | none |
| agentic-implementation | value_balanced | gpt-6.1-sol / max / default | gpt-6.1-sol / max / default | gpt-6.1-sol / max / default | value_balanced_choice | reduced |
| deep-reasoning | value_balanced | gpt-6.1-sol / max / long_context | gpt-6.1-sol / max / long_context | gpt-6.1-sol / max / long_context | value_balanced_choice | reduced |
| review | value_balanced | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | value_balanced_choice | reduced |
| visual-ui | value_balanced | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | value_balanced_choice | reduced |
| mechanical | value_balanced | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | budget_constrained_choice | reduced |
| triage | value_balanced | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | gpt-6.1-sol / xhigh / default | budget_constrained_choice | reduced |

Normal recommendations require the intersection of each profile's explicit qualification dimensions, not one global model ranking. Price decides only among configurations passing every required band. Every comparison needs at least two distinct eligible models; multiple efforts do not inflate coverage. Empty intersections or insufficient evidence retain a non-retired current configuration without certifying it. Supporting-only scores never blend, rank or veto; overlapping benchmark lineage is not independent corroboration. Unknown publication age, cached evidence, single-source coverage and external harnesses reduce confidence. A context capability is not a benchmark measurement at that context length.
An effectively retired incumbent triggers mandatory recovery without waiting for confirmation or comparable incumbent evidence: a fully qualified winner first, otherwise the existing primary benchmark/value rules, otherwise an exact GitHub-suggested successor. Emergency migrations are not certified role-qualified winners. All hard admissibility and authorized configuration limits remain binding; no safe replacement fails the review instead of publishing a retained retired model.
Value-balanced profiles minimize reference AIC within a source-specific gap of their best eligible score, under fixed hard input/output price ceilings. Bands are policy tolerances, not capability percentages or proof of task success. Token-price ceilings are not total session-spend limits.
Cost basis is decided per profile, once, over its qualified configurations: when every one has valid, fresh, comparable measured input/output token totals on the same pinned benchmark workload, ranking uses those totals repriced as uncached tokens at current GitHub rates (reasoning is already inside output; no effort multiplier). If any qualified configuration lacks such usage, the entire profile uses the fixed reference basket and says why; measured and fixed costs are never mixed, and unqualified configurations cannot disable measured ranking. Measured cost is an external benchmark-workload proxy, not predicted Copilot task spend, latency or cache behavior. It never lowers a quality band or bypasses a safeguard.
Orchestrator workflow metrics allow a 0.03 absolute gap; Mechanical allows 0.01. For normal optimization every other required dimension must also pass, so the intersection may be empty. These are policy tolerances, not statistical significance claims. Missing incumbent evidence reduces confidence, not candidate requirements, and does not alone block a qualified fallback replacement. An established stronger primary or qualification basis remains protected.
Configuration cells show model / effective effort / context; 'none' means the model exposes no effort control. Allowed effort ranges are standing authorization: model and effort changes apply together after confirmation, except mandatory retirement recovery. Force bypasses only the normal confirmation wait, never hard budgets, allowed ranges, availability, capabilities or evidence requirements.

## Pricing refresh

- Status: **partial**. Source: https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing
- Last successful page fetch: 2026-11-10T13:22:08.0729472Z. Per-model verification ages govern eligibility.
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
- Warning: Unmapped GitHub pricing model: GPT-5.4 nano
- Warning: Unmapped GitHub pricing model: GPT-6.1 Terra
- Warning: Unmapped GitHub pricing model: Grok 4.7

## Benchmark sources

| Source | Status | Results published | Suite label | Artifact updated | Retrieved | Raw observation identity |
|---|---|---|---|---|---|---|
| artificialAnalysis | ok | n/a | n/a | n/a | 2026-11-10T13:22:00.6840097Z | 21fcd159165d37685cd9f8318f1646c8c43abfff0a600e755db609e9f3222c67&#124; |
| artificialAnalysisCodingAgents | ok | n/a | n/a | n/a | 2026-11-10T13:22:02.2974591Z | c6b7e78aa1e0594e821c6c3093d75e59d052134292300f59c135b21ff66b7fe2 |
| artificialAnalysisComponents | ok | n/a | n/a | n/a | 2026-11-10T13:22:04.2219230Z | ec794568f6d6899d9a22b4227f86f27420e683d91c1a67d9eb0babf4f272fd4a |
| liveBench | ok | n/a | 2026-06-25 | 2026-11-10T01:03:35.0000000Z | 2026-11-10T13:22:07.2633370Z | a8d2183fc195b3177c396c0fbe6ac80040e2a4090717d391c9a2c6ec3243207d |

Confirmation uses metric-scoped observations, not the raw page fingerprint. Suite labels, artifact updates, row evaluation ages and retrieval times are distinct: an artifact update does not make every row newly evaluated. Unknown dates or methodology versions are not fabricated. AA public components remain separate from API aggregates; public pricing is never imported. Data attribution: https://artificialanalysis.ai and https://livebench.ai (LiveBench 1.x data; not LiveBench 2.0).


## Coverage and exclusions

578 distinct exclusions, advisory warnings and evidence gaps. Repeated findings are listed once with every affected profile; full eligibility and scores remain available below.

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
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 047ef12b001416f72e30e1ad633988e2: model_identity_unresolved_or_ambiguous 'Muse Wonder Full (Max)' | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 06c2cfad6e3aba9000f2dd5e429d4407: model_or_provider_unresolved | agentic-implementation |
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 1566a99a00883bdb3cbdb4894e95ca1f: model_identity_unresolved_or_ambiguous 'Muse Ember (Max)' | agentic-implementation |
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
| evidence gap | n/a / n/a / n/a | artificialAnalysisCodingAgents: 9f9935acf5ec3f55d1752fd01ff30de9: model_identity_unresolved_or_ambiguous 'Muse Ember (Xhigh)' | agentic-implementation |
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
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-high: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-low: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-medium: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1-xhigh: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-1: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-2-high: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-2-low: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-2-medium: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-2-xhigh: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | artificialAnalysisComponents: claude-fable-5-2: identity_ambiguous_or_effort_invalid | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
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
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | claude-haiku-5.5: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
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
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-opus-5-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-opus-5: artificialAnalysisComponents.ifbench 'claude-opus-5' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
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
| evidence gap | n/a / n/a / n/a | claude-sonnet-4.6: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-4-6-adaptive' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
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
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.enterpriseOpsGym 'claude-sonnet-5-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.ifbench 'claude-sonnet-5' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-high' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-low' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-medium' score_missing_or_invalid | visual-ui |
| evidence gap | n/a / n/a / n/a | claude-sonnet-5: artificialAnalysisComponents.mmmuPro 'claude-sonnet-5-xhigh' score_missing_or_invalid | visual-ui |
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
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-luna-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-high' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | gpt-5.6-luna: artificialAnalysisComponents.ifbench 'gpt-5-6-luna' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
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
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-sol: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-sol-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
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
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-high' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: artificialAnalysisComponents.enterpriseOpsGym 'gpt-5-6-terra-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-5.6-terra: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6-astra: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
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
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'none' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6-sol: liveBench effort 'xhigh' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
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
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | gpt-6.1-sol: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis effort 'low' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis effort 'medium' alias_not_configured | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysis.intelligenceIndex 'grok-4-5' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisComponents effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisComponents effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: artificialAnalysisComponents.ifbench 'grok-4-5' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'high' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'low' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.5: liveBench effort 'medium' alias_not_configured | agentic-implementation, deep-reasoning, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysis.intelligenceIndex 'grok-4-6-low' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysis.intelligenceIndex 'grok-4-6-medium' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysis.intelligenceIndex 'grok-4-6' score_missing_or_invalid | deep-reasoning, default-development, quick, review, triage, visual-ui |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'high' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'low' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'medium' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisCodingAgents effort 'xhigh' structured_variant_not_matched | agentic-implementation |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.enterpriseOpsGym 'grok-4-6-low' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.enterpriseOpsGym 'grok-4-6-medium' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.enterpriseOpsGym 'grok-4-6-xhigh' score_missing_or_invalid | agentic-implementation, mechanical, orchestrator |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6-low' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6-medium' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6-xhigh' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
| evidence gap | n/a / n/a / n/a | grok-4.6: artificialAnalysisComponents.ifbench 'grok-4-6' score_missing_or_invalid | default-development, mechanical, orchestrator, quick, triage |
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
| exclusion | grok-4.5 / high / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | grok-4.5 / high / default | vision_unknown | visual-ui |
| exclusion | grok-4.5 / high / long_context | capabilities_stale | deep-reasoning |
| exclusion | grok-4.5 / low / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | grok-4.5 / low / default | vision_unknown | visual-ui |
| exclusion | grok-4.5 / low / long_context | capabilities_stale | deep-reasoning |
| exclusion | grok-4.5 / medium / default | capabilities_stale | agentic-implementation, default-development, mechanical, orchestrator, quick, review, triage, visual-ui |
| exclusion | grok-4.5 / medium / default | vision_unknown | visual-ui |
| exclusion | grok-4.5 / medium / long_context | capabilities_stale | deep-reasoning |
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

Budget: **hard**, input 3 / output 15 USD per million. Deciding source: artificialAnalysisComponents.
Quality leader before hard-budget exclusions: gpt-6-astra / max / default. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
**Cost basis: measured benchmark workload** (`aa-intelligence-index-canonical-v1`). Every qualified configuration has valid, fresh, comparable measured input/output token totals on the same workload, repriced as uncached tokens at current GitHub rates; output already includes reasoning. This is an external benchmark-workload cost proxy, not predicted Copilot task spend, latency or cache behavior. Task-specific quality bands are separate from this whole-suite cost workload.
Authorized deciding routes, strongest first: **AutomationBench-AA > EnterpriseOps-Gym-AA**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **budget_constrained_choice**. Deciding metric: artificialAnalysisComponents.automationBench.
Incumbent selection basis (applied/current after run): artificialAnalysisComponents.automationBench.
AutomationBench-AA (guardrail-adjusted objective fraction): Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA (strict pass@1 fraction): AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Benchmark-workload usage: candidate **355872.8918 AIC**; incumbent **355872.8918 AIC**.
Benchmark-workload AIC reprices each configuration's own measured input/output tokens at current GitHub rates, uncached, with reasoning already inside output. It compares configurations on one external benchmark workload; it does not predict Copilot task cost or latency.
Eligible quality reference: gpt-6.1-sol / xhigh / default (0.665737214136). Candidate gap: **0 / 0.03** absolute automationBench score points.
Lowest measured benchmark-workload cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Benchmark-workload usage: candidate **355872.8918 AIC**; incumbent **355872.8918 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **0.665737214136**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysisComponents.automationBench | 7 | gpt-6.1-sol / xhigh / default | 0.665737214136 | 0.03 | 0.635737214136 | False | n/a |
| long-context | artificialAnalysisComponents.lcr | 8 | gpt-6.1-sol / low / default | 0.84 | 0.05 | 0.79 | False | n/a |
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
| claude-haiku-5.5 / xhigh / default | False | primary: 0.359538897734 (outside_quality_band); long-context: 0.783333333333 (outside_quality_band); instruction-following: 66.4665 (outside_quality_band) |
| gpt-6-sol / medium / default | False | primary: 0.579722351077 (outside_quality_band); long-context: 0.823333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: 0.278721506064 (outside_quality_band); long-context: 0.736666666667 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: 0.337268531177 (outside_quality_band); long-context: 0.773333333333 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: 0.425977673743 (outside_quality_band); long-context: 0.816666666667 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 70.5165 (outside_quality_band) |
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: 56.78775 (outside_quality_band) |
| claude-haiku-5.5 / low / default | False | primary: 0.229108121811 (outside_quality_band); long-context: 0.72 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: 0.355879429306 (outside_quality_band); long-context: 0.803333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / none / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | True | primary: 0.665737214136 (passed); long-context: 0.796666666667 (passed); instruction-following: 71.325 (passed) |
| claude-haiku-5.5 / max / default | False | primary: 0.354110151328 (outside_quality_band); long-context: 0.826666666667 (passed); instruction-following: 54.65825 (outside_quality_band) |
| gpt-6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.496666666667 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: 0.616942351159 (outside_quality_band); long-context: 0.813333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: 0.616336929596 (outside_quality_band); long-context: 0.836666666667 (passed); instruction-following: 68.57475 (outside_quality_band) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: 0.120491872727 (outside_quality_band); long-context: 0.74 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / default | False | primary: 0.525708896475 (outside_quality_band); long-context: 0.84 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / default | False | primary: 0.116921622583 (outside_quality_band); long-context: 0.7 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: 0.335360403842 (outside_quality_band); long-context: 0.74 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: 0.19901936569 (outside_quality_band); long-context: 0.673333333333 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / default | False | primary: 0.404613687914 (outside_quality_band); long-context: 0.783333333333 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: 0.344762688906 (outside_quality_band); long-context: 0.766666666667 (outside_quality_band); instruction-following: 63.8585 (outside_quality_band) |
| claude-sonnet-5 / high / default | False | primary: 0.320966388144 (outside_quality_band); long-context: 0.766666666667 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: 0.625735097044 (outside_quality_band); long-context: 0.833333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: 0.36512675717 (outside_quality_band); long-context: 0.82 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / max / default | False | primary: 0.596499580253 (outside_quality_band); long-context: 0.83 (passed); instruction-following: 64.6165 (outside_quality_band) |
| claude-haiku-5.5 / medium / default | False | primary: 0.285896148143 (outside_quality_band); long-context: 0.773333333333 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: 0.478006867676 (outside_quality_band); long-context: 0.8 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: 0.230745388031 (outside_quality_band); long-context: 0.75 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / default | False | primary: 0.502086176376 (outside_quality_band); long-context: 0.836666666667 (passed); instruction-following: 60.121 (outside_quality_band) |
| gpt-6.1-sol / high / default | False | primary: 0.644952373218 (passed); long-context: 0.823333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: 0.601258409113 (outside_quality_band); long-context: 0.836666666667 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / high / default | False | primary: 0.420203829518 (outside_quality_band); long-context: 0.776666666667 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: 0.531681403448 (outside_quality_band); long-context: 0.833333333333 (passed); instruction-following: 55.93325 (outside_quality_band) |
| gpt-6-sol / low / default | False | primary: 0.538899927847 (outside_quality_band); long-context: 0.793333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | True | primary: 0.64868448824 (passed); long-context: 0.83 (passed); instruction-following: 74.15425 (passed) |
| gpt-6-luna / high / default | False | primary: 0.478244913992 (outside_quality_band); long-context: 0.793333333333 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / xhigh / default | False | primary: 0.47136313406 (outside_quality_band); long-context: 0.79 (passed); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / low / default | False | primary: 0.29106376138 (outside_quality_band); long-context: 0.713333333333 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / none / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / none / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| grok-4.5 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | automationBench | 0.337268531177 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-low | low | automationBench | 0.229108121811 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5 | max | automationBench | 0.354110151328 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-medium | medium | automationBench | 0.285896148143 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-xhigh | xhigh | automationBench | 0.359538897734 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | automationBench | 0.455934369153 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | automationBench | 0.535640105154 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-low | low | automationBench | 0.51790662987 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | automationBench | 0.565735557649 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | automationBench | 0.543392543199 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | automationBench | 0.532191921095 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | automationBench | 0.200980736645 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | automationBench | 0.320966388144 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-low | low | automationBench | 0.19901936569 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | automationBench | 0.36512675717 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-medium | medium | automationBench | 0.278721506064 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | automationBench | 0.344762688906 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | automationBench | 0.355879429306 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-low | low | automationBench | 0.116921622583 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | automationBench | 0.502086176376 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | automationBench | 0.230745388031 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | automationBench | 0.425977673743 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | automationBench | 0.553122035739 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | automationBench | 0.409856701134 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | automationBench | 0.600811499628 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | automationBench | 0.513275115886 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | automationBench | 0.553116726933 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | automationBench | 0.420203829518 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | automationBench | 0.29106376138 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | automationBench | 0.596499580253 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | automationBench | 0.335360403842 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | automationBench | 0.47136313406 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | automationBench | 0.666122174975 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-low | low | automationBench | 0.590967261045 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | automationBench | 0.684917480669 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | automationBench | 0.645949885056 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | automationBench | 0.671777802022 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | automationBench | 0.478244913992 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-low | low | automationBench | 0.120491872727 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna | max | automationBench | 0.531681403448 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-medium | medium | automationBench | 0.404613687914 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | automationBench | 0.478006867676 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | automationBench | 0.601258409113 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-low | low | automationBench | 0.538899927847 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol | max | automationBench | 0.616336929596 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-medium | medium | automationBench | 0.579722351077 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | automationBench | 0.616942351159 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | automationBench | 0.644952373218 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-low | low | automationBench | 0.525708896475 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | automationBench | 0.64868448824 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-medium | medium | automationBench | 0.625735097044 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | automationBench | 0.665737214136 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | automationBench | 0.579348603508 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | automationBench | 0.666784963812 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-low | low | automationBench | 0.534454005903 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-medium | medium | automationBench | 0.631512697537 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-xhigh | xhigh | automationBench | 0.669973683618 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | enterpriseOpsGym | 0.439570277529 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | enterpriseOpsGym | 0.474783646673 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | enterpriseOpsGym | 0.446732318711 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | enterpriseOpsGym | 0.438675022381 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | enterpriseOpsGym | 0.429125634139 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | enterpriseOpsGym | 0.384959713518 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | enterpriseOpsGym | 0.483437779767 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | lcr | 0.496666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | lcr | 0.773333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-low | low | lcr | 0.72 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5 | max | lcr | 0.826666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-medium | medium | lcr | 0.773333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-xhigh | xhigh | lcr | 0.783333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-low | low | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | lcr | 0.82 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-low | low | lcr | 0.673333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | lcr | 0.82 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-medium | medium | lcr | 0.736666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-low | low | lcr | 0.7 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | lcr | 0.75 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | lcr | 0.78 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | lcr | 0.84 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | lcr | 0.713333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | lcr | 0.74 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-low | low | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | lcr | 0.806666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-low | low | lcr | 0.74 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna | max | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-medium | medium | lcr | 0.783333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-low | low | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol | max | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-medium | medium | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-low | low | lcr | 0.84 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-medium | medium | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-low | low | lcr | 0.806666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-medium | medium | lcr | 0.81 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-xhigh | xhigh | lcr | 0.81 | True | False | source benchmark harness, not Copilot CLI | qualification route |
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
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | ifbench | 0.622448979592 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | ifbench | 0.565986394558 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | ifbench | 0.753741496599 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | ifbench | 0.691836734694 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | ifbench | 0.726530612245 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | ifbench | 0.695918367347 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | ifbench | 0.710204081633 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | ifbench | 0.644217687075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | ifbench | 0.712244897959 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | ifbench | 0.621768707483 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | ifbench | 0.662585034014 | True | False | source benchmark harness, not Copilot CLI | qualification route |

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
| LiveBench Instruction Following | claude-sonnet-5.5 / max / default | claude-sonnet-5-5-max-effort | 56.78775 | percentage points | n/a | 2026-11-10T13:22:07.2633370Z | False |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / none / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / high / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / max / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / medium / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / none / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / xhigh / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| grok-4.5 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |

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
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | ifbench | 0.622448979592 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | ifbench | 0.565986394558 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | ifbench | 0.753741496599 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | ifbench | 0.691836734694 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | ifbench | 0.726530612245 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | ifbench | 0.695918367347 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | ifbench | 0.710204081633 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | ifbench | 0.644217687075 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | ifbench | 0.712244897959 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | ifbench | 0.621768707483 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | ifbench | 0.662585034014 | True | False | source benchmark harness, not Copilot CLI | supporting only |
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

Budget: **hard**, input 4 / output 20 USD per million. Deciding source: n/a.
Quality leader before hard-budget exclusions: n/a. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket.** No qualified configuration was ranked, so no measured comparison applies.
Authorized deciding routes, strongest first: **LiveBench Coding > AA Intelligence Index**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **retained_no_role_qualified_candidate**. Deciding metric: n/a.
Incumbent selection basis (applied/current after run): unknown; no historical provenance inferred.
LiveBench Coding (percentage points): Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Reference usage: candidate **n/a AIC**; incumbent **112.5 AIC**.
Reference AIC uses a fixed token basket, not measured consumption. Effort-related changes in token usage, task cost and latency are unknown; equal reference AIC does not establish equal task cost.

**Role qualification:** retained_no_role_qualified_candidate. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | liveBench.coding | 10 | claude-sonnet-5.5 / max / default | 91.366 | 3 | 88.366 | False | n/a |
| instruction-following | liveBench.instructionFollowing | 10 | gpt-6.1-sol / max / default | 74.15425 | 3 | 71.15425 | False | n/a |

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
| claude-sonnet-5.5 / xhigh / default | False | primary: 88.8705 (passed); instruction-following: 70.5165 (outside_quality_band) |
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

**Current configuration retained, not certified:** no role-qualified recommendation is available. No requirements are relaxed to fill the profile, and force cannot bypass missing coverage or an empty intersection.

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / none / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / none / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| grok-4.5 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-max-effort | max | coding | 77.863 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-5.5 | liveBench | claude-haiku-5-5-xhigh-effort | xhigh | coding | 76.393 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-4.8 | liveBench | claude-opus-4-8-max-effort | max | coding | 81.828 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | liveBench | claude-opus-5-max-effort | max | coding | 81.4455 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5.5 | liveBench | claude-opus-5-5-max-effort | max | coding | 89.253 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5.5 | liveBench | claude-opus-5-5-xhigh-effort | xhigh | coding | 89.253 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-4.6 | liveBench | claude-sonnet-4-6-thinking-auto-medium-effort | medium | coding | 79.2715 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | liveBench | claude-sonnet-5-xhigh-effort | xhigh | coding | 80.68 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-max-effort | max | coding | 91.366 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5.5 | liveBench | claude-sonnet-5-5-xhigh-effort | xhigh | coding | 88.8705 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | liveBench | gpt-5.6-luna-max | max | coding | 82.915 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-sol | liveBench | gpt-5.6-sol-max | max | coding | 83.941 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | liveBench | gpt-5.6-terra-max | max | coding | 78.2455 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-astra | liveBench | gpt-6-astra-max | max | coding | 80.3585 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-luna | liveBench | gpt-6-luna-max | max | coding | 78.95 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6-sol | liveBench | gpt-6-sol-max | max | coding | 81.767 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-max | max | coding | 80.3585 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-6.1-sol | liveBench | gpt-6.1-sol-xhigh | xhigh | coding | 80.741 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
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
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | ifbench | 0.622448979592 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | ifbench | 0.565986394558 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | ifbench | 0.753741496599 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | ifbench | 0.691836734694 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | ifbench | 0.726530612245 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | ifbench | 0.695918367347 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | ifbench | 0.710204081633 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | ifbench | 0.644217687075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | ifbench | 0.712244897959 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | ifbench | 0.621768707483 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | ifbench | 0.662585034014 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### agentic-implementation

Budget: **hard**, input 10 / output 50 USD per million. Deciding source: artificialAnalysisCodingAgents.
Quality leader before hard-budget exclusions: gpt-6-astra / max / default. Family fallback (informational, not a winner): gpt-5.6-terra.
Strategy: **value_balanced**.
**Cost basis: measured benchmark workload** (`aa-intelligence-index-canonical-v1`). Every qualified configuration has valid, fresh, comparable measured input/output token totals on the same workload, repriced as uncached tokens at current GitHub rates; output already includes reasoning. This is an external benchmark-workload cost proxy, not predicted Copilot task spend, latency or cache behavior. Task-specific quality bands are separate from this whole-suite cost workload.
Authorized deciding routes, strongest first: **AA Coding Agent Index > LiveBench Agentic Coding**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: artificialAnalysisCodingAgents.codingAgentIndex.
Incumbent selection basis (applied/current after run): artificialAnalysisCodingAgents.codingAgentIndex.
AA Coding Agent Index (fraction): External coding-agent harness, not Copilot CLI.
LiveBench Agentic Coding (percentage points): External agentic coding evaluation, not the local orchestration workflow.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Benchmark-workload usage: candidate **446894.9268 AIC**; incumbent **446894.9268 AIC**.
Benchmark-workload AIC reprices each configuration's own measured input/output tokens at current GitHub rates, uncached, with reasoning already inside output. It compares configurations on one external benchmark workload; it does not predict Copilot task cost or latency.
Eligible quality reference: gpt-6-astra / max / default (0.546635690562). Candidate gap: **0.00535589193005 / 0.03** absolute codingAgentIndex score points.
Lowest measured benchmark-workload cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Benchmark-workload usage: candidate **446894.9268 AIC**; incumbent **446894.9268 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **0.541279798631**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysisCodingAgents.codingAgentIndex | 4 | gpt-6-astra / max / default | 0.546635690562 | 0.03 | 0.516635690562 | False | n/a |

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
| claude-haiku-5.5 / max / default | False | primary: 0.373496050722 (outside_quality_band) |
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
| gpt-6-luna / max / default | False | primary: 0.312156308461 (outside_quality_band) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | True | primary: 0.541279798631 (passed) |
| gpt-6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / max / default | True | primary: 0.546635690562 (passed) |
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
| AutomationBench-AA | gpt-6.1-sol / max / default | gpt-6-1-sol | 0.64868448824 | guardrail-adjusted objective fraction | n/a | 2026-11-10T13:22:04.2219230Z | False |
| EnterpriseOps-Gym-AA | gpt-6.1-sol / max / default | n/a | n/a (missing or invalid) | strict pass@1 fraction | n/a | n/a | n/a |

Separate metrics, not a blended ranking or hidden veto. n/a means no usable, exact-configuration evidence; it is not zero and other efforts are not substituted. Cached evidence cannot authorize a switch; unknown publication age remains unknown.
AutomationBench-AA: Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA: AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / high / default | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / low / default | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / max / default | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / medium / default | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / none / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / none / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / high / default | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / low / default | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / max / default | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / medium / default | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / xhigh / default | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| grok-4.5 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysisCodingAgents | Claude Code - Claude Haiku 5.5 (Max) | max | codingAgentIndex | 0.373496050722 | True | False | Claude Code; variant 2a2fed494e0d1343b14efe96e6bc3669; external agent harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisCodingAgents | Codex - GPT-6 Astra (Max) | max | codingAgentIndex | 0.546635690562 | True | False | Codex; variant 34e0f78892fac8fd39aff6595d04610e; external agent harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisCodingAgents | Codex - GPT-6 Luna (Max) | max | codingAgentIndex | 0.312156308461 | True | False | Codex; variant c54a3c8e7e89d5a784e98211605eaa53; external agent harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisCodingAgents | Codex - GPT-6.1 Sol (Max) | max | codingAgentIndex | 0.541279798631 | True | False | Codex; variant 3897d72a57138fd2e2353367570b4b37; external agent harness, not Copilot CLI | deciding |
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
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | automationBench | 0.337268531177 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-low | low | automationBench | 0.229108121811 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5 | max | automationBench | 0.354110151328 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-medium | medium | automationBench | 0.285896148143 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-xhigh | xhigh | automationBench | 0.359538897734 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | automationBench | 0.455934369153 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | automationBench | 0.535640105154 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-low | low | automationBench | 0.51790662987 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | automationBench | 0.565735557649 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | automationBench | 0.543392543199 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | automationBench | 0.532191921095 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | automationBench | 0.200980736645 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | automationBench | 0.320966388144 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-low | low | automationBench | 0.19901936569 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | automationBench | 0.36512675717 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-medium | medium | automationBench | 0.278721506064 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | automationBench | 0.344762688906 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | automationBench | 0.355879429306 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-low | low | automationBench | 0.116921622583 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | automationBench | 0.502086176376 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | automationBench | 0.230745388031 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | automationBench | 0.425977673743 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | automationBench | 0.553122035739 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | automationBench | 0.409856701134 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | automationBench | 0.600811499628 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | automationBench | 0.513275115886 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | automationBench | 0.553116726933 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | automationBench | 0.420203829518 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | automationBench | 0.29106376138 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | automationBench | 0.596499580253 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | automationBench | 0.335360403842 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | automationBench | 0.47136313406 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | automationBench | 0.666122174975 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-low | low | automationBench | 0.590967261045 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | automationBench | 0.684917480669 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | automationBench | 0.645949885056 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | automationBench | 0.671777802022 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | automationBench | 0.478244913992 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-low | low | automationBench | 0.120491872727 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna | max | automationBench | 0.531681403448 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-medium | medium | automationBench | 0.404613687914 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | automationBench | 0.478006867676 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | automationBench | 0.601258409113 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-low | low | automationBench | 0.538899927847 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol | max | automationBench | 0.616336929596 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-medium | medium | automationBench | 0.579722351077 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | automationBench | 0.616942351159 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | automationBench | 0.644952373218 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-low | low | automationBench | 0.525708896475 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | automationBench | 0.64868448824 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-medium | medium | automationBench | 0.625735097044 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | automationBench | 0.665737214136 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | automationBench | 0.579348603508 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | automationBench | 0.666784963812 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-low | low | automationBench | 0.534454005903 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-medium | medium | automationBench | 0.631512697537 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-xhigh | xhigh | automationBench | 0.669973683618 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | enterpriseOpsGym | 0.439570277529 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | enterpriseOpsGym | 0.474783646673 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | enterpriseOpsGym | 0.446732318711 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | enterpriseOpsGym | 0.438675022381 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | enterpriseOpsGym | 0.429125634139 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | enterpriseOpsGym | 0.384959713518 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | supporting only |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | enterpriseOpsGym | 0.483437779767 | True | False | source benchmark harness, not Copilot CLI | supporting only |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### deep-reasoning

Budget: **hard**, input 20 / output 75 USD per million. Deciding source: artificialAnalysis.
Quality leader before hard-budget exclusions: gpt-6-astra / max / long_context. Family fallback (informational, not a winner): claude-opus-5.5.
Strategy: **value_balanced**.
**Cost basis: measured benchmark workload** (`aa-intelligence-index-canonical-v1`). Every qualified configuration has valid, fresh, comparable measured input/output token totals on the same workload, repriced as uncached tokens at current GitHub rates; output already includes reasoning. This is an external benchmark-workload cost proxy, not predicted Copilot task spend, latency or cache behavior. Task-specific quality bands are separate from this whole-suite cost workload.
Authorized deciding routes, strongest first: **AA Intelligence Index > LiveBench Reasoning**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **value_balanced_choice**. Deciding metric: artificialAnalysis.intelligenceIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.intelligenceIndex.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning (percentage points): Reasoning proxy; does not establish interactive triage skill.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Benchmark-workload usage: candidate **861959.3506 AIC**; incumbent **861959.3506 AIC**.
Benchmark-workload AIC reprices each configuration's own measured input/output tokens at current GitHub rates, uncached, with reasoning already inside output. It compares configurations on one external benchmark workload; it does not predict Copilot task cost or latency.
Eligible quality reference: gpt-6-astra / max / long_context (56.9). Candidate gap: **2.3 / 3** absolute intelligenceIndex score points.
Lowest measured benchmark-workload cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Benchmark-workload usage: candidate **861959.3506 AIC**; incumbent **861959.3506 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **54.6**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysis.intelligenceIndex | 8 | gpt-6-astra / max / long_context | 56.9 | 3 | 53.9 | False | n/a |
| long-context | artificialAnalysisComponents.lcr | 11 | gpt-5.6-sol / max / long_context | 0.84 | 0.05 | 0.79 | False | n/a |

primary routes: AA Intelligence Index > LiveBench Reasoning.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning: Reasoning proxy; does not establish interactive triage skill.

long-context routes: AA-LCR.
AA-LCR: Long-document reasoning, not conversational retention.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| gpt-5.6-terra / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.79 (passed) |
| claude-haiku-5.5 / xhigh / long_context | False | primary: 34.6 (outside_quality_band); long-context: 0.783333333333 (outside_quality_band) |
| claude-sonnet-5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.766666666667 (outside_quality_band) |
| claude-opus-4.8 / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / max / long_context | False | primary: 36.5 (outside_quality_band); long-context: 0.826666666667 (passed) |
| claude-sonnet-5 / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.673333333333 (outside_quality_band) |
| claude-opus-5.5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / max / long_context | True | primary: 56.9 (passed); long-context: 0.806666666667 (passed) |
| gpt-6-astra / xhigh / long_context | True | primary: 55.3 (passed); long-context: 0.8 (passed) |
| gpt-5.6-sol / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.803333333333 (passed) |
| claude-opus-4.8 / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-astra / high / long_context | True | primary: 54.8 (passed); long-context: 0.8 (passed) |
| claude-opus-4.8-fast / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / high / long_context | False | primary: 50.3 (outside_quality_band); long-context: 0.823333333333 (passed) |
| claude-sonnet-5.5 / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.836666666667 (passed) |
| claude-opus-5 / max / long_context | False | primary: 44.2 (outside_quality_band); long-context: 0.793333333333 (passed) |
| gpt-5.6-sol / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.816666666667 (passed) |
| claude-sonnet-5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.766666666667 (outside_quality_band) |
| claude-opus-4.8-fast / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.823333333333 (passed) |
| gpt-5.6-sol / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.823333333333 (passed) |
| gpt-5.6-luna / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.816666666667 (passed) |
| gpt-6-luna / max / long_context | False | primary: 27.9 (outside_quality_band); long-context: 0.833333333333 (passed) |
| claude-sonnet-5.5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.736666666667 (outside_quality_band) |
| gpt-5.6-terra / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.74 (outside_quality_band) |
| gpt-5.6-luna / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.7 (outside_quality_band) |
| gpt-5.6-luna / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.75 (outside_quality_band) |
| gpt-5.6-terra / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.776666666667 (outside_quality_band) |
| gpt-6.1-sol / medium / long_context | False | primary: 46.3 (outside_quality_band); long-context: 0.833333333333 (passed) |
| gpt-6.1-sol / low / long_context | False | primary: 34.8 (outside_quality_band); long-context: 0.84 (passed) |
| gpt-6-astra / low / long_context | False | primary: 43.3 (outside_quality_band); long-context: 0.8 (passed) |
| gpt-6-luna / medium / long_context | False | primary: 18.5 (outside_quality_band); long-context: 0.783333333333 (outside_quality_band) |
| gpt-6.1-sol / max / long_context | True | primary: 54.6 (passed); long-context: 0.83 (passed) |
| claude-haiku-5.5 / low / long_context | False | primary: 18.6 (outside_quality_band); long-context: 0.72 (outside_quality_band) |
| claude-opus-4.8 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / long_context | False | primary: 23.8 (outside_quality_band); long-context: 0.836666666667 (passed) |
| claude-opus-4.8-fast / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / long_context | False | primary: 23.5 (outside_quality_band); long-context: 0.8 (passed) |
| claude-haiku-5.5 / medium / long_context | False | primary: 24.6 (outside_quality_band); long-context: 0.773333333333 (outside_quality_band) |
| claude-opus-5 / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.813333333333 (passed) |
| gpt-5.6-terra / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.713333333333 (outside_quality_band) |
| gpt-5.6-sol / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.803333333333 (passed) |
| claude-sonnet-5 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.82 (passed) |
| gpt-5.6-sol / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.78 (outside_quality_band) |
| claude-opus-5.5 / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.79 (passed) |
| claude-opus-4.8-fast / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / long_context | False | primary: 44.2 (outside_quality_band); long-context: 0.836666666667 (passed) |
| gpt-6-luna / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.776666666667 (outside_quality_band) |
| claude-opus-5 / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.803333333333 (passed) |
| claude-opus-4.8-fast / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / long_context | False | primary: 52.5 (outside_quality_band); long-context: 0.796666666667 (passed) |
| claude-opus-5.5 / high / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / max / long_context | False | primary: 32.3 (outside_quality_band); long-context: 0.83 (passed) |
| claude-haiku-5.5 / high / long_context | False | primary: 29.9 (outside_quality_band); long-context: 0.773333333333 (outside_quality_band) |
| gpt-6-sol / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.793333333333 (passed) |
| gemini-3.8-flash / none / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / low / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / medium / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.82 (passed) |
| gpt-6-astra / medium / long_context | False | primary: 51.6 (outside_quality_band); long-context: 0.796666666667 (passed) |
| gpt-6-luna / low / long_context | False | primary: 9.7 (outside_quality_band); long-context: 0.74 (outside_quality_band) |
| gpt-5.6-sol / max / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.84 (passed) |
| gpt-6-luna / high / long_context | False | primary: 21.4 (outside_quality_band); long-context: 0.793333333333 (passed) |
| gpt-6-sol / xhigh / long_context | False | primary: n/a (exact_configuration_evidence_missing); long-context: 0.813333333333 (passed) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / long_context | False | context_unsupported | n/a | default | 1 / 5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / high / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / low / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / max / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / medium / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / xhigh / long_context | True | n/a | n/a | long_context | 0.5 / 2.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / low / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / medium / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / high / long_context | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / low / long_context | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / max / long_context | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / medium / long_context | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / xhigh / long_context | True | n/a | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / high / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / low / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / max / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / medium / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / xhigh / long_context | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / high / long_context | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / low / long_context | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / max / long_context | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / medium / long_context | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / xhigh / long_context | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-4.6 / high / long_context | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / low / long_context | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / max / long_context | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / long_context | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-5 / high / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / low / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / max / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / medium / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / xhigh / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / high / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / low / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / max / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / medium / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / xhigh / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gemini-3.8-flash / none / long_context | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / long_context | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / long_context | False | capabilities_stale, context_unsupported | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / low / long_context | False | capabilities_stale, context_unsupported | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / medium / long_context | False | capabilities_stale, context_unsupported | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / long_context | False | capabilities_stale, context_unsupported | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.6-luna / high / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / low / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / max / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / medium / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / none / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / xhigh / long_context | True | n/a | n/a | long_context | 0.4 / 1.8 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / high / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / low / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / max / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / medium / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / none / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / xhigh / long_context | True | n/a | n/a | long_context | 8 / 30 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / high / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / low / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / max / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / medium / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / none / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / xhigh / long_context | True | n/a | n/a | long_context | 4 / 18 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / high / long_context | True | n/a | n/a | long_context | 20 / 75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / low / long_context | True | n/a | n/a | long_context | 20 / 75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / max / long_context | True | n/a | n/a | long_context | 20 / 75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / medium / long_context | True | n/a | n/a | long_context | 20 / 75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / xhigh / long_context | True | n/a | n/a | long_context | 20 / 75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / high / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / low / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / max / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / medium / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / none / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / xhigh / long_context | True | n/a | n/a | long_context | 0.2 / 0.75 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / high / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / low / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / max / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / medium / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / none / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / xhigh / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / high / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / low / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / max / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / medium / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / xhigh / long_context | True | n/a | n/a | long_context | 4 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| grok-4.5 / high / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / low / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / medium / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / high / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / low / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / medium / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / xhigh / long_context | False | capabilities_stale | n/a | long_context | 4 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| mai-code-1.1-flash / high / long_context | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / low / long_context | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / medium / long_context | False | context_unsupported | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |

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
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | lcr | 0.773333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-low | low | lcr | 0.72 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5 | max | lcr | 0.826666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-medium | medium | lcr | 0.773333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-xhigh | xhigh | lcr | 0.783333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-low | low | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | lcr | 0.82 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-low | low | lcr | 0.673333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | lcr | 0.82 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-medium | medium | lcr | 0.736666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-low | low | lcr | 0.7 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | lcr | 0.75 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | lcr | 0.78 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | lcr | 0.84 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | lcr | 0.713333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | lcr | 0.74 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-low | low | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | lcr | 0.806666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-low | low | lcr | 0.74 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna | max | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-medium | medium | lcr | 0.783333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-low | low | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol | max | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-medium | medium | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-low | low | lcr | 0.84 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-medium | medium | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-low | low | lcr | 0.806666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-medium | medium | lcr | 0.81 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-xhigh | xhigh | lcr | 0.81 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### review

Budget: **hard**, input 5 / output 30 USD per million. Deciding source: liveBench.
Quality leader before hard-budget exclusions: claude-sonnet-5.5 / max / default. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket (profile fallback).** Measured benchmark-workload usage (`aa-intelligence-index-canonical-v1`) is unavailable or not comparable for at least one qualified configuration (usage_missing), so the entire profile is ranked on the fixed basket. Measured and fixed costs are never mixed, and no qualified configuration is dropped to improve coverage.
Qualified configurations without valid measured usage: gpt-5.6-sol / max / default (usage_missing).
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
| long-context | artificialAnalysisComponents.lcr | 11 | gpt-5.6-sol / max / default | 0.84 | 0.05 | 0.79 | False | n/a |

primary routes: LiveBench Coding > AA Intelligence Index.
LiveBench Coding: Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.

reasoning routes: LiveBench Reasoning.
LiveBench Reasoning: Reasoning proxy; does not establish interactive triage skill.

long-context routes: AA-LCR.
AA-LCR: Long-document reasoning, not conversational retention.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: 76.393 (outside_quality_band); reasoning: 81.23075 (outside_quality_band); long-context: 0.783333333333 (outside_quality_band) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.823333333333 (passed) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.736666666667 (outside_quality_band) |
| claude-haiku-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.773333333333 (outside_quality_band) |
| claude-opus-5.5 / max / default | False | primary: 89.253 (passed); reasoning: 92.15375 (passed); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.79 (passed) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.816666666667 (passed) |
| claude-sonnet-5.5 / xhigh / default | False | primary: 88.8705 (passed); reasoning: 86.80775 (outside_quality_band); long-context: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: 91.366 (passed); reasoning: 91.6345 (passed); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.72 (outside_quality_band) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.803333333333 (passed) |
| gpt-5.6-terra / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.813333333333 (passed) |
| gpt-6.1-sol / xhigh / default | True | primary: 80.741 (passed); reasoning: 91.6345 (passed); long-context: 0.796666666667 (passed) |
| gpt-5.6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.803333333333 (passed) |
| claude-haiku-5.5 / max / default | False | primary: 77.863 (outside_quality_band); reasoning: 84.6345 (outside_quality_band); long-context: 0.826666666667 (passed) |
| gpt-5.6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.78 (outside_quality_band) |
| gpt-6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.823333333333 (passed) |
| claude-opus-4.8 / max / default | False | primary: 81.828 (passed); reasoning: 89.19225 (outside_quality_band); long-context: 0.776666666667 (outside_quality_band) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.496666666667 (outside_quality_band) |
| claude-opus-5 / max / default | True | primary: 81.4455 (passed); reasoning: 91.2115 (passed); long-context: 0.793333333333 (passed) |
| gpt-6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.813333333333 (passed) |
| gpt-5.6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: 81.767 (passed); reasoning: 88.65375 (outside_quality_band); long-context: 0.836666666667 (passed) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.74 (outside_quality_band) |
| gpt-6.1-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.84 (passed) |
| gpt-5.6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.7 (outside_quality_band) |
| claude-opus-4.8 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.74 (outside_quality_band) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.673333333333 (outside_quality_band) |
| gpt-5.6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.816666666667 (passed) |
| gpt-6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.783333333333 (outside_quality_band) |
| claude-opus-5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.803333333333 (passed) |
| claude-sonnet-5 / xhigh / default | False | primary: 80.68 (passed); reasoning: 88.69225 (outside_quality_band); long-context: 0.766666666667 (outside_quality_band) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.766666666667 (outside_quality_band) |
| claude-opus-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.833333333333 (passed) |
| claude-sonnet-5 / max / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.82 (passed) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / max / default | False | primary: 78.2455 (outside_quality_band); reasoning: 90.6345 (passed); long-context: 0.83 (passed) |
| claude-haiku-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.773333333333 (outside_quality_band) |
| gpt-5.6-sol / max / default | True | primary: 83.941 (passed); reasoning: 91.65375 (passed); long-context: 0.84 (passed) |
| gpt-6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.8 (passed) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.75 (outside_quality_band) |
| gpt-5.6-luna / max / default | False | primary: 82.915 (passed); reasoning: 85.64425 (outside_quality_band); long-context: 0.836666666667 (passed) |
| gpt-6.1-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.823333333333 (passed) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.836666666667 (passed) |
| gpt-5.6-terra / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.776666666667 (outside_quality_band) |
| claude-opus-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.82 (passed) |
| claude-opus-5.5 / xhigh / default | False | primary: 89.253 (passed); reasoning: 90.65375 (passed); long-context: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: 78.95 (outside_quality_band); reasoning: 81.76925 (outside_quality_band); long-context: 0.833333333333 (passed) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.793333333333 (passed) |
| gpt-6.1-sol / max / default | True | primary: 80.3585 (passed); reasoning: 92.6345 (passed); long-context: 0.83 (passed) |
| gpt-6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.793333333333 (passed) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.79 (passed) |
| claude-opus-4.8 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / low / default | False | primary: n/a (exact_configuration_evidence_missing); reasoning: n/a (exact_configuration_evidence_missing); long-context: 0.713333333333 (outside_quality_band) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / none / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / none / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| grok-4.5 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |

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
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | lcr | 0.773333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-low | low | lcr | 0.72 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5 | max | lcr | 0.826666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-medium | medium | lcr | 0.773333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-xhigh | xhigh | lcr | 0.783333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-low | low | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | lcr | 0.82 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-low | low | lcr | 0.673333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | lcr | 0.82 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-medium | medium | lcr | 0.736666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | lcr | 0.766666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-low | low | lcr | 0.7 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | lcr | 0.75 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | lcr | 0.816666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | lcr | 0.78 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | lcr | 0.84 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | lcr | 0.776666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | lcr | 0.713333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | lcr | 0.74 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | lcr | 0.79 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-low | low | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | lcr | 0.806666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-low | low | lcr | 0.74 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna | max | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-medium | medium | lcr | 0.783333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | lcr | 0.8 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-low | low | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol | max | lcr | 0.836666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-medium | medium | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | lcr | 0.813333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | lcr | 0.823333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-low | low | lcr | 0.84 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | lcr | 0.83 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-medium | medium | lcr | 0.833333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | lcr | 0.796666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | lcr | 0.793333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | lcr | 0.803333333333 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-low | low | lcr | 0.806666666667 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-medium | medium | lcr | 0.81 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-xhigh | xhigh | lcr | 0.81 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### visual-ui

Budget: **hard**, input 5 / output 25 USD per million. Deciding source: liveBench.
Quality leader before hard-budget exclusions: claude-sonnet-5.5 / max / default. Family fallback (informational, not a winner): claude-sonnet-5.5.
Strategy: **value_balanced**.
**Cost basis: fixed reference basket (profile fallback).** Measured benchmark-workload usage (`aa-intelligence-index-canonical-v1`) is unavailable or not comparable for at least one qualified configuration (usage_missing), so the entire profile is ranked on the fixed basket. Measured and fixed costs are never mixed, and no qualified configuration is dropped to improve coverage.
Qualified configurations without valid measured usage: gpt-5.6-sol / max / default (usage_missing).
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
| visual-understanding | artificialAnalysisComponents.mmmuPro | 9 | gpt-6.1-sol / max / default | 0.859537572254 | 0.03 | 0.829537572254 | False | n/a |

primary routes: LiveBench Coding > AA Intelligence Index.
LiveBench Coding: Coding proxy, not direct review or UI implementation evidence.
AA Intelligence Index: General reasoning proxy; overlaps component benchmarks, not independent corroboration.

visual-understanding routes: MMMU Pro (AA).
MMMU Pro (AA): Visual understanding, not UI implementation fidelity.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: 76.393 (outside_quality_band); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.804046242775 (outside_quality_band) |
| claude-sonnet-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / max / default | False | primary: 89.253 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.824277456647 (outside_quality_band) |
| gpt-5.6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.785549132948 (outside_quality_band) |
| claude-sonnet-5.5 / xhigh / default | False | primary: 88.8705 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: 91.366 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.775722543353 (outside_quality_band) |
| gpt-5.6-terra / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.798265895954 (outside_quality_band) |
| gpt-6.1-sol / xhigh / default | True | primary: 80.741 (passed); visual-understanding: 0.850867052023 (passed) |
| gpt-5.6-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.81387283237 (outside_quality_band) |
| claude-haiku-5.5 / max / default | False | primary: 77.863 (outside_quality_band); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.809826589595 (outside_quality_band) |
| gpt-6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.826589595376 (outside_quality_band) |
| claude-opus-4.8 / max / default | False | primary: 81.828 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.551445086705 (outside_quality_band) |
| claude-opus-5 / max / default | True | primary: 81.4455 (passed); visual-understanding: 0.847398843931 (passed) |
| gpt-6-sol / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.825433526012 (outside_quality_band) |
| gpt-5.6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-4.8 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: 81.767 (passed); visual-understanding: 0.829479768786 (outside_quality_band) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.759537572254 (outside_quality_band) |
| gpt-6.1-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.831213872832 (passed) |
| gpt-5.6-luna / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.739884393064 (outside_quality_band) |
| claude-opus-4.8 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.767630057803 (outside_quality_band) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.818497109827 (outside_quality_band) |
| gpt-6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.778612716763 (outside_quality_band) |
| claude-opus-5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.839884393064 (passed) |
| claude-sonnet-5 / xhigh / default | False | primary: 80.68 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.839306358382 (passed) |
| claude-sonnet-5 / max / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.772832369942 (outside_quality_band) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / max / default | False | primary: 78.2455 (outside_quality_band); visual-understanding: 0.806936416185 (outside_quality_band) |
| claude-haiku-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-sol / max / default | True | primary: 83.941 (passed); visual-understanding: 0.834104046243 (passed) |
| gpt-6-luna / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.79710982659 (outside_quality_band) |
| gpt-5.6-luna / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.75838150289 (outside_quality_band) |
| gpt-5.6-luna / max / default | False | primary: 82.915 (passed); visual-understanding: 0.785549132948 (outside_quality_band) |
| gpt-6.1-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.849132947977 (passed) |
| gpt-6-sol / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.819653179191 (outside_quality_band) |
| gpt-5.6-terra / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.790751445087 (outside_quality_band) |
| claude-opus-5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.816184971098 (outside_quality_band) |
| claude-opus-5.5 / xhigh / default | False | primary: 89.253 (passed); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: 78.95 (outside_quality_band); visual-understanding: 0.796531791908 (outside_quality_band) |
| gpt-6-sol / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.801734104046 (outside_quality_band) |
| gpt-6.1-sol / max / default | True | primary: 80.3585 (passed); visual-understanding: 0.859537572254 (passed) |
| gpt-6-luna / high / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.775144508671 (outside_quality_band) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| claude-opus-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.794797687861 (outside_quality_band) |
| claude-opus-4.8 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-terra / low / default | False | primary: n/a (exact_configuration_evidence_missing); visual-understanding: 0.761271676301 (outside_quality_band) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / high / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / low / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / max / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / medium / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / xhigh / default | True | n/a | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale, vision_unknown | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale, vision_unknown | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale, vision_unknown | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale, vision_unknown | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / high / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / low / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / max / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / medium / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / none / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / xhigh / default | True | n/a | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / high / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / low / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / max / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / medium / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / none / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / xhigh / default | True | n/a | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| grok-4.5 / high / default | False | capabilities_stale, vision_unknown | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / low / default | False | capabilities_stale, vision_unknown | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / medium / default | False | capabilities_stale, vision_unknown | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |

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
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | mmmuPro | 0.824277456647 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-low | low | mmmuPro | 0.798265895954 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | mmmuPro | 0.847398843931 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | mmmuPro | 0.816184971098 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | mmmuPro | 0.839884393064 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | mmmuPro | 0.732947976879 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | mmmuPro | 0.772832369942 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | mmmuPro | 0.784971098266 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | mmmuPro | 0.775722543353 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-low | low | mmmuPro | 0.739884393064 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | mmmuPro | 0.785549132948 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | mmmuPro | 0.75838150289 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | mmmuPro | 0.785549132948 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | mmmuPro | 0.818497109827 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | mmmuPro | 0.809826589595 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | mmmuPro | 0.834104046243 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | mmmuPro | 0.81387283237 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | mmmuPro | 0.826589595376 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | mmmuPro | 0.790751445087 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | mmmuPro | 0.761271676301 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | mmmuPro | 0.806936416185 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | mmmuPro | 0.767630057803 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | mmmuPro | 0.794797687861 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | mmmuPro | 0.864161849711 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-low | low | mmmuPro | 0.846242774566 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | mmmuPro | 0.868786127168 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | mmmuPro | 0.850867052023 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | mmmuPro | 0.862427745665 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | mmmuPro | 0.775144508671 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-low | low | mmmuPro | 0.759537572254 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna | max | mmmuPro | 0.796531791908 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-medium | medium | mmmuPro | 0.778612716763 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | mmmuPro | 0.79710982659 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | mmmuPro | 0.819653179191 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-low | low | mmmuPro | 0.801734104046 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol | max | mmmuPro | 0.829479768786 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-medium | medium | mmmuPro | 0.804046242775 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | mmmuPro | 0.825433526012 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | mmmuPro | 0.849132947977 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-low | low | mmmuPro | 0.831213872832 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | mmmuPro | 0.859537572254 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-medium | medium | mmmuPro | 0.839306358382 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | mmmuPro | 0.850867052023 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | mmmuPro | 0.804046242775 | True | False | source benchmark harness, not Copilot CLI | qualification route |

Evidence gaps are grouped by affected profile in [Coverage and exclusions](#coverage-and-exclusions).

</details>

### mechanical

Budget: **hard**, input 2 / output 10 USD per million. Deciding source: artificialAnalysisComponents.
Quality leader before hard-budget exclusions: gpt-6-astra / max / default. Family fallback (informational, not a winner): claude-haiku-5.5.
Strategy: **value_balanced**.
**Cost basis: measured benchmark workload** (`aa-intelligence-index-canonical-v1`). Every qualified configuration has valid, fresh, comparable measured input/output token totals on the same workload, repriced as uncached tokens at current GitHub rates; output already includes reasoning. This is an external benchmark-workload cost proxy, not predicted Copilot task spend, latency or cache behavior. Task-specific quality bands are separate from this whole-suite cost workload.
Authorized deciding routes, strongest first: **AutomationBench-AA > EnterpriseOps-Gym-AA**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **budget_constrained_choice**. Deciding metric: artificialAnalysisComponents.automationBench.
Incumbent selection basis (applied/current after run): artificialAnalysisComponents.automationBench.
AutomationBench-AA (guardrail-adjusted objective fraction): Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA (strict pass@1 fraction): AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Benchmark-workload usage: candidate **355872.8918 AIC**; incumbent **355872.8918 AIC**.
Benchmark-workload AIC reprices each configuration's own measured input/output tokens at current GitHub rates, uncached, with reasoning already inside output. It compares configurations on one external benchmark workload; it does not predict Copilot task cost or latency.
Eligible quality reference: gpt-6.1-sol / xhigh / default (0.665737214136). Candidate gap: **0 / 0.01** absolute automationBench score points.
Lowest measured benchmark-workload cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Benchmark-workload usage: candidate **355872.8918 AIC**; incumbent **355872.8918 AIC** (1 AIC = USD 0.01).
Candidate cost change: **0%** (informational, not an incumbent-relative limit). Fixed hard ceilings authorize spending; they never rise automatically. A percentage is n/a when incumbent cost is unknown or a free incumbent would become paid.
Matched incumbent score in this deciding-source observation: **0.665737214136**.

**Role qualification:** qualified. Every required dimension must pass independently; then the cheapest qualified configuration wins. At least 2 distinct eligible models are required per comparison, not per surviving intersection.
References are fixed before intersecting dimensions. Missing evidence is not zero or a pass; no cross-benchmark or cross-effort score substitution. These are proxy-based policy tolerances, not statistical equivalence or direct task-success measurements.

| Required dimension | Selected metric | Comparison models | Reference configuration | Reference score | Allowed gap | Minimum score | Cached | Results published |
|---|---|---|---|---|---|---|---|---|
| primary | artificialAnalysisComponents.automationBench | 6 | gpt-6.1-sol / xhigh / default | 0.665737214136 | 0.01 | 0.655737214136 | False | n/a |
| instruction-following | liveBench.instructionFollowing | 7 | gpt-6.1-sol / max / default | 74.15425 | 3 | 71.15425 | False | n/a |

primary routes: AutomationBench-AA > EnterpriseOps-Gym-AA.
AutomationBench-AA: Workflow/tool-use proxy; clarifying questions prohibited. Not interactive orchestration or conversation-memory evidence.
EnterpriseOps-Gym-AA: AA oracle-tool workflow harness; tools supplied. Not tool-discovery evidence or the original paper's scores.

instruction-following routes: IFBench (AA) > LiveBench Instruction Following.
IFBench (AA): Single-turn instruction following, not multi-turn retention.
LiveBench Instruction Following: Instruction following, not end-to-end workflow completion.

| Budget/capability-eligible configuration | Role qualified | Required evidence checks |
|---|---|---|
| claude-haiku-5.5 / xhigh / default | False | primary: 0.359538897734 (outside_quality_band); instruction-following: 66.4665 (outside_quality_band) |
| gpt-6-sol / medium / default | False | primary: 0.579722351077 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / medium / default | False | primary: 0.278721506064 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / high / default | False | primary: 0.337268531177 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / xhigh / default | False | primary: 0.425977673743 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / xhigh / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: 70.5165 (outside_quality_band) |
| mai-code-1.1-flash / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-3.8-flash / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / max / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: 56.78775 (outside_quality_band) |
| claude-haiku-5.5 / low / default | False | primary: 0.229108121811 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / high / default | False | primary: 0.355879429306 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / xhigh / default | True | primary: 0.665737214136 (passed); instruction-following: 71.325 (passed) |
| claude-haiku-5.5 / max / default | False | primary: 0.354110151328 (outside_quality_band); instruction-following: 54.65825 (outside_quality_band) |
| gpt-6-sol / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-4.5 / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / xhigh / default | False | primary: 0.616942351159 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / max / default | False | primary: 0.616336929596 (outside_quality_band); instruction-following: 68.57475 (outside_quality_band) |
| mai-code-1.1-flash / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / low / default | False | primary: 0.120491872727 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / low / default | False | primary: 0.525708896475 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / low / default | False | primary: 0.116921622583 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / low / default | False | primary: 0.19901936569 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / medium / default | False | primary: 0.404613687914 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / xhigh / default | False | primary: 0.344762688906 (outside_quality_band); instruction-following: 63.8585 (outside_quality_band) |
| claude-sonnet-5 / high / default | False | primary: 0.320966388144 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / medium / default | False | primary: 0.625735097044 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5 / max / default | False | primary: 0.36512675717 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gemini-4-argon / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| mai-code-1.1-flash / medium / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-haiku-5.5 / medium / default | False | primary: 0.285896148143 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / xhigh / default | False | primary: 0.478006867676 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / medium / default | False | primary: 0.230745388031 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-5.6-luna / max / default | False | primary: 0.502086176376 (outside_quality_band); instruction-following: 60.121 (outside_quality_band) |
| gpt-6.1-sol / high / default | False | primary: 0.644952373218 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-sol / high / default | False | primary: 0.601258409113 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / high / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / max / default | False | primary: 0.531681403448 (outside_quality_band); instruction-following: 55.93325 (outside_quality_band) |
| gpt-6-sol / low / default | False | primary: 0.538899927847 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6.1-sol / max / default | False | primary: 0.64868448824 (outside_quality_band); instruction-following: 74.15425 (passed) |
| gpt-6-luna / high / default | False | primary: 0.478244913992 (outside_quality_band); instruction-following: n/a (exact_configuration_evidence_missing) |
| claude-sonnet-5.5 / low / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |
| gpt-6-luna / none / default | False | primary: n/a (exact_configuration_evidence_missing); instruction-following: n/a (exact_configuration_evidence_missing) |

**Supporting evidence** (informational only; for the recommended configuration, not necessarily the applied configuration):
None: the configured role dimensions are binding qualification requirements.

<details>
<summary>Eligibility and exact benchmark evidence</summary>

| Configuration (model / effort / context) | Budget/capability eligible | Exclusions | Advisory warnings | Price tier | Input / output USD per M | Price verified | Capability as-of |
|---|---|---|---|---|---|---|---|
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / none / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / high / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / max / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / medium / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / none / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / xhigh / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| grok-4.5 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |

| Model | Source | Exact alias / source label | Effort | Metric | Score | Publication age unknown | Cached | Harness | Role |
|---|---|---|---|---|---|---|---|---|---|
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-high | high | automationBench | 0.337268531177 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-low | low | automationBench | 0.229108121811 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5 | max | automationBench | 0.354110151328 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-medium | medium | automationBench | 0.285896148143 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-haiku-5.5 | artificialAnalysisComponents | claude-haiku-5-5-xhigh | xhigh | automationBench | 0.359538897734 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | automationBench | 0.455934369153 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-high | high | automationBench | 0.535640105154 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-low | low | automationBench | 0.51790662987 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | automationBench | 0.565735557649 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-medium | medium | automationBench | 0.543392543199 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5-xhigh | xhigh | automationBench | 0.532191921095 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | automationBench | 0.200980736645 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-high | high | automationBench | 0.320966388144 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-low | low | automationBench | 0.19901936569 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | automationBench | 0.36512675717 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-medium | medium | automationBench | 0.278721506064 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | automationBench | 0.344762688906 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-high | high | automationBench | 0.355879429306 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-low | low | automationBench | 0.116921622583 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | automationBench | 0.502086176376 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-medium | medium | automationBench | 0.230745388031 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna-xhigh | xhigh | automationBench | 0.425977673743 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | automationBench | 0.553122035739 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | automationBench | 0.409856701134 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | automationBench | 0.600811499628 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | automationBench | 0.513275115886 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | automationBench | 0.553116726933 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | automationBench | 0.420203829518 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | automationBench | 0.29106376138 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | automationBench | 0.596499580253 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | automationBench | 0.335360403842 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | automationBench | 0.47136313406 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-high | high | automationBench | 0.666122174975 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-low | low | automationBench | 0.590967261045 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra | max | automationBench | 0.684917480669 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-medium | medium | automationBench | 0.645949885056 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-astra | artificialAnalysisComponents | gpt-6-astra-xhigh | xhigh | automationBench | 0.671777802022 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-high | high | automationBench | 0.478244913992 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-low | low | automationBench | 0.120491872727 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna | max | automationBench | 0.531681403448 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-medium | medium | automationBench | 0.404613687914 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-luna | artificialAnalysisComponents | gpt-6-luna-xhigh | xhigh | automationBench | 0.478006867676 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-high | high | automationBench | 0.601258409113 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-low | low | automationBench | 0.538899927847 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol | max | automationBench | 0.616336929596 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-medium | medium | automationBench | 0.579722351077 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6-sol | artificialAnalysisComponents | gpt-6-sol-xhigh | xhigh | automationBench | 0.616942351159 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-high | high | automationBench | 0.644952373218 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-low | low | automationBench | 0.525708896475 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol | max | automationBench | 0.64868448824 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-medium | medium | automationBench | 0.625735097044 | True | False | source benchmark harness, not Copilot CLI | deciding |
| gpt-6.1-sol | artificialAnalysisComponents | gpt-6-1-sol-xhigh | xhigh | automationBench | 0.665737214136 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | automationBench | 0.579348603508 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | automationBench | 0.666784963812 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-low | low | automationBench | 0.534454005903 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-medium | medium | automationBench | 0.631512697537 | True | False | source benchmark harness, not Copilot CLI | deciding |
| grok-4.6 | artificialAnalysisComponents | grok-4-6-xhigh | xhigh | automationBench | 0.669973683618 | True | False | source benchmark harness, not Copilot CLI | deciding |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | enterpriseOpsGym | 0.439570277529 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-opus-5 | artificialAnalysisComponents | claude-opus-5 | max | enterpriseOpsGym | 0.474783646673 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5 | max | enterpriseOpsGym | 0.446732318711 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-sonnet-5 | artificialAnalysisComponents | claude-sonnet-5-xhigh | xhigh | enterpriseOpsGym | 0.438675022381 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-luna | artificialAnalysisComponents | gpt-5-6-luna | max | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | enterpriseOpsGym | 0.429125634139 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | enterpriseOpsGym | 0.384959713518 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.5 | artificialAnalysisComponents | grok-4-5 | high | enterpriseOpsGym | 0.408236347359 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| grok-4.6 | artificialAnalysisComponents | grok-4-6 | high | enterpriseOpsGym | 0.483437779767 | True | False | source benchmark harness, not Copilot CLI | authorized fallback |
| claude-haiku-4.5 | artificialAnalysisComponents | claude-4-5-haiku | none | ifbench | 0.420408163265 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | ifbench | 0.622448979592 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | ifbench | 0.565986394558 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | ifbench | 0.753741496599 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | ifbench | 0.691836734694 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | ifbench | 0.726530612245 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | ifbench | 0.695918367347 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | ifbench | 0.710204081633 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | ifbench | 0.644217687075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | ifbench | 0.712244897959 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | ifbench | 0.621768707483 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | ifbench | 0.662585034014 | True | False | source benchmark harness, not Copilot CLI | qualification route |
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
**Cost basis: measured benchmark workload** (`aa-intelligence-index-canonical-v1`). Every qualified configuration has valid, fresh, comparable measured input/output token totals on the same workload, repriced as uncached tokens at current GitHub rates; output already includes reasoning. This is an external benchmark-workload cost proxy, not predicted Copilot task spend, latency or cache behavior. Task-specific quality bands are separate from this whole-suite cost workload.
Authorized deciding routes, strongest first: **AA Intelligence Index > LiveBench Reasoning**. Supporting metrics are informational only.
Task fit: external-harness proxy, not a measurement of Copilot CLI task success.
Decision status: **budget_constrained_choice**. Deciding metric: artificialAnalysis.intelligenceIndex.
Incumbent selection basis (applied/current after run): artificialAnalysis.intelligenceIndex.
AA Intelligence Index (index points): General reasoning proxy; overlaps component benchmarks, not independent corroboration.
LiveBench Reasoning (percentage points): Reasoning proxy; does not establish interactive triage skill.
Configuration selection: **automatic bounded effort**; authorized efforts: none, minimal, low, medium, high, xhigh, max. Models without effort controls use their native configuration; context remains fixed.
Benchmark-workload usage: candidate **355872.8918 AIC**; incumbent **355872.8918 AIC**.
Benchmark-workload AIC reprices each configuration's own measured input/output tokens at current GitHub rates, uncached, with reasoning already inside output. It compares configurations on one external benchmark workload; it does not predict Copilot task cost or latency.
Eligible quality reference: gpt-6.1-sol / max / default (54.6). Candidate gap: **2.1 / 3** absolute intelligenceIndex score points.
Lowest measured benchmark-workload cost among configurations passing every required band wins; equal-cost model ties prefer the newest verified release. Benchmark-workload usage: candidate **355872.8918 AIC**; incumbent **355872.8918 AIC** (1 AIC = USD 0.01).
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
| claude-haiku-4.5 / none / default | True | n/a | n/a | default | 1 / 5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-haiku-5.5 / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-4.8-fast / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 5 / 25 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-opus-5.5 / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-4.6 / high / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / low / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / max / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-4.6 / medium / default | False | capabilities_stale, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | model_retirement_scope_unconfirmed | default | 3 / 15 | 2026-11-10T13:22:08.0729472Z | 2026-07-30 |
| claude-sonnet-5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| claude-sonnet-5.5 / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gemini-3.8-flash / none / default | True | n/a | n/a | default | 0.75 / 3.75 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gemini-4-argon / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-10-30T08:37:00.782Z |
| gpt-5.3-codex / high / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / low / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / medium / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.3-codex / xhigh / default | False | capabilities_stale, pricing_output_exceeds_ceiling | n/a | default | 1.75 / 14 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| gpt-5.6-luna / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / max / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / none / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-luna / xhigh / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / none / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-sol / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 4 / 20 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / high / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / low / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / max / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / medium / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / none / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-5.6-terra / xhigh / default | False | pricing_output_exceeds_ceiling | n/a | default | 2 / 12 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / high / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / low / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / max / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / medium / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-astra / xhigh / default | False | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | n/a | default | 10 / 50 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / high / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / low / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / max / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / medium / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / none / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-luna / xhigh / default | True | n/a | n/a | default | 0.1 / 0.5 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / none / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / high / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / low / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / max / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / medium / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| gpt-6.1-sol / xhigh / default | True | n/a | n/a | default | 2 / 10 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| grok-4.5 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.5 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / high / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / low / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / medium / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| grok-4.6 / xhigh / default | False | capabilities_stale | n/a | default | 2 / 6 | 2026-11-10T13:22:08.0729472Z | 2026-09-08 |
| mai-code-1.1-flash / high / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / low / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |
| mai-code-1.1-flash / medium / default | True | n/a | n/a | default | 0.2 / 1.2 | 2026-11-10T13:22:08.0729472Z | 2026-11-04T12:31:37.443Z |

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
| claude-opus-4.8 | artificialAnalysisComponents | claude-opus-4-8 | max | ifbench | 0.622448979592 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| claude-sonnet-4.6 | artificialAnalysisComponents | claude-sonnet-4-6-adaptive | max | ifbench | 0.565986394558 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.3-codex | artificialAnalysisComponents | gpt-5-3-codex | xhigh | ifbench | 0.753741496599 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-high | high | ifbench | 0.691836734694 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-low | low | ifbench | 0.665306122449 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol | max | ifbench | 0.726530612245 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-medium | medium | ifbench | 0.695918367347 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-sol | artificialAnalysisComponents | gpt-5-6-sol-xhigh | xhigh | ifbench | 0.710204081633 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-high | high | ifbench | 0.644217687075 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-low | low | ifbench | 0.596598639456 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra | max | ifbench | 0.712244897959 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-medium | medium | ifbench | 0.621768707483 | True | False | source benchmark harness, not Copilot CLI | qualification route |
| gpt-5.6-terra | artificialAnalysisComponents | gpt-5-6-terra-xhigh | xhigh | ifbench | 0.662585034014 | True | False | source benchmark harness, not Copilot CLI | qualification route |
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
