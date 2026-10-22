# Copilot Workbench Integration

Treat the current working directory as the target project, not this workbench.
Read the applicable target-project instructions (`AGENTS.md`, `CLAUDE.md`,
`.github/copilot-instructions.md` and scoped instructions) before working.
Project-specific requirements override generic workbench guidance; stricter user
or project restrictions always apply.

## Delivery policy belongs to the company/project

Use the active company `general.instructions.md` and `code-review.instructions.md`
(distributed by CopilotCustomizations), together with applicable project policy.
They own planning/Main Flow, skill choice, validation, actual-change self-review
and task-scoped Git boundaries. This workbench does not duplicate or replace them.

If no applicable company/project delivery policy is loaded, report the missing
policy and ask the user before implementation or Git writes. Do not invent a
fallback workflow. Read-only investigation and explanations may continue.

## Model routing belongs to this workbench

`10-model-selection.instructions.md` owns launch baselines, triage and drift
detection; `15-orchestrator-mode.instructions.md` owns task-class agent routing.
Resolve settings from `task-profiles.json`. Routing supplies execution settings
within the active delivery stage and approved plan, never workflow exemptions.
Retain applicable BC/CE domain guidance from the scoped instructions.