---
applyTo: "**"
---

# Git Boundaries

The user handles Git manually in VS Code unless explicitly stated otherwise.

Allowed without asking:

- `git status`
- `git diff`
- `git diff --stat`
- `git log`
- `git branch`
- `git show`

Ask before running:

- `git add`
- `git restore`
- `git checkout`
- `git switch`
- `git pull`
- `git merge`

Never run unless explicitly requested:

- `git commit`
- `git push`
- `git reset --hard`
- `git clean`
- `git rebase`
- `git filter-branch`
- `gh pr create`
- `gh release`
- deleting branches
- force push

After making code changes, tell the user to review the diff in VS Code before committing.

## Sanctioned exception: release / TDD skills

Two shared skills perform git operations **by design**, and invoking them counts as the
user's explicit request to do so:

- **`/create-release`** — creates a release branch and runs `git checkout`, `git commit`, and
  `git push` (via `Prepare-Release.ps1`) as part of the documented release procedure.
- **`/tdd-implement`** — creates a feature branch and a draft PR in its Setup phase.

When the user explicitly invokes one of these skills, follow the skill's git steps without
re-asking for each command. Outside these skills, the rules above still apply in full. Even
within them, never force-push or rewrite history, and summarize what was pushed/created.