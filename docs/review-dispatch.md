# Native review evidence handoff

Use this sequence before delegating a review in an orchestrator session,
including an ordinary "review my changes" request or stage-owned review workers.
Keep inline reviews inline. The active review stage still owns scope, comparison,
axes, prompts, reviewer roles and interpretation of findings.

The helper prepares evidence; the orchestrator launches the normal native
reviewer. No SDK runtime, plugin setup or tracker vocabulary is required.

## 1. Select the review inputs

Resolve the user/stage-selected comparison and task ownership before capture.
Use actual target-project instruction and standards sources. For a stage with
no spec, set `spec` to `[]` and supply a nonempty `specUnavailable` explanation;
preserve the stage's skipped Spec axis instead of inventing requirements.

Save a request outside the target project:

```json
{
  "repository": "C:\\Work\\Project",
  "base": "user-selected-base",
  "head": "user-selected-head",
  "comparison": "direct",
  "profile": "review",
  "scope": {
    "owned": ["src/example.js"],
    "excluded": [],
    "ambiguous": []
  },
  "instructions": ["C:\\Work\\Project\\AGENTS.md"],
  "standards": ["C:\\Work\\Project\\CONTRIBUTING.md"],
  "spec": ["C:\\Session\\task-spec.md"],
  "axis": "Correctness",
  "prompt": "The review stage's complete worker brief, including its axis-specific criteria."
}
```

`comparison` is explicitly `direct` or `merge-base`; no branch/ref is assumed.
Classify every changed path exactly once as owned or excluded using Git-relative
`/` paths, including both names of a rename. Clarify mixed ownership rather
than guessing hunk ownership.

Profiles `review` and `deep-reasoning` resolve through the existing settings
helper and generated definitions. These are execution settings, not replacement
stage roles. For read-only delegation, retain/select a native read-only role;
passing Deep reasoning settings does not narrow a full-permission agent.

## 2. Capture and prepare

Run the helper from the configured workbench, not an assumed target-project
`scripts` directory. These example paths must be replaced with actual paths:

```powershell
$review = 'C:\Tools\copilot-task-master\scripts\review-dispatch.mjs'
node $review capture --request C:\Session\request.json --artifacts C:\Session\reviews
node $review prepare --packet C:\Session\reviews\review-ID\packet.json
```

Capture includes resolved references, commit list, complete task-owned committed,
staged, unstaged and untracked UTF-8 evidence, full workspace inventory, and
instruction/standards/spec contents. Change states stay separate. The actual
checkout commit supplies the staged baseline even when the selected head differs.
Excluded paths remain in inventory without their contents.

Preparation verifies packet integrity and current evidence/configuration, then
returns `handoffPath`, `id`, `promptPath` and `requestedSettings`. Read the entire
prompt file; use a full-file read when the reader would otherwise truncate it.
Missing, modified, stale, unsupported or oversized evidence stops preparation.
Refresh the packet rather than launching from a summary or stale handoff.

## 3. Launch the normal native reviewer

Immediately supply the **complete prompt contents** in the native task's initial
prompt, together with the stage-owned brief already included in the request.
Use the prepared `requestedSettings` as explicit task arguments, omitting effort
when unsupported, and preserve the stage's native role and axis separation.
If the complete material cannot fit or the reviewer cannot access necessary
context, report incomplete coverage; do not silently truncate or broaden tools.

The prompt contains actual evidence, not just commands a read-only reviewer
cannot execute. Native read/search tools provide surrounding target-project
context. Collect the worker result and actual invocation arguments. A later
message is not a substitute for complete evidence at launch.

## 4. Record the result before accepting it

Write the native result outside the target, identifying the returned handoff
`id`. The caller assesses the worker's coverage; successful transport or zero
findings alone is insufficient:

```json
{
  "handoffId": "id-from-prepare",
  "execution": "completed",
  "findings": "The complete native worker response.",
  "coverage": "complete",
  "coverageGaps": [],
  "invocation": {
    "agent_type": "the-actual-native-role",
    "model": "model-from-requestedSettings",
    "reasoning_effort": "effort-from-requestedSettings",
    "context_tier": "context-from-requestedSettings"
  }
}
```

`execution` is `completed`, `failed` or `cancelled`; failed/cancelled reports also
require an `error` message. `coverage` is `complete`, `incomplete` or `not-assessed`.
Record explicit gaps rather than claiming complete coverage. Preserve partial
findings and errors when a worker fails. Use the actual invocation values, not
an invented copy of the requested settings.

```powershell
node $review record --handoff C:\Session\reviews\review-ID\handoff-ID.json --report C:\Session\native-result.json
```

Recording verifies the handoff/prompt against the packet and checks current
freshness. Changed evidence, references, inputs, profile/catalog/definition or
workspace inventory makes the result `stale` / `incomplete-stale`, retaining
findings. Inventory freshness includes same-status excluded-file content edits.
Invocation mismatches and missing completed output fail acceptance explicitly.
No replacement worker or credit-consuming retry starts automatically.

## Guarantees and limits

The public module interface is `captureReview(request, options)`,
`prepareReview(packetPath)` and `recordReview(handoffPath, report)`. Native tasks
stay outside this module; orchestrator instructions coordinate their sequence.
Validation blocks preparation when called, but does not mechanically intercept
arbitrary native launches or atomically bind a task call to preparation.

Results distinguish caller-reported execution/coverage and invocation settings
from effective runtime model/tools, which remain unavailable to this helper.
The profile definition's tool declaration is recorded separately from the actual
native role; neither is an independently attested runtime restriction.
There is no SDK model-verification gate, universal fail-closed dispatch claim,
OS immutability claim or certification of another client's permissions.

Packets, prompts, handoffs and results stay outside the target repository.
Scoped binary/linked files, unmerged entries, unsupported inventory, inaccessible
required inputs and evidence over 512 KiB block explicitly without truncation.
Offline tests exercise the public interface with disposable Git repositories
and caller-supplied fixture reports; actual native handoff evidence is separate.

One authorized native Review acceptance run consumed the prepared four-state
fixture, read/searched surrounding context and returned a coverage report.
Post-review freshness remained current. This demonstrates that handoff, not
independently verified effective native model/tools or universal task interception.
