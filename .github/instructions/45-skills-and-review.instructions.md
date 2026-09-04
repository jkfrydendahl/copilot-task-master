---
applyTo: "**"
description: When to use the shared skills, plus the post-implementation self-review protocol
---

# Skills & Self-Review

These skills are installed globally (personal skills dir) and available in every repo.
Choose the right workflow for the size of the task — don't over-ceremony small work.

## Precedence: task-master skills vs. repo-local skills

Some repos ship their own `.github/skills/` alongside these global ones. When a request could be
handled by **either** a task-master (personal, global) skill **or** a repo-local skill:

- **Always prefer the task-master skill.** It is the maintained, cross-repo canonical version.
- **Only fall back to a repo-local skill** when no task-master skill covers that need — e.g. a
  repo-local skill with genuinely unique scope (such as a domain-specific variant with no global
  equivalent).
- If a repo-local skill's name or purpose merely duplicates a task-master skill, treat it as
  superseded — do not invoke it, and note the duplication to the user if relevant.
- This precedence applies to skill *selection/invocation* behavior. It does not require deleting
  or renaming repo-local skills — that's a per-repo decision — but this session should default to
  the task-master version whenever both exist.

## Skill routing

| Task size | Approach |
|-----------|----------|
| **Trivial** (typos, config tweaks, one-line fixes) | Implement directly. |
| **Small** (bug fixes, minor localized features) | Implement directly with tests. |
| **Medium–Large** (new features, multi-file changes, design decisions) | `/refine-requirements` → `/tdd-implement`. |

> **Exception:** If the launched task class (from the kickoff message) is `triage` **or** `orchestrator`, skip this routing table.
> - `triage`: follow the Triage mode instructions in `10-model-selection.instructions.md` and show the `🔎 TRIAGE ESTIMATE` callout first.
> - `orchestrator`: follow task-level routing rules in `15-orchestrator-mode.instructions.md` (`Routing: ...`, inline for trivial, `@agent-key` for non-trivial).

This complements the plan-first rules in `AGENTS.md` and the planning-first instruction —
it does not replace them. Respect those before editing.

## Available skills

- `/grill-me` — Stress-test a plan or design by interviewing you one question at a time.
- `/refine-requirements` — Analyze and plan a work item before implementation (multi-phase).
- `/estimate-task` — Produce a structured effort/complexity estimate for a work item.
- `/tdd-implement` — Implement a planned feature using TDD (multi-phase).
- `/reference-lookup` — Find authoritative patterns, APIs, or implementations in external sources.
- `/code-review-synthesis` — After a multi-model `/review`, consolidate the passes into one deduplicated, prioritized report (this is the skill's name; the review criteria live in the Code Review Standards instruction).
- `/create-release` — Merge feature branches and bump the version for a release.
- `/update-readme` — Bring a README in sync with the current state of the project.
- `/session-time-audit` — Compare AI-assisted vs. no-AI effort for one Copilot CLI session (current or by ID).

## Post-implementation self-review

After completing a feature or non-trivial change, self-review before returning to the user:

1. Analyze the diff of all changes made during this task.
2. Evaluate it against the **Code Review Standards** instruction (loaded with your instructions).
3. Classify findings by severity (🔴 Critical, 🟠 Warning, 🟡 Suggestion, ℹ️ Note).
4. Fix any Critical or Warning findings before presenting the work.
5. Present a brief review summary alongside the completed work.

For deeper coverage, suggest a multi-model review:

> For additional coverage, run `/review` with the models listed in the master
> `config/review-models.md`, then ask Copilot to synthesize the findings.
