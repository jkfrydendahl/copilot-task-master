# Public evidence source screening (bounded)

## Current integrating decision: candidate v3, 2026-11-03

**The data phase is not accepted: coverage remains 5/9 profiles and 3/6
required complete incumbent comparisons.** The current artifact is
[`public-evidence-pack-v3.json`](public-evidence-pack-v3.json), SHA-256
`ACA27072E7D413A1F36C0E08726B7E7F7B6BCE817AE486275F8F91D8D6F5F112`,
as of `2026-11-03T16:04:23.8377671Z`. Earlier v1/v2 packs are preserved as
immutable historical candidates, not current-engine or acceptance evidence.

**Banking units are now verified, not guessed.** The official v1.0.1
[submission model](https://raw.githubusercontent.com/sierra-research/tau2-bench/fc0055dc4e0a316c3f83133267fbd6faaa770992/src/tau2/scripts/leaderboard/submission.py)
and generated
[JSON schema](https://raw.githubusercontent.com/sierra-research/tau2-bench/fc0055dc4e0a316c3f83133267fbd6faaa770992/web/leaderboard/public/submissions/schema.json)
explicitly define `pass_1` through `pass_4` as success-rate percentages bounded
0-100. The tag resolves to methodology-reference revision
`fc0055dc4e0a316c3f83133267fbd6faaa770992`; this is not proof of the deployed
evaluator commit, which remains unknown. Schema SHA-256:
`A345447E345A55614FC28531C13FA89B2B5DCA10C9D23803A779A1A705B9C35F`;
producer SHA-256:
`8BA7A0D981AE73F470219E0FF3D132ABCB029EE322F95BBC8A91DEE7668D2C12`.
Both captures and their original retrieval times (15:33:32 UTC) are recorded in
the pack's supplemental `unitProof` and this session's
`files\banking-unit-proof\unit-proof.json`.

The importer admits the four previously captured model/effort rows' native
`pass_1` values through the existing evidence interface as an **inactive**
metric, without scaling. All retain their original
`2026-11-03T10:22:57Z` score-capture timestamps and evaluation/submission dates;
publication dates remain unknown, with zero proven publication-fresh Banking
configurations. Saved submission JSON includes local `_capture_meta`; its hashes
identify those saved captures, not publisher-signed original HTTP bytes.

| Profile | Complete configurations, unchanged routes | Incumbent complete | Banking models | Banking two-model cohort |
|---|---:|:---:|---:|:---:|
| Orchestrator | 3 | Yes | 1 | No |
| Quick | 3 | No | 0 | No |
| Default Development | 0 | No | 1 | No |
| Agentic Implementation | 10 | Yes | 4 | Yes |
| Deep Reasoning | 6 | Yes | 4 | Yes |
| Review | 0 | No | 1 | No |
| Visual/UI | 4 | No | 0 | No |
| Mechanical | 0 | No | 0 | No |
| Triage | 0 | No | 0 | No |

These are frozen CLI-eligibility/context projections, not proof of benchmark
execution at a Copilot context tier. No primary/required dimension is waived.
Banking adds one comparable dataset cohort, not a new complete incumbent.

**Correction to earlier lineage claims:** a distinct source/metric namespace or
publisher is not sufficient proof that an evaluation lineage is disjoint from
the frozen aggregate. The cached AA API observation has no declared dataset or
methodology version. The current public page's index-component list does not
bind that older cached observation. Accordingly, the earlier affirmative
independence claim below/in the preserved admission packet is historical and
**not accepted as independence proof**: v3 counts **zero proven additional
independent lineages**, one candidate, and no independent result replication.
This does not assert that an overlap exists; disjointness remains unverified.

The separately authorized [focused pass](public-evidence-focused-screening.md)
used exactly **3/3 new cohorts and 1/1 deep check**, adding no admitted exact
configurations. Vals remains unresolved, not disproved: native CLI `none` means
no exposed effort dial, not zero reasoning tokens. Further research is outside
the exhausted authorization; all acceptance criteria and selection remain frozen.

All eight selection inputs and eleven engine fingerprints match v3. Full
offline validation passed 14/14 test files; it did not evaluate models or prove
benchmark correctness. Actual-change self-review repaired a no-clobber
directory-destination edge case and covered relative paths; no Critical/Warning
findings remain. No staging, commits, pushes, branch changes or activation
occurred; the pre-existing audit addition and local handover were preserved.

## Historical first-pass screening (before native-unit proof)

**Decision: no new source is admitted, routed, scored, or activated by this screening.** This is a bounded, read-only screening pass, not a re-audit and not an admission decision. It builds on, and does not revise or supersede, `reports\public-source-coverage-audit.md` and `reports\public-evidence-selection-handover.md`, both preserved unmodified.

**Terminology note:** this screening verifies lineage/configuration-cohort membership, but neither admits scores nor accepts the full data phase. These are separate decisions:
1. **Source/score admission** — accepting a cohort's numeric values into the project's evidence pipeline, normalizing its units, or activating it in a selection route/quality band. **Not done here, for any cohort, including tau-bench Banking.**
2. **Lineage/configuration-cohort verification** — confirming that a given set of already-public, already-captured models/efforts/contexts are (a) members of a profile's existing eligible-configuration pool and (b) drawn from a benchmark/dataset/harness lineage distinct from existing AA/LiveBench routes. **This is what "Met" means below for the additional-lineage target** — it is a factual membership/provenance check, not a score admission, and the units of the underlying scores remain explicitly unverified (see Cohort 6 and `banking-admission.json`).
3. **Full phase/target acceptance** — a decision that the accepted screening targets as a whole are satisfied and a route/band change should follow. **Out of scope for this task entirely**, reserved for the parent/maintainers, and not claimed anywhere in this report.

- Pinned baseline used: `public-source-baseline.json`, SHA-256 `213CA9A9F67892C082E1069B869BAD74C9FAD34E9965DD53124AEAA1CFB0B3A3` (re-verified byte-identical before use), policy version **15**, existing-policy calculation **2026-11-03T08:23:05.170Z**.
- Screening performed: **2026-11-03**.
- No policy, catalog, snapshot, selection-route, quality-band, or profile file was changed. No model-task evaluation, SDK call, account/credential discovery, dependency installation, or Git write was performed. The two protected report files were read only (`view`), never edited; `git status`/`git diff --stat` confirms both remain in their pre-existing modified/untracked state with no new changes from this task.
- New raw captures and a machine-readable manifest are saved under this session's own folder: `C:\Users\JesperKF\.copilot\session-state\0e7ebf18-f781-43cb-b0eb-fbc943c4ba4d\files\public-evidence-screening\` (`captures\` subfolder + `capture-manifest.json`, plus a new `banking-admission.json` data packet — see bottom of this report), separate from the prior sessions' `files\public-source-audit` and `files\additional-public-evidence` directories, which were read for continuity but not written to.

## Implemented data-only integration

The accompanying [`public-evidence-pack-v1.json`](public-evidence-pack-v1.json)
is a **candidate, not an accepted evidence pack**. It contains the normalized
AA components, captured-source provenance, all nine frozen eligible pools and
the four original Banking submissions as **reference-only** evidence.
Banking's raw values are not converted or admitted while their native units
remain unverified. Its publication dates remain unknown, not inferred stale.

The three added AA metrics each have the same matched model/configuration
counts shown below. They remain opt-in and inactive in selection.

| Profile | Existing-route measured configurations: baseline → capture | Additional AA models / configurations, per metric | Banking reference models | Complete incumbent comparison |
|---|---:|---:|---:|---|
| Orchestrator | 3 → 3 | 3 / 6 | 1 | Yes |
| Quick | 3 → 3 | 3 / 3 | 0 | No |
| Default Development | 0 → 0 | 3 / 6 | 1 | No |
| Agentic Implementation | 10 → 10 | 4 / 9 | 4 | Yes |
| Deep Reasoning | 7 → 6 | 3 / 7 | 4 | Yes |
| Review | 0 → 0 | 3 / 6 | 1 | No |
| Visual/UI | 4 → 4 | 3 / 6 | 0 | No |
| Mechanical | 0 → 0 | 3 / 3 | 0 | No |
| Triage | 0 → 0 | 3 / 3 | 0 | No |

The Deep Reasoning difference reflects fresh-first comparison routing when
AA's aggregate refresh failed without its API key: the captured-source view
uses fresh LiveBench Reasoning before cached AA Intelligence. The cached
scores and original dates are retained; no policy, profile or selection state
was changed. These are measurement intersections, not quality-band passes.

**Acceptance remains unmet:** complete existing-route data for 5/9 profiles,
complete incumbents for 3/9 against the required minimum of six, and one
additional lineage candidate whose numeric units still require verification.
All 14 offline test files passed. Actual changes were self-reviewed; identity,
lineage, date and immutable-write issues found during development were repaired.
No model-task evaluations, commits or pushes were performed.

## Correction notice (this revision)

This report was revised after an explicit, same-task, no-new-fetch correction pass. Four errors in the original version are fixed below; **no new research, fetch, or cohort was added to produce this revision** — only recounting and re-framing of already-gathered, already-cited facts.

1. **Bound-overrun miscount (ledger).** The original version claimed "6 cohorts screened, 3 deep-checked... within bounds." That count incorrectly grouped multiple distinct dataset/harness/release cohorts under single "source family" ledger rows: HELM's `v1.13.0` and `v1.14.0` releases were counted as one row; SWE-bench's Test, Lite, and Multimodal boards were counted as one row; and the IFBench maintainer README re-fetch (a document/freshness check, not a result cohort) was counted as if it were a cohort. Recounted individually, this screening actually touched **9 distinct dataset/harness/release cohorts**, exceeding the stated 6-cohort screening bound **by 3**. This is reported honestly below; see "Corrected screen ledger."
2. **Publication-date / staleness conflation (tau-bench Banking, cohort 6 below).** The original version treated the cohort's 91–104-day evaluation/submission-date age as if it established a known publication age exceeding the stated 90-day ceiling, and used that to exclude the cohort from current-target counts. Evaluation/submission dates are not publication dates. Per the accepted tiered rule, only a **known** published age > 90 days excludes a cohort from current counts; an **unknown** publication date **may** count toward exact-configuration coverage when explicitly flagged as unknown. tau-bench Banking's publication date was never established (by either the original audit or this screening) — it is corrected below to "unknown publication date, flagged," not "stale."
3. **Unsubstantiated "resolved" claim (LiveBench "2.0", cohort 5 below).** The original version concluded LiveBench 2.0 is "rebranding only... resolved," based on circumstantial observations (same category catalog, same release list, no separate v2 artifact found). No primary-source identity statement or exact evaluator/dataset-binding proof was found for this claim. It is retracted below to "distinct, inconclusive" — the same disposition the original audit already carried — because absence of found evidence for a v2 artifact is not proof of identity with v1.
4. **Overbroad SWE-bench absence claim.** The original version stated the Quick/Visual-UI incumbent (`gemini-3.8-flash/none`) is "absent from SWE-bench entirely." This is narrowed below to the exact boards/artifacts actually enumerated in the one captured `index.html` snapshot (Test, Lite, Multimodal, Verified, Multilingual, as of the one capture timestamp) — not a claim about SWE-bench as a whole, any other filter, or any future snapshot.

**Correction notice, round 2 (this revision, artifact-completion only — no new fetch/research performed):**
5. **Missing provenance in `banking-admission.json`.** The packet's per-submission `source` objects had only `path`/`sha256`, omitting the requested `url`/`retrievedAtUtc`. These are now added, sourced from the already-existing `capture-index.json` in the prior session's `additional-public-evidence` folder (not invented, not re-dated) — see Cohort 6 and the packet itself.
6. **"0–100" was stated too strongly.** The metric-unit paragraph (Cohort 6) and the JSON packet's `metricSemantics.range` field previously presented "0–100" as if it were a confirmed legal/defined range for `pass_k`. No excerpt states a defined floor/ceiling for this metric. Both are corrected to report only the **observed** data range across the 16 captured values (`22.68041237113402`–`48.71134020618557`), with "0–100" demoted to an explicitly unverified, common-convention assumption, not a verified bound.
7. **IFBench and LiveBench absence/currency claims over-scoped.** "No new results table has been published" (IFBench) and "the admitted `2026-06-25` table remains current" (LiveBench) are narrowed to what was actually checked: one README file's own content, and one captured app bundle's own release list, respectively — not a claim about IFBench's or LiveBench's publications anywhere else.
8. **Top-line "no new source qualifies" vs. the lineage target's "Met" needed reconciled wording.** A "Terminology note" is added directly below this notice distinguishing *source/score admission* (not done, for any cohort), *lineage/configuration-cohort verification* (what "Met"/"verified" means for the tau-bench Banking target below — a membership/provenance fact, not a score claim), and *full phase acceptance* (out of scope, reserved for the parent). This same distinction is now applied consistently everywhere the additional-lineage target is discussed.

The 9-vs-6 cohort overrun from round 1 remains exactly as recorded — no cohort was added, removed, or re-investigated in this round either.

## Corrected bound accounting

| | Declared bound | Actual (corrected count) | Status |
|---|---|---|---|
| Distinct dataset/harness/release cohorts screened | ≤ 6 | **9** | **Exceeded by 3** |
| Of those, deep-checked | ≤ 3 | **3**, correctly attributed to 3 *distinct* cohorts (LiveBench v1 `2026-06-25`, LiveBench "2.0" branding, tau-bench Banking `v1.0.1`) — not to grouped families | **Within bound**, once attribution is corrected to individual cohorts rather than source families |

Honest accounting of how the overrun happened: counting stopped (informally) once HELM, IFBench, BFCL, and the two LiveBench cohorts and tau-bench Banking had been examined — at the time this felt like "6 source families," but two of those "families" (HELM, LiveBench) each actually contained two internally-distinct release/branding cohorts, so the true distinct-cohort count was already higher than 6 before SWE-bench was opened at all. The three SWE-bench boards (Test, Lite, Multimodal) were then opened as a seventh "family," which, split into its three constituent boards, is cohorts 7–9. **Had cohorts been counted correctly in real time, screening should have stopped at or before cohort 6 (tau-bench Banking), and the three SWE-bench boards should not have been opened.** No retroactive fix is being attempted now — per instruction, this correction performs no further research. The SWE-bench findings (cohorts 7–9) were already gathered and are factual; they are reported below for completeness and honesty, explicitly flagged as beyond the declared 6-cohort screening allowance, not as sanctioned additional screening.

IFBench's maintainer-README re-fetch is **excluded from the 9-cohort count entirely** — it is a document/freshness check (confirming this one file is unchanged and contains no results table), not a dataset/harness/release cohort with any result rows to match against the eligible union. It is reported separately below for completeness.

## Corrected screen ledger (9 distinct cohorts actually touched against a declared 6-cohort bound)

| # | Cohort (dataset/harness/release) | New vs. previously-known | Depth | Disposition |
|---|---|---|---|---|
| 1 | HELM IFEval, release `v1.13.0` | Previously-unchecked release | Screened | No eligible-union model |
| 2 | HELM IFEval, release `v1.14.0` | Rechecked release already named in the initial audit | Screened | No eligible-union model |
| 3 | BFCL score snapshot `2025-12-16` | Previously-unchecked, newer snapshot | Screened | Only `Claude-Haiku-4-5` present; updated scores, still one model, no effort field |
| 4 | LiveBench — classic admitted `/v1` feed, release `2026-06-25` | Freshness re-confirmation of an already-admitted source | **Deep-checked** | Confirmed still the latest release; exhaustive 71-row eligible-model match built |
| 5 | LiveBench — `livebench.ai` "2.0" marketing branding | Re-screen of a source flagged "inconclusive" in the prior audit | **Deep-checked (attempt)** | **Inconclusive, distinct from cohort 4** — retracted from "resolved" (see Cohort 5 below); circumstantial-only evidence found, no primary-source identity proof |
| 6 | tau-bench Banking (`tau2-bench` `v1.0.1`), 4-model cohort | Reuses prior captures; new per-profile eligibility cross-reference against the pinned baseline | **Deep-checked** | All 4 models are exact-match eligible configurations in Agentic Implementation and Deep Reasoning; genuinely additional, non-AA lineage confirmed; publication date unknown-flagged (corrected, see Cohort 6 below) |
| 7 | SWE-bench — Test board | Previously-unchecked board, same-day cached payload | Screened | Zero eligible-union models |
| 8 | SWE-bench — Lite board | Previously-unchecked board, same-day cached payload | Screened | Zero eligible-union models |
| 9 | SWE-bench — Multimodal board | Previously-unchecked board, same-day cached payload | Screened | Zero eligible-union models |

Non-cohort check (excluded from the count above): **IFBench maintainer README re-fetch** — byte-identical to the already-indexed capture; this is a freshness check on one file (confirming that specific README is unchanged and contains no results table within it), not a dataset/harness/release cohort with result rows, and not a claim about whether IFBench has published results anywhere else (e.g., a separate results page, paper appendix, or dataset repo not re-checked in this pass).

Cohorts 1–3 and 7–9 were screened for exact eligible model/effort overlap first and conclusively yielded nothing new (mechanical pattern-matching against already-cached or newly-fetched artifacts, no multi-step forensic work required). Genuine deep-check effort — multi-step reverse engineering, cross-referencing against the pinned baseline's full eligible-configuration pool, or metric-semantics verification against primary methodology documents — was spent on cohorts 4, 5, and 6 specifically (three distinct cohorts, matching the 3-deep-check cap once attributed correctly rather than to grouped "LiveBench" or "SWE-bench" families).

---

## Cohort 1 — HELM IFEval, `v1.13.0`

- Bucket listing (`capabilities/benchmark_output/runs/v1.13.0/...ifeval:model=...`) contains exactly two model dirs: `anthropic_claude-sonnet-4-5-20250929` and `qwen_qwen3-next-80b-a3b-thinking`. Neither is in the 21-model eligible union (`claude-sonnet-4-5` is a different, earlier generation than eligible `claude-sonnet-5`/`claude-sonnet-5.5`).
- Capture: `helm-gcs-bucket-listing-v1.13.0.json` (1,310 bytes, SHA-256 `E38565E2887125FEC70FFCEB7603E4F45107C3970C2014DE9767A69BE3E6CB9D`). Source: `https://storage.googleapis.com/storage/v1/b/crfm-helm-public/o?prefix=capabilities/benchmark_output/runs/v1.13.0/&delimiter=/&maxResults=50`.
- **Disposition: Hold — no new eligible-union coverage.**

## Cohort 2 — HELM IFEval, `v1.14.0`

- Bucket listing contains exactly two model dirs: `ibm_granite-4.0-h-small` and `ibm_granite-4.0-micro`. Neither is eligible.
- Combined with cohort 1 and the already-audited `v1.15.0` (one eligible model, `claude-haiku-4.5`, plus two non-eligible models), **no HELM IFEval release in `v1.13.0`–`v1.15.0` contains a second eligible model** to form the required two-model comparison.
- Capture: `helm-gcs-bucket-listing-v1.14.0.json` (1,190 bytes, SHA-256 `D44295A03AC485FDA58BF99218A2474950174B2D5474CFCA275326A08C4035C4`). Source: `.../runs/v1.14.0/&delimiter=/&maxResults=50`.
- **Disposition: Hold — no new eligible-union coverage.** Earlier releases (pre-`v1.13.0`) remain unchecked and this is not a claim of their emptiness.

## Non-cohort check — IFBench maintainer materials (re-fetch; document check, not a result cohort)

- Re-fetched `https://raw.githubusercontent.com/allenai/IFBench/main/README.md`. Result is **byte-identical** to the capture already indexed in `reports\public-source-coverage-audit.md` (SHA-256 `3AEDA5D9691BA92C2439A3ED881C51F342F3E609E997EE66F854F12138F73807` both times; new local copy `captures\ifbench-readme-rechecked.md`).
- **Disposition: Hold — this one file confirmed unchanged.** No new results table exists **within this README file** compared to the prior audit's capture. This is not a claim that IFBench has published no results anywhere (a separate results page, dataset repo, or paper appendix was not re-checked in this pass). This check is excluded from the 9-cohort count: it verifies the freshness of a document, not a dataset/harness/release with result rows to match against the eligible union.

## Cohort 3 — BFCL fresh snapshot, `2025-12-16`

- `https://raw.githubusercontent.com/HuanzhiMao/BFCL-Result/main/2025-12-16/score/data_overall.csv` (33,046 bytes, SHA-256 `EDE5081A24BC5AC7F9B3B09A52AF6BCFCD35AA0F1709239FED979DB77A8159A6`) is a newer dated folder than the previously-audited `2025-11-03` snapshot (discovered via the GitHub Trees API directory listing).
- `Claude-Haiku-4-5-20251001` is still the only eligible-union model name present: FC mode **68.70%** (up from 61.79% in the older snapshot), Prompt mode **25.26%** (down from 26.24%). The 33 score columns do not include a reasoning-effort/thinking-budget column (confirmed by listing all 34 header fields).
- A broad regex scan of all 21 eligible model-name stems against this CSV found only `Haiku-4.5` (4 cells) and `grok-4` (4 cells); the `grok-4` hits are `Grok-4-0709`, `Grok-4-1-fast-reasoning`, `Grok-4-1-fast-non-reasoning` — an **earlier, non-eligible** xAI generation, not `grok-4.5`/`grok-4.6`.
- **Disposition: Hold — scores refreshed, coverage unchanged.** Still one model, two modes (not two models), no effort field, and no independent second eligible model.

## Cohort 4 — LiveBench classic admitted `/v1` feed, release `2026-06-25` (deep-checked)

**4a. Confirming `2026-06-25` is still the latest release.**
The app bundle (`livebench-main.js`, 386,105 bytes, SHA-256 `B4158E5400886BA821E3C3B284A4A0B36687FFD04FAEDBE8A0492CF29D79EE8F`) contains a hard-coded release list: `["2024-06-24","2024-07-26","2024-08-31","2024-11-25","2025-04-02","2025-04-25","2025-05-30","2025-11-25","2025-12-23","2026-01-08","2026-06-25"]`. **Within this one captured bundle**, no release after `2026-06-25` is listed (later-looking dates such as `2026-07-22`, `2026-09-10`, `2026-10-14` found elsewhere in the bundle are individual model-announcement/version dates and a methodology-note date, not new dataset releases). This is a claim about the contents of this specific captured bundle at this specific retrieval time — not a claim that no later release exists anywhere (e.g., a server-side release the publicly-served bundle has not yet been rebuilt to reference, or a release on a different route not fetched in this pass). **Within that scope, the admitted `2026-06-25` table (71 rows) is the most recent release this screening found; this is a bundle-scoped freshness re-confirmation, not new source admission and not a universal claim of absence.**

**4b. Exhaustive eligible-model match against the `2026-06-25` table.**
All 71 row names were enumerated and matched against the 21-model eligible union, cross-checked against the bundle's own per-model effort-label metadata object (which disambiguates bare, unsuffixed row names):

| Eligible model | Row(s) found in `table_2026_06_25.csv` | Effort(s) actually tested |
|---|---|---|
| `claude-haiku-4.5` | none | — |
| `claude-haiku-5.5` | `claude-haiku-5-5-max-effort`, `-xhigh-effort` | max, xhigh |
| `claude-opus-4.8` | `claude-opus-4-8-max-effort` | max |
| `claude-opus-4.8-fast` | none | — |
| `claude-opus-5` | `claude-opus-5-max-effort` | max |
| `claude-opus-5.5` | `claude-opus-5-5-max-effort`, `-xhigh-effort` | max, xhigh |
| `claude-sonnet-5` | `claude-sonnet-5-xhigh-effort` | xhigh |
| `claude-sonnet-5.5` | `claude-sonnet-5-5-max-effort`, `-xhigh-effort` | max, xhigh |
| `gemini-3.8-flash` | `gemini-3.8-flash-high` | high (see mismatch note below) |
| `gemini-4-argon` | none | — |
| `gpt-5.3-codex` | none | — |
| `gpt-5.6-luna` | `gpt-5.6-luna-max` | max |
| `gpt-5.6-sol` | `gpt-5.6-sol-max` | max |
| `gpt-5.6-terra` | `gpt-5.6-terra-max` | max |
| `gpt-6-astra` | `gpt-6-astra-max` | max |
| `gpt-6-luna` | `gpt-6-luna-max` | max |
| `gpt-6-sol` | `gpt-6-sol-max` | max |
| `gpt-6.1-sol` | `gpt-6.1-sol-max`, `-xhigh` | max, xhigh |
| `grok-4.5` | bare `grok-4.5` row | **xhigh** (per bundle metadata: `"grok-4.5":{...,"effort":"xhigh"}` — not an unlabeled/ambiguous row) |
| `grok-4.6` | bare `grok-4.6` row | **xhigh** (per bundle metadata: `"grok-4.6":{...,"effort":"xhigh"}`) |
| `mai-code-1.1-flash` | none | — |

A full list of all 71 row names was enumerated to confirm no `-medium` or plain `-low`/`-none` row exists anywhere in this release for any of the above models; the only non-`max`/`xhigh` rows in the entire table belong to non-eligible model generations (`claude-opus-4-5-...-high-effort`, `claude-opus-4-6-...-high-effort`, `claude-sonnet-4-6-...-medium-effort`, `gemini-3.1/3.5/3.6/3.7-flash-high`, `gpt-5.2-...-high`, `mistral-large-4-high`).

**Configuration-identity flag (per the "never infer effort:none from an unlabeled row" / native-execution-identity rule):** `gemini-3.8-flash` is `effortMode: "unsupported"` / `supportedEfforts: []` in `config\model-capabilities.json` — its only native CLI configuration is `effort: none`. The LiveBench `gemini-3.8-flash-high` row is a **different, externally reasoning-enabled deployment surface**, not evidence of this project's native `none` configuration. It is **not usable** as a match for the Quick/Visual-UI incumbent (`gemini-3.8-flash/none`) or for Review's `gemini-3.8-flash/none` eligible row. This is a conflation risk to flag, not a resolution.

**Net effect on the priority targets, via this source specifically:**
- Default Development needs `gpt-6.1-sol / medium-or-high` (IF) and `gpt-5.6-sol / medium-or-high` (primary) — table has only `max`/`xhigh` for both. **Unfilled.**
- Mechanical needs `gpt-6-sol / low`; Triage needs `gpt-6.1-sol / low` — table has only `max` / `max`+`xhigh`. **Unfilled.** More broadly, cross-checking Mechanical/Triage's full 13-model `low`/`none`-effort eligible pool against all 71 rows found **zero** exact matches (the closest candidates, `grok-4.5`/`grok-4.6`, are confirmed `xhigh`, not `low`). This is now an exhaustively confirmed, not merely unexamined, gap for this source.
- Review needs `medium`/`high` (or the two `none` exceptions) across 19 models/35 configs — **zero** of the 71 rows match any of the 35 required configurations exactly (table rows are max/xhigh/bare-xhigh, or `-high` only for the non-native-identity-matching `gemini-3.8-flash`). **Unfilled**, exhaustively confirmed.
- Quick/Visual incumbent (`gemini-3.8-flash/none`) — present only as a mismatched-identity `-high` row. **Unfilled.**

**Disposition: usable only as a freshness/negative confirmation, not new coverage.** Capture: `livebench-main.js`, `livebench-table_2026_06_25.csv` (11,910 bytes, SHA-256 `09D810986777C92B75B40A58A1829E0318E34CB5693ECAE970B3145852271BA7`, 71 rows — matches the row count already described as admitted in the handover), `livebench-categories_2026_06_25.json`, `livebench-cost_2026_06_25.csv` (30,993 bytes, SHA-256 `C4227B553186ADE582022EA19D04B91B75B577CCCADB88F6E00857A27EEB84B8`, captured for completeness, not used in any claim above). Source URLs: `https://livebench.ai/`, `https://livebench.ai/v1/table_2026_06_25.csv`, `.../categories_2026_06_25.json`, `.../cost_2026_06_25.csv`.

## Cohort 5 — LiveBench "2.0" marketing branding (deep-checked attempt; **corrected: retracted from "resolved" to distinct/inconclusive**)

**This is a counted, distinct cohort-screening attempt from cohort 4, not the same cohort.** The original version of this report merged this branding-screening attempt into cohort 4 and concluded it "resolves (does not merely re-flag) the prior audit's inconclusive/blocked LiveBench-2.0 disposition: it is brand repositioning of the same admitted feed, not a new source requiring separate admission." **That conclusion is retracted.** Absence of found evidence for a separate v2 dataset/API is not proof that one does not exist, and none of the material found constitutes a primary-source identity statement ("2.0 is the same dataset as v1") or an exact evaluator/dataset-binding statement from the publisher.

What was actually found, reported now as circumstantial/suggestive, not conclusive:
- The live homepage (`https://livebench.ai/`) carries the eyebrow label "LiveBench 2.0" and hero copy: *"We give models real work (decks, research reports, bug fixes, apps that run for hours) and grade what they hand back. We use these results to power our powerful agent and supercomputer, available via an Abacus AI subscription."*
- The same app bundle (`livebench-main.js`, hash as in cohort 4) renders a leaderboard section that literally renders `"Showing the {release} release"` and fetches `./v1/table_{release}.csv` — the identical admitted route already referenced in the handover (`model-review-report.ps1:424`).
- The bundle's category catalog (`livebench-categories_2026_06_25.json`, 725 bytes, SHA-256 `DAD300AD18655B69DB720E1B88FC5A5EAC06C5B2F0E52C2BF50F10FF057674F3`) still defines the classic categories (Reasoning, Coding, Agentic Coding, Instruction Following, Mathematics, Data Analysis, Language) — none of which correspond to "decks," "research reports," or "hour-long apps."
- No second, separate dataset or API endpoint matching the hero copy's description was found in this screening's searches.

None of these four observations, individually or combined, is a primary-source statement that the "2.0" branding and the classic `/v1` feed are the *same evaluated artifact*. They are equally consistent with: (a) "2.0" being pure marketing copy over the unchanged `/v1` dataset (the original, now-retracted, conclusion), or (b) "2.0" referring to a genuinely different evaluation product/dataset not yet surfaced in the publicly-reachable bundle and routes this screening inspected, or (c) a transitional state where "2.0" branding has been deployed ahead of a dataset change that has not yet shipped. This screening's searches cannot distinguish between these without an explicit publisher statement, and none was found.

**Disposition: Hold — distinct, inconclusive.** This reinstates (does not newly establish) the prior audit's own "inconclusive/blocked" disposition for "LiveBench 2.0." It is counted here as its own cohort-screening attempt (distinct from cohort 4's `/v1` freshness confirmation) because real screening effort was spent specifically trying to characterize it, per the correction instruction that "the admitted LiveBench v1 and branded v2 cannot be merged without proof." No eligible-model match table is produced for "2.0" because no distinct "2.0" dataset/leaderboard artifact (separate from the `/v1` table already covered in cohort 4) was found to match against.

## Cohort 6 — tau-bench Banking `v1.0.1` (deep-checked, new cross-reference; **corrected: publication-date and lineage framing**)

The prior audit (`public-source-coverage-audit.md`, "Follow-up: tau-bench Banking" section) already verified four `submission.json` rows — `claude-opus-5/max`, `grok-4.5/high`, `gpt-5.6-sol/xhigh`, `claude-opus-4.8/max` — as a mutually comparable, post-`v1.0.1`-fix, Sierra-submitted cohort (`tau2_bench_version: "1.0.1"`, identical `retrieval_config: "alltools"`, `user_simulator: "gpt-5.2"`, `num_trials: 4`), but explicitly stated: *"Whether any two of these four rows share a profile-admissible effort band for any specific profile was **not** re-evaluated in this task and is **not** resolved by this packet... reserved for the parent."* This screening performs exactly that reserved cross-reference against the pinned baseline, reusing the four already-captured `submission.json` files (hashes independently re-verified in this session; no new fetch performed) rather than re-downloading them.

**Per-profile eligible-configuration match (against `public-source-baseline.json`'s `eligibleConfigurations` per profile), including each profile's fixed `context` value:**

| Profile | Fixed `context` for this profile's eligible pool | `gpt-5.6-sol/xhigh` | `claude-opus-4.8/max` | `grok-4.5/high` | `claude-opus-5/max` |
|---|---|:---:|:---:|:---:|:---:|
| Orchestrator | `default` | — | — | ✓ | — |
| Quick | `default` | — | — | — | — |
| Default Development | `default` | — | — | ✓ | — |
| **Agentic Implementation** | `default` | **✓** | **✓** | **✓** | **✓** |
| **Deep Reasoning** | `long_context` | **✓** | **✓** | **✓** | **✓** |
| Review | `default` | — | — | ✓ | — |
| Visual/UI | `default` | — | — | — | — |
| Mechanical | `default` | — | — | — | — |
| Triage | `default` | — | — | — | — |

All four efforts are confirmed **native/supported** per `config\model-capabilities.json`: `gpt-5.6-sol` supports `xhigh`; `claude-opus-4.8` and `claude-opus-5` support `max`; `grok-4.5` supports `high`. None are inferred or unlabeled. The `context` column (added in this correction pass; the original version matched model/effort only and omitted this dimension) is a **profile-wide fixed assignment**, not a mixed per-row field: every eligible configuration in Deep Reasoning's 35-config pool uses `context: "long_context"`; every eligible configuration in Agentic Implementation (44 configs), Orchestrator (25), Default Development (31), and Review (35) uses `context: "default"`. tau-bench Banking's own methodology does not vary by this field — it is a property of the baseline's profile-pool definition, not of the benchmark submission — so it does not itself create or remove a match; it is reported for completeness per instruction.

**Agentic Implementation and Deep Reasoning each have all four tau-bench Banking models/efforts as exact-match members of their existing eligible-configuration pool.** `tau2-bench`'s `banking_knowledge` pass^k metric (pass_1..pass_4, multi-turn tool-use/retrieval reliability under a simulated user) is in a **distinct metric namespace from every existing `evidenceMetrics` route** in `config\model-policy.json` (all AA- or LiveBench-sourced) and is **not an AA component** — satisfying "new AA components alone are NOT independent."

Checking where these four configurations already sit in each profile's **currently measured** routes (not just the generic eligible pool):
- **Agentic Implementation** — `liveBench.agenticCoding` (its primary route) already separately measures `claude-opus-4.8/max` (score 50.505) and `claude-opus-5/max` (score 65.202); `gpt-5.6-sol/xhigh` and `grok-4.5/high` are eligible but **not** currently measured by any route. tau-bench Banking would be a complementary corroborating measurement for the first two, and net-new coverage breadth (not a filled policy route, since none exists for this metric) for the latter two.
- **Deep Reasoning** — `artificialAnalysisComponents.lcr` (its long-context route) already separately measures all four at these exact efforts: `claude-opus-4.8/max` (0.7767), `claude-opus-5/max` (0.7933), `gpt-5.6-sol/xhigh` (0.8233), `grok-4.5/high` (0.7933). `liveBench.reasoning` (its primary route) separately measures `claude-opus-4.8/max` (89.19) and `claude-opus-5/max` (91.21). tau-bench Banking would be a clean complementary measurement across all four already-measured configurations.

**Correction — publication date vs. evaluation/submission date (this revision).** The original version of this report wrote: *"evaluation dates are 92–104 days old and submission date is 91 days old as of this report's date, all exceeding the stated 90-day freshness ceiling for current-target counting... this cohort's historical/evaluation-age status... places it outside the current freshness window."* **This was an error and is retracted.** Evaluation date (Sierra ran the benchmark: 2026-07-22 to 2026-08-03 across the four rows) and submission date (packaged to the leaderboard: 2026-08-04, identical for all four) are known and are correctly disclosed, but neither is a publication date, and neither was ever shown by this screening or the prior audit to be a valid proxy for one. The cohort's actual **publication date remains unknown** — not independently established by either audit. Per the accepted tiered rule: a **known** published age exceeding 90 days excludes a cohort from current target counts; an **unknown** publication date **may still count toward exact-configuration coverage**, provided it is explicitly flagged as unknown (which it is, here and in the data packet below). **Corrected disposition: this cohort is flagged-unknown-publication-date data that may count toward exact-configuration coverage — it is not publication-stale data that is excluded.**

**Correction — lineage independence vs. result-level replication (this revision, explicit distinction preserved).** Two separate questions, not to be conflated:
1. *Is tau2-bench a genuinely additional benchmark lineage relative to the admitted AA/LiveBench measurements?* **Yes at the dataset/harness level.** It has a different named publisher (Sierra), a multi-turn simulated-user tool-use methodology, and a separate reliability metric family. This is not proof of complete institutional independence, disjoint judge dependencies, or independent replication of these results.
2. *Are the four specific `banking_knowledge` scores in this cohort independently replicated or corroborated by a separate party?* **No.** All four rows were submitted by Sierra — tau2-bench's own commercial maintainer — in the identical submission batch (`submission_date: 2026-08-04` for all four). No third party has re-run or independently verified any of the four specific numbers. This self-submission conflict is disclosed, carried forward unchanged from the original audit (not newly discovered, not resolved by lineage independence).

These two answers (lineage-independent: yes; independently-replicated: no, not claimed) must be reported together, not merged into a single "independent" or "not independent" label.

**Other disclosed limitations (carried forward unchanged from the prior audit, not re-litigated):** `cost` unreported for all four rows; the only LLM-judged component of the reward basis (`NL_ASSERTION`, a small banking task subset) uses `gpt-4.1-2025-04-14`, not the later 2.0-era judge models (`gpt-5.4-mini-2026-03-17`, `gpt-5.5`) that apply to unrelated, non-cohort benchmarks; the default `[DB, COMMUNICATE]` reward basis is fully deterministic (hash/substring match, no LLM judge) for the remainder of the task set; `tau2-bench v1.0.1` (2026-07-15) is a grading-affecting release specifically for `banking_knowledge` (fixes a read-call reward bug, sierra-research/tau2-bench#329, described by the maintainer's changelog as accounting for "nearly all score movement," and a gold-value fix on task_074, sierra-research/tau2-bench#374); all four cohort rows are confirmed **post**-fix via their `methodology.tau2_bench_version: "1.0.1"` field, so they are mutually comparable to each other, but the changelog explicitly states scores from before v1.0.1 must not be compared to these.

**Metric unit, stated honestly (no guessed percent/fraction, per instruction; observed data magnitude is not the same as a verified legal/defined range):** `pass_1`..`pass_4` values in the raw `submission.json` files are stored as plain floating-point numbers (e.g., `48.71134020618557`). No excerpt read in this screening or the prior audit contains an explicit maintainer statement that these numbers are "a percentage," "a 0–1 fraction," or any other named unit, and none states the metric's defined minimum/maximum bounds. The 16 values actually observed across all four submissions' `pass_1`..`pass_4` fields fall between `22.68041237113402` and `48.71134020618557`, with `pass_1 > pass_2 > pass_3 > pass_4` monotonically decreasing per model — consistent with a pass^k-style "all of k simulated trials succeed" reliability metric derived from `--num-trials 4`. The original audit's own results table already displayed these values with a `%` suffix, and a 0–100 percentage-style scale is a common convention for metrics of this shape, but **this is an unverified assumption about the metric's bounds, not a confirmed legal range** — no maintainer text states "0" and "100" as the metric's floor/ceiling. This report carries the raw numeric value and the observed 22.68–48.71 data range only, flagged as "scale consistent with, but not independently confirmed as, a 0–100 percentage," rather than asserting either a unit or a verified range as fact. See `banking-admission.json` (below) for the exact raw values carried through with this same honest hedge.

**Disposition: lineage/configuration-cohort membership verified (not score admission) — 4 eligible models/efforts/contexts within one profile cohort (actually two: Agentic Implementation and Deep Reasoning), confirming literally what the prior audit left unresolved; publication date flagged unknown (not stale), so this membership counts toward exact-configuration coverage under the corrected tiered rule.** This is new analysis (a baseline eligibility cross-reference), not a new fetch; it reuses previously-captured, hash-verified primary artifacts (`taubench-banking-manifest.json`, four `submission.json` files — hashes listed in the capture manifest and in `banking-admission.json`). It does **not** itself touch Default Development, Mechanical, Triage, Review, Quick, or Visual-UI's stated gaps (tau-bench Banking is not an IF, reasoning-route, or incumbent-fallback metric for those profiles), and it does **not** fill any Agentic/Deep Reasoning gap that didn't already exist (both profiles already have complete incumbent comparisons and are part of the 5/9 current-route coverage) — it is additive/complementary breadth, consistent with the "add complementary primary-task measurements" target, plus a clean, bounded satisfaction of the configuration/lineage half of the "≥1 genuinely additional evaluation lineage with ≥2 eligible models within one specific profile cohort" target. **This disposition is explicitly NOT score admission:** the pass_k unit/range is unverified (above), and no score has been normalized or activated into any route or quality band by this screening.

## Cohort 7 — SWE-bench Test board

- Embedded `<script id="leaderboard-data">` JSON blob inside the already-captured, same-day `swebench-index.html` (2,392,125 bytes, SHA-256 `C862011A4EE1D1A7199FAD6CA0905FA5C64F58216F7217AC1EDDF37F28788433` — re-verified identical to the audit's recorded hash; no new fetch), Test board section: matches resolve to `claude3opus`, `claude3.5sonnet`, and one `claude-opus-4-5` row (`20251219_sonar-foundation-agent_claude-opus-4-5`) — `claude-opus-4-5` is an earlier generation than eligible `claude-opus-4.8`/`claude-opus-5`, not a match.
- **Disposition: Hold — no eligible-union model.**

## Cohort 8 — SWE-bench Lite board

- Same captured payload, Lite board section (161 raw text matches for `haiku|opus|sonnet`): every distinct submission folder resolves to a **pre-4.5/pre-5-generation** Claude model (`claude-3.5-sonnet`, `claude-3-opus`, `claude-3.7-sonnet`, `claude-4-sonnet`) — none in the 21-model eligible union.
- **Disposition: Hold — no eligible-union model.**

## Cohort 9 — SWE-bench Multimodal board

- Same captured payload, Multimodal board section: matches resolve only to `claude3.5`/`claude3.7`/`claude4-sonnet` folders — same outcome, no eligible model.
- **Disposition: Hold — no eligible-union model.**

**Combined note for cohorts 7–9 (corrected scope of absence claim):** Explicit targeted regex checks across **all five boards present in this one captured snapshot** (Test, Lite, Multimodal, plus the already-audited Verified and Multilingual) for `gemini-3\.8`, `gemini-4-argon`, `mai-code`, `claude-opus-4-8-fast`, `claude-haiku-5-5`, `gpt-5\.6`, `gpt-6\.1`, `gpt-6-sol`, `gpt-6-luna`, `gpt-6-astra`, `claude-opus-5\.5`, `claude-sonnet-5\.5`, `gpt-5\.3-codex` all returned **zero matches**. **Corrected claim scope:** this confirms the Quick/Visual-UI `gemini-3.8-flash/none` incumbent is absent from the **Test, Lite, Multimodal, Verified, and Multilingual boards as enumerated in the one `swebench-index.html` payload captured at this screening's retrieval time** — not a claim that it is absent from "SWE-bench entirely," from any other filter/tag/category the live site may expose, or from any future snapshot. The original version of this report made the broader, uncorrected claim; that broader claim is retracted here.

---

## Acceptance-target assessment (data found vs. not found; no selection/routing changes made or proposed)

| Target | Status after this screening (corrected) |
|---|---|
| All 9 profiles: ≥2 distinct eligible models per comparable primary/required-dimension cohort | **Unchanged.** No cohort screened supplies a second comparable model for Default Development's primary∩IF intersection, Mechanical/Triage's IF cohort, or Review's reasoning cohort. |
| All 9 profiles: ≥1 exact model/effort configuration measured across all required dimensions | **Unchanged** for Default Development (still 0), Mechanical (still 0), Triage (still 0), Review (still 0). |
| ≥6 profiles with complete incumbent comparisons (existing 3 + Quick + Visual + ≥1 additional) | **Unchanged — still 3/9** (Orchestrator, Agentic Implementation, Deep Reasoning). Quick and Visual-UI's incumbent (`gemini-3.8-flash/none`) was explicitly screened for in BFCL, HELM, the enumerated SWE-bench boards, and LiveBench, and found **absent in every artifact actually enumerated** (one LiveBench row exists only under a configuration-identity-mismatched `-high` label, correctly not counted); this is scoped to the artifacts checked, not a claim about every possible source. |
| Add complementary primary-task measurements | **Partially met.** tau-bench Banking's `v1.0.1` `banking_knowledge` cohort supplies a comparable, non-AA, complementary measurement across all four already-measured Deep Reasoning long-context (LCR) configurations and two already-measured Agentic Implementation primary (`liveBench.agenticCoding`) configurations. This is corroborating breadth on profiles that already have coverage, not new coverage on gapped profiles. |
| ≥1 genuinely additional evaluation lineage with ≥2 eligible models within one specific profile cohort (new AA components alone do not count) | **The lineage/configuration-cohort membership is verified; this is not score admission.** tau-bench Banking (`tau2-bench v1.0.1`, a non-AA, non-LiveBench, maintainer-run lineage) supplies 4 eligible models at exact native efforts, matching the full eligible-configuration pool of both Agentic Implementation and Deep Reasoning — exceeding the ≥2 threshold in either profile alone. Its publication date is **unknown, not known-stale** — flagged as such, it counts toward exact-configuration coverage under the corrected tiered rule, rather than being excluded by an evaluation/submission-age calculation that was never a valid publication-age proxy. Lineage is genuinely independent of AA/LiveBench; the four specific results are **not** independently replicated (all four self-submitted by Sierra, the benchmark's own maintainer, in one batch) — both facts are preserved together. **What remains unverified and is NOT claimed:** the `pass_1`..`pass_4` numeric unit (percent vs. fraction vs. some other scale) is not confirmed by any maintainer prose found; no score has been normalized, converted, or activated into any route/band; this row reports a verified configuration/lineage match only. |
| Review reasoning (externally measured additional lineage) | **Not met.** LiveBench (Review's sole permitted `evidenceRoutes` entry for reasoning) was exhaustively checked against all 35 of Review's eligible configurations; zero matches found, across all 71 rows in the current release. tau-bench Banking's metric is workflow/tool-use reliability, not reasoning, and cannot (without a policy change, which is out of scope) satisfy Review's `liveBench.reasoning`-only route. |
| Default Development / Mechanical / Triage repair via IF/IFEval/IFBench | **Not met.** HELM IFEval (`v1.13.0`, `v1.14.0`, and the already-audited `v1.15.0`) and IFBench's maintainer README were exhaustively screened; no second eligible model exists in any checked release, and no new IFBench results table has been published. |

## What remains genuinely unmet, and why (not a fabricated success)

- **Default Development's primary∩IF intersection remains empty.** No screened source — HELM, IFBench, BFCL, LiveBench, tau-bench, or SWE-bench — provides a `gpt-6.1-sol`/medium-or-high IF score or a `gpt-5.6-sol`/medium-or-high primary-intelligence score. This is a confirmed, not merely unexamined, gap within the cohorts actually touched.
- **Mechanical and Triage's two-distinct-model IF cohort remains unformed.** LiveBench's current release was exhaustively checked against the full 13-model low/none-effort eligible pool for both profiles and found zero matching rows (the closest-looking candidates, bare `grok-4.5`/`grok-4.6` rows, resolve via the source's own metadata to `xhigh`, not `low`, so they do not qualify and were correctly excluded rather than assumed).
- **Review's reasoning route remains unfilled.** The sole permitted route (`liveBench.reasoning`) was checked exhaustively; no medium/high-effort row exists for any of Review's 19 eligible models in the current LiveBench release.
- **Quick and Visual-UI's incumbent fallback (`gemini-3.8-flash/none`) remains unmeasured externally**, scoped to the artifacts actually checked: absent from BFCL's `2025-12-16` snapshot, HELM's `v1.13.0`–`v1.15.0` releases, and the Test/Lite/Multimodal/Verified/Multilingual boards in the one captured SWE-bench snapshot; present in LiveBench only under a mismatched deployment/effort identity (`-high`) that must not be substituted for the native `none` configuration. This is not a claim about every possible SWE-bench filter, board, or future snapshot.
- **The ≥1-additional-lineage target is the one target this screening can report as configuration/lineage-verified** (not score-admitted), via tau-bench Banking's four-model cohort landing inside Agentic Implementation's and Deep Reasoning's existing eligible-configuration pools — a genuinely new determination (not previously resolved) built from already-captured primary artifacts, with its publication date correctly flagged unknown rather than excluded as stale. This is a membership/provenance finding, not an admission of its scores: the `pass_1`..`pass_4` unit remains unconfirmed and no normalization or activation has occurred (see Cohort 6 and `banking-admission.json`).
- **LiveBench "2.0" remains distinct and inconclusive**, not resolved as a rebrand. No primary-source identity statement was found; this screening cannot and does not claim the matter is settled.

No new selection route, quality band, or qualification-dimension was proposed or implied for tau-bench Banking or any other cohort; that determination remains, as stated by the user, out of scope for this task and reserved for the parent/maintainers. Producing this report does not constitute acceptance of any data pack, and no role-activation or changed-winner claim is made anywhere above.

## Capture index (this session's new artifacts)

All retrieved **2026-11-03**, UTC session time, under `C:\Users\JesperKF\.copilot\session-state\0e7ebf18-f781-43cb-b0eb-fbc943c4ba4d\files\public-evidence-screening\captures\`. Full machine-readable manifest (including reused prior-session artifact hashes, independently re-verified in this session): `...\public-evidence-screening\capture-manifest.json`. A small machine-readable data packet for the tau-bench Banking cohort (cohort 6) is additionally saved at `...\public-evidence-screening\banking-admission.json` (data-only; not a route or band approval — see below).

| Saved file | Primary URL | Size (bytes) | SHA-256 |
|---|---|---:|---|
| `helm-gcs-bucket-listing-v1.13.0.json` | `https://storage.googleapis.com/storage/v1/b/crfm-helm-public/o?prefix=capabilities/benchmark_output/runs/v1.13.0/&delimiter=/&maxResults=50` | 1,310 | `E38565E2887125FEC70FFCEB7603E4F45107C3970C2014DE9767A69BE3E6CB9D` |
| `helm-gcs-bucket-listing-v1.14.0.json` | `.../runs/v1.14.0/&delimiter=/&maxResults=50` | 1,190 | `D44295A03AC485FDA58BF99218A2474950174B2D5474CFCA275326A08C4035C4` |
| `ifbench-readme-rechecked.md` | `https://raw.githubusercontent.com/allenai/IFBench/main/README.md` | 4,931 | `3AEDA5D9691BA92C2439A3ED881C51F342F3E609E997EE66F854F12138F73807` |
| `bfcl-data_overall-2025-12-16.csv` | `https://raw.githubusercontent.com/HuanzhiMao/BFCL-Result/main/2025-12-16/score/data_overall.csv` | 33,046 | `EDE5081A24BC5AC7F9B3B09A52AF6BCFCD35AA0F1709239FED979DB77A8159A6` |
| `livebench-main.js` | `https://livebench.ai/` (referenced app bundle) | 386,105 | `B4158E5400886BA821E3C3B284A4A0B36687FFD04FAEDBE8A0492CF29D79EE8F` |
| `livebench-table_2026_06_25.csv` | `https://livebench.ai/v1/table_2026_06_25.csv` | 11,910 | `09D810986777C92B75B40A58A1829E0318E34CB5693ECAE970B3145852271BA7` |
| `livebench-categories_2026_06_25.json` | `https://livebench.ai/v1/categories_2026_06_25.json` | 725 | `DAD300AD18655B69DB720E1B88FC5A5EAC06C5B2F0E52C2BF50F10FF057674F3` |
| `livebench-cost_2026_06_25.csv` | `https://livebench.ai/v1/cost_2026_06_25.csv` | 30,993 | `C4227B553186ADE582022EA19D04B91B75B577CCCADB88F6E00857A27EEB84B8` |

Reused prior-session artifacts (not re-fetched; hashes independently re-verified in this session and matched the audit's recorded values): `swebench-index.html` (SHA-256 `C862011A4EE1D1A7199FAD6CA0905FA5C64F58216F7217AC1EDDF37F28788433`), `taubench-banking-manifest.json`, and the four `taubench-banking-submission-*.json` files (hashes, source URLs, and retrieval timestamps in the capture manifest and in `banking-admission.json`). `banking-admission.json` also now carries source URL/retrieval-timestamp provenance for the pinned grading/methodology documents used in Cohort 6's cohort-compatibility claims (`tau2bench-v1.0.1-evaluation-md-excerpt.md`, `tau2bench-v1.0.1-config-py-excerpt.py`, `tau2bench-leaderboard-submission-doc-excerpt.md`, `tau2bench-changelog-1.0.1-section-excerpt.md`), all sourced from the prior session's existing `capture-index.json` (not re-fetched, not re-dated).

## Gaps and scope notes

- Earlier HELM releases (pre-`v1.13.0`), the full IFBench paper's model-comparison tables, and complete LongBench v2 row/configuration coverage remain unchecked (the bound was spent on cohorts judged more promising for the stated priorities; this is an unverified gap, not zero coverage).
- The legacy `tau2` text tab and the 2.0 `text-v1` tab's availability were not re-checked in this pass (the Banking cross-reference satisfied the "additional lineage" target before this fallback was needed, consistent with the user's own stop-on-verified-cohort instruction carried over from the prior audit).
- This screening did not touch, re-verify, or make any claim about the parent-handled Artificial Analysis `intelligenceIndexEvaluations` (`frontiercode-2-0`, `terminalbench-4-0`, `critpt-v2-hard`) ingestion.
- **Bound overrun, stated honestly:** this screening actually touched 9 distinct dataset/harness/release cohorts (see "Corrected bound accounting" above) against a declared 6-cohort screening bound — exceeded by 3. This is a correction of a counting error (grouping distinct releases/boards under single source-family ledger rows in the original version), not newly performed research; no cohort has been added, removed, or re-investigated since the original pass to produce this corrected count. Per instruction, no further research was performed to "fix" the overrun after discovering it; it is reported as-is.
- LiveBench "2.0"'s relationship to the classic `/v1` feed remains genuinely inconclusive after this screening; it is not established as a rebrand, and it is not established as a distinct dataset. Either could still be true; only a primary-source statement from the publisher could resolve it, and none was found in the material available to this screening.
- tau-bench Banking's publication date remains unknown (not established as stale); this is flagged, not treated as a disqualifying gap, per the corrected tiered rule. See `banking-admission.json` for the full, machine-readable disclosure of this and all other dating fields.
