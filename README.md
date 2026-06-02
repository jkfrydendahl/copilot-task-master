# copilot-task-master

A small Windows/PowerShell launcher that starts the **GitHub Copilot CLI** inside one of
your project repositories with a consistent, shared set of workflow instructions injected.

It is a personal workflow harness — not application code. The "payload" is the shared rule set
in `AGENTS.md` and `.github/instructions/`, plus the reusable **skills** in `skills/`, all of
which get applied to whatever repo you launch into.

## What's here

| File | Purpose |
| ---- | ------- |
| `Start-CopilotWork.ps1` | Interactive picker: choose a repo **and a task class**, inject master instructions, optionally open VS Code, then launch `copilot` with the right model/effort/context. |
| `repos.json` | Registry of your working repos (`name`, `type`, `path`). |
| `task-profiles.json` | Maps each task class → `{ model, effort, context }`. The source of truth for model selection. |
| `usage-log.csv` | Local, git-ignored cost-audit log appended after each session (created on first run). |
| `AGENTS.md` | Baseline plan-first workflow rules. |
| `.github/instructions/*.instructions.md` | Scoped rules (model selection, planning, skills routing, code review, Git boundaries, D365 BC/CE). |
| `.github/config/review-models.md` | Models + `/review` command used for multi-model code review. |
| `skills/` | Reusable agent skills (slash commands) linked into `~/.copilot/skills` so they're available in every repo. |
| `LICENSE` | MIT. |

## Usage

1. Edit `repos.json` so the `path` values point at real local repositories:

   ```json
   [
     { "name": "Customer A - BC Extension", "type": "Business Central / AL", "path": "C:\\Work\\Repos\\customer-a-bc" }
   ]
   ```

2. Run the launcher:

   ```powershell
   .\Start-CopilotWork.ps1
   ```

3. Pick a numbered repo or `C` for a custom path, then pick a **task class**. The script will:
   - Set `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` to this folder so the master rules travel with you.
   - `cd` into the target repo.
   - Look up the task class in `task-profiles.json` and **validate the model** against the CLI's current list.
   - Optionally open VS Code for source-control review (skipped if `code` isn't on PATH).
   - Launch `copilot --model <m> --effort <e> --context <c>` (errors out clearly if the CLI isn't installed).

## Startup flow

What happens, end to end, each time you launch:

1. **Run `Start-CopilotWork.ps1`** in a terminal.
2. **Loads + validates** `repos.json` and `task-profiles.json`.
3. **Prompts: "Select repo"** — a numbered list from `repos.json`, or `C` for a custom path.
4. **Validates** the path exists, sets `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` to this folder, and `cd`s into the repo.
5. **Prompts: "Select task class"** — this is where the **model / effort / context** are decided (from the matching profile).
6. **Validates** the profile's model against the live CLI list, and shows the new-model nudge if any.
7. **Exports** `COPILOT_TASK_*` env vars (so the drift banner knows the launched class).
8. **Prompts: "Open VS Code? y/n"** — optional source-control review.
9. **Checks** `copilot` is on PATH, then **launches** `copilot --model … --effort … --context …` inside the repo.
10. **On exit:** appends a row to `usage-log.csv` and prints the running cost mix.

So the order is: **script → pick repo → pick task class (model) → optional VS Code → Copilot launches**.

### Working in multiple repos at once

Each launch is a fully independent Copilot process with its own repo and its own task
class/model. To work in several repos simultaneously, just run `Start-CopilotWork.ps1` again
in **another terminal window** — e.g. a *Quick* haiku session in one repo and a *Deep
reasoning* opus session in another, side by side, each logged separately.

## Model selection (the point of this repo)

Model choice is decided **at launch**, deterministically — not by asking the running model to
recommend a switch (it can't switch itself). The three levers the Copilot CLI exposes are set
from the chosen task class:

- `--model` — e.g. `claude-sonnet-4.6`, `claude-opus-4.8`, `gpt-5.4-mini`
- `--effort` — `none|low|medium|high|xhigh|max`
- `--context` — `default|long_context`

Edit `task-profiles.json` to tune which model/effort/context each task class uses. The launcher
discovers the **current valid model list from the CLI itself** (`copilot help config`) and warns
if a profile references an unknown model, so the config can't silently go stale. To change models
for a single session instead, use the in-session `/model` command.

`task-profiles.json` is **not** auto-updated from the GitHub docs — it's a deliberate, manual
config (scraping the human-facing comparison page would be brittle, and "best model" depends on
your plan). Instead the launcher keeps you informed: it caches the model list it has seen
(`.known-models.json`, git-ignored) and, when the CLI starts offering a **new** model you don't
use in any profile, prints a one-time nudge pointing you to the docs to decide. It never edits
your config for you.

When tuning profiles, consult the
[model comparison page](https://docs.github.com/en/copilot/reference/ai-models/model-comparison)
rather than guessing.

### Drift detection within a session

The launcher exports the chosen task class to the session (`COPILOT_TASK_CLASS` and related
vars). If the work drifts into a **different** class than you launched as, the agent shows a
high-visibility **⚠️ TASK-CLASS MISMATCH** banner at the top of its response, telling you which
class/model to switch to and how (`Start-CopilotWork.ps1` relaunch or in-session `/model`).
This works **both ways**: it flags *under-powered* sessions (a *Quick* launch that became an
architecture change — switch up for quality) **and** *over-powered* ones (a *Deep reasoning*
launch now doing a one-line rename — switch down to stop paying opus rates every turn). It does
not switch automatically; you stay in control, but the prompt to reconsider is loud and
unmissable. See `.github/instructions/10-model-selection.instructions.md` for the exact rule.

## Instruction precedence

Two layers of instructions can be active at once:

1. **Master (baseline)** — this repo's `AGENTS.md` and `.github/instructions/`, injected via
   `COPILOT_CUSTOM_INSTRUCTIONS_DIRS`.
2. **Target repo** — any `AGENTS.md` / `.github` instructions inside the repo you launch into.

Treat the **master rules as the baseline** and the **target repo's rules as overrides**: when
guidance conflicts, the target repo wins because it has project-specific context. Keep the
master rules general (workflow discipline, Git boundaries, model selection) and leave
project-specific detail to each repo.

## Shared skills (slash commands)

The `skills/` folder holds reusable [agent skills](https://docs.github.com/en/copilot/concepts/agents/about-agent-skills)
— `/grill-me`, `/refine-requirements`, `/estimate-task`, `/tdd-implement`, `/reference-lookup`,
`/code-review`, `/create-release`, `/update-readme`.

The Copilot CLI loads **personal skills** from `~/.copilot/skills` in *every* repo. To keep this
folder the single source of truth (no per-repo copies), the launcher creates a Windows
**directory junction** `~/.copilot/skills` → `<this-folder>/skills` and self-heals it on each
run (`Sync-PersonalSkills`). So the skills live and are version-controlled here, but are active
everywhere automatically.

- If `~/.copilot/skills` already exists as a **real directory** (your own skills), the launcher
  leaves it untouched rather than clobbering it, and prints a notice.
- Because the junction makes skills active in **every** session, a broken skill affects all
  repos — edit them deliberately.
- When to reach for which skill is described in
  `.github/instructions/45-skills-and-review.instructions.md`.

## Requirements

- Windows + PowerShell
- [GitHub Copilot CLI](https://github.com/github/copilot-cli) (`copilot` on PATH)
- VS Code (`code` on PATH) — optional, only for the source-control review step

## Verifying the savings (usage log)

Because "more cost-effective" should be measurable, the launcher appends one row to
`usage-log.csv` after every session and prints a running mix by task class, e.g.:

```
Session mix so far (count | total min) by task class:
  Quick                     8 |   31 min
  Default development       5 |  120 min
  Deep reasoning            1 |   55 min
```

Each row records start/end time, wall-clock duration, repo, task class, and the
model/effort/context used. The file is git-ignored (personal data, high churn).

**Caveat:** duration is a wall-clock **proxy**, not token spend — it shows whether your
launches skew toward expensive classes, not exact cost. For real per-session token/cost
figures use the in-session `/usage` command. If the mix shows lots of long Deep-reasoning or
few Quick sessions, that's your signal to launch lighter or tune `task-profiles.json`.

## Notes / limitations

- Windows-only and single-user by design (hardcoded drive paths, PowerShell).
- The launcher starts an **interactive** Copilot session; it does not yet dispatch a
  predefined task/prompt non-interactively.
