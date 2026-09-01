# Monthly task profile review (2026-09-01)

Reference: https://docs.github.com/en/copilot/reference/ai-models/model-comparison

Model source: **copilot help config**

Force benchmark consensus (manual first-run override): **False**

## Current profiles

| Key | Model | Effort | Context |
|---|---|---|---|
| orchestrator | gpt-5.4 | medium | default |
| quick | claude-haiku-4.5 | low | default |
| default-development | gpt-5.6-luna | medium | default |
| agentic-implementation | gpt-5.3-codex | high | default |
| deep-reasoning | claude-opus-5 | high | long_context |
| review | gpt-5.6-sol | medium | default |
| visual-ui | claude-sonnet-5 | medium | default |
| mechanical | claude-haiku-4.5 | low | default |
| triage | claude-sonnet-5 | low | default |

## Applied profile changes in this run
- None.

## Benchmark consensus pending
- None.

## Benchmark consensus AA-data-missing fallback

_AA alias IS configured but Artificial Analysis returned no score this run. LiveBench-only comparison is allowed as a temporary bridge, provided the LiveBench source data is at most 90 days old._

- None.

## Benchmark consensus AA-alias-not-configured exclusions

_No `artificialAnalysis` alias is configured in `config/model-ranking-aliases.json` for these models, so Artificial Analysis is never consulted for them. They are excluded from benchmark consensus entirely (no LiveBench-only promotion). Add an alias if a model deserves consideration._

- "agentic-implementation": AA alias not configured -- excluded from consensus: claude-opus-4.5, claude-opus-4.6, claude-opus-4.7, claude-opus-4.8, claude-sonnet-4.6, claude-sonnet-5, gpt-5.4, gpt-5.4-mini, gpt-5.5, gpt-5.6-luna, gpt-5.6-terra

## Active benchmark overrides
- "orchestrator": "gpt-5.4"
- "default-development": "gpt-5.6-luna"
- "review": "gpt-5.6-sol"

## Benchmark consensus auto-applied changes
- None.

## Model admissibility (rule 9: availability confidence, capability/pricing freshness, profile ceilings, exclusion reasons)

### orchestrator

- Availability confidence: **verified**
- Pricing ceilings (per million tokens): input <= $3, output <= $15
- Incumbent/current model: **gpt-5.4** — admissible: **True** (reasons: none)
- Exclusions:

| Model | Reasons | Pricing tier | Input $/M | Output $/M | Capability as-of |
|---|---|---|---|---|---|
| claude-opus-5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8-fast | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| claude-opus-4.7 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.6 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-sonnet-4.5 | context_unsupported, effort_unsupported | default | 3 | 15 | 2026-07-30 |
| claude-opus-4.5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| gpt-5.6-sol | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5.5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5-mini | context_unsupported, effort_unsupported | default | 0.25 | 2 | 2026-07-30 |
| mai-code-1.1-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| mai-code-1-flash-picker | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| gemini-3.7-flash | capabilities_missing | n/a | n/a | n/a | n/a |

### quick

- Availability confidence: **verified**
- Pricing ceilings (per million tokens): input <= $2, output <= $10
- Incumbent/current model: **claude-haiku-4.5** — admissible: **True** (reasons: none)
- Exclusions:

| Model | Reasons | Pricing tier | Input $/M | Output $/M | Capability as-of |
|---|---|---|---|---|---|
| claude-opus-5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8-fast | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| claude-opus-4.7 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-sonnet-4.6 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 3 | 15 | 2026-07-30 |
| claude-opus-4.6 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-sonnet-4.5 | context_unsupported, effort_unsupported, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 3 | 15 | 2026-07-30 |
| claude-opus-4.5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| gpt-5.6-sol | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5.6-terra | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 2.5 | 15 | 2026-07-30 |
| gpt-5.5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5.4 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 2.5 | 15 | 2026-07-30 |
| gpt-5.3-codex | pricing_output_exceeds_ceiling | default | 1.75 | 14 | 2026-07-30 |
| gpt-5-mini | context_unsupported, effort_unsupported | default | 0.25 | 2 | 2026-07-30 |
| mai-code-1.1-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| mai-code-1-flash-picker | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| gemini-3.7-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| gemini-3.1-pro-preview | pricing_output_exceeds_ceiling | default | 2 | 12 | 2026-07-30 |

### default-development

- Availability confidence: **verified**
- Pricing ceilings (per million tokens): input <= $3, output <= $15
- Incumbent/current model: **gpt-5.6-luna** — admissible: **True** (reasons: none)
- Exclusions:

| Model | Reasons | Pricing tier | Input $/M | Output $/M | Capability as-of |
|---|---|---|---|---|---|
| claude-opus-5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8-fast | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| claude-opus-4.7 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.6 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-sonnet-4.5 | context_unsupported, effort_unsupported | default | 3 | 15 | 2026-07-30 |
| claude-opus-4.5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| gpt-5.6-sol | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5.5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5-mini | context_unsupported, effort_unsupported | default | 0.25 | 2 | 2026-07-30 |
| mai-code-1.1-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| mai-code-1-flash-picker | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| gemini-3.7-flash | capabilities_missing | n/a | n/a | n/a | n/a |

### agentic-implementation

- Availability confidence: **verified**
- Pricing ceilings (per million tokens): input <= $10, output <= $50
- Incumbent/current model: **gpt-5.3-codex** — admissible: **True** (reasons: none)
- Exclusions:

| Model | Reasons | Pricing tier | Input $/M | Output $/M | Capability as-of |
|---|---|---|---|---|---|
| claude-opus-4.8-fast | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| claude-sonnet-4.5 | context_unsupported, effort_unsupported | default | 3 | 15 | 2026-07-30 |
| gpt-5-mini | context_unsupported, effort_unsupported | default | 0.25 | 2 | 2026-07-30 |
| mai-code-1.1-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| mai-code-1-flash-picker | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| gemini-3.7-flash | capabilities_missing | n/a | n/a | n/a | n/a |

### deep-reasoning

- Availability confidence: **verified**
- Pricing ceilings (per million tokens): input <= $10, output <= $45
- Incumbent/current model: **claude-opus-5** — admissible: **True** (reasons: none)
- Exclusions:

| Model | Reasons | Pricing tier | Input $/M | Output $/M | Capability as-of |
|---|---|---|---|---|---|
| claude-opus-4.8-fast | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| claude-sonnet-4.5 | context_unsupported, effort_unsupported | default | 3 | 15 | 2026-07-30 |
| claude-haiku-4.5 | context_unsupported | default | 1 | 5 | 2026-07-30 |
| gpt-5.4-mini | context_unsupported | default | 0.75 | 4.5 | 2026-07-30 |
| gpt-5.3-codex | context_unsupported | default | 1.75 | 14 | 2026-07-30 |
| gpt-5-mini | context_unsupported, effort_unsupported | default | 0.25 | 2 | 2026-07-30 |
| mai-code-1.1-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| mai-code-1-flash-picker | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| gemini-3.7-flash | capabilities_missing | n/a | n/a | n/a | n/a |

### review

- Availability confidence: **verified**
- Pricing ceilings (per million tokens): input <= $5, output <= $30
- Incumbent/current model: **gpt-5.6-sol** — admissible: **True** (reasons: none)
- Exclusions:

| Model | Reasons | Pricing tier | Input $/M | Output $/M | Capability as-of |
|---|---|---|---|---|---|
| claude-opus-4.8-fast | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| claude-sonnet-4.5 | context_unsupported, effort_unsupported | default | 3 | 15 | 2026-07-30 |
| gpt-5-mini | context_unsupported, effort_unsupported | default | 0.25 | 2 | 2026-07-30 |
| mai-code-1.1-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| mai-code-1-flash-picker | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| gemini-3.7-flash | capabilities_missing | n/a | n/a | n/a | n/a |

### visual-ui

- Availability confidence: **verified**
- Pricing ceilings (per million tokens): input <= $3, output <= $15
- Incumbent/current model: **claude-sonnet-5** — admissible: **False** (reasons: vision_unknown)
- Exclusions:

| Model | Reasons | Pricing tier | Input $/M | Output $/M | Capability as-of |
|---|---|---|---|---|---|
| claude-opus-5 | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8 | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8-fast | vision_unknown, context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| claude-opus-4.7 | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.6 | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-sonnet-4.5 | vision_unknown, context_unsupported, effort_unsupported | default | 3 | 15 | 2026-07-30 |
| claude-opus-4.5 | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-haiku-4.5 | vision_unknown | default | 1 | 5 | 2026-07-30 |
| gpt-5.6-sol | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5.6-terra | vision_unknown | default | 2.5 | 15 | 2026-07-30 |
| gpt-5.6-luna | vision_unknown | default | 1 | 6 | 2026-07-30 |
| gpt-5.5 | vision_unknown, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5.4 | vision_unknown | default | 2.5 | 15 | 2026-07-30 |
| gpt-5.4-mini | vision_unknown | default | 0.75 | 4.5 | 2026-07-30 |
| gpt-5.3-codex | vision_unknown | default | 1.75 | 14 | 2026-07-30 |
| gpt-5-mini | context_unsupported, effort_unsupported | default | 0.25 | 2 | 2026-07-30 |
| mai-code-1.1-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| mai-code-1-flash-picker | vision_unknown, context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| gemini-3.7-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| gemini-3.6-flash | vision_unknown | default | 1.5 | 7.5 | 2026-07-30 |
| gemini-3.5-flash | vision_unknown | default | 1.5 | 9 | 2026-07-30 |

### mechanical

- Availability confidence: **verified**
- Pricing ceilings (per million tokens): input <= $2, output <= $10
- Incumbent/current model: **claude-haiku-4.5** — admissible: **True** (reasons: none)
- Exclusions:

| Model | Reasons | Pricing tier | Input $/M | Output $/M | Capability as-of |
|---|---|---|---|---|---|
| claude-opus-5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8-fast | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| claude-opus-4.7 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-sonnet-4.6 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 3 | 15 | 2026-07-30 |
| claude-opus-4.6 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-sonnet-4.5 | context_unsupported, effort_unsupported, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 3 | 15 | 2026-07-30 |
| claude-opus-4.5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| gpt-5.6-sol | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5.6-terra | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 2.5 | 15 | 2026-07-30 |
| gpt-5.5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5.4 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 2.5 | 15 | 2026-07-30 |
| gpt-5.3-codex | pricing_output_exceeds_ceiling | default | 1.75 | 14 | 2026-07-30 |
| gpt-5-mini | context_unsupported, effort_unsupported | default | 0.25 | 2 | 2026-07-30 |
| mai-code-1.1-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| mai-code-1-flash-picker | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| gemini-3.7-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| gemini-3.1-pro-preview | pricing_output_exceeds_ceiling | default | 2 | 12 | 2026-07-30 |

### triage

- Availability confidence: **verified**
- Pricing ceilings (per million tokens): input <= $2, output <= $10
- Incumbent/current model: **claude-sonnet-5** — admissible: **True** (reasons: none)
- Exclusions:

| Model | Reasons | Pricing tier | Input $/M | Output $/M | Capability as-of |
|---|---|---|---|---|---|
| claude-opus-5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-opus-4.8-fast | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| claude-opus-4.7 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-sonnet-4.6 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 3 | 15 | 2026-07-30 |
| claude-opus-4.6 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| claude-sonnet-4.5 | context_unsupported, effort_unsupported, pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 3 | 15 | 2026-07-30 |
| claude-opus-4.5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 25 | 2026-07-30 |
| gpt-5.6-sol | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5.6-terra | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 2.5 | 15 | 2026-07-30 |
| gpt-5.5 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 5 | 30 | 2026-07-30 |
| gpt-5.4 | pricing_input_exceeds_ceiling, pricing_output_exceeds_ceiling | default | 2.5 | 15 | 2026-07-30 |
| gpt-5.3-codex | pricing_output_exceeds_ceiling | default | 1.75 | 14 | 2026-07-30 |
| gpt-5-mini | context_unsupported, effort_unsupported | default | 0.25 | 2 | 2026-07-30 |
| mai-code-1.1-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| mai-code-1-flash-picker | context_unsupported, effort_unsupported, pricing_missing | n/a | n/a | n/a | 2026-07-30 |
| gemini-3.7-flash | capabilities_missing | n/a | n/a | n/a | n/a |
| gemini-3.1-pro-preview | pricing_output_exceeds_ceiling | default | 2 | 12 | 2026-07-30 |

## External model ranking snapshot

- Status: **partial**
- Stale: **false**
- Fallback used: **false**
- Note: Ranking buckets generated from partial live data. The committed last-good snapshot was not replaced.
- Artificial Analysis URL: https://artificialanalysis.ai/?intelligence=agentic-index
- Artificial Analysis Coding Agents URL: https://artificialanalysis.ai/agents/coding-agents
- LiveBench URL: https://github.com/LiveBench/new-livebench/tree/main/public
- Artificial Analysis source date: 
- Artificial Analysis Coding Agent source date: n/a
- LiveBench source date: 2026-06-25
- Artificial Analysis fetched at (UTC): 2026-09-01T12:08:42.5273948Z
- Artificial Analysis Coding Agents fetched at (UTC): 2026-09-01T12:08:42.9636539Z
- LiveBench fetched at (UTC): 2026-09-01T12:08:43.2059367Z

> External rankings can auto-apply only after strict two-run consensus; verified availability, capabilities, pricing, and benchmark quality govern promotion, and family preferences are baseline-only.

| Model | AA Agentic | AA Coding Agent | LB Coding | LB Agentic Coding | LB Reasoning | LB Instruction Following | LB Cost | LB Cost Bucket |
|---|---|---|---|---|---|---|---|---|
| claude-sonnet-5 | n/a | n/a | competitive | top | competitive | competitive | 0.5134 | lagging |
| claude-opus-5 | n/a | competitive | competitive | top | top | competitive | 0.7067 | lagging |
| claude-opus-4.8 | n/a | n/a | top | competitive | top | top | 0.9858 | lagging |
| claude-opus-4.8-fast | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| claude-opus-4.7 | n/a | n/a | top | competitive | lagging | top | 0.5282 | lagging |
| claude-sonnet-4.6 | n/a | n/a | lagging | lagging | lagging | lagging | 0.3062 | top |
| claude-opus-4.6 | n/a | n/a | lagging | lagging | competitive | lagging | 0.4035 | competitive |
| claude-sonnet-4.5 | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| claude-opus-4.5 | n/a | n/a | competitive | lagging | lagging | lagging | 0.6104 | lagging |
| claude-haiku-4.5 | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| gpt-5.6-sol | n/a | competitive | top | top | top | top | 0.507 | competitive |
| gpt-5.6-terra | n/a | n/a | lagging | top | top | competitive | 0.3437 | top |
| gpt-5.6-luna | n/a | n/a | top | lagging | lagging | lagging | 0.1677 | top |
| gpt-5.5 | n/a | n/a | top | top | top | top | 0.4356 | competitive |
| gpt-5.4 | n/a | n/a | lagging | competitive | competitive | top | 0.3874 | top |
| gpt-5.4-mini | n/a | n/a | lagging | lagging | lagging | lagging | 0.3343 | top |
| gpt-5.3-codex | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| gpt-5-mini | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| mai-code-1.1-flash | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| mai-code-1-flash-picker | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| gemini-3.7-flash | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| gemini-3.6-flash | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| gemini-3.5-flash | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| gemini-3.1-pro-preview | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
