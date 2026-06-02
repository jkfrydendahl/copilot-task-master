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

State whether the current model is sufficient.

If a different model would be better, recommend it before continuing.

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