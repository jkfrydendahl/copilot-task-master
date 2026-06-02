---
applyTo: "**"
---

# Planning-First Workflow

Never start by editing files.
Always use this structure:

## 1. Task classification

Briefly classify the task:

- quick
- default development
- agentic implementation
- deep reasoning
- review
- mechanical

## 2. Model check

Model/effort/context were set at launch via the task class (see Model Selection Rules).
Only flag the model if the work clearly belongs to a **different task class** than the one
launched — then say so once and suggest relaunching or `/model`. Otherwise skip this step.

## 3. Context check

Identify:

- current repo
- likely affected area
- likely affected files
- missing context, if any

Do not ask unnecessary questions if the repo can be inspected.

## 4. Plan

For meaningful changes, produce a short implementation plan:

- files to inspect
- expected changes
- risks
- validation steps

## 5. Execute

Only edit files after the plan is clear.

## 6. Validate

After changes, suggest or run appropriate validation.

Prefer repo-discovered commands over invented commands.

## 7. Summarize

End with:

- changed files
- what changed
- validation performed or recommended
- risks or follow-up notes