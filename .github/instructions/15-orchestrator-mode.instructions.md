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
