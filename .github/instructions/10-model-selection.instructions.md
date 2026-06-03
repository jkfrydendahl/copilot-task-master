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
4. Deep reasoning — architecture, unclear bugs, integration design, data-model/security/performance-sensitive work, risky refactors. NOT for routine builds, deploys, or packaging steps even if the target system is complex.
5. Review — ordinary diff review (use Deep reasoning for risky/large/business-critical diffs).
6. Visual/UI — UI/layout-oriented work where visual reasoning matters.
7. Mechanical — repetitive bulk edits OR known operational steps (build, package, deploy, run migrations) after the approach is clear; no real design decisions required.
8. Triage — a cheap "I'm not sure" launch that estimates the task first, then recommends one of the classes above (see Triage mode below).

To change models, effort, or context tier, the **right action is to adjust the launch**:
relaunch via `Start-CopilotWork.ps1` with a different task class, or use the in-session
`/model` command. Editing `task-profiles.json` changes the defaults for next time.

## Knowing the launched task class

The launcher sends a kickoff message at session start that tells you the task class directly
in the conversation — look for text like:
> Session initialized: task class = **Label** (`key`), model = `...`, effort = `...`, context = `...`

Treat everything in that message as the **user's declared launch baseline** — what they *thought*
the task was when they chose a profile. It is **not** a pre-validated fit. You must still run the
drift check on your first substantive turn and flag a mismatch if the actual work doesn't match
the declared class. The kickoff settles the launched model/effort/context; it does not settle
whether those settings are appropriate for the task the user actually describes.

Do **not** re-read env vars to determine task class — the kickoff is the single source of truth.

If no kickoff message is present, the session was not started through the launcher —
do not show the banner, but you may mention once that launching via `Start-CopilotWork.ps1`
enables task-aware model selection.

## Triage mode (auto-estimate)

If the launched task class (from the kickoff message) is `triage`, the user launched cheaply on purpose because they were
unsure how heavy the task is. **Before doing the actual work**, on your first substantive turn,
perform a streamlined inline task estimate — do NOT invoke the `/estimate-task` skill:

1. Ask the one or two highest-value clarifying questions needed to score the task (skip this
   if the user's description already makes the size obvious).
2. Score the task across these dimensions (brief, not exhaustive):
   - **Size** — roughly how many files/systems are touched?
   - **Uncertainty** — is the approach clear or ambiguous?
   - **Technical complexity** — any schema, security, perf, or cross-system concerns?
3. Map the score to a recommended task class:
   - **Trivial** (~≤1h, one-liners, config) → **Quick** (or **Mechanical** if approved repetitive bulk edits).
   - **Small** (~1–4h, localized bug/feature) → **Default development**.
   - **Medium** (~4–16h, multi-file, coordinated changes) → **Agentic implementation**.
   - **Large / high uncertainty** (≳16h, or high Uncertainty/Technical-Complexity, or architecture,
     cross-system, schema, security, or performance-sensitive work) → **Deep reasoning**.
   - **Kind overrides** (apply regardless of size): mostly reviewing a diff → **Review**;
     UI/layout/visual work → **Visual/UI**.
4. Read the exact `model` / `effort` / `context` for the recommended class from `task-profiles.json`
   in the directory named by `COPILOT_CUSTOM_INSTRUCTIONS_DIRS`, then present the result:

```
> [!NOTE]
> 🔎 **TRIAGE ESTIMATE** — this task looks like **<suggested label>**.
>
> **Estimate:** <one-line size/complexity read>.
> **Recommended:** `<suggested model>` (effort `<effort>`, context `<context>`).
> **Switch:** relaunch via `Start-CopilotWork.ps1` as *<suggested label>*, or run `/model` → `<suggested model>` + set effort `<effort>` in-session. Switching in-session keeps this conversation.
```

5. **STOP. Do not proceed.** After presenting the callout, your response ends. Do not add
   next steps, do not start exploring the repo, do not ask follow-up questions about the task.
   Wait silently for the user to either relaunch with the recommended profile or explicitly
   say "continue here." Any output after the callout block is a violation of triage mode.

Compare the **full profile** (model + effort + context) when deciding whether a switch is needed —
not just the model name. If the recommended class has a different effort or context than triage
(e.g. triage is `low`/`default` but Default development is `medium`/`default`), a switch is
still warranted even if the model name is the same. Only skip the switch recommendation if the
full profile is identical to triage.

After triage, if the user keeps working in the triage session on heavier work, the normal drift
banner below still applies.

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

**Ambiguity is also a drift signal.** If you cannot assess whether the task fits the launched
class without significant upfront investigation (e.g. parsing large external files, reconstructing
context from history, or the scope is genuinely unknown), treat that uncertainty itself as a
mismatch. Show the banner and suggest Triage or a heavier class rather than silently proceeding
on the assumption that it will turn out to be simple.

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
suggested class) and the kickoff message (launched label/model). Keep it to that block — no extra
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