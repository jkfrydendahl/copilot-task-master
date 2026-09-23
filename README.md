# copilot-task-master

A Windows/PowerShell launcher that starts the **GitHub Copilot CLI** inside one of
your project repositories with a consistent, shared set of workflow instructions injected.

It is a personal workflow harness — not application code. The "payload" is the shared rule set
in `AGENTS.md` and `.github/instructions/`, plus the reusable **skills** in `skills/`, all of
which get applied to whatever repo you launch into.

## What's here

| File | Purpose |
| ---- | ------- |
| `Start-CopilotWork.ps1` | Interactive picker: choose a repo **and a task class**, inject master instructions, sync shared skills + generated task-class agents, optionally open VS Code, then launch `copilot` with the right model/effort/context. |
| `scripts/workbench-setup.ps1` | Personal skills/agent setup and the launch-baseline kickoff message. Importing it performs no setup. |
| `scripts/workbench-session.ps1` | Session markers, shared usage-record formatting, completion logging and abandoned-session recovery. |
| `repos.json` | Registry of your working repos (`name`, `type`, `path`). |
| `task-profiles.json` | Maps each task class → `{ model, effort, context }`. The source of truth for model selection. |
| `usage-log.csv` | Silent session log: start/end time, duration, repo name+type (created on first run, git-ignored). |
| `AGENTS.md` | Baseline plan-first workflow rules. |
| `.github/instructions/*.instructions.md` | Scoped rules (model selection, planning, skills routing, code review, Git boundaries, D365 BC/CE). |
| `.github/config/review-models.md` | Models + `/review` command used for multi-model code review. |
| `skills/` | Reusable agent skills (slash commands) linked into `~/.copilot/skills` so they're available in every repo. |
| `LICENSE` | MIT. |

Workflow ownership is explicit: `AGENTS.md` provides the baseline workflow;
`10-model-selection.instructions.md` owns triage and drift detection;
`15-orchestrator-mode.instructions.md` owns task-level routing. The launcher supplies the
selected profile's baseline and points to the applicable rules rather than maintaining another
copy of those rules in its kickoff text.

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

`task-profiles.json` can be updated by the monthly workflow (see below), using quality evidence
for each candidate's actual configuration. All nine profiles automatically select the cheapest
qualified model-effort pair within fixed hard price ceilings and preauthorized effort ranges.
Context remains fixed. Family preferences are informational fallbacks, not restrictions on
benchmark winners.

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
route non-trivial work to the best `@agent-key` without restarting the session. The caller must
also pass `model`, `reasoning_effort` (when supported) and `context_tier` explicitly from the current
approved profile. Generated descriptions include those arguments, but Markdown does not enforce
execution effort/context, and inherited orchestrator settings are not a substitute. If the task
tool cannot express the required configuration, use the direct profile launcher instead. This is additive:
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
`/code-review`, `/create-release`, `/update-readme`, `/session-time-audit`.

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
Resumed launches log and display the existing session ID; each launch still records its own duration.

### Abandoned session recovery

If you close the terminal window mid-session the log row is never written. The launcher writes a
unique `usage-pending-*.json` marker before starting the CLI and removes it on clean exit. On the
**next launch**, leftover markers whose owning launcher process has ended are logged automatically
with `abandoned = True`. The owner is identified by both PID and process start time: parallel
live sessions are left alone, and PID reuse does not prevent recovery of an older session. Legacy markers without ownership
metadata, or markers whose ownership cannot be determined, are preserved with a warning for manual
recovery rather than guessed abandoned.

For token/cost details per session, use the in-session `/usage` command.

## Automated monthly task-profile review

The process is **refresh models locally using your own credentials, commit and push the
sanitized metadata, then run the remote review Action**. No Copilot account credentials
are required by or exported to the Action.

On your local machine, with Node.js 22.12+ and your CLI authenticated using your own account:

```powershell
npm ci
.\scripts\refresh-model-catalog.ps1
```

Review `data/model-discovery-snapshot.json`, commit and push that file using your normal Git
workflow, then run **Monthly task profile review** from GitHub Actions on the branch containing
the metadata. The refresh command does not stage, commit or push anything. It only exports
allowlisted model metadata, never credentials or account identity, and runs no inference.
A failed local refresh does not overwrite a previously valid snapshot.

The snapshot is valid for **7 days**, configured by `consensusPolicy.discoveryFreshnessDays`.
Missing, invalid, future-dated or expired metadata **freezes all profile changes, even with force**.
The Action can still refresh public pricing/benchmarks and publish an explanatory report.
Refresh and push metadata before a manual or scheduled review; the monthly schedule does not
renew this seven-day validity. Availability is explicitly **locally verified at the recorded time**,
not live-verified by the Action. Access changes after capture cannot be detected remotely.
Help-only entries remain CLI-catalog evidence, not proof of per-account entitlement; the
report distinguishes them from models listed by the authenticated runtime.

The [workflow](.github/workflows/monthly-task-profile-review.yml) runs the tests, consumes the
committed local snapshot, refreshes GitHub prices, and evaluates configuration-matched benchmarks.
It never runs account discovery or refreshes the input snapshot. It opens/updates the review PR with:

- `reports/task-profile-review.md`: current/recommended/applied configurations, confidence, exclusions, and price changes.
- `task-profiles.json`: model and effort changes applied together after confirmation, within approved ranges. Context remains fixed.
- `data/model-ranking-snapshot.json`: independent source observations and confirmation state.
- `data/model-pricing-snapshot.json`: independently verified rates and timestamps.
- `data/model-onboarding-snapshot.json`: runtime metadata, discovered candidates, catalog changes and unresolved identities.
- The capability, benchmark-alias and pricing-alias catalogs: verified onboarding additions and capability refreshes.

Review changes before merging. Run manually with `force_benchmark_consensus` to apply a qualified
recommendation on its first observation; this bypasses only the confirmation wait, never
availability, capability, pricing, hard spending ceilings, allowed effort ranges, or evidence requirements.

### Automatic model onboarding

The local refresh captures CLI-help discovery and authenticated `models.list` metadata from
the pinned official Copilot SDK using the user's own credentials. Before comparing profiles,
the remote review reconciles those recorded sources. Neither list is assumed exhaustive:
a model missing from one list is not automatically unavailable. Explicit runtime denials,
the denylist, duplicate identities and the virtual `auto` router are excluded.
Unverified hardcoded fallback IDs never become verified just because another model appears in the runtime.

New models need enabled runtime metadata with explicit supported efforts and tool support.
Vision remains unknown when not published. A default execution context is established by the
runtime's valid context limit; `long_context` additionally requires an explicitly advertised
tier or structured long-context billing metadata. A large context limit alone is not enough.
Capability timestamps use the original local observation time, not the Action's run time.
Repeated remote reviews cannot renew discovery or capability freshness. Missing context/vision
facts do not silently renew an older record.

The onboarding resolver adds exact runtime-display-name matches to GitHub pricing rows.
AA aliases require structured release identity and effort metadata; LiveBench aliases require
an exact model ID with an explicit effort suffix (or a native no-effort model). Cosmetic
punctuation normalization must resolve uniquely. Existing conflicting mappings are not overwritten.
AA onboarding proofs bind aliases to their published release identity and effort; a later
contradictory identity quarantines that mapping for selection without silently rewriting it.
Composite/fallback-served benchmarks, contradictory labels, ambiguous identities, missing
efforts and family-level guesses are not accepted. A benchmark or pricing listing alone is not
proof that a model is available in Copilot.

Verified facts are persisted and can enter comparison in the same run. Missing pricing,
capabilities or configuration-matched benchmark evidence still blocks the affected candidates.
Onboarding is not qualification: all existing profile budgets, bands, required dimensions,
recency rules and confirmation requirements remain in force. Reports show discovered,
partial, blocked and comparison-ready models; the onboarding snapshot retains unmapped
benchmark variants and exact catalog changes.

The Action's normal repository `GITHUB_TOKEN` is used for repository operations, not Copilot
account discovery. The separate `ARTIFICIAL_ANALYSIS_API_KEY` secret remains necessary for
AA API benchmarks. Local and remote invocations of `review-task-profiles.ps1` both consume
the committed discovery snapshot; only `refresh-model-catalog.ps1` authenticates locally.

### Pricing and eligibility

Every run fetches [GitHub's Copilot pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing),
not provider API prices. `config/model-pricing-aliases.json` maps exact published names to CLI IDs.
The parser stores default/long-context rates, thresholds, cached-input and cache-write rates.
Missing optional cache prices stay null, not zero. Malformed or ambiguous tables cannot replace
the last-known-good snapshot. Missing model rows retain their original verification dates;
unmapped names and failures appear in the report. Onboarding can add verified mappings;
conflicting existing mappings are never rewritten automatically.

Prices expire after 45 days, independently of the 60-day capability lifetime. A successful pricing
refresh never changes `config/model-capabilities.json` or its timestamps. Both freshness limits
are configured in `config/model-policy.json`. Missing/expired candidate prices block automatic changes.

Every profile has **hard input/output price ceilings**, configured in `profileRequirements`
with `costSensitive: true`. Both limits must be met in the applicable pricing tier:

| Profiles | Input / output USD per million tokens |
|---|---|
| Quick, Mechanical, Triage | $2 / $10 |
| Orchestrator | $3 / $15 |
| Default Development | $4 / $20 |
| Visual/UI | $5 / $25 |
| Review | $5 / $30 |
| Agentic Implementation | $10 / $50 |
| Deep Reasoning | $10 / $45 |

These are fixed standing authorization limits, not spending targets. They do not grow with the
incumbent's price or benchmark rank, and only an explicit policy edit changes them.

Cost comparisons use a configurable aggregate reference basket of 1M uncached input and 100K
output tokens across requests within the selected context tier. Reports express this as AI credits
(AIC), using GitHub's conversion of **1 AIC = $0.01**. The basket excludes caching and is **not**
a predicted task cost or a single oversized prompt. Actual consumption also depends on token use,
reasoning, retries and cache reuse; a cheaper basket does not guarantee a cheaper completed task.

Eligibility also requires unexpired locally verified availability, no denylist match, fresh capability
metadata, supported effort/context, and verified vision when required. `effortMode: unsupported`
uses explicitly mapped `none` evidence and preserves the launcher's omission of `--effort`.
Long-context pricing is used where published; otherwise an unbounded published default rate
applies. A default rate capped by an input-token threshold cannot price undocumented long-context
usage. Missing previously known tiers preserve the model's last-known-good rates and timestamp.
New models with unknown capabilities remain visibly unresolved rather than being guessed.

### Evidence and selection

`config/model-ranking-aliases.json` maps AA general-model and LiveBench model/effort pairs to explicit source IDs.
AA public components reuse those exact AA identities, but remain separate source observations.
Max/xhigh scores cannot stand in for high/medium/low. Onboarding adds verified new variants;
unresolved mappings still require investigation. Price refresh alone does not supply capability facts.

- [Artificial Analysis API](https://artificialanalysis.ai/api/v2/data/llms/models) supplies the Coding and Intelligence indices. [AA coding-agent harnesses](https://artificialanalysis.ai/agents/coding-agents) supply specialized Agentic evidence.
- AA public model pages supply workflow, instruction-following, long-document reasoning and visual-understanding components. One deterministically chosen known-model page supplies the bulk comparison records plus the current model; the adapter does not fetch every model separately or execute page scripts.
- [LiveBench](https://github.com/LiveBench/new-livebench/tree/main/public) supplies explicitly authorized fallback and supporting categories. Incomplete categories are unusable, rather than averages of whichever columns happen to exist. Cost-feed failure does not discard quality data.
- Single-source evidence is allowed with reduced confidence. AA and LiveBench raw scores are never averaged; disagreement from informational alternatives is disclosed, while explicitly required dimensions are binding.
- All eligible models compete; there is no orchestration shortlist. Family preferences from `config/model-policy.json` are informational fallback suggestions, never benchmark gates or automatic family upgrades.

`selectionPolicy.profiles` in `config/model-policy.json` sets the strategy for every profile:

| Profile | Primary deciding metric | Authorized primary fallbacks | Additional required dimensions |
|---|---|---|---|
| Quick | AA Coding | LiveBench Coding | None; narrow coding tasks |
| Default Development | AA Coding | LiveBench Coding | Instruction following |
| Agentic Implementation | AA Coding Agent Index | LiveBench Agentic Coding | None; the primary already measures end-to-end agentic coding |
| Deep Reasoning | AA Intelligence | LiveBench Reasoning | Long-document reasoning |
| Review | AA Coding | LiveBench Coding | Reasoning AND long-document reasoning |
| Visual/UI | AA Coding | LiveBench Coding | Visual understanding |
| Mechanical | AutomationBench-AA | EnterpriseOps-Gym-AA | Instruction following |
| Orchestrator | AutomationBench-AA | EnterpriseOps-Gym-AA | Long-document reasoning AND instruction following |
| Triage | AA Intelligence | LiveBench Reasoning | Instruction following |

All nine profiles use `value_balanced`: the cheapest eligible configuration within the deciding
metric's native score band **that also passes every required role dimension**. Each dimension
has ordered metric alternatives: reasoning uses AA Intelligence then LiveBench Reasoning;
instruction following uses LiveBench then AA IFBench for Orchestrator and Default Development,
and AA IFBench then LiveBench for Mechanical and Triage; long-document reasoning
uses AA-LCR; visual understanding uses MMMU Pro.

The September 2026 cross-profile coverage audit repaired explicit effort aliases and found larger
complete comparison groups with LiveBench instruction following for those two profiles.
Other source priorities were preserved; routes are not changed just to produce a desired winner.
More complete mappings can raise eligible reference scores and leave a previously qualifying
configuration outside a band. Sparse low-effort evidence remains an explicit limitation.

The first usable authorized route supplies each dimension's comparable pool, preferring fresh
over cached observations. Every pool requires at least **two distinct budget/capability-eligible
models**; multiple efforts of one model do not inflate coverage. Set each metric's quality
reference independently before intersecting the qualifying configurations. Every required band
must pass: an exceptional coding score cannot compensate for weak reasoning, and a low price
cannot compensate for missing visual evidence. No weighted average or cross-benchmark score
conversion is used. A candidate cannot choose a weaker route simply because it fails the first
usable one, and filtering candidates never lowers a reference score.

Only the surviving intersection enters cost selection. **One surviving configuration can win**
if each comparison had adequate coverage. Missing evidence excludes that candidate, not all its
qualified peers. If no candidate survives, or any dimension lacks comparable coverage, retain the
current configuration with an explicit reason. Retention does **not** certify the incumbent.
Force cannot relax these requirements. Sparse coverage can therefore pause automatic changes.

Quick's IF scores and Agentic's workflow scores remain explicitly supporting-only.
Supporting metrics never become hidden weights, vetoes or replacement routes. General coding
cannot authorize an Agentic or Mechanical workflow replacement, and general intelligence cannot rescue Orchestrator.
The policy's metric registry records units, ranges, benchmark lineage and limitations; overlapping
components are not independent corroboration of their aggregate.

These are external-harness proxies for local task performance, not guarantees:
[AutomationBench-AA](https://artificialanalysis.ai/evaluations/automationbench-aa) measures
guardrail-adjusted objective completion and prohibits clarifying questions.
[EnterpriseOps-Gym-AA](https://artificialanalysis.ai/evaluations/enterprise-ops-gym-aa) uses AA's
oracle-tool harness and strict pass@1; it does not test tool discovery or reproduce the original
paper's setup. [IFBench](https://artificialanalysis.ai/evaluations/ifbench) is single-turn;
[AA-LCR](https://artificialanalysis.ai/evaluations/artificial-analysis-long-context-reasoning)
measures long-document reasoning, not conversation memory. MMMU Pro measures visual understanding,
not UI implementation fidelity. Coding scores are a proxy for review quality.
BFCL is deferred; there is no family-score inheritance or personal-preference override.

#### Automatic configuration selection

Every profile uses `configurationSelection.mode: bounded_effort` and
`effortChangePolicy: automatic`. Its allowed effort range is standing authorization:

| Profiles | Allowed efforts |
|---|---|
| Quick, Mechanical, Triage | low |
| Orchestrator | high |
| Default Development, Review, Visual/UI | medium, high |
| Agentic Implementation, Deep Reasoning | high, xhigh, max |

Candidates are the intersection of that range and each model's supported efforts, at the
profile's fixed context.
Models without effort controls keep their one native configuration and exact `none` aliases.
Missing capability records and unmatched variants are reported, not guessed.

AA coding-agent variants are resolved automatically from structured page data rather than a
hand-maintained list of full leaderboard labels. The adapter retains source variant IDs, provider,
published model, harness/version and complete benchmark-component identities. Conservative
name-format rules match known CLI models; effort must be explicit unless the model has no effort
control. New labels or harness names do not require new aliases, but unknown models still need
verified availability, capabilities and pricing. Ambiguous identities or multiple variants for the
same model/effort, composite systems, incomplete coverage and incompatible benchmark suites are
reported rather than guessed. Legacy cached label-only agent records are not silently upgraded.

Every fallback replacement, including a fallback used by a required qualification dimension,
requires the incumbent's exact configuration in the same usable metric observation.
An established stronger primary or qualification basis cannot be downgraded through a weaker fallback,
even with force. Primary routes may replace an unscored incumbent; if no authorized route is usable,
the current assignment stays. The report distinguishes recommendations from permission to apply.
Incumbent provenance belongs to the actual model/effort/context, not to its family or profile name.
Manual configuration changes do not inherit another configuration's basis.

Orchestrator retains high-only effort and its $3 / $15 ceilings. Changing the deciding metric does
not establish reliable Copilot CLI delegation, constraint retention or supervision. All profiles
show required metrics, comparison coverage, reference scores, bands and per-candidate pass/fail
checks outside collapsed evidence details. Any remaining informational scores are labelled separately.

The framework compares **measured configurations**, not the maximum setting by definition:
an `xhigh` result can win even if the model supports an unmeasured `max` setting. Each configuration
passes its own eligibility gates, and corroboration must match the same model, effort and context.
Multiple efforts of one model do not count as independent model coverage.
[AA's methodology](https://artificialanalysis.ai/methodology/coding-agents-benchmarking#agent-settings)
describes agent variants and normally uses agent-default reasoning settings; it is not a universal
maximum-effort comparison. Scores remain external-harness evidence, not Copilot CLI measurements.

An effort change inside the allowed range requires no separate approval. The same confirmation
rules apply to model replacements, effort-only changes, and changes to both: the complete
configuration must qualify twice on distinct decision-evidence observations, or once on a forced run.
The model and effective effort are applied together; confirmation cannot be borrowed from a
different effort of the same model. Native no-effort models retain the stored launcher effort
preference, but it is not passed to the model or used as its benchmark identity.

An effort change can alter token consumption and latency without changing the per-token rate.
Reference AIC therefore remains a fixed-basket comparison, never an estimate that two effort
settings cost the same per task. Effort-related task cost and latency are reported as unknown.
Token-price ceilings and reference AIC do not impose a total task or session spending cap.

Each value profile has explicit `qualityBands` keyed by `source.metric`, for example
`artificialAnalysisComponents.automationBench` and `artificialAnalysisComponents.enterpriseOpsGym` for Orchestrator.
The initial tolerances are **0.03** for the 0-1 AA coding-agent index and **3 absolute score points**
for each applicable AA general-model and LiveBench metric. Orchestrator's workflow metrics allow
an absolute **0.03** gap; Mechanical retains **zero** workflow tolerance.
These are configurable starting policy
choices, not percentages of capability, absolute competence floors, or empirically established
task-success thresholds. Bands are not transferred
between sources or averaged. Every possible deciding-source metric needs its own band; zero
permits only the top score.

`qualification.dimensions` defines additional binding checks with their own ordered
`evidenceRoutes` and `qualityBands`. Their tolerances are **3 absolute points** for
0-100 metrics, **0.05** for AA-LCR long-document reasoning (Orchestrator, Review and Deep Reasoning),
and **0.03** for the other 0-1 qualification metrics. These are explicit policy choices, not a claim that
different benchmarks measure equivalent capability or have comparable statistical uncertainty.
Budgets are unchanged. `qualification.minimumModels` sets the distinct-model
coverage requirement (initially two) for every primary and additional comparison.

For value profiles, `costTieBreak: newest_verified_release` prefers the **newest verified model
release day among equal-reference-cost, fully qualified candidates**, even if their scores differ
inside the allowed bands. AA's explicit release metadata is reconciled across exact configured
model aliases, independently of the deciding benchmark. Effort settings of the same model are
not different releases. Missing, invalid, future, conflicting or stale release metadata for any
tied model disables recency for the entire tie; unknown dates are never ranked as oldest.
When recency is unavailable, or release days are equal, prefer the exact qualified incumbent
configuration, then primary score, model ID, effort and context. Reports disclose the dates,
provenance and fallback. Legacy snapshots without release metadata use this explicit fallback.
Release facts are not benchmark publication dates, and metadata changes cannot supply a new
confirmation observation; corrected tie facts reset the pending decision's identity.
Hard-budget exclusions apply before setting
the band's reference score. LiveBench corroboration uses its own band for value profiles rather
than requiring the cheaper candidate to be its exact quality leader.

The fixed ceilings replace the former incumbent-relative `maxAutomaticCostIncreasePercent`
limit. A more-expensive qualified configuration, including a free-to-paid transition, can apply
inside those ceilings. There is no separate premium veto and no automatic increase of the ceilings.
An over-budget model is excluded before establishing the eligible quality reference, so adding it
cannot raise the quality bar for affordable candidates.

On a primary route, an incumbent without a matched score does not freeze an otherwise authorized
candidate. Fallbacks require the comparison and stronger-basis protection described above.
Missing incumbent pricing is still not a veto.
The candidate still needs its own eligible configuration, fresh pricing,
matched evidence and confirmation. Reports disclose missing incumbent evidence rather than
claiming a measured quality improvement. Missing incumbent prices leave savings and percentage
cost changes unknown; a free-to-paid percentage is also undefined. Matched comparisons use the
same source, metric, observation and complete configuration, including native `none` mappings.

Retrieval age and publication age are distinct: retrieval must be within 45 days and a known
publication date within 90 days. Unknown publication dates remain unknown and reduce confidence.
Metric-scoped fingerprints identify score observations, not publisher methodology-version IDs;
agent fingerprints also include variant, harness/version and benchmark-component identities. AA API scores are
not substituted with numbers from its public pages. Benchmarks do not prove performance at the
profile's requested context length or in the Copilot CLI harness. LLM Stats is not currently an input.
Fresh sources take priority over cached sources, subject to the incumbent comparison and
stronger-basis guards.
If only cached evidence remains, it may inform the recommendation but cannot authorize a change.
LiveBench's dated filename is a **suite label**, not the latest results-publication date.
The last artifact update is recorded separately; it does not refresh every row's unknown
evaluation age. Model release dates and retrieval times are never substituted for score dates.

### Confirmation, retention and reporting

Two distinct observations of the **complete binding evidence** confirm a change to the same model,
effective effort and context. Repeated content,
older publications, cached observations, or unrelated source failures do not advance confirmation.
Changes to a selected required metric can advance confirmation; supporting-only scores or unrelated
page changes cannot. All selected required metrics must be fresh to authorize a change.
Publication rollback checks cover every selected binding metric, including observations where
no candidate qualifies. Failed qualification clears the pending candidate.
Changing a selected metric, route, known methodology or harness identity resets pending confirmation. Policy, effort/context and alias
fingerprints prevent old evidence from authorizing a new configuration.
Strategy, band, ceiling or allowed-range changes also invalidate pending confirmation. Force
bypasses only the wait, not value qualification, hard budgets, allowed ranges or the candidate's
availability, capabilities, pricing and evidence requirements. No threshold change directly
rewrites the current model.

Policy schema 4 defines binding role contracts; ranking snapshot schema 4 stores the separated sources.
Confirmation state schema 4 includes complete decision-evidence identities and the incumbent's
primary and required-dimension routes.
Migration invalidates incompatible pending counts while retaining current assignments,
trustworthy provenance, compatible caches and publication rollback history. Unknown historical
basis remains unknown rather than being inferred from the new policy.
Legacy specialized AA-agent activations retain their unambiguous metric basis; a general
AA activation alone cannot establish which historical index was used.
The broad policy fingerprint can also reset other profiles' pending counts when policy changes.
If evidence is insufficient, the report says **retained**, not **winner**. If no replacement qualifies,
even an over-budget incumbent is retained with an explicit warning rather than writing an empty
model ID. Automatic changes remain frozen when availability cannot be verified.

The report separates quality leader, recommended candidate, pending change, and configuration actually
applied, showing model / effective effort / context. Value profiles also show their eligible
quality reference, score gap/band, candidate and
incumbent reference AIC, informational percentage cost change, fixed authorization limits, allowed
efforts and any incumbent evidence or pricing gaps.
Repeated exclusions and variant gaps are grouped by configuration with all affected profiles.
Expandable sections retain the complete
per-profile eligibility and benchmark evidence.
Fresh capability metadata and valid mappings still require maintenance.

The implementation uses focused modules under `scripts/`:

| Module | Responsibility |
|---|---|
| `model-data-common.ps1` | Fetch results, JSON/member access, content fingerprints, freshness and atomic JSON writes; no provider imports. |
| `model-artificial-analysis.ps1`, `model-livebench.ps1` | Provider-specific acquisition and parsing. |
| `model-aa-component-data.ps1` | Pure, non-executing AA public-component normalization and validation. |
| `model-aa-components.ps1` | Bulk public-component acquisition, separate from API aggregates and pricing. |
| `model-role-evidence.ps1` | Pure profile-contract qualification and comparable metric pools. |
| `refresh-model-catalog.ps1`, `get-runtime-models.mjs` | Local-only authenticated discovery using the user's own credentials; sanitized metadata export. |
| `model-discovery-snapshot.ps1`, `model-onboarding.ps1` | Seven-day snapshot validation, conservative catalog reconciliation and explicit onboarding audit without remote authentication. |
| `model-release-data.ps1` | Verified release-date reconciliation and equal-cost recency decisions, independent of benchmark observations. |
| `model-pricing-data.ps1` | GitHub pricing acquisition and last-known-good rates. |
| `model-configuration.ps1` | Shared candidate generation, effective-effort normalization and model/effort/context identities. |
| `model-benchmark-evidence.ps1`, `model-admissibility.ps1` | Configuration-matched evidence and independent eligibility gates. |
| `model-profile-selection.ps1` | Pure selection and confirmation-state transitions. |
| `model-value-selection.ps1` | Reference costs and cheapest-qualified ranking within native metric bands. |
| `model-review-report.ps1` | Decision summary, grouped coverage and expandable audit detail. |
| `review-task-profiles.ps1` | End-to-end orchestration. |

The former combined ranking module and its legacy snapshot/bucket pipeline have been removed.
Configuration and pricing can load without importing benchmark providers. Run:

```powershell
.\scripts\test-all.ps1
.\scripts\review-task-profiles.ps1
```

The live review needs `ARTIFICIAL_ANALYSIS_API_KEY` (configured as an action secret) for AA's API;
without it the failure is reported and independently usable sources remain available. The local
review writes snapshots/report and can update profiles after confirmation; it performs no Git operations.

## Notes / limitations

- Windows-only and single-user by design (hardcoded drive paths, PowerShell).
- The launcher starts an **interactive** Copilot session; it does not yet dispatch a
  predefined task/prompt non-interactively.
