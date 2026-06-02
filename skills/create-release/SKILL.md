---
name: create-release
description: Create a new release branch by merging feature branches and bumping the version. Supports any project type.
---

# Helper Scripts
This skill includes PowerShell scripts in the same folder as this SKILL.md:
- `Find-TaskBranches.ps1` — Finds remote branches matching task IDs or name patterns
- `Prepare-Release.ps1` — Syncs branches, creates release branch, merges, updates version (steps 02-07 in one call)

# Workflow
## 00. Validate starting state
## 01. Identify branches to include
## 02-07. Prepare the release branch (single script)
## 08. Build
## 09. Push the release branch

## Notes
- Master/main branch: Only one is available. Choose the one that exists.

# Steps
## 00. Validate starting state
Before starting, verify:
- The working tree is clean (no uncommitted changes). Run `git status`.
- If there are uncommitted changes, stop and ask the user to resolve them before continuing.

## 01. Identify branches to include
The user may provide:
- **Task IDs** (numeric) — use the helper script to find matching branches
- **Branch names** — use directly
- **A mix** — resolve task IDs via the script, pass branch names through as-is

If the prompt doesn't contain any task IDs or branch names, ask the user to provide a list.

### Resolving task IDs to branches
Run the helper script to find branches for any numeric task IDs:
```
& "{SKILL_DIR}\Find-TaskBranches.ps1" -TaskIds {comma-separated task ids}
```
Where `{SKILL_DIR}` is the directory containing this SKILL.md file.

- If a task has no matching branch, list existing remote branches as suggestions and ask the user to pick one or clarify.
- If multiple branches match a task, ask the user which one to use.

### Final confirmation
Always confirm with the user the final list of branches that will be included in the release before proceeding to the next step.

## 02-07. Prepare the release branch
This single script handles: syncing task branches, syncing main, creating the release branch, merging all task branches, updating the version, and committing.

### Determining the version
If the user has specified a version number, use that directly.

Otherwise, auto-detect the current version from the master/main branch (whichever exists) and increment the last numeric segment by 1 (e.g. `1.2.3` → `1.2.4`, `2.0.0.7` → `2.0.0.8`).

The script auto-detects the version source from these files (checked in priority order):
1. `app.json` — field `"version"` (AL / Business Central projects)
2. `package.json` — field `"version"` (Node.js projects)
3. `VERSION` — plain text file containing just the version string
4. `.csproj` / `Directory.Build.props` — `<Version>` element (.NET projects)

Read the version from the main branch using `git show {main}:{file}` — do NOT read from the current branch, as feature branches may have an outdated version.

### Running the script
```
& "{SKILL_DIR}\Prepare-Release.ps1" -Branches "{branch1}","{branch2}" -Version "{version number}"
```
Where `{SKILL_DIR}` is the directory containing this SKILL.md file.

If merge conflicts occur, the script stops with a clear error. Ask the user to resolve the conflicts, then continue the remaining merges and version update manually.

## 08. Build
Auto-detect the project's build command and run it:

| Detection | Build command |
|-----------|--------------|
| `app.json` exists (AL/BC) | Use the `al_build` tool |
| `package.json` with `build` script | `npm run build` |
| `*.sln` or `*.csproj` exists (.NET) | `dotnet build` |
| `go.mod` exists (Go) | `go build ./...` |
| `Cargo.toml` exists (Rust) | `cargo build` |
| `pom.xml` exists (Java/Maven) | `mvn package -DskipTests` |
| No recognizable build system | Skip build step, inform the user |

If the build fails, ask the user to fix the issues. Wait for the user to reply that the issues are fixed before continuing.

## 09. Push the release branch
If all merges completed successfully and the build passes (or was skipped), push immediately without asking for confirmation.
Push the release branch to the remote with upstream tracking:
```
git push -u origin release/{version number}
```