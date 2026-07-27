---
name: session-time-audit
description: "Estimate AI-assisted vs. no-AI effort for a Copilot CLI session or a manually described task. Extracts (or accepts) what was done and its duration, then produces a calibrated no-AI time estimate and speed multiplier."
---

# Session Time Audit

Produces an AI-assisted-vs-manual time comparison for a piece of work: what was actually done, how long the AI-assisted work took, and a judgment-based estimate of how long a competent developer would need to do the same work unaided.

Supports two data sources:
1. **A real local Copilot CLI session** (current or by ID) — duration comes from real event telemetry, not guesswork.
2. **A manual description** — for work done outside a trackable session (pairing on someone else's screen, a VS Code chat, work from memory, etc.), where the user directly supplies what was done and how long it took.

> **Note**: This skill produces a report only. It reads the local session store and event logs; it does not modify any session, code, or repository. Cloud-hosted sessions are not supported when `session_store_sql (source: cloud)` errors out (e.g. GHE-hosted accounts) — session-mode relies on the **local** session store only.

## Invocation

| Command | Action |
|---------|--------|
| `/session-time-audit` | Audit the **current** session (its ID is available as `$env:COPILOT_AGENT_SESSION_ID`) |
| `/session-time-audit <session-id>` | Audit a specific past local CLI session by ID (a GUID) |
| `/session-time-audit <description>` | **Manual mode** — anything that isn't a bare GUID is treated as a task description. Ask for the AI-assisted time used if it wasn't included inline (e.g. "... in about 45 minutes") |

## Output

A short Markdown write-up (presented in the response; only saved to a file if the user asks):

| Section | Contents |
|---------|----------|
| What was done | A factual, technical summary — grounded in the session's actual checkpoints/turns for session mode, or the user's own description for manual mode |
| AI-assisted time | Session mode: wall span + active-time estimate with method/caveats stated. Manual mode: the time the user supplied, taken at face value |
| No-AI estimate | A range with a reasoned midpoint, explaining *why* (what specifically would be slow/hard without AI) |
| Multiplier | No-AI midpoint ÷ AI active time, with an honest confidence note |

## Prerequisites (session mode only)

- Node.js with `node:sqlite` support (Node 22.5+ with `--experimental-sqlite`, or Node 23.4+ unflagged). Verify with `node --version`; if `node:sqlite` is unavailable, fall back to the `session_store_sql` tool (`source: local`) for the digest step instead of `extract-session-digest.js`.
- Local session store must exist: `%USERPROFILE%\.copilot\session-store.db` and `%USERPROFILE%\.copilot\session-state\<id>\events.jsonl`.

Manual mode has no prerequisites — it only needs the user's own input.

## Workflow

### Phase 0: Determine mode

Look at the argument (if any):
- **No argument** → session mode, current session.
- **A single token matching a GUID/UUID pattern** (`[0-9a-f]{8}-[0-9a-f]{4}-...`) → session mode, that session ID.
- **Anything else (free text)** → manual mode.

**Manual mode:** treat the argument as the task description. If it doesn't already state a duration (look for phrases like "in Xh", "took X minutes", "(45m)"), ask the user directly: *"How much AI-assisted time did this take?"* Do not guess a duration on the user's behalf. Once you have both a description and a time, skip straight to Phase 4 (Phases 1–3 are session-mode-only extraction steps).

**Session mode:** continue to Phase 1.

### Phase 1: Identify the target session

1. If the user supplied a session ID, use it directly.
2. Otherwise, use the current session: `$env:COPILOT_AGENT_SESSION_ID`.
3. Confirm the session exists by checking both:
   - `%USERPROFILE%\.copilot\session-state\<id>\events.jsonl` (for duration)
   - `%USERPROFILE%\.copilot\session-store.db` has a matching row in `sessions` (for content)

   If either is missing, tell the user plainly what's missing rather than guessing (e.g. "no event log exists for this session, so active-time can't be estimated — only wall-clock timestamps from the database are available"). If **neither** exists (e.g. the "session ID" doesn't actually resolve to anything local), offer to fall back to manual mode instead of failing outright.

### Phase 2: Extract duration

Run:
```
node scripts/estimate-session-duration.js <session-id>
```

This computes:
- **`wall_span_min`** — first-to-last-event timestamp span (overstates active effort if the session was resumed across multiple sittings — check `n_blocks`).
- **`active_min_est`** — sum of only consecutive-event gaps ≤10 minutes (an explicit, stated judgment call; longer gaps are treated as idle/away time and excluded).

If `n_blocks > 1`, call this out explicitly — the session was resumed across multiple sittings, so wall span is not a reliable proxy for effort.

### Phase 3: Extract content digest

Run:
```
node scripts/extract-session-digest.js <session-id>
```

This pulls checkpoint overviews (best summaries, if any exist), all user messages (chronological, truncated), and the final assistant response from the local session store. If `node:sqlite` isn't available, use the `session_store_sql` tool (`source: local`) instead:

```sql
SELECT turn_index, user_message, assistant_response, timestamp FROM turns WHERE session_id = '<id>' ORDER BY turn_index;
SELECT checkpoint_number, title, overview FROM checkpoints WHERE session_id = '<id>' ORDER BY checkpoint_number;
```

Read the digest closely enough to describe **what was actually built/fixed/decided** — not just a restatement of the session title. Identify:
- The concrete problem or feature
- Key technical decisions or root causes found
- Whether the work reached a resolved state, or was left incomplete/unvalidated (flag this explicitly — don't assume success)

### Phase 4: Estimate no-AI effort (the judgment-heavy step)

This is deliberately not mechanical — it requires reasoning about developer effort, the same way `/estimate-task` does. **If the current session is running under a lighter task class** (`quick`, `mechanical`, `default-development`), consider delegating this phase to a `deep-reasoning` subagent (via the `task` tool) rather than reasoning it out under a lighter model — the judgment quality matters more here than speed.

Reason from what was actually done (Phase 3 digest for session mode, or the user's own description for manual mode) — not from the session title alone:
1. What would make this slow without AI? (opaque/undocumented internals, cross-system reverse-engineering, obscure platform behavior, trial-and-error debugging, boilerplate volume)
2. What would a competent developer already know how to do quickly? (familiar patterns, established conventions in the codebase)
3. Produce a **range** (e.g. "3–6 h") with a **midpoint**, and state the reasoning in one or two sentences.
4. Compute the multiplier: no-AI midpoint ÷ AI active time.

**Calibration guardrails** (avoid inflating the number):
- Novel/opaque platform internals or heavy reverse-engineering → multiplier **~3.5–5×** (conservative floor)
- Standard feature work with real design decisions → **~6–10×** (most representative band)
- Root-cause debugging of misleading/obscure bugs → **~7–12×**
- Trivial single-shot fixes/Q&A → ratio is statistically noisy (tiny AI time); report the **absolute minutes saved** instead of leaning on the ratio
- If the session's work was left unresolved, unvalidated, or was a workaround rather than a root-cause fix, **say so explicitly** and note that realized time-savings are provisional
- **Manual mode only:** the AI-assisted time is whatever the user stated, taken at face value — don't second-guess or re-derive it, but do note in the output that it's self-reported rather than measured

### Phase 5: Deliver

Present the write-up per the Output table above. Do not write a file unless the user asks — if they do, ask where (a sensible default is `reports/session-time-audits/<session-id-or-slug>.md` inside this repo, git-ignored alongside `usage-log.csv` if it will be run regularly).

## Argument Detection

| Pattern | Type | Action |
|---------|------|--------|
| `/session-time-audit` | No argument | Session mode: use `$env:COPILOT_AGENT_SESSION_ID`, start Phase 1 |
| `/session-time-audit <guid>` | Session ID | Session mode: use the given ID, start Phase 1 |
| `/session-time-audit <free text>` | Description | Manual mode: use as task description, ask for time if not stated, then jump to Phase 4 |

## Task List Structure

```
[Phase 0] Mode - Determine session vs. manual mode from the argument
[Phase 1] Identify - (session mode) Resolve target session ID, confirm data exists
[Phase 2] Duration - (session mode) Run estimate-session-duration.js, note resumption/multi-block caveats
[Phase 3] Digest - (session mode) Run extract-session-digest.js (or session_store_sql fallback), read what was actually done
[Phase 4] Estimate - Reason a no-AI range + midpoint + multiplier, escalate to deep-reasoning if judgment quality needs it
[Phase 5] Deliver - Present the write-up; save to file only if asked
```

## Quality Gate (Required)

- Duration figures come from the actual event log / database in session mode — never fabricated when data is missing (state the gap instead); in manual mode, the user's stated time is used as-is and marked self-reported
- Multi-block/resumed sessions are flagged, not silently averaged into a misleading wall-span figure
- The "what was done" summary reflects the actual digest content (session mode) or the user's own description (manual mode) — not just a session title
- The no-AI estimate is a range with a stated midpoint and one to two sentences of reasoning
- Trivial/single-shot sessions report absolute minutes saved, not just an inflated ratio
- Unresolved, unvalidated, or workaround-only outcomes are explicitly flagged
