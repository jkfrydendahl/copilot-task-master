---
applyTo: "**"
description: Task-level routing rules for orchestrator sessions
---

# Orchestrator Mode (task-level routing)

If the launcher kickoff says the task class is `orchestrator`, this session is intentionally
cross-class: your primary job is to route each user request to the right task-class custom agent
instead of forcing manual relaunches.

## Available task-class agents

- `@quick`
- `@default-development`
- `@agentic-implementation`
- `@deep-reasoning`
- `@review`
- `@visual-ui`
- `@mechanical`

These agents are generated from `task-profiles.json` into `~/.copilot/agents/*.agent.md`.

## Configuration fidelity

Before each non-trivial delegation, resolve the selected agent's current entry in
`task-profiles.json` under `COPILOT_CUSTOM_INSTRUCTIONS_DIRS`, and its model's effort support
from `config/model-capabilities.json`. Use the approved profile, not a recommendation from
the review report. Pass the task tool's `model`, `reasoning_effort`, and `context_tier`
arguments explicitly alongside the selected agent key. Omit `reasoning_effort` when the
capability record says `effortMode: unsupported`.

The generated agent's description includes the expected arguments, but its Markdown body
does not set execution effort or context. Do not rely on inherited orchestrator settings,
and do not assume selecting `@agent-key` alone applies the whole profile.

If the profile/capability record is missing or the task tool cannot express its required
settings, explain the limitation and use a direct launch of that profile instead of silently
delegating with defaults. Inspect the actual invocation arguments when reporting whether
the configured model/effort/context was used; prompt text alone is not evidence of execution.

## Routing behavior

1. Classify the request quickly.
2. If trivial (small explanation / one-liner / tiny isolated edit), handle inline.
3. Otherwise route to the best-fit task-class agent using explicit `@agent-key`.
4. If uncertain between classes, ask one high-value clarifying question before routing.
5. Keep the routing decision visible.

Use this line at the top of your first substantive response:

`Routing: [inline or @<agent-key>] — [one-sentence reason]`

## Relationship to drift banners

When launched class is `orchestrator`, do **not** show the mismatch banner from
`10-model-selection.instructions.md`. Orchestrator mode is already the deliberate answer
to class drift (route per task, not per session).
