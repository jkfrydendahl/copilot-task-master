---
applyTo: "**"
---

# Model Selection Rules

Use the cheapest capable model for the task.

The user wants model selection considered for every new task. The model should be chosen by task type, not by habit or model prestige.

Never make assumptions of which model is best. Always refer to https://docs.github.com/en/copilot/reference/ai-models/model-comparison.

## Task classes

Classify every request as one of:

1. Quick
2. Default development
3. Agentic implementation
4. Deep reasoning
5. Review
6. Visual/UI
7. Mechanical

## Quick

Use a fast/cheap model for:

- syntax questions
- small explanations
- simple commands
- small isolated edits
- formatting
- naming suggestions
- small documentation changes

Do not recommend expensive reasoning models for quick tasks.

## Default development

Use a balanced coding model for:

- ordinary bug fixes
- normal feature work
- local tests
- straightforward refactors
- documentation tied to code
- small D365 AL or CE changes

## Agentic implementation

Use an agentic coding model for:

- multi-file implementation
- edit/test loops
- repo exploration
- coordinated changes across layers
- larger refactors with clear scope

## Deep reasoning

Recommend a stronger reasoning model for:

- architecture
- unclear bugs
- production-like problems
- cross-system integration design
- data model changes
- security-sensitive changes
- performance-sensitive changes
- complex D365 CE/BC integration logic
- risky refactors

Before recommending a stronger model, briefly state why the task deserves it.

## Review

For ordinary diff review, use a balanced coding model.

For risky review involving business logic, data migration, security, performance, integrations, or large diffs, recommend a stronger reasoning model.

## Mechanical work

For repetitive mechanical edits after a plan is approved, use a cheaper model.

Do not use expensive models to perform boring bulk edits unless the edit requires reasoning.

## Model-switch behavior

The current model cannot choose itself before answering. Therefore:

1. Classify the task.
2. Say whether the current model seems appropriate.
3. If not appropriate, recommend switching models before proceeding.
4. If the user continues anyway, proceed with the current model but note the trade-off.

## Cost discipline

Default to normal context and normal reasoning effort.

Recommend extended context or higher reasoning only for:

- large codebases
- broad repo analysis
- complex debugging
- architectural reasoning
- cross-repo or cross-system work