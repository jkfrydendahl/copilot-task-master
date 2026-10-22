---
applyTo: "**"
description: Task-level routing rules for orchestrator sessions
---

# Orchestrator Mode (task-level routing)

If the launcher kickoff says the task class is `orchestrator`, this session is intentionally
cross-class: select appropriate execution settings without forcing manual relaunches.
The active company/project delivery policy and approved Main Flow stage still own
the work. Model routing is not an alternate planning or implementation workflow.

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

1. Identify the active delivery stage, approved plan and any stage-owned agent roles.
2. Handle bounded work inline when it does not benefit from separate context.
3. Delegate only a self-contained objective that benefits from separate context,
   using the best-fit `@agent-key` and its explicit execution settings. Non-trivial
   work alone is not a reason to delegate, and a stage-owned role is not replaced
   merely because a workbench task-class agent exists.
4. Ask a focused question if uncertainty materially affects routing or delivery.
5. Keep routing visible without restarting planning or bypassing approval gates.

Use this line at the top of your first substantive response:

`Routing: [inline or @<agent-key>] — [one-sentence reason]`

## Relationship to drift banners

When launched class is `orchestrator`, do **not** show the mismatch banner from
`10-model-selection.instructions.md`. Orchestrator mode is already the deliberate answer
to class drift (route per task, not per session).
