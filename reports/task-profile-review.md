# Monthly task profile review (2026-07-30)

Reference: https://docs.github.com/en/copilot/reference/ai-models/model-comparison

Model source: **gh copilot help config**

Force benchmark consensus (manual first-run override): **True**

## Current profiles

| Key | Model | Effort | Context |
|---|---|---|---|
| orchestrator | claude-sonnet-5 | medium | default |
| quick | claude-haiku-4.5 | low | default |
| default-development | claude-sonnet-5 | medium | default |
| agentic-implementation | gpt-5.3-codex | high | default |
| deep-reasoning | claude-opus-5 | high | long_context |
| review | gpt-5.6-terra | medium | default |
| visual-ui | claude-sonnet-5 | medium | default |
| mechanical | claude-haiku-4.5 | low | default |
| triage | claude-sonnet-5 | low | default |

## Applied profile changes in this run
- "review": "claude-sonnet-5" -> "gpt-5.6-terra" (benchmark_consensus_forced)

## Benchmark consensus pending
- None.

## Active benchmark overrides
- "review": "gpt-5.6-terra"

## Benchmark consensus auto-applied changes
- "review": "claude-sonnet-5" -> "gpt-5.6-terra" (benchmark_consensus_forced - manual override, first qualifying run)

## External model ranking snapshot

- Status: **ok**
- Stale: **false**
- Fallback used: **false**
- Note: Ranking buckets generated from live source data.
- Artificial Analysis URL: https://artificialanalysis.ai/?intelligence=agentic-index
- Artificial Analysis Coding Agents URL: https://artificialanalysis.ai/agents/coding-agents
- LiveBench URL: https://github.com/LiveBench/new-livebench/tree/main/public
- Artificial Analysis source date: 2026-07-24
- Artificial Analysis Coding Agent source date: n/a
- LiveBench source date: 2026-06-25
- Artificial Analysis fetched at (UTC): 2026-07-30T11:29:13.2632775Z
- Artificial Analysis Coding Agents fetched at (UTC): 2026-07-30T11:29:13.7507473Z
- LiveBench fetched at (UTC): 2026-07-30T11:29:13.9123563Z

> External rankings can auto-apply only after strict two-run consensus; task-family eligibility remains authoritative.

| Model | AA Agentic | AA Coding Agent | LB Coding | LB Agentic Coding | LB Reasoning | LB Instruction Following | LB Cost | LB Cost Bucket |
|---|---|---|---|---|---|---|---|---|
| claude-sonnet-5 | competitive | n/a | competitive | top | competitive | competitive | 0.492 | competitive |
| claude-sonnet-4.6 | n/a | n/a | lagging | lagging | lagging | lagging | 0.3062 | top |
| claude-sonnet-4.5 | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| claude-haiku-4.5 | lagging | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| claude-opus-5 | top | top | competitive | top | top | competitive | 0.6414 | lagging |
| claude-opus-4.8 | competitive | n/a | top | competitive | top | top | 0.9858 | lagging |
| claude-opus-4.8-fast | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| claude-opus-4.7 | n/a | n/a | top | competitive | lagging | top | 0.5282 | competitive |
| claude-opus-4.6 | n/a | n/a | lagging | lagging | competitive | lagging | 0.4035 | top |
| claude-opus-4.5 | n/a | n/a | competitive | lagging | lagging | lagging | 0.6104 | lagging |
| gpt-5.6-sol | top | competitive | top | top | top | top | 0.5887 | lagging |
| gpt-5.6-terra | top | n/a | lagging | top | top | competitive | 0.4974 | competitive |
| gpt-5.6-luna | lagging | n/a | top | lagging | lagging | lagging | 0.202 | top |
| gpt-5.5 | n/a | n/a | top | top | top | top | 0.5298 | lagging |
| gpt-5.4 | n/a | n/a | lagging | competitive | competitive | top | 0.3874 | top |
| gpt-5.3-codex | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| gpt-5.4-mini | n/a | n/a | lagging | lagging | lagging | lagging | 0.3343 | top |
| gpt-5-mini | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| gemini-3.1-pro-preview | n/a | lagging | n/a | n/a | n/a | n/a | n/a | n/a |
| gemini-3.6-flash | lagging | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
| gemini-3.5-flash | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a |
