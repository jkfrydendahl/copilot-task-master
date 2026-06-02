---
applyTo: "**"
---

# Model Selection Rules

Model, reasoning effort, and context tier are **chosen at launch**, not per turn.

The launcher (`Start-CopilotWork.ps1`) asks for a task class, looks up the matching
profile in `task-profiles.json`, and starts the CLI with the right
`--model` / `--effort` / `--context`. That is the single source of truth for model
selection. Do **not** re-litigate the model choice on every request.

## Task classes

These are the shared vocabulary; each maps to a key in `task-profiles.json`:

1. Quick — syntax questions, small explanations, tiny isolated edits, formatting, naming.
2. Default development — ordinary bug fixes, normal feature work, straightforward refactors, small D365 changes.
3. Agentic implementation — multi-file work, edit/test loops, repo exploration, coordinated layered changes.
4. Deep reasoning — architecture, unclear bugs, integration design, data-model/security/performance-sensitive work, risky refactors.
5. Review — ordinary diff review (use Deep reasoning for risky/large/business-critical diffs).
6. Visual/UI — UI/layout-oriented work where visual reasoning matters.
7. Mechanical — repetitive bulk edits after a plan is approved.

To change models, effort, or context tier, the **right action is to adjust the launch**:
relaunch via `Start-CopilotWork.ps1` with a different task class, or use the in-session
`/model` command. Editing `task-profiles.json` changes the defaults for next time.

## Knowing the launched task class

The launcher exports the launched class into the environment:

- `COPILOT_TASK_CLASS` (key, e.g. `quick`), `COPILOT_TASK_LABEL` (e.g. `Quick`)
- `COPILOT_TASK_MODEL`, `COPILOT_TASK_EFFORT`, `COPILOT_TASK_CONTEXT`

At the **start of a session** (your first response), read `COPILOT_TASK_CLASS` once
(e.g. `echo $env:COPILOT_TASK_CLASS`) and treat it as the launched baseline for the rest
of the session. If the variable is empty, the session was not started through the launcher —
do not show the banner, but you may mention once that launching via `Start-CopilotWork.ps1`
enables task-aware model selection.

## Drift detection — MANDATORY visual banner

You cannot switch your own model mid-session. Your job is to make a mismatch **impossible to
miss** so the user can switch. On **every turn**, compare the work the user's most recent
input actually requires against the launched baseline class.

Mismatch matters in **both directions**, and the cheaper direction matters at least as much:

- **Under-powered (upgrade):** launched light, but the work now needs more capability — e.g.
  launched **Quick**/**Mechanical** but the request needs real reasoning, multi-file changes,
  design decisions, or touches schema / security / performance / integrations; or launched
  **Default development**/**Review** but it has become architecture, an unclear production-like
  bug, a data-model change, or a risky refactor (→ Deep reasoning). Risk: silently
  under-powering the task and producing weak work.
- **Over-powered (downgrade — cost):** launched heavy, but the work is actually trivial — e.g.
  launched **Deep reasoning** (`opus`, high effort, long_context) but you're now doing a rename,
  a formatting fix, a one-line edit, or other Quick/Mechanical work. Staying on the expensive
  model/effort/context wastes money on **every turn**. Flag it so the user can drop to a cheaper
  class. This direction is at least as important as upgrading.

Do **not** raise it for normal in-class variation, or merely because a different model *could*
also work. Only raise it on a genuine class change, in either direction.

When raised, the banner MUST be the **first thing** in your response, reproduced exactly in
this format (it renders as a high-visibility callout in the terminal):

```
> [!WARNING]
> ⚠️ **TASK-CLASS MISMATCH — CONSIDER SWITCHING MODELS** ⚠️
>
> Launched as **<launched label>** (`<launched model>`), but recent input looks like **<suggested label>**.
> **Direction:** <"upgrade for capability" or "downgrade to save cost">.
> **Why:** <one concise sentence tied to what the user just asked>.
> **Switch:** relaunch via `Start-CopilotWork.ps1` as *<suggested label>*, or run `/model` → `<suggested model>` (effort `<effort>`, context `<context>`).
```

Fill every placeholder from `task-profiles.json` (suggested model/effort/context for the
suggested class) and the env vars (launched label/model). Keep it to that block — no extra
preamble above it. After the banner, continue helping with the launched model unless the user
switches; re-show the banner on later turns if the mismatch persists or recurs.

Never bury the recommendation in prose, and never silently proceed on a mismatched task —
whether it is under-powered (quality risk) or over-powered (wasted cost) — without showing
the banner.

## Tuning the profiles

`task-profiles.json` is the place to encode "cheapest capable model per task class."
When tuning it, consult the model comparison page rather than guessing:
https://docs.github.com/en/copilot/reference/ai-models/model-comparison

Keep cost discipline in the profiles themselves: reserve higher `effort` and
`long_context` for the Deep reasoning class and genuinely large/complex work.