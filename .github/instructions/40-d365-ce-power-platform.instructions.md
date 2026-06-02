---
applyTo: "**"
---

# D365 CE / Power Platform Rules

When working with D365 CE, Dataverse, plugins, APIs, or Power Automate:

- Treat schema changes, option sets, relationship changes, plugin steps, and API contracts as high-impact.
- Inspect existing naming conventions and layering before editing.
- Be careful with synchronous plugin behavior, transaction scope, recursion depth, and performance.
- Avoid broad queries without column selection.
- Prefer explicit tracing and meaningful error handling in plugins.
- Consider security roles, field-level security, environment variables, connection references, and solution layering.
- For integration code, identify source system, target system, mapping, retry behavior, idempotency, and failure handling.
- Suggest validation through unit tests, plugin registration checks, flow checks, API tests, or Postman collections where applicable.