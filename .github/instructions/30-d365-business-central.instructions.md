---
applyTo: "**/*.al"
---

# D365 Business Central / AL Rules

When working with AL:

- Prefer minimal, maintainable changes.
- Respect existing object naming, ID ranges, prefixes, and app structure.
- Inspect `app.json`, permissions, dependencies, and existing object patterns before adding objects.
- Avoid changing table schema casually.
- Treat table extensions, enum extensions, events, subscribers, reports, and API pages as high-impact changes.
- Prefer event subscribers over base-object modification where applicable.
- Watch for breaking changes in public APIs, integrations, and report datasets.
- Suggest validation through compile/build and relevant BC test or smoke-test steps.
- Do not invent object IDs if the repo has a documented ID range; inspect first.