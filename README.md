# copilot-task-master

A small Windows/PowerShell launcher that starts the **GitHub Copilot CLI** inside one of
your project repositories with a consistent, shared set of workflow instructions injected.

It is a personal workflow harness — not application code. The "payload" is the shared rule set
in `AGENTS.md` and `.github/instructions/`, plus the reusable **skills** in `skills/`, all of
which get applied to whatever repo you launch into.

## What's here

| File | Purpose |
| ---- | ------- |
| `Start-CopilotWork.ps1` | Interactive picker: choose a repo **and a task class**, inject master instructions, sync shared skills + generated task-class agents, optionally open VS Code, then launch `copilot` with the right model/effort/context. |
| `repos.json` | Registry of your working repos (`name`, `type`, `path`). |
| `task-profiles.json` | Maps each task class → `{ model, effort, context }`. The source of truth for model selection. |
| `usage-log.csv` | Silent session log: start/end time, duration, repo name+type (created on first run, git-ignored). |
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

2. Add a PowerShell alias so you can launch from any terminal (one-time setup):

   Open your PowerShell profile (`$PROFILE`) and add:

   ```powershell
   function copilot-work { & "C:\Dev\00_MyStuff\copilot-task-master\Start-CopilotWork.ps1" @args }
   ```

   Then reload: `. $PROFILE`

3. Run the launcher from any terminal:

   ```powershell
   copilot-work
   ```

   Or directly from the repo:

   ```powershell
   .\Start-CopilotWork.ps1
   ```

3. Pick a numbered repo or `C` for a custom path, then pick a **task class**. The script will:
   - Set `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` to this folder so the master rules travel with you.
   - Sync shared **skills** (`~/.copilot/skills` junction) and generate task-class custom agents in `~/.copilot/agents` from `task-profiles.json` (except `triage`/`orchestrator`).
   - `cd` into the target repo.
   - Sends a **kickoff message** into the session with the task class, model, effort, context, and class definition — so the agent knows its baseline from turn 0 without reading env vars.
   - Launches `copilot --model <m> --effort <e> --context <c> --interactive "<kickoff>"` (errors out clearly if the CLI isn't installed).

## Startup flow

What happens, end to end, each time you launch:

1. **Run `Start-CopilotWork.ps1`** in a terminal.
2. **Loads + validates** `repos.json` and `task-profiles.json`.
3. **Prompts: "Select repo"** — a numbered list from `repos.json`, or `C` for a custom path.
4. **Validates** the path exists, sets `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` to this folder, syncs skills, regenerates task-class custom agents, and `cd`s into the repo.
5. **Prompts: "Select task class"** — this is where the **model / effort / context** are decided (from the matching profile).
6. **Validates** the profile's model against the live CLI list, and shows the new-model nudge if any.
7. **Sends a kickoff message** into the session with the task class key, label, model, effort, context, and class definition embedded as text — so the agent has a hard baseline in conversation history from turn 0. For triage, also triggers the inline estimation.
8. **Prompts: "Open VS Code? y/n"** — optional source-control review.
9. **Checks** `copilot` is on PATH, then **launches** `copilot --model … --effort … --context …` inside the repo.
10. **On exit:** silently appends a row to `usage-log.csv`.

So the order is: **script → pick repo → pick task class (model) → optional VS Code → Copilot launches**.

### Working in multiple repos at once

Each launch is a fully independent Copilot process with its own repo and its own task
class/model. To work in several repos simultaneously, just run `Start-CopilotWork.ps1` again
in **another terminal window** — e.g. a *Quick* haiku session in one repo and a *Deep
reasoning* opus session in another, side by side, each logged separately.

## Model selection (the point of this repo)

Model choice is decided **at launch** by default — not by asking the running model to
recommend a switch (it can't switch itself). The three levers the Copilot CLI exposes are set
from the chosen task class:

- `--model` — e.g. `claude-sonnet-4.6`, `claude-opus-4.8`, `gpt-5.4-mini`
- `--effort` — `none|low|medium|high|xhigh|max`
- `--context` — `default|long_context`

Edit `task-profiles.json` to tune which model/effort/context each task class uses. The launcher
discovers the **current valid model list from the CLI itself** (`copilot help config`) and warns
if a profile references an unknown model, so the config can't silently go stale. To change models
for a single session instead, use the in-session `/model` command.

`task-profiles.json` is auto-updated by the monthly workflow (see below) — version bumps within
a model family are applied automatically. What the workflow does **not** auto-update are the
family-to-task-class assignments (e.g. "deep-reasoning uses opus-family") — those are deliberate,
manual decisions that require human judgment against the model comparison page.

When tuning profiles, consult the
[model comparison page](https://docs.github.com/en/copilot/reference/ai-models/model-comparison)
rather than guessing.

### Orchestrator mode (route per task without relaunch)

If your work is mixed/evolving and you want one session to pick the right model *per request*,
launch **Orchestrator (route per task)**. On each run, the launcher generates per-class custom
agents in `~/.copilot/agents` from `task-profiles.json`:

- `quick.agent.md`
- `default-development.agent.md`
- `agentic-implementation.agent.md`
- `deep-reasoning.agent.md`
- `review.agent.md`
- `visual-ui.agent.md`
- `mechanical.agent.md`

These agent profiles pin the class model in frontmatter (`model: ...`), so the orchestrator can
route non-trivial work to the best `@agent-key` without restarting the session. This is additive:
for long, interactive single-class work, the normal per-process launch class still gives the
cleanest workflow.

> Cost note: routing/delegation can improve quality and context isolation, but can also increase
> total AI-credit usage (more independent LLM round-trips). It's not automatically cheaper.

### Drift detection within a session

The launcher sends a kickoff message embedding the chosen task class and its definition into
the conversation. On every turn the agent compares the actual work against that baseline. If
the work drifts into a **different** class, the agent shows a high-visibility **⚠️ TASK-CLASS
MISMATCH** banner at the top of its response, telling you which class/model to switch to and
how (`Start-CopilotWork.ps1` relaunch or in-session `/model`).
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

### Not sure how heavy it is? Triage mode

If you can't tell up front whether a task is light or heavy, pick the **Triage (not sure —
estimate first)** class. It launches a cheap Sonnet/low session whose first action is to perform
an **inline task estimate** — scoring size, uncertainty, and complexity — then recommend the
right class with the exact model/effort/context to switch to. After showing the estimate it
**stops and waits**: relaunch via the harness with the recommended class, or tell it to continue
in-session. This turns "I don't know which model" into a cheap, one-question step instead of a
guess.

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

## Usage log

The launcher silently appends one row to `usage-log.csv` after every session:
`session_id`, `timestamp_start`, `timestamp_end`, `duration_min`, `repo_name`, `repo_type`, `task_class`, `task_label`, `abandoned`.

Duration is capped at 10 hours to prevent forgotten open sessions from skewing totals.
Both `usage-log.csv` and the transient `usage-pending-*.json` markers are git-ignored (personal data, high churn).

### Session resume

Each session gets a UUID printed at exit: `Session ended. Duration: 26.3 min in Guldager. (ID: 0cb916db)`.
For triage sessions, the full UUID is also printed in cyan so you can copy it into the next launch.
At the start of every launch, the launcher asks `Resume a previous session?` — paste the ID to
continue with full conversation context in the new profile. This is especially useful after triage:
relaunch with the recommended class and resume the triage session to keep all the analysis.

### Abandoned session recovery

If you close the terminal window mid-session the log row is never written. The launcher writes a
`usage-pending-*.json` marker before starting the CLI and removes it on clean exit. On the **next
launch**, any leftover markers are detected and logged automatically with `abandoned = True`.

For token/cost details per session, use the in-session `/usage` command.

## Automated monthly task-profile review

A scheduled GitHub Actions workflow (`.github/workflows/monthly-task-profile-review.yml`) runs on
the 1st of each month and opens/updates a PR with:

- `reports/task-profile-review.md` (summary + applied/suggested changes)
- `task-profiles.json` updated directly in the PR (when suggestions apply)

The workflow selects models using **family-pattern matching** — each task class maps to an ordered
list of model families (e.g. `deep-reasoning` → opus-family, then gpt-flagship-family). Within a
family, the newest available version wins automatically. A `$ModelDenylist` in the script lets you
exclude models that appear in the CLI list but aren't yet usable (e.g. pulled-back previews).

Changes are applied directly in the PR branch. You still approve/reject at merge time.

- Human review is expected before merge, using:
  https://docs.github.com/en/copilot/reference/ai-models/model-comparison
- To block a specific model, add it to `$script:ModelDenylist` in `scripts/review-task-profiles.ps1`.
- To change which family a task class prefers, edit `$classPreferences` in the same script.

## Notes / limitations

- Windows-only and single-user by design (hardcoded drive paths, PowerShell).
- The launcher starts an **interactive** Copilot session; it does not yet dispatch a
  predefined task/prompt non-interactively.
