import test from "node:test";
import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { createHash } from "node:crypto";
import { mkdtemp, mkdir, writeFile, readFile, copyFile, rm, symlink } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { captureReview, prepareReview, recordReview } from "./review-dispatch.mjs";

async function fixture(t) {
    const root = await mkdtemp(join(tmpdir(), "review-dispatch-test-"));
    t.after(() => rm(root, { recursive: true, force: true }));
    const repository = join(root, "project");
    const workbenchRoot = join(root, "workbench");
    const agentDirectory = join(root, "agents");
    const artifactsDirectory = join(root, "artifacts");
    for (const path of [repository, agentDirectory, artifactsDirectory,
        join(workbenchRoot, "scripts"), join(workbenchRoot, "config")]) {
        await mkdir(path, { recursive: true });
    }
    const git = (...args) => execFileSync("git", [
        "-c", "core.hooksPath=" + join(root, "no-hooks"),
        "-c", "user.name=Review fixture", "-c", "user.email=fixture@example.invalid",
        ...args,
    ], { cwd: repository, encoding: "utf8", stdio: ["ignore", "pipe", "pipe"] }).trim();
    git("init", "-q");
    git("config", "core.autocrlf", "false");
    for (const [path, content] of Object.entries({
        "calculator.js": "export const value = 1;\n",
        "AGENTS.md": "Project instructions: assess changes without modifying files.\n",
        "standards.md": "Review standard: report meaningful correctness problems.\n",
        "spec.md": "Requirement: the exported value must be two.\n",
    })) await writeFile(join(repository, path), content);
    git("add", ".");
    git("commit", "-qm", "Base");
    const base = git("rev-parse", "HEAD");
    await writeFile(join(repository, "calculator.js"), "export const value = 2;\n");
    git("commit", "-qam", "Change value");
    const profiles = ["review", "deep-reasoning"].map(key => ({
        key, model: "fixture-model", effort: "xhigh",
        context: key === "review" ? "default" : "long_context",
    }));
    await writeFile(join(workbenchRoot, "task-profiles.json"), JSON.stringify(profiles));
    await writeFile(join(workbenchRoot, "config", "model-capabilities.json"), JSON.stringify({
        models: { "fixture-model": {
            effortMode: "supported", supportedEfforts: ["xhigh"],
            supportedContexts: ["default", "long_context"],
        } },
    }));
    await copyFile(new URL("./model-launch-args.ps1", import.meta.url),
        join(workbenchRoot, "scripts", "model-launch-args.ps1"));
    for (const profile of profiles) {
        const settings = { model: profile.model, reasoning_effort: profile.effort, context_tier: profile.context };
        await writeFile(join(agentDirectory, `${profile.key}.agent.md`),
            `---\nname: '${profile.key}'\nmodel: '${profile.model}'\ntools: ['read', 'search']\n---\n` +
            `Required task tool arguments (caller responsibility): ${JSON.stringify(settings)}\nRead-only reviewer.\n`);
    }
    return {
        root, repository, git,
        options: { workbenchRoot, agentDirectory, artifactsDirectory },
        request: {
            repository, base, head: "HEAD", comparison: "direct", profile: "review",
            scope: { owned: ["calculator.js"], excluded: [], ambiguous: [] },
            instructions: [join(repository, "AGENTS.md")],
            standards: [join(repository, "standards.md")],
            spec: [join(repository, "spec.md")],
            axis: "Correctness", prompt: "Assess the selected task changes against the supplied requirement.",
        },
    };
}

function nativeReport(prepared, overrides = {}) {
    return {
        handoffId: prepared.handoff.id, execution: "completed",
        findings: "Offline fixture result for the supplied Correctness axis.",
        coverage: "complete", coverageGaps: [],
        invocation: { agent_type: "review", ...prepared.handoff.requestedSettings },
        ...overrides,
    };
}

test("A native handoff contains the complete selected evidence and records caller-reported results", async t => {
    const fx = await fixture(t);
    const captured = await captureReview(fx.request, fx.options);
    const prepared = await prepareReview(captured.packetPath);
    const result = await recordReview(prepared.handoffPath, nativeReport(prepared));
    assert.equal(result.execution, "completed");
    assert.equal(result.freshness, "current");
    assert.equal(result.axis, "Correctness");
    assert.match(prepared.prompt, /-export const value = 1;/);
    assert.match(prepared.prompt, /\+export const value = 2;/);
    assert.match(prepared.prompt, /Requirement: the exported value must be two/);
    assert.equal(await readFile(prepared.handoff.promptPath, "utf8"), prepared.prompt);
    const report = JSON.parse(await readFile(result.resultPath, "utf8"));
    assert.equal(report.invocation.model, "fixture-model");
    assert.equal(report.reviewCoverage, "reported-complete");
    assert.equal(report.effectiveConfiguration, null);
    assert.equal(report.effectiveTools, null);
});

test("Changed evidence blocks native launch-material preparation", async t => {
    const fx = await fixture(t);
    const captured = await captureReview(fx.request, fx.options);
    await writeFile(join(fx.repository, "standards.md"), "A changed review standard.\n");
    await assert.rejects(prepareReview(captured.packetPath), { code: "STALE_PACKET" });
});

test("A different reported native invocation fails acceptance while retaining the findings", async t => {
    const fx = await fixture(t);
    const captured = await captureReview(fx.request, fx.options);
    const prepared = await prepareReview(captured.packetPath);
    const result = await recordReview(prepared.handoffPath, nativeReport(prepared, {
        invocation: { agent_type: "review", ...prepared.handoff.requestedSettings, model: "different-model" },
    }));
    assert.equal(result.execution, "failed");
    assert.equal(result.reviewCoverage, "incomplete");
    assert.equal(result.errors[0].code, "INVOCATION_MISMATCH");
    assert.match(result.findings, /Offline fixture result/);
});

test("Missing and modified packets cannot produce native launch material", async t => {
    const fx = await fixture(t);
    await assert.rejects(prepareReview(join(fx.root, "missing.json")),
        { code: "INPUT_UNAVAILABLE" });
    const captured = await captureReview(fx.request, fx.options);
    const changed = JSON.parse(await readFile(captured.packetPath, "utf8"));
    changed.evidence.committed = "An incomplete replacement patch";
    await writeFile(captured.packetPath, JSON.stringify(changed));
    await assert.rejects(prepareReview(captured.packetPath), { code: "INVALID_PACKET" });
});

test("Unsupported scoped content and incomplete ownership never produce a packet", async t => {
    const fx = await fixture(t);
    await assert.rejects(captureReview({ ...fx.request, scope: {
        owned: ["not-the-change.js"], excluded: [], ambiguous: [],
    } }, fx.options), { code: "INCOMPLETE_SCOPE" });
    await writeFile(join(fx.repository, "calculator.js"), Buffer.from([0, 1, 2]));
    fx.git("commit", "-qam", "Binary change");
    await assert.rejects(captureReview(fx.request, fx.options), { code: "UNSUPPORTED_EVIDENCE" });
});

test("A staged deletion validates its actual checkout base even when a different review head is selected", async t => {
    const fx = await fixture(t);
    const head = fx.git("rev-parse", "HEAD");
    await writeFile(join(fx.repository, "calculator.js"), Buffer.from([0, 1, 2]));
    fx.git("commit", "-qam", "Binary checkout outside selected comparison");
    fx.git("rm", "calculator.js");
    await assert.rejects(captureReview({ ...fx.request, head }, fx.options), { code: "UNSUPPORTED_EVIDENCE" });
});

test("A scoped file behind a linked parent directory cannot read external evidence", async t => {
    const fx = await fixture(t);
    const nested = join(fx.repository, "nested");
    const external = join(fx.root, "external");
    await mkdir(nested);
    await mkdir(external);
    await writeFile(join(nested, "helper.js"), "export const helper = 1;\n");
    await writeFile(join(external, "helper.js"), "export const helper = 1;\n");
    fx.git("add", "nested");
    fx.git("commit", "-qm", "Add nested helper");
    await rm(nested, { recursive: true });
    await symlink(external, nested, "junction");
    const request = { ...fx.request, scope: { ...fx.request.scope,
        owned: ["calculator.js", "nested/helper.js"],
    } };
    await assert.rejects(captureReview(request, fx.options), { code: "UNSUPPORTED_WORKSPACE" });
});

test("A changed target after native handoff retains stale output without launching a replacement", async t => {
    const fx = await fixture(t);
    const captured = await captureReview(fx.request, fx.options);
    const prepared = await prepareReview(captured.packetPath);
    await writeFile(join(fx.repository, "calculator.js"), "export const value = 99;\n");
    const result = await recordReview(prepared.handoffPath, nativeReport(prepared, {
        findings: "Findings about the original packet.",
    }));
    assert.equal(result.freshness, "stale");
    assert.equal(result.reviewCoverage, "incomplete-stale");
    assert.equal(result.findings, "Findings about the original packet.");
});

test("Supported profiles preserve context and omit unsupported effort overrides", async t => {
    const fx = await fixture(t);
    let captured = await captureReview({ ...fx.request, profile: "deep-reasoning" }, fx.options);
    let prepared = await prepareReview(captured.packetPath);
    assert.equal(prepared.handoff.requestedSettings.context_tier, "long_context");
    const catalogPath = join(fx.options.workbenchRoot, "config", "model-capabilities.json");
    const catalog = JSON.parse(await readFile(catalogPath, "utf8"));
    catalog.models["fixture-model"].effortMode = "unsupported";
    catalog.models["fixture-model"].supportedEfforts = [];
    await writeFile(catalogPath, JSON.stringify(catalog));
    const agentPath = join(fx.options.agentDirectory, "review.agent.md");
    await writeFile(agentPath, (await readFile(agentPath, "utf8")).replace(',"reasoning_effort":"xhigh"', ""));
    captured = await captureReview(fx.request, fx.options);
    prepared = await prepareReview(captured.packetPath);
    const result = await recordReview(prepared.handoffPath, nativeReport(prepared));
    assert.equal(result.execution, "completed");
    assert.equal(Object.hasOwn(result.requestedSettings, "reasoning_effort"), false);
});

test("A mixed workspace preserves committed, index, working-tree and untracked evidence without unrelated contents", async t => {
    const fx = await fixture(t);
    await writeFile(join(fx.repository, "calculator.js"), "export const value = 3;\n");
    fx.git("add", "calculator.js");
    await writeFile(join(fx.repository, "calculator.js"), "export const value = 4;\n");
    await writeFile(join(fx.repository, "new-note.txt"), "A task-owned untracked requirement.\n");
    await writeFile(join(fx.repository, "unrelated.txt"), "UNRELATED_CONTENT_MUST_NOT_BE_SENT\n");
    const request = { ...fx.request, scope: {
        owned: ["calculator.js", "new-note.txt"], excluded: ["unrelated.txt"], ambiguous: [],
    } };
    const captured = await captureReview(request, fx.options);
    const prepared = await prepareReview(captured.packetPath);
    const result = await recordReview(prepared.handoffPath, nativeReport(prepared));
    assert.equal(result.execution, "completed");
    const evidence = captured.packet.evidence;
    assert.match(evidence.committed, /\+export const value = 2/);
    assert.match(evidence.staged, /\+export const value = 3/);
    assert.match(evidence.unstaged, /-export const value = 3/);
    assert.match(evidence.unstaged, /\+export const value = 4/);
    assert.equal(evidence.untracked[0].content, "A task-owned untracked requirement.\n");
    assert.ok(evidence.inventory.some(entry => entry.path === "unrelated.txt"));
    assert.doesNotMatch(prepared.prompt, /UNRELATED_CONTENT_MUST_NOT_BE_SENT/);
});

test("Mixed ownership must be explicit and same-status unrelated edits invalidate the packet", async t => {
    const fx = await fixture(t);
    await writeFile(join(fx.repository, "unrelated.txt"), "First unrelated state\n");
    await assert.rejects(captureReview(fx.request, fx.options), { code: "INCOMPLETE_SCOPE" });
    await assert.rejects(captureReview({ ...fx.request, scope: {
        owned: ["calculator.js"], excluded: [], ambiguous: ["unrelated.txt"],
    } }, fx.options), { code: "AMBIGUOUS_SCOPE" });
    const captured = await captureReview({ ...fx.request, scope: {
        owned: ["calculator.js"], excluded: ["unrelated.txt"], ambiguous: [],
    } }, fx.options);
    await writeFile(join(fx.repository, "unrelated.txt"), "Second unrelated state\n");
    await assert.rejects(prepareReview(captured.packetPath), { code: "STALE_PACKET" });
});

test("Staged renames preserve both names and a replacement untracked original", async t => {
    const fx = await fixture(t);
    fx.git("mv", "calculator.js", "renamed.js");
    await writeFile(join(fx.repository, "calculator.js"), "A replacement at the original name\n");
    const captured = await captureReview({ ...fx.request, scope: {
        owned: ["calculator.js", "renamed.js"], excluded: [], ambiguous: [],
    } }, fx.options);
    assert.ok(captured.packet.evidence.inventory.some(entry =>
        entry.path === "renamed.js" && entry.originalPath === "calculator.js"));
    assert.match(captured.packet.evidence.staged, /renamed.js/);
    assert.equal(captured.packet.evidence.untracked[0].content, "A replacement at the original name\n");
});

test("Caller-selected direct and merge-base comparisons keep their distinct meaning", async t => {
    const fx = await fixture(t);
    const head = fx.git("rev-parse", "HEAD");
    fx.git("checkout", "-qb", "diverged", fx.request.base);
    await writeFile(join(fx.repository, "calculator.js"), "export const value = 10;\n");
    fx.git("commit", "-qam", "Diverged comparison base");
    const direct = await captureReview({ ...fx.request, base: "diverged", head }, fx.options);
    const merged = await captureReview({ ...fx.request, base: "diverged", head, comparison: "merge-base" }, fx.options);
    assert.match(direct.packet.evidence.committed, /-export const value = 10;/);
    assert.match(merged.packet.evidence.committed, /-export const value = 1;/);
    assert.equal(merged.packet.evidence.comparison.start, fx.request.base);
});

test("Modified native prompt material cannot be recorded as the original complete evidence", async t => {
    const fx = await fixture(t);
    const captured = await captureReview(fx.request, fx.options);
    const prepared = await prepareReview(captured.packetPath);
    await writeFile(prepared.handoff.promptPath, "Only a summary, not the complete evidence.");
    await assert.rejects(recordReview(prepared.handoffPath, nativeReport(prepared)), { code: "INVALID_HANDOFF" });
});

test("A rehashed handoff cannot change the captured review axis or profile tool declaration", async t => {
    const fx = await fixture(t);
    const captured = await captureReview(fx.request, fx.options);
    for (const change of [{ axis: "An unrelated axis" }, { profileDeclaredTools: "verified shell access" }]) {
        const prepared = await prepareReview(captured.packetPath);
        const { id, ...body } = { ...prepared.handoff, ...change };
        const modified = { ...body, id: createHash("sha256").update(JSON.stringify(body)).digest("hex") };
        await writeFile(prepared.handoffPath, JSON.stringify(modified));
        await assert.rejects(recordReview(prepared.handoffPath, nativeReport(prepared)), { code: "INVALID_HANDOFF" });
    }
});

test("Results must identify their handoff and cannot claim complete coverage with declared gaps", async t => {
    const fx = await fixture(t);
    const captured = await captureReview(fx.request, fx.options);
    const prepared = await prepareReview(captured.packetPath);
    await assert.rejects(recordReview(prepared.handoffPath, nativeReport(prepared, { handoffId: "different" })),
        { code: "INVALID_REPORT" });
    await assert.rejects(recordReview(prepared.handoffPath, nativeReport(prepared, { coverageGaps: ["Missing context"] })),
        { code: "INVALID_REPORT" });
    const result = await recordReview(prepared.handoffPath, nativeReport(prepared, {
        coverage: "incomplete", coverageGaps: ["Missing context"],
    }));
    assert.equal(result.execution, "completed");
    assert.equal(result.reviewCoverage, "incomplete");
    assert.deepEqual(result.coverageGaps, ["Missing context"]);
});

test("A stage may explicitly report no spec without inventing requirements", async t => {
    const fx = await fixture(t);
    await assert.rejects(captureReview({ ...fx.request, spec: [] }, fx.options), { code: "INVALID_REQUEST" });
    const captured = await captureReview({ ...fx.request, spec: [], specUnavailable: "No spec; Spec axis skipped." }, fx.options);
    const prepared = await prepareReview(captured.packetPath);
    assert.match(prepared.prompt, /No spec; Spec axis skipped/);
});

test("Native cancellation and missing output remain incomplete and preserve partial findings safely", async t => {
    const fx = await fixture(t);
    const captured = await captureReview(fx.request, fx.options);
    const prepared = await prepareReview(captured.packetPath);
    const cancelled = await recordReview(prepared.handoffPath, nativeReport(prepared, {
        execution: "cancelled", findings: "Partial observation.", coverage: "incomplete",
        error: "Cancelled; Bearer fixture-secret",
    }));
    assert.equal(cancelled.execution, "cancelled");
    assert.equal(cancelled.reviewCoverage, "incomplete");
    assert.equal(cancelled.findings, "Partial observation.");
    assert.doesNotMatch(cancelled.errors[0].message, /fixture-secret/);
    const missing = await recordReview(prepared.handoffPath, nativeReport(prepared, { findings: "" }));
    assert.equal(missing.execution, "failed");
    assert.equal(missing.errors[0].code, "MISSING_OUTPUT");
});

test("The command-line helper prepares full launch material and records a native result", async t => {
    const fx = await fixture(t);
    const captured = await captureReview(fx.request, fx.options);
    const script = fileURLToPath(new URL("./review-dispatch.mjs", import.meta.url));
    const prepared = JSON.parse(execFileSync(process.execPath, [script, "prepare", "--packet", captured.packetPath], { encoding: "utf8" }));
    assert.match(await readFile(prepared.promptPath, "utf8"), /\+export const value = 2;/);
    const reportPath = join(fx.root, "native-report.json");
    await writeFile(reportPath, JSON.stringify(nativeReport({ handoff: prepared })));
    const result = JSON.parse(execFileSync(process.execPath, [script, "record", "--handoff", prepared.handoffPath,
        "--report", reportPath], { encoding: "utf8" }));
    assert.equal(result.freshness, "current");
    assert.equal(result.reviewCoverage, "reported-complete");
});
