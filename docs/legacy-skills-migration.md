# Legacy personal-skills migration

This is upgrade compatibility for older Task Master installations, not an active
skill catalog or a launcher startup step. New installations and already-migrated
real personal-skills directories do not need it. Skill and plugin installation are separate operations; this helper performs neither and does not select a provider.

## When it is needed

Earlier launchers linked `~/.copilot/skills` to the old workbench's `skills/` with
one directory junction. The launcher no longer owns that link. This helper converts it to a real user-managed directory without installing replacement content.

Do not remove personal skills or reset the installation to test the new workflow.
First inspect the existing path and, only for the legacy junction, review a plan
from `scripts\Migrate-PersonalSkills.ps1`. Applying it requires explicit approval.

## Plan and apply

The helper is **plan-only by default**:

```powershell
# Plan: reads and reports only, writes nothing.
pwsh -NoProfile -File scripts\Migrate-PersonalSkills.ps1 -SourceSkillsPath 'C:\Work\copilot-task-master\skills'
# Only after reviewing and approving the plan:
pwsh -NoProfile -File scripts\Migrate-PersonalSkills.ps1 -SourceSkillsPath 'C:\Work\copilot-task-master\skills' -Apply
```

Run from the current workbench root. Replace the example path with the existing
skills folder the junction really points to. This checkout no longer ships
`skills/`, so pass the actual legacy target with `-SourceSkillsPath`; an unexpected
target blocks the run. The source folder is only read, never modified.
`-PersonalRoot` (default `%USERPROFILE%\.copilot`) and `-ArchiveRoot` (default
`<personal root>\migration-archive`) are optional.

| What it finds at `~/.copilot/skills` | Result |
| ------------------------------------ | ------ |
| A directory junction to the expected source | Planned, or migrated with `-Apply` |
| A junction to anything else, any other link, a missing or linked source, links inside the source tree, an archive location inside skill discovery, an invalid `-RetireSkill` name, or a leftover `skills.migration-*` folder when there is no skills folder | **Blocked**: nothing is written (exit 1) |
| A real directory (already migrated, or your own skills) or no folder at all | No action (exit 0): a real directory is never replaced and no link is ever recreated |

## What an approved apply does

With `-Apply` the script, in order:

1. Archives the approved legacy skills (`grill-me`, `refine-requirements`,
   `tdd-implement`, `reference-lookup`, `create-release`, `update-readme`,
   `estimate-task`, `code-review`, `session-time-audit`, or the names given with
   `-RetireSkill`) as a verified copy under
   `<archive root>\skills-migration-<timestamp>-<id>\retired-skills`, outside skill discovery.
2. Copies every other entry (unique personal skills, loose and hidden files, and
   empty folders) into a staging folder next to the junction and verifies it byte for byte.
3. Rechecks the junction and verifies that the source is unchanged.
4. Detaches **only** the verified junction object. The source folder is never modified or deleted.
5. Renames the staging folder to the real `~/.copilot/skills` and verifies destination and source again.
6. Writes `migration-report.json` into the archive folder.

Legacy skills end up archived and no longer discoverable; unique personal skills
stay in the real destination; the source keeps everything. The complete legacy
audit folder, including both helpers, is archived by default as legacy content, not as a recommendation for any replacement.

An explicit `-RetireSkill` list replaces the defaults. Excluding a skill preserves it as personal content. Review the planned list before applying it. For an already-real skills directory the migration remains a no-op; any later archival or installation is separately managed and authorized by its owner.

If the source contains only retired skills, or is empty, the real destination is
intentionally empty until its owner adds skills.
Native plugin skills are discovered separately; do not copy them into that directory.

## Recovery and upgrade order

There is no automatic rollback and the junction is never recreated. On a failure,
the script reports what is left and how to continue. Individual skills can be
restored by copying them from the archive or source after reviewing conflicts.
Retain recovery archives, failed-attempt staging and the original checkout until
their owner explicitly approves cleanup.

Run migration **before** pulling the change that removes legacy `skills/` into the
checkout the junction points to. After that pull, the junction no longer shows those
files, so there is nothing left to archive; the plan reports them missing from the
source. Stop and review recovery from Git history or an existing backup before
applying a plan that would omit content you expected to preserve.
