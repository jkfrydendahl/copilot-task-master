<#
.SYNOPSIS
Plans (default) or applies the one-time move of the personal skills root off the legacy whole-root junction.

.DESCRIPTION
Older Task Master launchers linked the personal skills root (~/.copilot/skills) to this workbench's skills
folder with ONE directory junction. The launcher no longer owns that link, because the company installer and
the native plug-in flow need a real directory they can write to.

Without -Apply this script only reports what it would do and writes nothing at all.

With -Apply it
  1. verifies that the personal skills root is a directory junction whose target is the expected source
     skills folder (and that the source is a real folder without nested links),
  2. archives the explicitly approved legacy skills OUTSIDE skill discovery (a verified copy; the archive
     location may not be inside the personal skills root or the source), including session-time-audit
     with both helpers before the shared company version is installed,
  3. copies EVERY other entry (unique personal skills, loose files, hidden files, empty folders) into a staging
     folder next to the junction and verifies it byte for byte,
  4. detaches ONLY the verified junction object - the source folder is never modified or deleted,
  5. renames the staging folder to the real destination and verifies destination and source once more,
  6. writes migration-report.json next to the archived material.

Anything unexpected blocks the run BEFORE any write: a junction with another target, a missing or linked
source, links inside the source tree, an unsafe archive location, a leftover staging folder when the skills
root is missing, or an invalid -RetireSkill name. An existing real directory is never replaced, so repeating
the migration is a safe no-op. The whole-root junction is never recreated, and nothing is deleted
recursively, so there is no automatic rollback: recovery is stage specific and printed on failure.

Exit codes: 0 = Planned, Applied or NoAction; 1 = Blocked (nothing was written); 2 = Failed while applying.

.PARAMETER PersonalRoot
The personal Copilot folder that contains the skills root. Defaults to %USERPROFILE%\.copilot.

.PARAMETER SourceSkillsPath
The skills folder the legacy junction is expected to point to. Defaults to this checkout's skills folder
for compatibility with older checkouts. Current workbench sources no longer ship that folder; pass the
actual legacy junction target explicitly. An unexpected target is blocked on purpose.

.PARAMETER ArchiveRoot
Base folder for the archive of retired skills. Defaults to <PersonalRoot>\migration-archive. Each run writes
into its own skills-migration-<timestamp>-<id> subfolder.

.PARAMETER RetireSkill
Names of the legacy skill folders to archive and leave out of the real destination. Replaces the approved
default list (including the relocated session-time-audit) when given. Only single folder names are accepted.

.PARAMETER Apply
Actually migrate. Without it the script is plan-only.

.EXAMPLE
pwsh -NoProfile -File scripts\Migrate-PersonalSkills.ps1 -SourceSkillsPath C:\Dev\00_MyStuff\copilot-task-master\skills

.EXAMPLE
pwsh -NoProfile -File scripts\Migrate-PersonalSkills.ps1 -SourceSkillsPath C:\Dev\00_MyStuff\copilot-task-master\skills -Apply
#>
[CmdletBinding()]
param(
    [string]$PersonalRoot,
    [string]$SourceSkillsPath,
    [string]$ArchiveRoot,
    [string[]]$RetireSkill = @('grill-me', 'refine-requirements', 'tdd-implement', 'reference-lookup', 'create-release', 'update-readme', 'estimate-task', 'code-review', 'session-time-audit'),
    [switch]$Apply
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Attributes that are preserved and compared (Archive, NotContentIndexed and friends are not meaningful here).
$script:AttributeMask = [IO.FileAttributes]([int][IO.FileAttributes]::Hidden -bor [int][IO.FileAttributes]::ReadOnly -bor [int][IO.FileAttributes]::System)
$script:Stage = 'preflight'
$script:Context = @{}
# Captured at script scope: $PSBoundParameters inside a function describes that function, not this script.
$script:RetireSkillExplicit = $PSBoundParameters.ContainsKey('RetireSkill')

function Write-Info([string]$Text = '') {
    Write-Host $Text
}

function Exit-WithResult([string]$Result, [int]$ExitCode) {
    Write-Host ''
    Write-Host "Result: $Result"
    exit $ExitCode
}

# --- paths ------------------------------------------------------------------------------------------------

function Remove-TrailingSeparator([string]$Path) {
    $trimmed = $Path.TrimEnd('\', '/')
    if ($trimmed.Length -eq 0) { return $Path }
    if ($trimmed.Length -le 2 -and $trimmed.EndsWith(':')) { return $trimmed + '\' }
    return $trimmed
}

function Resolve-FullPath([string]$Path) {
    $unresolved = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
    return Remove-TrailingSeparator ([IO.Path]::GetFullPath($unresolved))
}

function ConvertTo-ComparablePath([string]$Path) {
    $text = $Path
    if ($text.StartsWith('\??\')) {
        $text = $text.Substring(4)
    } elseif ($text.StartsWith('\\?\') -and -not $text.StartsWith('\\?\UNC\')) {
        $text = $text.Substring(4)
    }
    return Remove-TrailingSeparator ([IO.Path]::GetFullPath($text))
}

function Test-SamePath([string]$Left, [string]$Right) {
    return [string]::Equals((ConvertTo-ComparablePath $Left), (ConvertTo-ComparablePath $Right), [StringComparison]::OrdinalIgnoreCase)
}

function Test-PathInside([string]$Path, [string]$Parent) {
    $child = ConvertTo-ComparablePath $Path
    $root = ConvertTo-ComparablePath $Parent
    if ([string]::Equals($child, $root, [StringComparison]::OrdinalIgnoreCase)) { return $true }
    return $child.StartsWith($root.TrimEnd('\') + '\', [StringComparison]::OrdinalIgnoreCase)
}

function Test-SkillFolderName([string]$Name) {
    if ([string]::IsNullOrWhiteSpace($Name)) { return $false }
    if ($Name -eq '.' -or $Name -eq '..') { return $false }
    if ($Name.IndexOfAny([IO.Path]::GetInvalidFileNameChars()) -ge 0) { return $false }
    if ($Name.EndsWith('.') -or $Name.EndsWith(' ')) { return $false }
    return $true
}

# --- file system facts ------------------------------------------------------------------------------------

function Get-PathItem([string]$Path) {
    return Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
}

function Test-IsReparsePoint($Item) {
    return [bool]($Item.Attributes -band [IO.FileAttributes]::ReparsePoint)
}

function Test-IsDirectoryEntry($Item) {
    return [bool]($Item.Attributes -band [IO.FileAttributes]::Directory)
}

function Get-ItemLinkType($Item) {
    $property = $Item.PSObject.Properties['LinkType']
    if ($null -eq $property -or $null -eq $property.Value) { return '' }
    return [string]$property.Value
}

function Get-ItemLinkTarget($Item) {
    $property = $Item.PSObject.Properties['Target']
    if ($null -eq $property -or $null -eq $property.Value) { return $null }
    $values = @($property.Value)
    if ($values.Count -eq 0) { return $null }
    return [string]$values[0]
}

function Get-TopLevelEntries([string]$Directory) {
    return @(([IO.DirectoryInfo]$Directory).EnumerateFileSystemInfos())
}

function Get-FileSha256([string]$Path) {
    $share = [IO.FileShare]([int][IO.FileShare]::ReadWrite -bor [int][IO.FileShare]::Delete)
    $stream = [IO.File]::Open($Path, [IO.FileMode]::Open, [IO.FileAccess]::Read, $share)
    try {
        $algorithm = [Security.Cryptography.SHA256]::Create()
        try {
            return [BitConverter]::ToString($algorithm.ComputeHash($stream)).Replace('-', '')
        } finally {
            ([IDisposable]$algorithm).Dispose()
        }
    } finally {
        $stream.Dispose()
    }
}

# A manifest line describes one entry without ever following links: type, relative path, preserved
# attributes and (for files) the SHA-256. Directories, hidden files and empty folders are all covered.
function Add-EntryLines {
    param($Entry, [string]$Relative, $Lines)

    if (Test-IsReparsePoint $Entry) {
        $Lines.Add("L|$Relative")
        return
    }
    $attributes = [int]($Entry.Attributes -band $script:AttributeMask)
    if (Test-IsDirectoryEntry $Entry) {
        $Lines.Add("D|$Relative|$attributes")
        foreach ($child in ([IO.DirectoryInfo]$Entry.FullName).EnumerateFileSystemInfos()) {
            Add-EntryLines -Entry $child -Relative ($Relative + '\' + $child.Name) -Lines $Lines
        }
    } else {
        $Lines.Add("F|$Relative|$attributes|$(Get-FileSha256 $Entry.FullName)")
    }
}

function Get-EntryLines($Entry, [string]$Name) {
    $lines = [System.Collections.Generic.List[string]]::new()
    Add-EntryLines -Entry $Entry -Relative $Name -Lines $lines
    $array = $lines.ToArray()
    [Array]::Sort($array, [StringComparer]::Ordinal)
    return , $array
}

function Get-ManifestMap($Entries) {
    $map = @{}
    foreach ($entry in @($Entries)) {
        $map[$entry.Name] = Get-EntryLines $entry $entry.Name
    }
    return $map
}

function Get-LineDifferences([string[]]$Expected, [string[]]$Actual) {
    $differences = [System.Collections.Generic.List[string]]::new()
    $expectedSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$Expected, [StringComparer]::Ordinal)
    $actualSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$Actual, [StringComparer]::Ordinal)
    foreach ($line in $expectedSet) {
        if (-not $actualSet.Contains($line)) { $differences.Add("missing or different: $line") }
    }
    foreach ($line in $actualSet) {
        if (-not $expectedSet.Contains($line)) { $differences.Add("unexpected: $line") }
    }
    return @($differences)
}

function Get-MapDifferences($Expected, $Actual) {
    $differences = [System.Collections.Generic.List[string]]::new()
    foreach ($name in @($Expected.Keys)) {
        if (-not $Actual.ContainsKey($name)) {
            $differences.Add("missing entry: $name")
            continue
        }
        foreach ($difference in @(Get-LineDifferences $Expected[$name] $Actual[$name])) { $differences.Add($difference) }
    }
    foreach ($name in @($Actual.Keys)) {
        if (-not $Expected.ContainsKey($name)) { $differences.Add("unexpected entry: $name") }
    }
    return @($differences)
}

function Copy-EntryTree($Entry, [string]$DestinationPath) {
    if (Test-IsReparsePoint $Entry) { throw "Refusing to copy a link: $($Entry.FullName)" }
    if (Test-IsDirectoryEntry $Entry) {
        [IO.Directory]::CreateDirectory($DestinationPath) | Out-Null
        foreach ($child in ([IO.DirectoryInfo]$Entry.FullName).EnumerateFileSystemInfos()) {
            Copy-EntryTree -Entry $child -DestinationPath (Join-Path $DestinationPath $child.Name)
        }
        [IO.File]::SetAttributes($DestinationPath, $Entry.Attributes)
        [IO.Directory]::SetLastWriteTimeUtc($DestinationPath, $Entry.LastWriteTimeUtc)
    } else {
        [IO.File]::Copy($Entry.FullName, $DestinationPath, $false)
        [IO.File]::SetAttributes($DestinationPath, $Entry.Attributes)
        [IO.File]::SetLastWriteTimeUtc($DestinationPath, $Entry.LastWriteTimeUtc)
    }
}

function Write-NameList([string]$Heading, $Names) {
    Write-Info $Heading
    if (@($Names).Count -eq 0) {
        Write-Info '  (none)'
        return
    }
    foreach ($name in @($Names)) { Write-Info "  - $name" }
}

function Write-FailureGuidance([string]$Stage, [string]$Message) {
    $skills = $script:Context['SkillsPath']
    $source = $script:Context['SourcePath']
    $staging = $script:Context['StagingPath']
    $run = $script:Context['RunDirectory']
    Write-Info ''
    Write-Info "FAILED while applying (stage: $Stage): $Message"
    switch ($Stage) {
        { $_ -in @('archive', 'staging', 'verify-before-detach') } {
            Write-Info "The junction at $skills was NOT detached and the source folder was not modified. Nothing needs to be repaired."
            if ($run) { Write-Info "A partial archive may exist at $run. A partial staging copy may exist at $staging. Neither is used by anything; inspect and clean them up yourself, then run the migration again." }
        }
        'detach' {
            Write-Info "Detaching the junction failed; check whether $skills is still a junction. The source folder was not modified. A complete, verified copy of the personal entries is at $staging."
        }
        'detached' {
            Write-Info "The junction was detached, but the verified staging copy could not be renamed to $skills."
            Write-Info "Finish by hand: rename $staging to $skills (it holds the complete, verified personal entries). The source folder $source was not modified."
        }
        default {
            Write-Info "The real destination $skills exists, but its final verification failed. The source folder $source was not modified."
            Write-Info "Compare $skills with $source (the retired skills are archived at $run) before relying on it."
        }
    }
    Write-Info 'The whole-root junction is never recreated by this tool; restore individual skills by copying them from the archive or from the source.'
}

# --- the migration ----------------------------------------------------------------------------------------

function Invoke-Migration {
    $modeText = if ($Apply) { 'APPLY' } else { 'PLAN ONLY' }
    Write-Info "Task Master personal skills migration - $modeText"
    if ($Apply) {
        Write-Info 'Apply mode: a verified whole-root junction is replaced by a real directory; the source skills folder is never modified.'
    } else {
        Write-Info 'Plan mode: nothing is written, copied, archived, detached or deleted. Re-run with -Apply to migrate.'
    }

    if ([Environment]::OSVersion.Platform -ne [PlatformID]::Win32NT) {
        Write-Info 'The whole-root junction layout only exists on Windows; nothing to do on this platform.'
        Exit-WithResult 'NoAction' 0
    }

    $personalRootText = $PersonalRoot
    if ([string]::IsNullOrWhiteSpace($personalRootText)) {
        if ([string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
            Write-Info 'BLOCKED: USERPROFILE is not set. Pass -PersonalRoot explicitly.'
            Exit-WithResult 'Blocked' 1
        }
        $personalRootText = Join-Path $env:USERPROFILE '.copilot'
    }
    $personalFull = Resolve-FullPath $personalRootText
    $skillsPath = Join-Path $personalFull 'skills'
    if ([string]::IsNullOrWhiteSpace($SourceSkillsPath)) {
        $sourceFull = Resolve-FullPath (Join-Path (Split-Path -Parent $PSScriptRoot) 'skills')
    } else {
        $sourceFull = Resolve-FullPath $SourceSkillsPath
    }
    if ([string]::IsNullOrWhiteSpace($ArchiveRoot)) {
        $archiveBase = Join-Path $personalFull 'migration-archive'
    } else {
        $archiveBase = Resolve-FullPath $ArchiveRoot
    }
    $script:Context['SkillsPath'] = $skillsPath
    $script:Context['SourcePath'] = $sourceFull

    Write-Info ''
    Write-Info "Personal skills path : $skillsPath"
    Write-Info "Expected source      : $sourceFull"
    Write-Info "Archive base         : $archiveBase"

    $blocks = [System.Collections.Generic.List[string]]::new()

    # -RetireSkill: plain single folder names only (a comma separated value is accepted for -File invocations).
    $retireNames = [System.Collections.Generic.List[string]]::new()
    $seen = @{}
    foreach ($entry in @($RetireSkill)) {
        foreach ($part in ([string]$entry).Split(',')) {
            $name = $part.Trim()
            if (-not (Test-SkillFolderName $name)) {
                $blocks.Add("-RetireSkill entry '$name' is not a single skill folder name (no path separators, '.', '..' or empty values).")
                continue
            }
            $key = $name.ToLowerInvariant()
            if (-not $seen.ContainsKey($key)) {
                $seen[$key] = $true
                $retireNames.Add($name)
            }
        }
    }
    $retireSource = if ($script:RetireSkillExplicit) { 'selected with -RetireSkill' } else { 'approved default list' }

    # Classify the personal skills root.
    $personalExists = Test-Path -LiteralPath $personalFull -PathType Container
    $skillsItem = $null
    $leftovers = @()
    if ($personalExists) {
        $skillsItem = Get-PathItem $skillsPath
        $leftovers = @(Get-ChildItem -LiteralPath $personalFull -Force -Directory | Where-Object { $_.Name -like 'skills.migration-*' } | ForEach-Object { $_.FullName })
    }
    if (-not $personalExists) {
        $state = 'PersonalRootMissing'
    } elseif ($null -eq $skillsItem) {
        $state = 'Missing'
    } elseif (Test-IsReparsePoint $skillsItem) {
        $state = if ((Get-ItemLinkType $skillsItem) -eq 'Junction') { 'Junction' } else { 'OtherLink' }
    } elseif (Test-IsDirectoryEntry $skillsItem) {
        $state = 'RealDirectory'
    } else {
        $state = 'File'
    }

    $junctionTarget = $null
    switch ($state) {
        'File' {
            $blocks.Add("$skillsPath is a file, not a directory or a junction.")
        }
        'OtherLink' {
            $blocks.Add("$skillsPath is a link of type '$(Get-ItemLinkType $skillsItem)', not a directory junction. Only a verified junction to the expected source is migrated.")
        }
        'Missing' {
            if ($leftovers.Count -gt 0) {
                $blocks.Add("$skillsPath does not exist, but a staging folder from an interrupted migration does: $($leftovers -join ', '). Inspect it and rename it to $skillsPath by hand if it is complete; it is never guessed at or deleted.")
            }
        }
        'Junction' {
            $junctionTarget = Get-ItemLinkTarget $skillsItem
            if ([string]::IsNullOrWhiteSpace($junctionTarget)) {
                $blocks.Add("The target of the junction $skillsPath cannot be read.")
            } elseif (-not (Test-SamePath $junctionTarget $sourceFull)) {
                $blocks.Add("$skillsPath is a junction that does not point to the expected source (junction target: $junctionTarget; expected source: $sourceFull). If it points at the live Task Master skills folder, pass that folder with -SourceSkillsPath.")
            }
        }
    }

    $sourceEntries = @()
    $sourceManifest = $null
    $retireEntries = @()
    $keepEntries = @()
    if ($state -eq 'Junction' -and $blocks.Count -eq 0) {
        $sourceItem = Get-PathItem $sourceFull
        if ($null -eq $sourceItem -or -not (Test-IsDirectoryEntry $sourceItem)) {
            $blocks.Add("The expected source $sourceFull does not exist or is not a folder (the junction is dangling).")
        } elseif (Test-IsReparsePoint $sourceItem) {
            $blocks.Add("The expected source $sourceFull is itself a link; it must be a real folder.")
        } else {
            $sourceEntries = @(Get-TopLevelEntries $sourceFull)
            $sourceManifest = Get-ManifestMap $sourceEntries
            foreach ($name in @($sourceManifest.Keys)) {
                foreach ($line in $sourceManifest[$name]) {
                    if ($line.StartsWith('L|')) {
                        $blocks.Add("The source contains a nested link that cannot be copied safely: $($line.Substring(2)). Resolve it first.")
                    }
                }
            }
            if ($blocks.Count -eq 0) {
                $visible = Get-ManifestMap (Get-TopLevelEntries $skillsPath)
                $visibleDifferences = @(Get-MapDifferences $sourceManifest $visible)
                if ($visibleDifferences.Count -gt 0) {
                    $blocks.Add("The content visible through the junction $skillsPath does not match the expected source ($($visibleDifferences[0])).")
                }
            }
            if (Test-PathInside $archiveBase $skillsPath) {
                $blocks.Add("The archive location $archiveBase is inside the personal skills path, i.e. inside skill discovery. Choose an ArchiveRoot outside it.")
            }
            if (Test-PathInside $archiveBase $sourceFull) {
                $blocks.Add("The archive location $archiveBase is inside the source skills folder. Choose an ArchiveRoot outside it.")
            }
            $archiveItem = Get-PathItem $archiveBase
            if ($null -ne $archiveItem -and ((Test-IsReparsePoint $archiveItem) -or -not (Test-IsDirectoryEntry $archiveItem))) {
                $blocks.Add("The archive location $archiveBase exists but is not a real folder.")
            }
        }
    }

    if ($blocks.Count -gt 0) {
        Write-Info ''
        foreach ($block in $blocks) { Write-Info "BLOCKED: $block" }
        Write-Info 'Nothing was written.'
        Exit-WithResult 'Blocked' 1
    }

    switch ($state) {
        'PersonalRootMissing' {
            Write-Info ''
            Write-Info "No personal Copilot folder exists at $personalFull; there is nothing to migrate."
            Exit-WithResult 'NoAction' 0
        }
        'Missing' {
            Write-Info ''
            Write-Info "No personal skills folder exists at $skillsPath; there is nothing to migrate and nothing is created."
            Exit-WithResult 'NoAction' 0
        }
        'RealDirectory' {
            Write-Info ''
            Write-Info "$skillsPath is already a real directory (migrated earlier or owned by the user)."
            Write-Info 'It is left untouched: nothing is archived, copied, detached or deleted, and no junction is created.'
            Exit-WithResult 'NoAction' 0
        }
    }

    # From here on: a verified junction to the expected source, a real source folder, a safe archive location.
    $retireEntries = @($sourceEntries | Where-Object { (Test-IsDirectoryEntry $_) -and ($retireNames -contains $_.Name) })
    $retirePresentNames = @($retireEntries | ForEach-Object { $_.Name })
    $keepEntries = @($sourceEntries | Where-Object { $retirePresentNames -notcontains $_.Name })
    $retireMissing = @($retireNames | Where-Object { $retirePresentNames -notcontains $_ })
    $keepDisplay = @($keepEntries | Sort-Object Name | ForEach-Object { if (Test-IsDirectoryEntry $_) { $_.Name } else { "$($_.Name) (file)" } })

    $stamp = [DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss', [Globalization.CultureInfo]::InvariantCulture)
    $token = [Guid]::NewGuid().ToString('N').Substring(0, 8)
    $runDirectory = Join-Path $archiveBase "skills-migration-$stamp-$token"
    $retiredDirectory = Join-Path $runDirectory 'retired-skills'
    $stagingPath = Join-Path $personalFull "skills.migration-$stamp-$token"
    $script:Context['RunDirectory'] = $runDirectory
    $script:Context['StagingPath'] = $stagingPath

    Write-Info "Current state        : directory junction -> $junctionTarget (verified against the expected source)"
    Write-Info ''
    Write-NameList "Legacy skills ($retireSource) to archive outside skill discovery, a verified copy under ${archiveBase}\skills-migration-<timestamp>-<id>\retired-skills :" @($retirePresentNames | Sort-Object)
    if ($retireMissing.Count -gt 0) { Write-Info "Legacy skills not present in the source (nothing to archive): $($retireMissing -join ', ')" }
    Write-Info ''
    Write-NameList "Entries preserved in the real destination ${skillsPath} (copied, never removed from the source) :" $keepDisplay

    if (-not $Apply) {
        Write-Info ''
        Write-Info 'With -Apply the following steps run, stopping at the first problem:'
        Write-Info '  1. Archive the legacy skills above (verified copy) outside skill discovery.'
        Write-Info '  2. Copy every preserved entry into a staging folder next to the junction and verify it byte for byte.'
        Write-Info '  3. Re-verify the junction and that the source did not change.'
        Write-Info '  4. Detach ONLY the junction (the source folder is never modified or deleted).'
        Write-Info '  5. Rename the staging folder to the real destination and verify destination and source again.'
        Write-Info '  6. Write migration-report.json into the archive run folder.'
        Write-Info 'The whole-root junction is never recreated by this tool. Plan mode made no changes.'
        Exit-WithResult 'Planned' 0
    }

    # --- apply ---------------------------------------------------------------------------------------------
    $keepManifest = @{}
    foreach ($entry in $keepEntries) { $keepManifest[$entry.Name] = $sourceManifest[$entry.Name] }

    $script:Stage = 'archive'
    Write-Info ''
    Write-Info "[1/6] Archiving $($retireEntries.Count) legacy skill(s) to $retiredDirectory"
    [IO.Directory]::CreateDirectory($retiredDirectory) | Out-Null
    $archived = [System.Collections.Generic.List[object]]::new()
    foreach ($entry in $retireEntries) {
        $archivedPath = Join-Path $retiredDirectory $entry.Name
        Copy-EntryTree -Entry $entry -DestinationPath $archivedPath
        $copyLines = Get-EntryLines ([IO.DirectoryInfo]$archivedPath) $entry.Name
        $differences = @(Get-LineDifferences $sourceManifest[$entry.Name] $copyLines)
        if ($differences.Count -gt 0) { throw "The archived copy of $($entry.Name) does not match the source ($($differences[0]))." }
        $fileCount = @($copyLines | Where-Object { $_.StartsWith('F|') }).Count
        $archived.Add([ordered]@{ name = $entry.Name; archivedTo = $archivedPath; files = $fileCount })
    }

    $script:Stage = 'staging'
    Write-Info "[2/6] Copying $($keepEntries.Count) personal entr$(if ($keepEntries.Count -eq 1) { 'y' } else { 'ies' }) to the staging folder $stagingPath"
    [IO.Directory]::CreateDirectory($stagingPath) | Out-Null
    foreach ($entry in $keepEntries) {
        Copy-EntryTree -Entry $entry -DestinationPath (Join-Path $stagingPath $entry.Name)
    }
    $stagingDifferences = @(Get-MapDifferences $keepManifest (Get-ManifestMap (Get-TopLevelEntries $stagingPath)))
    if ($stagingDifferences.Count -gt 0) { throw "The staging copy does not match the source ($($stagingDifferences[0]))." }

    $script:Stage = 'verify-before-detach'
    Write-Info '[3/6] Re-verifying the junction and the source before anything is detached'
    $currentItem = Get-PathItem $skillsPath
    $stillJunction = ($null -ne $currentItem) -and (Test-IsReparsePoint $currentItem) -and ((Get-ItemLinkType $currentItem) -eq 'Junction')
    if (-not $stillJunction -or -not (Test-SamePath (Get-ItemLinkTarget $currentItem) $sourceFull)) {
        throw "The personal skills junction changed while the migration was running."
    }
    $sourceNow = Get-ManifestMap (Get-TopLevelEntries $sourceFull)
    $sourceDrift = @(Get-MapDifferences $sourceManifest $sourceNow)
    if ($sourceDrift.Count -gt 0) {
        throw "The source skills folder changed while the migration was running ($($sourceDrift[0])); nothing was detached."
    }

    $script:Stage = 'detach'
    Write-Info "[4/6] Detaching ONLY the junction $skillsPath (the source folder is not touched)"
    [System.IO.Directory]::Delete($skillsPath, $false)

    $script:Stage = 'detached'
    Write-Info "[5/6] Renaming the staging folder to $skillsPath"
    $moved = $false
    for ($attempt = 1; $attempt -le 3 -and -not $moved; $attempt++) {
        try {
            [System.IO.Directory]::Move($stagingPath, $skillsPath)
            $moved = $true
        } catch {
            if ($attempt -eq 3) { throw }
            Start-Sleep -Milliseconds 500
        }
    }

    $script:Stage = 'verify-after'
    Write-Info '[6/6] Verifying the real destination and the unchanged source'
    $finalItem = Get-PathItem $skillsPath
    if ($null -eq $finalItem -or (Test-IsReparsePoint $finalItem) -or -not (Test-IsDirectoryEntry $finalItem)) {
        throw "$skillsPath is not a real directory after the migration."
    }
    $finalDifferences = @(Get-MapDifferences $keepManifest (Get-ManifestMap (Get-TopLevelEntries $skillsPath)))
    if ($finalDifferences.Count -gt 0) { throw "The real destination does not match the preserved source content ($($finalDifferences[0]))." }
    $sourceAfter = @(Get-MapDifferences $sourceManifest (Get-ManifestMap (Get-TopLevelEntries $sourceFull)))
    if ($sourceAfter.Count -gt 0) { throw "The source skills folder changed during the migration ($($sourceAfter[0]))." }

    $recovery = "Legacy skills were copied (never moved) to $retiredDirectory; copy one back into $skillsPath to restore it. The source folder $sourceFull was not modified. The whole-root junction is not recreated by this tool."
    $report = [ordered]@{
        schemaVersion          = 1
        result                 = 'Applied'
        appliedAtUtc           = [DateTime]::UtcNow.ToString('o')
        personalSkillsPath     = $skillsPath
        detachedJunctionTarget = $junctionTarget
        sourceSkillsPath       = $sourceFull
        archivePath            = $runDirectory
        retiredSkills          = @($archived)
        preservedEntries       = @($keepEntries | Sort-Object Name | ForEach-Object { $_.Name })
        sourceUnchanged        = $true
        recovery               = $recovery
    }
    $reportPath = Join-Path $runDirectory 'migration-report.json'
    $reportWritten = $true
    try {
        [IO.File]::WriteAllText($reportPath, ($report | ConvertTo-Json -Depth 6), (New-Object System.Text.UTF8Encoding($false)))
    } catch {
        $reportWritten = $false
        Write-Info "WARNING: the migration is complete and verified, but the report could not be written: $($_.Exception.Message)"
    }

    $script:Stage = 'done'
    Write-Info ''
    Write-Info 'Migration applied and verified.'
    Write-NameList 'Legacy skills archived outside skill discovery :' @($retirePresentNames | Sort-Object)
    Write-NameList "Entries preserved in the real destination ${skillsPath} :" $keepDisplay
    Write-Info ''
    Write-Info "Archive run folder   : $runDirectory"
    if ($reportWritten) { Write-Info "Migration report     : $reportPath" }
    Write-Info "Source folder        : $sourceFull (unchanged)"
    Write-Info $recovery
    Exit-WithResult 'Applied' 0
}

try {
    Invoke-Migration
} catch {
    $message = $_.Exception.Message
    if ($script:Stage -eq 'preflight') {
        Write-Info ''
        Write-Info "BLOCKED: the migration preconditions could not be verified: $message"
        Write-Info 'Nothing was written.'
        Exit-WithResult 'Blocked' 1
    }
    Write-FailureGuidance -Stage $script:Stage -Message $message
    Exit-WithResult 'Failed' 2
}
