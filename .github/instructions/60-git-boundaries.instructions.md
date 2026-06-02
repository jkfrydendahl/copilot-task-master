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