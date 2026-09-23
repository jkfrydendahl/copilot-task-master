import { pathToFileURL } from "node:url";

export async function collectRuntimeCatalog(client) {
    await client.start();
    const auth = await client.getAuthStatus();
    if (auth.isAuthenticated !== true) {
        return { status: "unavailable", authenticated: false, message: "Copilot runtime authentication is required.", models: [] };
    }
    const runtime = await client.getStatus();
    const models = await client.listModels();
    return {
        status: "ok",
        authenticated: true,
        source: "copilot-sdk models.list",
        runtimeVersion: runtime.version,
        fetchedAtUtc: new Date().toISOString(),
        models: models.map(model => ({
            id: model.id,
            name: model.name,
            vision: model.capabilities?.supports?.vision,
            toolCalls: model.capabilities?.supports?.tool_calls,
            reasoningEffort: model.capabilities?.supports?.reasoningEffort,
            maxContextTokens: model.capabilities?.limits?.max_context_window_tokens,
            supportedReasoningEfforts: model.supportedReasoningEfforts,
            supportedContextTiers: model.supportedContextTiers,
            policyState: model.policy?.state,
            tokenPrices: model.billing?.tokenPrices,
        })),
    };
}

async function main() {
    let client;
    let timer;
    try {
        const { CopilotClient } = await import("@github/copilot-sdk");
        client = new CopilotClient({
            logLevel: "none",
        });
        const result = await Promise.race([
            collectRuntimeCatalog(client),
            new Promise((_, reject) => {
                timer = setTimeout(() => reject(new Error("Runtime catalog request exceeded 45 seconds.")), 45000);
            }),
        ]);
        console.log(JSON.stringify(result));
    } catch (error) {
        let message = error instanceof Error ? error.message : "Runtime catalog request failed.";
        for (const key of ["COPILOT_GITHUB_TOKEN", "GH_TOKEN", "GITHUB_TOKEN"]) {
            if (process.env[key]) message = message.replaceAll(process.env[key], "[redacted]");
        }
        console.log(JSON.stringify({ status: "error", authenticated: false, message, models: [] }));
        process.exitCode = 1;
    } finally {
        clearTimeout(timer);
        if (client) await client.forceStop();
    }
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) await main();
