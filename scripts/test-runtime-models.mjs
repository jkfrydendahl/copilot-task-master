import test from "node:test";
import assert from "node:assert/strict";
import { collectRuntimeCatalog, getRuntimeClientOptions } from "./get-runtime-models.mjs";

test("Runtime path selection uses the explicit installation without changing the parent environment", () => {
    const env = { COPILOT_CLI_PATH: "old-runtime", OTHER: "preserved" };
    const options = getRuntimeClientOptions(["--cli-path", "C:\\Program Files\\Copilot\\copilot.exe"], env);
    assert.equal(options.env.COPILOT_CLI_PATH, "C:\\Program Files\\Copilot\\copilot.exe");
    assert.equal(options.env.OTHER, "preserved");
    assert.equal(env.COPILOT_CLI_PATH, "old-runtime");
    assert.deepEqual(getRuntimeClientOptions([]), { logLevel: "none" });
    assert.throws(() => getRuntimeClientOptions(["--cli-path"]), /Expected --cli-path/);
    assert.throws(() => getRuntimeClientOptions(["--cli-path", " "]), /Expected --cli-path/);
    assert.throws(() => getRuntimeClientOptions(["--other", "path"]), /Expected --cli-path/);
});

test("Unauthenticated discovery never queries or publishes a model catalog", async () => {
    const result = await collectRuntimeCatalog({
        start: async () => {},
        getAuthStatus: async () => ({ isAuthenticated: false }),
        listModels: async () => { throw new Error("Must not query models"); },
    });
    assert.equal(result.status, "unavailable");
    assert.deepEqual(result.models, []);
});

test("Only explicit, whitelisted metadata is captured; unknown facts stay absent", async () => {
    const result = await collectRuntimeCatalog({
        start: async () => {},
        getAuthStatus: async () => ({ isAuthenticated: true, login: "not-persisted" }),
        getStatus: async () => ({ version: "fixture" }),
        listModels: async () => [{
            id: "new-model",
            name: "New model",
            capabilities: { supports: { vision: true, tool_calls: true }, limits: { max_context_window_tokens: 1000000 } },
            policy: { state: "enabled", terms: "not-persisted" },
            metadata: { private: "not-persisted" },
        }],
    });
    assert.equal(result.models[0].vision, true);
    assert.equal(result.models[0].supportedReasoningEfforts, undefined);
    assert.equal(result.models[0].supportedContextTiers, undefined);
    assert.equal(JSON.stringify(result).includes("not-persisted"), false);
});

test("Catalog errors propagate rather than manufacturing available models", async () => {
    await assert.rejects(collectRuntimeCatalog({
        start: async () => { throw new Error("fixture outage"); },
    }), /fixture outage/);
});
