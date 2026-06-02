---
name: update-readme
description: "Generate or update a project README. Auto-detects the project type (AL, CRM, Power Platform, generic) and tailors sections accordingly."
---

# Update README

Generate or update the project README with a consistent structure tailored to the detected project type. The skill auto-detects AL / Business Central, CRM / Dynamics 365, Power Platform, or generic projects and adjusts feature discovery, software dependencies, and reference links accordingly.

> **Note**: This skill modifies only the README file. It does not change project code or configuration.

## Invocation

| Command | Action |
|---------|--------|
| `/update-readme` | Start — auto-detects project type and generates README |
| `/update-readme <project type>` | Start with an explicit project type override (e.g. `al`, `crm`, `power-platform`) |

## Output

A single `README.md` file containing:

| Section | Contents |
|---------|----------|
| Introduction | Concise summary of the project's purpose and key features |
| Feature Areas | Flat list of feature areas with short descriptions |
| Documentation | Software dependencies, project docs, and reference links |

## Workflow

### Phase 1: Project Detection

Detect the project type by examining the repository root. Use the **first match**:

| Indicator | Project Type |
|-----------|-------------|
| `app.json` with `platform` or `runtime` property | **AL / Business Central** |
| `.csproj` or `.sln` referencing `Microsoft.CrmSdk`, `Microsoft.Xrm`, or `Dataverse` | **CRM / Dynamics 365** |
| `solution.xml`, `*.msapp`, or folders named `CanvasApps`, `Flows`, `CustomConnectors` | **Power Platform** |
| None of the above | **Generic** |

If the project type cannot be confidently determined, ask the user before proceeding.

If the user provided an explicit project type via the invocation argument, use that instead of auto-detection.

### Phase 2: Codebase Exploration

Explore the repository to gather the information needed for each README section:

1. **Introduction** — Read existing README, project manifests (`app.json`, `*.csproj`, `solution.xml`, `package.json`), and top-level documentation to understand the project's purpose.

2. **Feature Areas** — Scan the primary source folder(s) for distinct feature areas:
   - **AL**: `/src` folder and subfolders
   - **CRM**: `/Plugins`, `/Workflows`, `/WebResources`, or solution component folders
   - **Power Platform**: `CanvasApps/`, `Flows/`, `CustomConnectors/`, solution component folders
   - **Generic**: `/src` or the primary source folder

3. **Software Dependencies** — Extract from the project's manifest/config files.

4. **Project Documentation** — Scan `/documentation` and `/aidocs` folders for numbered files.

5. **Reference Documentation** — Compile relevant external links based on the detected project type.

### Phase 3: README Generation

Generate the README with the following sections. Adhere strictly to the formatting guidelines.

#### Section 1: Introduction

- Concise summary explaining the project's purpose and key features.
- Keep it scannable — a short paragraph, not a wall of text.

#### Section 2: Feature Areas

- Short description of each feature area, in a **flat list**.
- List all feature areas on the **same level** — do not nest them into sub-groups even if they live in a subfolder (e.g. `/workflows`). Just list the separate feature areas.

#### Section 3: Documentation

##### Software Dependencies

List **only** the essential development tools and platform requirements:

**AL / Business Central:**
- Minimum Business Central version required
- Minimum runtime version
- [Microsoft AL Language extension for VS Code](https://marketplace.visualstudio.com/items?itemName=ms-dynamics-smb.al)
- App dependencies from `app.json`

**CRM / Dynamics 365:**
- Target Dataverse / Dynamics 365 version or solution version
- .NET SDK version required
- [Power Platform CLI](https://learn.microsoft.com/en-us/power-platform/developer/cli/introduction)
- NuGet package dependencies (from `.csproj` or `packages.config`)

**Power Platform:**
- Target Power Platform environment version (if applicable)
- [Power Platform CLI](https://learn.microsoft.com/en-us/power-platform/developer/cli/introduction)
- [Power Apps Component Framework](https://learn.microsoft.com/en-us/power-apps/developer/component-framework/overview) (if PCF controls are used)
- Solution dependencies

**Generic:**
- Language runtime/SDK version
- Package manager and key dependencies from the project manifest

##### Project Documentation

- List **only** files from `/documentation` and/or `/aidocs` that are prefixed by a number (e.g. `01_*.md`).
- Do **not** include files like `index.md` or `project_analysis.md`.
- If the same files exist in both folders, list the `/documentation` version.
- Include relative links so readers can navigate directly to each document.

##### Reference Documentation

Include clickable links to external documentation relevant to the project type.

**AL / Business Central** (minimum):
- [Microsoft AL Documentation](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-dev-overview)
- [Business Central Extension Development](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-reference-overview)


**CRM / Dynamics 365** (minimum):
- [Dataverse Developer Guide](https://learn.microsoft.com/en-us/power-apps/developer/data-platform/overview)
- [Dynamics 365 Customization Guide](https://learn.microsoft.com/en-us/dynamics365/customerengagement/on-premises/developer/overview)

**Power Platform** (minimum):
- [Power Apps Developer Documentation](https://learn.microsoft.com/en-us/power-apps/developer/)
- [Power Automate Documentation](https://learn.microsoft.com/en-us/power-automate/)

Add more reference links if relevant to the specific project.

### Phase 4: Review & Deliver

- Present the generated README to the user.
- If an existing README was present, highlight what changed.
- Wait for user approval before writing the file.

## Formatting Guidelines

- For **all** external documentation, always include a clickable link.
- Keep the README scannable — prefer bullet lists over long paragraphs.
- Feature areas are always a flat list, never nested.
- Only list numbered documentation files from the designated folders.

## Argument Detection

| Pattern | Type | Action |
|---------|------|--------|
| `/update-readme` | No argument | Auto-detect project type, then start Phase 1 |
| `/update-readme al` | Explicit type | Skip detection, use AL profile |
| `/update-readme crm` | Explicit type | Skip detection, use CRM profile |
| `/update-readme power-platform` | Explicit type | Skip detection, use Power Platform profile |

## Task List Structure

When starting a README update:

```
[Phase 1] Detection - Identify project type
[Phase 2] Exploration - Gather feature areas, dependencies, and documentation
[Phase 3] Generation - Build the README content
[Phase 4] Review - Present to user for approval
```

## Quality Gate (Required)

- Project type is identified (auto or explicit) before generation starts
- Introduction is present and concise
- Feature areas are listed flat (no nesting)
- Software dependencies match the detected project type
- Only numbered documentation files are listed
- All external links are clickable URLs
- Reference documentation includes at least the minimum links for the detected type
