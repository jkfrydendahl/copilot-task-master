# Public benchmark source coverage audit (partial)

**Decision: no new source is ready for admission from the evidence verified in this audit.** This is not a finding that all public benchmarks lack useful evidence. Several releases, result cohorts and execution configurations remain unverified.

The audit uses published documentation and results only. No candidate benchmark runs, local or central task evaluations, account discovery, dependency installation, profile changes, policy changes or catalog changes were performed.

- Baseline commit: `3e3a2a7ac69ab837046565c8be9d48dd0a455a48`.
- Existing-policy calculation: **2026-11-03T08:23:05.170Z**, selection-policy version **15**.
- Public artifacts captured: **2026-11-03**, at the UTC times in the artifact index.
- Coverage: selected official instruction-following, tool-use, workflow, coding and long-document sources. Investigation stopped before every historical release and result configuration was examined.

## Existing coverage and actual blockers

The baseline was recomputed offline with the repository's existing pure onboarding, admissibility, evidence, qualification, selection and confirmation helpers. It uses the committed discovery, capability, alias, pricing and benchmark snapshots; no sources or prices were refreshed. Input hashes were checked before and after computation.

Recorded discovery was valid at the pinned calculation time. This is not a live account-entitlement or runtime-execution check. "Qualified" below means satisfying existing policy bands and comparison requirements, not proven task performance.

| Profile | Eligible models | Eligible configurations | Fully qualified configurations | Remaining issue |
|---|---:|---:|---:|---|
| Orchestrator | 15 | 25 | 1 | Current recommendation already rankable |
| Quick | 13 | 13 | 1 | Fallback lacks comparable incumbent evidence |
| Default Development | 17 | 31 | 0 | Empty intersection of primary and instruction-following bands |
| Agentic Implementation | 21 | 44 | 1 | Stronger incumbent evidence basis retained |
| Deep Reasoning | 16 | 35 | 2 | Current recommendation already rankable |
| Review | 19 | 35 | 0 | No usable comparison on the required LiveBench reasoning route |
| Visual/UI | 17 | 31 | 1 | Fallback lacks comparable incumbent evidence |
| Mechanical | 13 | 13 | 0 | Insufficient low/native-no-effort instruction-following comparison |
| Triage | 13 | 13 | 0 | Insufficient low/native-no-effort instruction-following comparison |

The union contains **21 eligible models**, not just the nine incumbent assignments:

`claude-haiku-4.5`, `claude-haiku-5.5`, `claude-opus-4.8`, `claude-opus-4.8-fast`, `claude-opus-5`, `claude-opus-5.5`, `claude-sonnet-5`, `claude-sonnet-5.5`, `gemini-3.8-flash`, `gemini-4-argon`, `gpt-5.3-codex`, `gpt-5.6-luna`, `gpt-5.6-sol`, `gpt-5.6-terra`, `gpt-6-astra`, `gpt-6-luna`, `gpt-6-sol`, `gpt-6.1-sol`, `grok-4.5`, `grok-4.6`, `mai-code-1.1-flash`.

Exact measurement targets for configurations that pass their other currently measured bands:

| Profile | Configuration | Missing measurement |
|---|---|---|
| Default Development | `gpt-6.1-sol / high` | Instruction following |
| Default Development | `gpt-5.6-sol / medium` or `/ high` | Primary coding/intelligence |
| Review | `gpt-6.1-sol / high` | Reasoning |
| Mechanical | `gpt-6-sol / low` | Instruction following |
| Triage | `gpt-6.1-sol / low` | Instruction following |

These are targets, not guaranteed remedies: new scores can change reference scores, bands and the qualifying intersection.

Default Development has a primary AA-intelligence pool of **3 models / 6 configurations** and an IFBench pool of **3 models / 5 configurations**, but no qualifying intersection. Review cannot count AA intelligence both as its primary metric and as independent reasoning evidence.

Mechanical and Triage each have one raw eligible IFBench record, `claude-haiku-4.5 / none`; the current route cannot form its required two-distinct-model comparison. Their eligible LiveBench instruction-following pool is empty. A second compatible model measurement **within that IFBench cohort** could make a comparison possible. An alternative IFEval route would instead need its own two-model cohort; scores from different benchmarks must not be pooled to manufacture coverage.

Baseline evidence: `config\model-policy.json`, `data\model-ranking-snapshot.json` and the calculation inputs below. The recomputation reproduces the nine outcome categories in `reports\task-profile-review.md`.

## Reviewed public evidence

Model-name overlap, matching execution configuration, comparable coverage and policy qualification are separate questions. No new metric has an approved route or score band in this audit.

| Source/cohort inspected | Verified observation | Admission disposition |
|---|---|---|
| IFBench maintainer materials | Dataset, verifier/evaluation code and paper references; no additional current-configuration score table verified | Hold: result coverage not established |
| HELM IFEval releases `v1.15.0` and `v1.14.0` | One eligible model identity in the inspected releases: Haiku 4.5. Reasoning effort is not published in its run specification | Hold: no demonstrated two-eligible-model, exact-configuration comparison |
| BFCL score snapshot `2025-11-03` | 111 rows; Haiku 4.5 has distinct native-FC and Prompt results. This is a historical snapshot, not an audit of all current scores | Hold: old snapshot, unknown effort and unverified evaluator-commit binding |
| tau-bench `text-v1` documentation and Banking page | Maintainers state that the 2.0 text leaderboard tab is not yet available. Banking has other eligible model names, but domain/configuration eligibility is unresolved | Hold: requested standard-text result cohort not verified; legacy text results remain unchecked |
| SWE-bench captured mini-SWE-agent rows | Haiku 4.5 appears on Verified at explicit `high` and on Multilingual with unlabeled effort | Hold: no demonstrated two-model, exact-configuration comparison |
| LongBench v2 inspected table/README | Older displayed models and CoT/no-CoT settings; no usable current-configuration overlap established | Hold: complete row coverage and execution-effort matching remain unverified |

### Instruction following: IFBench and HELM

[IFBench's maintainer README](https://github.com/allenai/IFBench) describes **Generalizing Verifiable Instruction Following**, its datasets and evaluation code. It also acknowledges and extends Google IFEval. It explicitly says the paper reports prompt-level loose accuracy. This audit did not verify a new usable model-results table or fully audit the paper's model comparisons; it does **not** claim that the maintainers publish no scores anywhere.

[HELM's published run artifacts](https://storage.googleapis.com/crfm-helm-public/capabilities/benchmark_output/runs/v1.15.0/ifeval:model=anthropic_claude-haiku-4-5-20251001/stats.json) give Haiku 4.5 an `ifeval_strict_accuracy` mean of **0.8012939001848433 (80.13%)**. Its [run specification](https://storage.googleapis.com/crfm-helm-public/capabilities/benchmark_output/runs/v1.15.0/ifeval:model=anthropic_claude-haiku-4-5-20251001/run_spec.json) records deployment `anthropic/claude-haiku-4-5-20251001`, temperature `0.0`, one trial and a `14096` output-token limit, but no reasoning-effort or thinking-budget field. Unknown effort is not automatically `none`.

The inspected `v1.15.0` IFEval results also include Gemini 3 Pro Preview and GPT-5.1, neither in the baseline eligible pool. An adjacent release was inspected, but **earlier releases remain unchecked**. Absence in these two releases is not absence from HELM generally. The downloaded current scenario file and the score's run specification do not establish the exact deployed evaluator/client revision.

HELM is a Stanford CRFM publication; IFBench is published by Ai2. Different publishers do not guarantee independent evidence. IFBench's stated IFEval ancestry and any overlap with the existing instruction-following inputs must be accounted for before granting corroboration credit. Strict IFEval accuracy is not interchangeable with loose IFBench accuracy.

### Tool use: BFCL

The [captured BFCL CSV](https://raw.githubusercontent.com/HuanzhiMao/BFCL-Result/main/2025-11-03/score/data_overall.csv) contains 111 ranked rows. For Haiku 4.5, overall accuracy is **61.79% in native FC mode** and **26.24% in Prompt mode**. The CSV lacks a reasoning-effort field. These are two modes of one model, not two comparison models.

The [Berkeley-hosted methodology](https://gorilla.cs.berkeley.edu/leaderboard.html) concerns function/tool-call accuracy. It must not be relabeled as instruction following or successful software orchestration. The chosen snapshot is dated **2025-11-03**; downloading it in 2026 does not renew the age of its measurements. Its exact evaluator-commit binding and fresher result cohorts remain unverified. The figures are historical metadata, not candidates for automatic activation.

### Workflows: tau-bench

[The maintainer submission guide](https://github.com/sierra-research/tau2-bench/blob/main/docs/leaderboard-submission.md) explicitly states, "The leaderboard has no 2.0 text tab yet." This concerns **2.0 `text-v1`**, not all public tau-bench text results. The legacy tau2 text tab was not successfully retrieved and remains unverified.

The captured [Banking leaderboard](https://taubench.com/leaderboard) includes names corresponding to **GPT-5.6-sol, Grok 4.5 and Claude Opus 5**. Therefore Haiku is **not** the only eligible model name found across all investigated families. Banking is a knowledge-retrieval domain, not the requested standard airline/retail/telecom cohort. The corresponding rows' exact efforts, retrieval setups, standard/custom status and compatible generation were not fully verified.

Sierra is a commercial agent vendor; its affiliation is disclosed, not treated as automatic disqualification. [The README](https://github.com/sierra-research/tau2-bench) documents non-comparable generations and LLM-judge dependencies. Customer-service workflow results could motivate a future role-appropriate route, but they do not directly supply the missing instruction-following or reasoning measurements.

### Coding: SWE-bench

[The Verified methodology](https://www.swebench.com/verified.html) distinguishes arbitrary-system submissions from the mini-SWE-agent/Bash Only comparison and discloses OpenAI's collaboration on the Verified subset.

The captured [structured leaderboard payload](https://www.swebench.com/index.html) gives Haiku 4.5:

| Board | Recorded date | mini-SWE-agent version | Published effort | Published resolved score |
|---|---|---|---|---:|
| Verified | 2026-02-17 | `2.0.0` | `high` | 66.6% |
| Multilingual | 2026-02-13 | `2.0.0a0` | null/unpublished | 64.7% |

These are different datasets and versions and were not pooled. Version differences alone do not prove incompatibility; comparability was not established. The Verified row has `checked: null` and `logs: null`, so a human-verified dataset is not proof that this individual submission was independently checked.

The baseline CLI capability record gives Haiku 4.5 effective effort `none`; its explicitly `high` SWE result must not be transferred to that configuration. Unlabeled effort is also not a match. The displayed dates and a new download do not independently establish fresh evaluation dates. Published API-run costs are not Copilot task-cost measurements.

Coding-agent evidence could become an alternative route for an **existing** coding role after justified metric/band approval; a new binding dimension is not inherently necessary.

### Long-document reasoning: LongBench

[LongBench v2](https://longbench2.github.io/) publishes long-context results with CoT/no-CoT distinctions. Those settings are not CLI `high`/`xhigh` effort. The inspected rows chiefly show older releases; complete row enumeration and matching current execution configurations were not finished. Model-release dates must not be substituted for evaluation dates.

## Admission criteria and remaining work

Source expansion should pass all of the following before affecting automatic selection:

1. **Primary provenance:** identifiable dataset, result artifact, publisher, evaluation method and source ownership/conflicts. University affiliation is not a neutrality guarantee.
2. **Configuration proof:** exact model/release and published effort, or a pinned execution configuration proving native behavior; compatible scaffold, prompts, trial/attempt budget, simulator and judge versions where applicable.
3. **Usable comparison:** at least two distinct budget/capability-eligible models in one comparable metric cohort. Multiple modes/efforts of one model do not meet this requirement.
4. **Freshness and bias controls:** distinguish retrieval, release, submission and evaluation dates; disclose unknowns, contamination risks and self-submissions; track shared datasets and judge dependencies rather than counting websites as independent sources.
5. **Demonstrable role coverage:** an appropriate existing dimension/route, a justified source-native band and a recalculated qualifying intersection. Keep hard budgets, exact matching, incumbent-basis protection and confirmation; do not average unrelated raw scores.

No new rows or metrics were inserted into the selection engine, so there is **no claimed improvement in current-policy outcomes**. Full hypothetical qualification was not calculated because source configurations/cohorts and future bands are unresolved.

Public benchmark scores remain proxies for their published test settings, not proof of quality or cost on a real repository task. No local task-validation requirement is proposed.

Outstanding bounded checks are: HELM's earlier releases; a fresh, evaluator-bound BFCL cohort; legacy tau2 text results and Banking row configurations; fuller IFBench paper/result inspection; and complete LongBench row/configuration coverage. The captured SWE payload is one dated observation, not a guarantee that the live site cannot change. These gaps are **unverified**, not zero coverage or proof that no usable public results exist.

## Calculation input fingerprints

These tracked files are recoverable at the baseline commit. SHA-256 values identify the exact calculation inputs, including checkout bytes.

| Input | SHA-256 |
|---|---|
| `task-profiles.json` | `93377aae3cbf057e3b2f809e1ac173390ea3b89a22957e1bd6ac1958ad27a69b` |
| `config\model-policy.json` | `330189731dea981c6575693752f699e3510b6c7d3815f76f3c59fa529e580932` |
| `config\model-capabilities.json` | `93c8fea201f6a81b20d53457c9b376d4abdc6b90f0ed519f06fc10de8b376fcf` |
| `config\model-ranking-aliases.json` | `09ff0e4548aafbaf52825399bc179e169bd648bf1819069e0018826e57df9734` |
| `config\model-pricing-aliases.json` | `2d5dbb153db85884f442bd56eb0b3592abcf725b501e986efef9e5c7aa0c9988` |
| `data\model-discovery-snapshot.json` | `5afbbc511cb0ad2d3bdced18797f1b967378faf83069f8f92b5594e4841cfcd0` |
| `data\model-pricing-snapshot.json` | `f2dd8988c7037b3aa8028b16e3a945e491eaaaaefecb3bcc617f065a844ca2b0` |
| `data\model-ranking-snapshot.json` | `3fa02738e12274bd9303ea795bf64535d2b7fcc44d0e3c59e9411ff82ec39830` |

## Public artifact index

**25 captured artifacts** are retained in the session's `files\public-source-audit` directory, not committed to the repository. Their sizes and SHA-256 values were checked against the saved files. The baseline calculation and unreviewed research draft are separate session artifacts.

The session also retains `audit-public-source-baseline.ps1` and its `public-source-baseline.json` result. These are offline audit artifacts, not a new selector or task-evaluation requirement.

Many URLs below are mutable. A capture hash identifies the observation; it does not pin an evaluator revision or promise that a later fetch returns the same bytes.

| Saved file | Primary URL | Retrieved (UTC) | Size (bytes) | SHA-256 |
|---|---|---|---:|---|
| `bfcl-model_config.py` | https://raw.githubusercontent.com/ShishirPatil/gorilla/main/berkeley-function-call-leaderboard/bfcl_eval/constants/model_config.py | 2026-11-03T08:51:53Z | 78,915 | `EC72B8499F140C9D870CEBC909C895FACB3CB26FEBC2D9146C8F1DFDEA7BDCBC` |
| `bfcl-leaderboard.html` | https://gorilla.cs.berkeley.edu/leaderboard.html | 2026-11-03T08:51:54Z | 16,207 | `EF72A8621B6EA1B8AA1D1B7691F73CC3079FD38E86F599C9A38CB626C911FC29` |
| `bfcl-data_overall-2025-11-03.csv` | https://raw.githubusercontent.com/HuanzhiMao/BFCL-Result/main/2025-11-03/score/data_overall.csv | 2026-11-03T08:51:07Z | 33,478 | `62EDBE7AFFDA07B8EC367D219B63DE340030B286786ABF756FABF9276F851496` |
| `ifbench-readme.md` | https://raw.githubusercontent.com/allenai/IFBench/main/README.md | 2026-11-03T08:51:53Z | 4,931 | `3AEDA5D9691BA92C2439A3ED881C51F342F3E609E997EE66F854F12138F73807` |
| `ifbench-arxiv-abs.html` | https://arxiv.org/abs/2507.02833 | 2026-11-03T08:52:06Z | 42,206 | `768F12044E4167F572DF513AEEE477A86EE5DC446F0E99239A46184B2F9DCBE8` |
| `helm-ifeval_scenario.py` | https://raw.githubusercontent.com/stanford-crfm/helm/main/src/helm/benchmark/scenarios/ifeval_scenario.py | 2026-11-03T08:51:55Z | 2,308 | `BF6435B9809DE62D633B8FE0708953ADB65D3D9DBBB49AC25E2F5ED2CA9C9BCB` |
| `helm-capabilities-config.js` | https://crfm.stanford.edu/helm/capabilities/latest/config.js | 2026-11-03T08:57:36Z | 181 | `8E778F217425B39602F41A0341F3899F1E8BF2DCDC6866E7DA8932D3A8876816` |
| `helm-gcs-bucket-listing-v1.15.0.json` | https://storage.googleapis.com/storage/v1/b/crfm-helm-public/o?prefix=capabilities/benchmark_output/runs/v1.15.0/&delimiter=/&maxResults=50 | 2026-11-03T08:57:38Z | 1,864 | `7F171B3146BA0A1393C82DE4DFF51FEA4774D3BB59E069F66CFE184EC8FD214E` |
| `helm-ifeval-scenario-claude-haiku-4-5.json` | https://storage.googleapis.com/crfm-helm-public/capabilities/benchmark_output/runs/v1.15.0/ifeval:model=anthropic_claude-haiku-4-5-20251001/scenario.json | 2026-11-03T08:57:37Z | 266 | `4BB7B2A6D4A8B2970B833335D4E544D8AECCAEC562F683D6E81B21DDDAD7E7CF` |
| `helm-ifeval-stats-anthropic_claude-haiku-4-5-20251001.json` | https://storage.googleapis.com/crfm-helm-public/capabilities/benchmark_output/runs/v1.15.0/ifeval:model=anthropic_claude-haiku-4-5-20251001/stats.json | 2026-11-03T08:56:14Z | 19,515 | `B058F1044B2EFA78681D2EB6A4D23580CB369CBFB4A691C05F107AD8BDA4A2ED` |
| `helm-ifeval-runspec-anthropic_claude-haiku-4-5-20251001.json` | https://storage.googleapis.com/crfm-helm-public/capabilities/benchmark_output/runs/v1.15.0/ifeval:model=anthropic_claude-haiku-4-5-20251001/run_spec.json | 2026-11-03T08:56:15Z | 1,844 | `6135C9DA238955A5F9CD1FF4F2946F4EEBC16421A39A3CC9F206D0769BE7F6D7` |
| `helm-ifeval-stats-google_gemini-3-pro-preview.json` | https://storage.googleapis.com/crfm-helm-public/capabilities/benchmark_output/runs/v1.15.0/ifeval:model=google_gemini-3-pro-preview/stats.json | 2026-11-03T08:56:16Z | 18,471 | `9B41718EEA0C6CFB573BA09E30942CF735B5BE09EFCCAB54B38B44922C781C4B` |
| `helm-ifeval-runspec-google_gemini-3-pro-preview.json` | https://storage.googleapis.com/crfm-helm-public/capabilities/benchmark_output/runs/v1.15.0/ifeval:model=google_gemini-3-pro-preview/run_spec.json | 2026-11-03T08:56:17Z | 1,820 | `86FC6A4F3375524E537395717147F4FCE949D2BAD2D0FC3C800C3E68FDCFBD0C` |
| `helm-ifeval-stats-openai_gpt-5.1-2025-11-13.json` | https://storage.googleapis.com/crfm-helm-public/capabilities/benchmark_output/runs/v1.15.0/ifeval:model=openai_gpt-5.1-2025-11-13/stats.json | 2026-11-03T08:56:18Z | 19,521 | `7615129C9ED8161D31AA6516B675AFC0A9A1EDFE9A2EE92C776F1273AFF9CC44` |
| `helm-ifeval-runspec-openai_gpt-5.1-2025-11-13.json` | https://storage.googleapis.com/crfm-helm-public/capabilities/benchmark_output/runs/v1.15.0/ifeval:model=openai_gpt-5.1-2025-11-13/run_spec.json | 2026-11-03T08:56:19Z | 1,814 | `510941A162CE7BC5C1ED2696EFE0413088E1B309546F85641E2E372A6CD21871` |
| `tau2bench-readme.md` | https://raw.githubusercontent.com/sierra-research/tau2-bench/main/README.md | 2026-11-03T08:51:54Z | 14,718 | `7AE047A745EF93B311EDB0DA5D74FBC2BD784A35CE285A73AB3AF8B6AED3E34B` |
| `tau2bench-changelog.md` | https://raw.githubusercontent.com/sierra-research/tau2-bench/main/CHANGELOG.md | 2026-11-03T08:52:18Z | 40,660 | `DBA330FCBC2E88D864E5D9188225BEB6D7F4642A087EA7D992B6E1EA804D2105` |
| `tau2bench-versioning.md` | https://raw.githubusercontent.com/sierra-research/tau2-bench/main/VERSIONING.md | 2026-11-03T08:52:18Z | 7,151 | `589B59CEE7D014B4AB0743EF409DCC5C46AEC05902548DD3026830183AF9F449` |
| `tau2bench-leaderboard-submission.md` | https://raw.githubusercontent.com/sierra-research/tau2-bench/main/docs/leaderboard-submission.md | 2026-11-03T08:53:10Z | 36,585 | `14799C2FAB57BE0E2D6F31882CCE1EC1F040B649ACD2191C3B596A1122B00146` |
| `taubench-leaderboard.html` | https://taubench.com/leaderboard | 2026-11-03T08:52:17Z | 62,345 | `F759783628B900DE1EB1E506991D38A8599C9C1F0805BB38EE040AB2F0B29DA7` |
| `swebench-verified.html` | https://www.swebench.com/verified.html | 2026-11-03T08:51:54Z | 18,300 | `8DDA70C3EEC64D5706EF4AAEE17E29316CACA5DFBA5B856888E61E72BA8EA3DF` |
| `swebench-mainResults.js` | https://www.swebench.com/js/mainResults.js | 2026-11-03T08:51:54Z | 25,315 | `F8AFD60F7B6D3AEBA34DB407FB7F04FAADD18C0474C147FFA013BAEBCCFEA616` |
| `swebench-index.html` | https://www.swebench.com/index.html | 2026-11-03T08:48:10Z | 2,392,125 | `C862011A4EE1D1A7199FAD6CA0905FA5C64F58216F7217AC1EDDF37F28788433` |
| `longbench2-index.html` | https://longbench2.github.io/ | 2026-11-03T08:51:55Z | 75,814 | `B16F4683A0970694A1AA4FC74155BC61024FA57F98F257B90CC67D54D48D2D35` |
| `longbench-github-readme.md` | https://raw.githubusercontent.com/THUDM/LongBench/main/README.md | 2026-11-03T08:51:55Z | 7,811 | `7DE8F5CEC86E49B9A0F3F90BF112E797903BCF93BD458D78C854FEC532B08EF1` |
