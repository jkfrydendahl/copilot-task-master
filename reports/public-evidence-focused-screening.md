# Public Evidence — Focused Screening Pass (IF & Incumbent Gaps)

**Status:** Data-phase screening only. No selection routes, quality bands, qualification dimensions, or policy/config files were changed. No Git writes were made. This report does not claim phase acceptance.

**Scope:** One bounded follow-up pass, explicitly approved by the user, to screen **at most 3 NEW** dataset/harness/release cohorts (distinct from the 9 already screened in `reports\public-evidence-source-screening.md`) and **deep-check at most 1** of them, targeting the instruction-following (IF) and incumbent-comparison gaps called out for Default Development, Mechanical, Triage, Review, and Quick/Visual-UI.

**Baseline used:** `public-source-baseline.json`, SHA-256 `213CA9A9F67892C082E1069B869BAD74C9FAD34E9965DD53124AEAA1CFB0B3A3`, policy v15, at `C:\Users\JesperKF\.copilot\session-state\26990ba8-1d1f-4d2f-bfe7-9310e79027d1\files\public-source-baseline.json`. All 8 pinned frozen inputs — `task-profiles.json`; `config\model-policy.json`; `config\model-capabilities.json`; `config\model-ranking-aliases.json`; `config\model-pricing-aliases.json`; `data\model-discovery-snapshot.json`; `data\model-pricing-snapshot.json`; `data\model-ranking-snapshot.json` — were re-confirmed to byte-match the baseline's recorded hashes before this pass began — no re-screen of "why" was needed; freshness was simply re-verified. (Correction: `config\model-routing.json` and `config\model-context.json` are **not** part of the baseline's frozen-input set and are not listed above; an earlier version of this report incorrectly named them instead of the two `*-aliases.json` config files and 3 `data\*-snapshot.json` files above.)

**New capture location (this pass only):** `C:\Users\JesperKF\.copilot\session-state\0e7ebf18-f781-43cb-b0eb-fbc943c4ba4d\files\public-evidence-focused-screening\` — contains `capture-manifest.json`, `admission.json`, and `captures\*.html` (4 raw downloaded pages, hashed directly from disk, not re-derived from any markdown conversion). The prior pass's sibling folder `public-evidence-screening\` under the same session-state root was not touched.

**Note on dates:** every `retrievedAtUtc` timestamp in this report records only when this screening session fetched a page; it is **not** a claim about when the underlying leaderboard data itself was generated, last updated, or released. No board-level version/release date is confirmed for either Scale AI's or Vals AI's dynamic, continuously-updated boards — this is treated as **unknown**, not assumed current, throughout.

---

## 1. Exact 3-slot cohort ledger

| Slot | Cohort | Publisher/domain | Distinct from the 9 already-screened? | Screened | Deep-checked | Disposition |
|---|---|---|---|---|---|---|
| 1 | Scale AI SEAL — **Instruction Following** leaderboard | `labs.scale.com/leaderboard/instruction_following` | Yes (Scale AI SEAL is a new publisher/lineage not among the 9) | Yes | No | **Rejected/Hold** — board is explicitly labeled "Deprecated (as of January 2025)"; ranks 1–12 inspected are all pre-2026 legacy models (o1, DeepSeek R1/V3, Gemini 1.5/2.0, Claude 3.5 Sonnet, GPT-4o, Llama 3.1, Mistral Large 2, GPT-4 Turbo). No eligible-union (21-model) name found in the portion inspected. |
| 2 | Scale AI SEAL — **MultiChallenge** leaderboard | `labs.scale.com/leaderboard/multichallenge` | Yes (different board/release than slot 1; "a family containing multiple releases/boards is NOT one cohort") | Yes | **Yes (the pass's one allowed deep-check)** | **Provisional** — 3 eligible-union model-identity matches found (`gpt-6.1-sol`, `gemini-4-argon`, `claude-haiku-5.5`), all genuinely new-lineage, but **none carries a disclosed reasoning-effort label**. Per the strict native-identity rule, none can be treated as an exact-configuration match. `admission.json` produced for this cohort (model-identity/lineage corroboration only, not a score admission). |
| 3 | Vals AI — **Vals Index** board | `vals.ai/benchmarks/vals_index` | Yes (different publisher, different metric family — a GDP-weighted finance/coding/legal/tax composite, not an IF/reasoning-specific board) | Yes (light screen only, no additional fetch beyond the one already-captured page) | No | **Hold (unresolved)** — richest eligible-union overlap found this pass (8 matches, including the Quick/Default-Development/Visual-UI/Mechanical/Triage incumbent `gemini-3.8-flash` itself, appearing on the same board/listing as several candidates), but invocation settings, aggregate-metric composition, and harness/trial/judge methodology were **not deep-verified** (no deep-check was spent here — it was already allocated to slot 2 before this overlap was found). Native-configuration compatibility with Copilot is therefore **unknown, not disproved**. The board is not currently a registered qualification-dimension `evidenceRoutes` entry in `config\model-policy.json` for any profile — a route-registration fact, not a verdict on the data's broader relevance. Flagged as the top candidate for a **future** pass's single deep-check; not resolved this pass. |

**Ledger total: 3 cohorts screened (≤3 bound met exactly, not exceeded), 1 deep-check performed (≤1 bound met exactly).** No 4th cohort was opened. The ancillary page `vals.ai/benchmarks` (the parent listing page used only to find the Vals Index URL) was fetched but is **not counted as a 4th slot** — same publisher/domain, a navigation page only, no separate dataset/harness/release of its own.

This ledger intentionally mirrors the format of `reports\public-evidence-source-screening.md`'s self-corrected table, to make the 9-already-screened-cohort history and this pass's 3-cohort addition auditable side by side without re-litigating the prior overrun.

---

## 2. Cohort 1 — Scale AI SEAL "Instruction Following" (screened, not deep-checked)

- **URL:** `https://labs.scale.com/leaderboard/instruction_following`
- **Capture:** `captures\scale-instruction-following.html`, SHA-256 `41BCD23BC8E464E1E8CE568B7F097C0F26A83CD1C7397E05A5694DC2A73055F0`, retrieved `2026-11-03T15:38:02.345Z`, 119,064 bytes.
- **Finding:** The page itself labels the board **"Deprecated (as of January 2025)"** (confirmed twice in the saved file) and lists it under a "Legacy" sidebar category. The top 12 ranked entries inspected are all pre-2026 models: o1 (December 2024), DeepSeek R1, DeepSeek V3, Gemini 1.5 Pro/Flash, Gemini 2.0, Claude 3.5 Sonnet (June 2024), GPT-4o, Llama 3.1 405B, Mistral Large 2, GPT-4 Turbo.
- **Scope of the "no match" claim:** Scoped strictly to ranks 1–12 as actually inspected; the full board was not paginated further once the deprecation notice and the uniformly pre-2026 model lineup made it clear no eligible-union model was plausible beyond that point. No admission.json, no further action.
- **Lineage:** Distinct from all 9 previously-screened cohorts (new publisher, new dataset, new judge design) — the **cohort slot** is dispositioned Rejected/Hold based on the inspected portion (ranks 1–12) and the page's own "Deprecated" label; this does not assert that no eligible-union model exists anywhere further down the full board, only that none was found in the portion actually inspected. No claim is made about the board's underlying data vintage beyond its own "Deprecated (as of January 2025)" label.

---

## 3. Cohort 2 — Scale AI SEAL "MultiChallenge" (screened + deep-checked)

- **URL:** `https://labs.scale.com/leaderboard/multichallenge`
- **Capture:** `captures\scale-multichallenge.html`, SHA-256 `8DDBA987BBC0662F784E61398CB5281772D88B3271F4CA92B5E9F88630917415`, retrieved `2026-11-03T15:38:03.410Z`, 148,317 bytes.
- **Benchmark paper:** "MultiChallenge: A Realistic Multi-Turn Conversation Evaluation Benchmark Challenging to Frontier LLMs", `arXiv:2501.17399`. Dataset repo: `https://huggingface.co/datasets/ScaleAI/MultiChallenge`.
- **Methodology (confirmed from the fetched page):**
  - Private Scale-AI-annotator-built + synthetic multi-turn conversation dataset, targeting 4 challenge categories (instruction retention, context allocation/recall, in-context reasoning, preference reliability) deliberately hard for frontier LLMs.
  - LLM-as-judge with **instance-level binary rubrics**, claimed ~93% agreement with human raters (vs. ~36% for a raw holistic LLM-judge baseline).
  - Ranking method: **"Rank (Upper Bound)"** — grouping by 95% CI overlap, not a strict score sort.
  - Publisher explicitly discloses a bias limitation: benchmark construction is "inevitably biased against" the frontier models originally used to build the failure cases.
  - **Not disclosed:** any current-run API call configuration (reasoning-effort/thinking-budget parameter, temperature, trial count, system prompt) for how the "NEW"-tagged 2026-era models were actually invoked. Only the original 2025 paper's static dataset/judge methodology was found in the fetched text.
- **Publisher-interest disclosure:** Scale AI is simultaneously the benchmark's creator, the LLM-judge operator, and the leaderboard publisher — a disclosed benchmark-operator-as-judge conflict of interest. This is a distinct *kind* of conflict from the tau-bench Banking cohort's issue in the prior pass (there, maintainer Sierra submitted its own company's model scores as a participating submitter); the two must not be treated as structurally equivalent and are disclosed here on their own terms. No independent third party has corroborated these specific new-model scores.
- **Eligible-union model matches found (of 36 ranked rows captured):**

| Rank | Raw model label | "NEW" tag | Score | 95% CI | Canonical model |
|---|---|---|---|---|---|
| 1 | `gpt 6.1 Sol` | Yes | 81.95 | ±4.16 | `gpt-6.1-sol` |
| 2 | `Gemini 4 Argon` | Yes | 78.70 | ±5.30 | `gemini-4-argon` |
| 10 | `Claude Haiku 5.5` | Yes | 67.67 | ±5.34 | `claude-haiku-5.5` |

  Observed data range across the 36 rows captured: 36.35 (rank 36, `gemini-2-0-flash`) to 81.95 (rank 1). This is the observed range of what was captured, **not** an asserted legal/defined 0–100 bound — no maintainer text in the fetched pages states an explicit floor/ceiling for this metric.

  **Confirmed non-match nearby:** `GPT 6.1 Terra` (rank 6, 74.20 ±5.40, also "NEW"-tagged) is **not** in the 21-model eligible union (only `gpt-6.1-sol` and `gpt-5.6-terra` are present as "Sol"/"Terra"-family names) — flagged explicitly to avoid conflation.

- **Why none of the three matches is an exact-configuration match:** None of the three rows carries any reasoning-effort/mode suffix. The raw DOM capture confirms this is not a markdown-conversion artifact — several *other* rows on the very same board **do** carry explicit effort/mode labels (e.g. `o3-pro-2025-06-10-reasoning-high`, `claude-opus-4-6 (Non-Thinking)`). However, those labeled rows only show that the UI is *capable* of rendering a mode label when one is present; they do **not** establish *why* the three eligible rows lack one (an undisclosed/unknown mode, a mode genuinely not recorded for newly-added rows, or some other reason are all equally possible) — this is kept as **unknown**, not asserted as a confirmed or "genuine" gap. Per the project's strict native-identity rule, an unlabeled result must never be assumed to correspond to any particular effort — including `effort:none` for `gemini-4-argon`. Note also that `config\model-capabilities.json`'s `effortMode: "unsupported"` for `gemini-4-argon` describes Copilot's own native CLI configuration (its only native effort value is `none`); it is **not** evidence about whether the model performs internal reasoning/thinking, and must not be read as "no reasoning." The CLI-side fact that there is only one native Copilot configuration for this model does **not** establish that an external, differently-surfaced API call used that same configuration — that compatibility remains unknown, not disproved.
- **Per-profile eligibility (from the pinned baseline):** all 9 profiles have at least one of these 3 models in their eligible-configuration pool, at the efforts shown below. None is usable as an exact-configuration match for any profile because effort remains unconfirmed for all three.

| Profile | `gpt-6.1-sol` eligible efforts | `gemini-4-argon` eligible efforts | `claude-haiku-5.5` eligible efforts | Incumbent | Priority-gap relevance |
|---|---|---|---|---|---|
| orchestrator | high, xhigh | none | high, xhigh | `gpt-6.1-sol`/xhigh | Row's own incumbent model, effort unconfirmed |
| quick | low | none | low | `gemini-3.8-flash`/none | Candidate fallback identity found; effort unconfirmed |
| default-development | medium, high | none | medium, high | `gemini-3.8-flash`/none | **Named priority gap** ("missing gpt-6.1-sol/high IF or gpt-5.6-sol/medium/high"); `gpt-6.1-sol` found but effort unconfirmed — gap **not filled**; `gpt-5.6-sol` was not found in this cohort at all |
| agentic-implementation | high, xhigh | none | high, max, xhigh | `claude-sonnet-5.5`/max | — |
| deep-reasoning | high, xhigh | none | high, max, xhigh | `gpt-6.1-sol`/xhigh | Row's own incumbent model, effort unconfirmed |
| review | medium, high | none | medium, high | `claude-opus-5`/high | Review's qualification dimension is "reasoning" via `liveBench.reasoning` only; MultiChallenge is lineage-mismatched regardless of effort (see §6) |
| visual-ui | medium, high | none | medium, high | `gemini-3.8-flash`/none | Candidate fallback identity found; effort unconfirmed |
| mechanical | low | none | low | `gemini-3.8-flash`/none | Named gap is specifically `gpt-6-sol/low` (not `gpt-6.1-sol`) — **not found in this cohort** (0 matches for "gpt-6-sol"/"GPT-6 Sol" confirmed by direct search of the saved file) |
| triage | low | none | low | `gpt-6.1-sol`/low | **Named priority gap**, exact incumbent configuration; `gpt-6.1-sol` found but effort unconfirmed — the single closest finding of this whole pass, still **not filled** |

- **Disposition:** **Provisional.** Lineage/model-identity corroboration only. `admission.json` produced (schema below) with `explicitEffort: null` on every row, `disposition: "provisional"` per row, and the full limitations list.

---

## 4. Cohort 3 — Vals AI "Vals Index" (screened only, not deep-checked)

- **URL:** `https://www.vals.ai/benchmarks/vals_index` (ancillary: `https://www.vals.ai/benchmarks`, the listing page used only to find this URL, not a separate cohort).
- **Captures:** `captures\vals-index.html` (SHA-256 `3AD9FE3C129F973832231654AAF030C3F073F21CA86F806A27B85304E9219CB6`, retrieved `2026-11-03T15:38:04.063Z`, 689,811 bytes) and `captures\vals-benchmarks.html` (SHA-256 `5E4DB68159873520E252A73695692F98F2DE0702DE07BDD27597CC970348E616`, retrieved `2026-11-03T15:38:05.521Z`, 296,966 bytes).
- **What the board is:** A "GDP-weighted" composite accuracy index across Finance, Coding, Legal, and Tax sub-benchmarks — **not** an instruction-following-labeled or reasoning-labeled metric. It has no corresponding entry in `config\model-policy.json`'s `evidenceMetrics`/lineage list for any of the 9 profiles' qualification dimensions.
- **Why this was only a light screen, not a deep-check:** The visible markdown-rendered leaderboard table lost its model-name column (client-rendered). Rather than performing additional fetches/methodology archaeology (which would have amounted to a second deep-check, exceeding the 1-deep-check bound), the model-identity data was recovered **from the single already-fetched page's own embedded Next.js flight-data JSON** (HTML-entity-escaped `model`/`accuracy`/`position`/`company`/`slug`/`tokens` records already present in the one captured file). No additional page was fetched to produce the table below.
- **Eligible-union matches found (8 of 32 ranked rows):**

| Position | Model (display) | Accuracy | Canonical model | Reasoning tokens (embedded telemetry) |
|---|---|---|---|---|
| 1 | Claude Sonnet 5.5 | 70.85% | `claude-sonnet-5.5` | 510,663,474 |
| 3 | Claude Opus 5.5 | 70.18% | `claude-opus-5.5` | 378,363,763 |
| 4 | Gemini 4 Argon | 69.24% | `gemini-4-argon` | 59,887,853 |
| 6 | GPT-6 Astra | 65.02% | `gpt-6-astra` | 59,928,445 |
| 8 | GPT-6.1 Sol | 63.94% | `gpt-6.1-sol` | 64,580,497 |
| 14 | Claude Haiku 5.5 | 58.73% | `claude-haiku-5.5` | 679,539,502 |
| **18** | **Gemini 3.8 Flash** | **55.95%** | **`gemini-3.8-flash`** (Quick/Default-Development/Visual-UI/Mechanical/Triage **incumbent**) | 68,777,600 |
| 25 | GPT-6 Luna | 52.32% | `gpt-6-luna` | 167,309,610 |

  **Confirmed non-matches nearby (to prevent conflation):** "Gemini 4 Carbon" (position 2, 70.45%) is a **different model name**, not in the 21-model eligible union, and must not be confused with `gemini-4-argon`. "GPT-6.1 Terra" (position 11, 60.54%) is likewise confirmed not in the eligible union (consistent with the same finding in Cohort 2).

- **Observed but not interpreted — `reasoning_tokens` telemetry:** every one of the 8 matched rows — including the incumbent `gemini-3.8-flash` itself — carries a **nonzero `reasoning_tokens`** value in its own embedded token-usage telemetry (field confirmed directly in the saved capture; see table above). **This observation is reported as a raw fact only.** It does **not** prove a high/manual reasoning-effort setting was used, does **not** establish a configuration mismatch with Copilot's native invocation, and does **not** establish that Copilot cannot reproduce whatever Vals measured. A nonzero cumulative reasoning-token count across an entire evaluation run is consistent with many possible explanations — including the model's own default/always-on internal reasoning behavior, which could be identical to what Copilot's native invocation for this model already produces — none of which this screening verified. Vals' own invocation settings, aggregate-metric composition, harness version, trial count, and judge/grading method were **not deep-verified** this pass, so native-configuration compatibility for every one of these 8 rows remains **unknown**, not disproved.
- **Why this does not (yet) fill the Quick/Visual-UI incumbent-fallback gap despite being the richest overlap found:** The gap calls for a "comparable fallback" to `gemini-3.8-flash`/none. `gemini-4-argon`/none is structurally the closest type of candidate (same effort-unsupported class) and its row appears on the same Vals Index board/listing as the incumbent's row — but appearing on the same board/listing is **not** proof that both were invoked under matching invocation settings, trial counts, or judge/grading protocols, and a GDP-weighted composite across Finance/Coding/Legal/Tax sub-benchmarks reporting one blended accuracy number is not established to constitute "one common task harness." Whether either row reflects a configuration compatible with Copilot's native configuration for these models is **unknown** — not disproved and not confirmed. The data is a real, relevant lead for a future deep-check, but it does not resolve the gap this pass.
- **Disposition:** **Hold (unresolved).** Not deep-checked this pass — the single allowed deep-check was already spent on Cohort 2 before this cohort's overlap was found. No `admission.json` was produced for it — producing one would require confirming invocation settings and harness/trial/judge methodology, which was not done; native compatibility remains **unknown**, not disproved. **Recommended as the top-priority target for a future pass's deep-check**, specifically because it is the only cohort found this pass or last where the incumbent and multiple eligible candidates appear on the same already-identified board.

---

## 5. Admission packet

One `admission.json` was produced, for **Cohort 2 (Scale AI SEAL MultiChallenge)** only — the single cohort that received this pass's one allowed deep-check, per the rule that only one promising, *verified* cohort may receive a packet.

- **Path:** `C:\Users\JesperKF\.copilot\session-state\0e7ebf18-f781-43cb-b0eb-fbc943c4ba4d\files\public-evidence-focused-screening\admission.json`
- **SHA-256:** `210D9790A539969A8328F76A5290FB8EF0A902BC5BE9679EE0BC28F8AD2C2D3F` (recomputed after this same-pass correction edit; prior pre-correction value was `93E33B6A3C32D869C90DABDD220FC21FE2F5DD450CD5F3DE6C1DA0C35D70C8CC` — no facts changed, only retraction of several over-strong inferences described in the correction below)
- **Contents:** `schemaVersion: 1`; source/cohort/metric definitions; 3 rows (raw + canonical model, `explicitEffort: null` with an explanatory note per row, raw score + CI, source field path, dates all `null`/unknown with a note on the SSR-timestamp artifact); per-profile eligibility/incumbent matches for all 9 profiles per row; a `nonMatchesConfirmedNearby` block for `gpt-6.1-terra`; a `crossCohortCorroboration` block noting (without drawing any configuration conclusion from it) that the same model identities also appear on the separately-screened, not-deep-checked Vals Index board; raw capture URLs/paths/SHA-256/retrieved-UTC; and a `limitations` array.
- **Explicitly does NOT:** assign any selection route or quality band, claim any dimension is qualified, or claim phase acceptance. `notRouteOrBandApproval`, `notSelectionOrQualificationChange`, and `notPhaseAccepted` are all set `true` in the packet, and `verificationStatus.exactConfigurationMatch` is explicitly `false`.

No second `admission.json` was produced for Cohort 3 (Vals Index), consistent with "at most ONE promising new cohort may be deep-checked" — Cohort 3 was screened, not deep-checked, and is documented in §4 above instead.

---

## 6. Admitted measurement coverage vs. remaining unknowns

**What this pass changed:** Nothing in terms of exact-configuration coverage. Zero new exact model/effort/config intersections were established for any of the 9 profiles' required dimensions. What this pass added is a record that 8 distinct eligible-union models (`gpt-6.1-sol`, `gemini-4-argon`, `claude-haiku-5.5`, `claude-sonnet-5.5`, `claude-opus-5.5`, `gpt-6-astra`, `gpt-6-luna`, and the incumbent `gemini-3.8-flash`) appear by name on two additional public leaderboards not previously screened (Scale AI SEAL MultiChallenge; Vals AI Vals Index), neither an AA/LiveBench component. For Scale MultiChallenge, judge design and dataset construction were directly read and confirmed distinct from every `evidenceRoutes` lineage in `config\model-policy.json` (see §3). For Vals Index, which was screened but **not** deep-checked, the mere fact of a new publisher/site does **not** by itself establish an independent judge or dataset — that independence is **unverified**, not confirmed, pending a future deep-check.

**Per-priority-gap status after this pass:**

| Priority gap (from the handover) | Status after this pass |
|---|---|
| Default Development: zero measured primary/IF exact-configuration intersection | **Still unfilled.** `gpt-6.1-sol` found in both new cohorts but effort-unconfirmed; `gpt-5.6-sol` was not found in either new cohort at all. |
| Mechanical: missing `gpt-6-sol/low` IF model | **Still unfilled; no occurrence of `gpt-6-sol` found in either new cohort** (confirmed zero matches via direct text search of both saved captures). |
| Triage: missing `gpt-6.1-sol/low` (exact incumbent config) | **Still unfilled** — `gpt-6.1-sol` appears in both new cohorts, unconfirmed effort. A pinned low-effort invocation would establish only one configuration; a compatible second distinct eligible model, metric/protocol verification and cross-dimension coverage would still be required. |
| Review: missing high/medium reasoning cohort | **Still unfilled.** Review's qualification dimension is "reasoning" via `liveBench.reasoning` only (`config\model-policy.json`, review profile block); neither MultiChallenge nor Vals Index is currently a registered `evidenceRoutes` entry for that dimension — a **current route-registration fact**, separate from the effort-ambiguity issue above. This is not itself a verdict that either benchmark's content is semantically irrelevant to reasoning capability; whether either benchmark's task content has any future data-relevance to Review's reasoning dimension was not researched this pass (researching semantic fit does not require activating a route) and remains open. |
| Quick/Visual-UI: `gemini-3.8-flash`/none incumbent lacks comparable fallback | **Still unfilled.** `gemini-4-argon`/none is the closest structural candidate and was found on both new cohorts, including alongside the incumbent itself on the Vals Index board/listing — but whether either row's invocation is compatible with Copilot's native configuration for these models is **unknown** (not deep-verified this pass); the nonzero reasoning-token telemetry observed for both models does not itself establish a mismatch, a particular effort level, or that Copilot cannot reproduce what Vals measured. |

**Accepted data-phase targets (all 9 profiles ≥2 distinct eligible models per compatible cohort with ≥1 exact configuration measured across all required dimensions; ≥6 complete incumbent comparisons) remain unmet.** This pass neither advanced nor regressed that status — it added disclosed, bounded, honestly-limited corroborating evidence and one clearly-flagged follow-up target (Vals Index), without claiming more than was verified.

---

## 7. Excluded non-primary sources

The following domains surfaced during discovery (via supplementary `web_search` summaries) but were **not** used as a source for any factual claim in this report or in `admission.json`, because they are third-party SEO/aggregator mirrors, not the benchmark publisher: `benchlm.ai`, `benchleader.com`, `scalesd.org`, `tech-insider.org`, `theaitoolbible.com`, `digitalapplied.com`, `artificialwatch.com`, `llmlearner.com`. Every score, rank, date, and methodology claim above is sourced only from a directly-fetched, locally-hashed capture of `labs.scale.com` or `vals.ai` (or, for the paper citation, `arxiv.org`), cited by file path and SHA-256 in §2–§4 and in `admission.json`.

---

## 8. Files touched by this pass

- **Created (untracked working-tree file; not committed, staged, or otherwise written to Git):** this file, `reports\public-evidence-focused-screening.md`.
- **Created (session-state, outside the repo):** `C:\Users\JesperKF\.copilot\session-state\0e7ebf18-f781-43cb-b0eb-fbc943c4ba4d\files\public-evidence-focused-screening\` containing `capture-manifest.json`, `admission.json`, and `captures\` (4 raw HTML files).
- **Not touched:** `reports\public-evidence-selection-handover.md`, `reports\public-evidence-source-screening.md`, `reports\public-source-coverage-audit.md`, `reports\public-evidence-pack-v1.json`, the prior pass's sibling folder `...\files\public-evidence-screening\`, any `task-profiles.json`/`config\*.json` policy file. No Git state was changed by this pass (no commits, no `git add`/staging, no branch changes) — the only new filesystem artifacts are this untracked report and the session-state capture folder above.
