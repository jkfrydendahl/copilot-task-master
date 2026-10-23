param([switch]$AgentOwnershipOnly)
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$script:Failed = 0

function Assert-True($Condition, $Message) {
    if (-not $Condition) { throw $Message }
}

function Run-Test($Name, [scriptblock]$Action) {
    if ($AgentOwnershipOnly -and $Name -notmatch "^Agent ownership:|^Setup helpers") { return }
    try {
        & $Action
        Write-Host "PASS: $Name"
    } catch {
        $script:Failed++
        Write-Host "FAIL: $Name -- $_"
    }
}

Run-Test "Setup helpers are import-safe and generate agents only in the requested directory" {
    . (Join-Path $PSScriptRoot "workbench-setup.ps1")
    $root = Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory $root | Out-Null
    try {
        $profiles = @(
            @{key="review";label="Review";description="Review a developer's changes";model="test-model";effort="xhigh";context="long_context"}
            @{key="triage";label="Triage";description="Estimate";model="test-model"}
        )
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        $agentPath = Join-Path $root "agents\review.agent.md"
        $content = Get-Content -LiteralPath $agentPath -Raw
        Assert-True ($content.Contains("developer''s") -and $content.Contains("tools: ['read', 'search']")) "Agent contract changed"
        foreach ($setting in @('"model":"test-model"','"reasoning_effort":"xhigh"','"context_tier":"long_context"')) {
            Assert-True ($content.Contains($setting)) "Generated agent lost required task argument $setting"
        }
        $frontmatter=[regex]::Match($content,'(?s)\A---\r?\n(.*?)\r?\n---').Groups[1].Value
        Assert-True ($frontmatter -notmatch '(?m)^(effort|context|reasoning_effort|context_tier):') "Unsupported execution frontmatter invented"
        Assert-True (-not (Test-Path (Join-Path $root "agents\triage.agent.md"))) "Triage agent generated"
        Set-Content -LiteralPath (Join-Path $root "agents\user-owned.agent.md") -Value "untouched"
        $profiles[0].key = "quick"
        $profiles[0].effort = "max"
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        Assert-True ((Get-Content -LiteralPath (Join-Path $root "agents\quick.agent.md") -Raw).Contains('"reasoning_effort":"max"')) "Regeneration retained an old effort"
        Assert-True (-not (Test-Path $agentPath)) "Generated stale agent retained"
        Assert-True ((Get-Content (Join-Path $root "agents\user-owned.agent.md")) -eq "untouched") "User-owned agent changed"
    } finally {
        if (Test-Path (Join-Path $root "agents")) {
            Get-ChildItem -LiteralPath (Join-Path $root "agents") -File -Force | Remove-Item -Force
            Remove-Item -LiteralPath (Join-Path $root "agents")
        }
        Remove-Item -LiteralPath $root
    }
}

Run-Test "Kickoff preserves the launch baseline and references canonical workflow rules" {
    . (Join-Path $PSScriptRoot "workbench-setup.ps1")
    foreach ($key in @("quick", "triage", "orchestrator")) {
        $profile = @{key=$key;label=$key;description="test purpose";model="test-model";effort="medium";context="default"}
        $text = Get-WorkbenchSessionKickoff -Profile $profile -MasterPath "C:\workbench"
        foreach ($value in @($key, "test-model", "medium", "default", "test purpose")) {
            Assert-True ($text.Contains($value)) "Kickoff lost $value"
        }
        $owner = if ($key -eq "orchestrator") { "15-orchestrator-mode" } else { "10-model-selection" }
        Assert-True ($text.Contains($owner)) "Missing canonical instruction owner"
    }
}

Run-Test "Session helpers preserve capped invariant usage records and JSON metadata" {
    . (Join-Path $PSScriptRoot "workbench-session.ps1")
    $root = Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory $root | Out-Null
    try {
        $info = [pscustomobject]@{
            session_id = "fixture-session"
            timestamp_start = "2026-09-08T10:00:00"
            repo_name = 'Quoted "repo"'
            repo_type = "Generic"
            task_class = "quick"
            task_label = "Quick"
        }
        $path = Join-Path $root "usage-pending-fixture.json"
        Write-WorkbenchSessionMarker -Path $path -SessionInfo $info
        $restored = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
        Assert-True ($restored.repo_name -eq $info.repo_name) "Session metadata changed"
        $usage = Get-WorkbenchUsageRecord -SessionInfo $restored -EndedAt ([datetime]"2026-09-09T10:00:00") -Abandoned $true
        Assert-True ($usage.duration_min -eq "600" -and $usage.abandoned) "Duration cap/abandoned state changed"
        $precise = Get-WorkbenchUsageRecord -SessionInfo $restored -StartedAt ([datetime]"2026-09-08T10:00:00.9") -EndedAt ([datetime]"2026-09-08T10:00:03.5")
        Assert-True ($precise.duration_min -eq "0") "Normal-session timing lost subsecond precision"
        Complete-WorkbenchSession -SessionInfo $info -PendingPath $path -LogPath (Join-Path $root "usage.csv") -EndedAt ([datetime]"2026-09-08T10:01:30")
        $logged = Import-Csv (Join-Path $root "usage.csv")
        Assert-True ($logged.duration_min -eq "1.5" -and $logged.abandoned -eq "False") "Normal usage record changed"
        Assert-True (-not (Test-Path $path)) "Completed marker retained"
        Write-WorkbenchSessionMarker -Path $path -SessionInfo $info
        $orphan = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
        $orphan | Add-Member -NotePropertyName owner_process_started_at_utc -NotePropertyValue "2000-01-01T00:00:00Z" -Force
        $orphan | ConvertTo-Json | Set-Content -LiteralPath $path
        Resolve-AbandonedSession -MasterPath $root -LogPath (Join-Path $root "usage.csv")
        $logged = @(Import-Csv (Join-Path $root "usage.csv"))
        Assert-True ($logged.Count -eq 2 -and $logged[1].abandoned -eq "True") "Recovery contract changed"
        $badLog = Join-Path $root "incompatible.csv"
        Set-Content -LiteralPath $badLog -Value "unrelated_header"
        Complete-WorkbenchSession -SessionInfo $info -PendingPath $path -LogPath $badLog
        Assert-True ((Get-Content -LiteralPath $badLog) -eq "unrelated_header") "Incompatible log was overwritten"
        $info.session_id = "short"
        $info.task_class = "triage"
        Write-WorkbenchSessionMarker -Path $path -SessionInfo $info
        $messages = Complete-WorkbenchSession -SessionInfo $info -PendingPath $path -LogPath (Join-Path $root "usage.csv") 6>&1 | Out-String
        Assert-True ($messages.Contains("paste session ID: short")) "Continuation message lost the supplied session ID"
    } finally {
        Get-ChildItem -LiteralPath $root -File | Remove-Item
        Remove-Item -LiteralPath $root
    }
}

Run-Test "Recovery preserves live and unidentifiable owners and recovers exited processes" {
    . (Join-Path $PSScriptRoot "workbench-session.ps1")
    $root = Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory $root | Out-Null
    try {
        $info = [pscustomobject]@{
            session_id="live-session";timestamp_start=(Get-Date).ToString("s")
            repo_name="Fixture";repo_type="Generic";task_class="quick";task_label="Quick"
        }
        $path = Join-Path $root "usage-pending-live.json"
        $log = Join-Path $root "usage.csv"
        Write-WorkbenchSessionMarker -Path $path -SessionInfo $info
        Resolve-AbandonedSession -MasterPath $root -LogPath $log
        Assert-True ((Test-Path $path) -and -not (Test-Path $log)) "Live session was marked abandoned"
        $marker = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
        Assert-True ($marker.owner_process_id -eq $PID -and $marker.owner_process_started_at_utc) "Missing process identity"
        Assert-True ($null -eq $info.PSObject.Properties["owner_process_id"]) "Marker writer mutated session metadata"
        $legacy = Join-Path $root "usage-pending-legacy.json"
        $info | ConvertTo-Json | Set-Content -LiteralPath $legacy
        Resolve-AbandonedSession -MasterPath $root -LogPath $log
        Assert-True ((Test-Path $legacy) -and -not (Test-Path $log)) "Unknown legacy owner guessed abandoned"
        $marker.owner_process_id = [int]::MaxValue
        $marker | ConvertTo-Json | Set-Content -LiteralPath $path
        Resolve-AbandonedSession -MasterPath $root -LogPath $log
        Assert-True (-not (Test-Path $path) -and (Test-Path $legacy)) "Exited owner was not recovered safely"
        $logged = @(Import-Csv -LiteralPath $log)
        Assert-True ($logged.Count -eq 1 -and $logged[0].abandoned -eq "True") "Wrong orphan recovery record"
        $marker.owner_process_started_at_utc = "invalid"
        $marker | ConvertTo-Json | Set-Content -LiteralPath $path
        Resolve-AbandonedSession -MasterPath $root -LogPath $log
        Assert-True ((Test-Path $path) -and @(Import-Csv -LiteralPath $log).Count -eq 1) "Malformed owner was discarded or guessed abandoned"
        $marker.owner_process_started_at_utc = "2000-01-01T00:00:00Z"
        $marker | ConvertTo-Json | Set-Content -LiteralPath $path
        $badLog = Join-Path $root "incompatible.csv"
        Set-Content -LiteralPath $badLog -Value "unrelated_header"
        Resolve-AbandonedSession -MasterPath $root -LogPath $badLog
        Assert-True ((Test-Path $path) -and (Get-Content -LiteralPath $badLog) -eq "unrelated_header") "Failed recovery lost marker or overwrote incompatible log"
        $dictionary = @{}
        foreach ($property in $info.PSObject.Properties) {
            $dictionary[$property.Name] = $property.Value
        }
        Write-WorkbenchSessionMarker -Path $path -SessionInfo $dictionary
        $restored = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
        Assert-True ($restored.session_id -eq $info.session_id -and $restored.owner_process_id -eq $PID) "Dictionary marker lost its metadata"
    } finally {
        Get-ChildItem -LiteralPath $root -File | Remove-Item
        Remove-Item -LiteralPath $root
    }
}

Run-Test "Interactive launcher wires helpers without starting a real CLI or editor" {
    $root = Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    $oldHome = $env:USERPROFILE
    $oldLocation = Get-Location
    $oldInstructions = $env:COPILOT_CUSTOM_INSTRUCTIONS_DIRS
    New-Item -ItemType Directory $root | Out-Null
    try {
        foreach ($directory in @("scripts", "config", "home")) {
            New-Item -ItemType Directory (Join-Path $root $directory) | Out-Null
        }
        $env:USERPROFILE = Join-Path $root "home"
        Copy-Item (Join-Path $PSScriptRoot "..\Start-CopilotWork.ps1") $root
        foreach ($file in @("model-id-parser.ps1", "model-launch-args.ps1", "workbench-setup.ps1", "workbench-session.ps1")) {
            Copy-Item (Join-Path $PSScriptRoot $file) (Join-Path $root "scripts")
        }
        Copy-Item (Join-Path $PSScriptRoot "..\config\model-capabilities.json") (Join-Path $root "config")
        @(@{name="Fixture";type="Generic";path=$root}) | ConvertTo-Json | Set-Content (Join-Path $root "repos.json")
        @(@{key="quick";label="Quick";description="Fixture";model="gpt-5.4";effort="medium";context="default";hint=""}) |
            ConvertTo-Json | Set-Content (Join-Path $root "task-profiles.json")
        $workbenchTestState = @{
            Answers = [Collections.Generic.Queue[string]]::new()
            LaunchArgs = @()
            MarkerPaths = @()
        }
        foreach ($answer in @("1", "1", "n", "")) { $workbenchTestState.Answers.Enqueue($answer) }
        function Read-Host { $workbenchTestState.Answers.Dequeue() }
        function copilot {
            if ($args[0] -eq "help") { return 'Allowed values: "gpt-5.4"' }
            $workbenchTestState.LaunchArgs = @($args)
            $markers = @(Get-ChildItem -LiteralPath $root -Filter "usage-pending-*.json")
            Assert-True ($markers.Count -eq 1) "Missing launch marker"
            $workbenchTestState.MarkerPaths += $markers[0].FullName
            $marker = Get-Content -LiteralPath $markers[0].FullName -Raw | ConvertFrom-Json
            $idFlag = if ($args -contains "--resume") { "--resume" } else { "--session-id" }
            $effectiveId = $args[[array]::IndexOf($args, $idFlag) + 1]
            Assert-True ($marker.session_id -eq $effectiveId) "Marker does not identify the actual CLI session"
            Assert-True ($marker.owner_process_id -eq $PID -and $marker.owner_process_started_at_utc) "Launcher marker has no owner"
        }
        & (Join-Path $root "Start-CopilotWork.ps1") 6>$null
        Assert-True ($workbenchTestState.Answers.Count -eq 0) "Menu/resume flow changed"
        foreach ($argument in @("--model", "gpt-5.4", "--effort", "medium", "--context", "default", "--session-id", "--interactive")) {
            Assert-True ($workbenchTestState.LaunchArgs -contains $argument) "Missing launch argument $argument"
        }
        Assert-True (@(Import-Csv (Join-Path $root "usage-log.csv")).Count -eq 1) "Completion log missing"
        Assert-True (@(Get-ChildItem -LiteralPath $root -Filter "usage-pending-*.json").Count -eq 0) "Pending marker leaked"
        foreach ($answer in @("1", "1", "n", "  previous-session-id  ")) { $workbenchTestState.Answers.Enqueue($answer) }
        & (Join-Path $root "Start-CopilotWork.ps1") 6>$null
        Assert-True ($workbenchTestState.LaunchArgs -contains "--resume" -and $workbenchTestState.LaunchArgs -contains "previous-session-id") "Resume flow changed"
        Assert-True ($workbenchTestState.LaunchArgs -notcontains "--session-id") "Resume also creates a new CLI session"
        Assert-True (@(Import-Csv (Join-Path $root "usage-log.csv")).Count -eq 2) "Repeat launch did not append usage"
        $logged = @(Import-Csv (Join-Path $root "usage-log.csv"))
        Assert-True ($logged[1].session_id -eq "previous-session-id") "Resumed session logged under unused UUID"
        Assert-True (@($workbenchTestState.MarkerPaths | Select-Object -Unique).Count -eq 2) "Launches reused a pending marker path"
    } finally {
        Set-Location $oldLocation
        $env:USERPROFILE = $oldHome
        $env:COPILOT_CUSTOM_INSTRUCTIONS_DIRS = $oldInstructions
        foreach ($file in Get-ChildItem -LiteralPath $root -Recurse -File -Force) {
            Remove-Item -LiteralPath $file.FullName -Force
        }
        foreach ($directory in Get-ChildItem -LiteralPath $root -Recurse -Directory -Force | Sort-Object { $_.FullName.Length } -Descending) {
            Remove-Item -LiteralPath $directory.FullName -Force
        }
        Remove-Item -LiteralPath $root
    }
}

# =================================================================================================
# Personal-skills migration and routing coverage (T16-T19).
# Everything below runs against temporary fake homes, temporary junctions and source copies. It
# never touches the real ~/.copilot, a real client, the live Task Master checkout or any global
# setting, and it never installs anything.
# =================================================================================================

$script:RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$script:MigrationScript = Join-Path $PSScriptRoot "Migrate-PersonalSkills.ps1"
$script:PowerShellExe = (Get-Process -Id $PID).Path
$script:OnWindows = ($PSVersionTable.PSEdition -eq "Desktop") -or ((Get-Variable -Name IsWindows -ValueOnly -ErrorAction SilentlyContinue) -eq $true)
$script:RetiredSkillNames = @("grill-me", "refine-requirements", "tdd-implement", "reference-lookup", "create-release", "update-readme", "estimate-task", "code-review", "session-time-audit")

function Skip-Test($Name, $Reason) {
    Write-Host "SKIP: $Name -- $Reason"
}

function Run-TestIf([bool]$Condition, $Name, $Reason, [scriptblock]$Action) {
    if ($Condition) { Run-Test $Name $Action } else { Skip-Test $Name $Reason }
}

function New-FixtureRoot {
    $root = Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory $root | Out-Null
    return $root
}

function Remove-FixtureNode([string]$Path) {
    # Junction-safe cleanup: a link is detached (never followed), real nodes are removed one at a time.
    $item = Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
    if ($null -eq $item) { return }
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        if ($item.PSIsContainer) { [IO.Directory]::Delete($Path, $false) } else { [IO.File]::Delete($Path) }
        return
    }
    if ($item.PSIsContainer) {
        foreach ($child in @(Get-ChildItem -LiteralPath $Path -Force)) { Remove-FixtureNode $child.FullName }
        [IO.Directory]::Delete($Path, $false)
    } else {
        [IO.File]::SetAttributes($Path, [IO.FileAttributes]::Normal)
        [IO.File]::Delete($Path)
    }
}

function Remove-FixtureRoot([string]$Root) {
    $full = [IO.Path]::GetFullPath($Root).TrimEnd("\", "/")
    $temp = [IO.Path]::GetFullPath([IO.Path]::GetTempPath()).TrimEnd("\", "/")
    if (-not $full.StartsWith($temp + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to clean up outside the temp directory: $full"
    }
    Remove-FixtureNode $full
}

function Set-FixtureFile([string]$Path, [string]$Content = "fixture") {
    $directory = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $directory)) { New-Item -ItemType Directory -Path $directory -Force | Out-Null }
    [IO.File]::WriteAllText($Path, $Content, [Text.UTF8Encoding]::new($false))
}

function Add-SnapshotEntries([string]$Base, [string]$Directory, $Lines) {
    foreach ($child in @(Get-ChildItem -LiteralPath $Directory -Force | Sort-Object Name)) {
        $relative = $child.FullName.Substring($Base.Length + 1)
        if ($child.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            $Lines.Add("L|$relative|$((@($child.Target))[0])")
        } elseif ($child.PSIsContainer) {
            $Lines.Add("D|$relative")
            Add-SnapshotEntries $Base $child.FullName $Lines
        } else {
            $Lines.Add("F|$relative|$((Get-FileHash -LiteralPath $child.FullName -Algorithm SHA256).Hash)")
        }
    }
}

function Get-TreeSnapshot([string]$Path) {
    # Content snapshot that never follows links: links are recorded with their target instead.
    $base = [IO.Path]::GetFullPath($Path).TrimEnd("\", "/")
    $lines = [Collections.Generic.List[string]]::new()
    Add-SnapshotEntries $base $base $lines
    return @($lines)
}

function Get-NodeState([string]$Path) {
    $item = Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
    if ($null -eq $item) { return "missing" }
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) { return "link:$((@($item.Target))[0])" }
    if ($item.PSIsContainer) { return "dir:`n" + ((Get-TreeSnapshot $Path) -join "`n") }
    return "file:$((Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash)"
}

function Test-IsLink([string]$Path) {
    $item = Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
    return ($null -ne $item) -and [bool]($item.Attributes -band [IO.FileAttributes]::ReparsePoint)
}

function Get-LinkTarget([string]$Path) {
    $item = Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
    if ($null -eq $item -or -not ($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) { return $null }
    return [string](@($item.Target)[0])
}

function Test-SamePath([string]$Left, [string]$Right) {
    $a = [IO.Path]::GetFullPath($Left).TrimEnd("\", "/")
    $b = [IO.Path]::GetFullPath($Right).TrimEnd("\", "/")
    return $a -ieq $b
}

function Test-IsUnder([string]$Path, [string]$Parent) {
    $child = [IO.Path]::GetFullPath($Path).TrimEnd("\", "/")
    $root = [IO.Path]::GetFullPath($Parent).TrimEnd("\", "/")
    return ($child -ieq $root) -or $child.StartsWith($root + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)
}

function Assert-SameSnapshot($Before, $After, $Message) {
    $left = @($Before)
    $right = @($After)
    if (($left -join "`n") -ceq ($right -join "`n")) { return }
    $removed = @($left | Where-Object { $right -cnotcontains $_ } | Select-Object -First 4)
    $added = @($right | Where-Object { $left -cnotcontains $_ } | Select-Object -First 4)
    throw "$Message (missing afterwards: $($removed -join ' | '); new afterwards: $($added -join ' | '))"
}

function Get-TopLevelName([string]$SnapshotLine) {
    return (($SnapshotLine -split "\|", 3)[1] -split "[\\/]")[0]
}

function New-MigrationFixture {
    # A fake home with a fake live workbench: the personal skills root is (by default) a junction
    # into the workbench's skills folder, exactly like the legacy Sync-PersonalSkills layout.
    param([ValidateSet("Junction", "WrongJunction", "RealDirectory", "NoSkills")][string]$Mode = "Junction")

    $root = New-FixtureRoot
    $personal = Join-Path $root "home\.copilot"
    $fixture = [pscustomobject]@{
        Root = $root
        Home = Join-Path $root "home"
        Personal = $personal
        Skills = Join-Path $personal "skills"
        Workbench = Join-Path $root "live-workbench"
        Source = Join-Path $root "live-workbench\skills"
        Other = Join-Path $root "other-skills"
        Archive = Join-Path $root "archive"
    }

    foreach ($name in $script:RetiredSkillNames) {
        Set-FixtureFile (Join-Path $fixture.Source "$name\SKILL.md") "---`nname: $name`n---`nlegacy $name"
        Set-FixtureFile (Join-Path $fixture.Source "$name\references\notes.md") "legacy reference for $name"
        Set-FixtureFile (Join-Path $fixture.Source "$name\.hidden-legacy") "hidden legacy file for $name"
    }
    Set-FixtureFile (Join-Path $fixture.Source "refine-requirements\phases\phase-1.md") "phase one"
    New-Item -ItemType Directory (Join-Path $fixture.Source "tdd-implement\empty-phase") | Out-Null
    foreach ($helper in @("estimate-session-duration.js", "extract-session-digest.js")) {
        Set-FixtureFile (Join-Path $fixture.Source "session-time-audit\scripts\$helper") "legacy audit helper $helper"
    }
    Set-FixtureFile (Join-Path $fixture.Source "my-personal-skill\SKILL.md") "---`nname: my-personal-skill`n---`npersonal"
    Set-FixtureFile (Join-Path $fixture.Source "my-personal-skill\assets\data.txt") "personal data"
    Set-FixtureFile (Join-Path $fixture.Source "notes.txt") "loose personal note"
    Set-FixtureFile (Join-Path $fixture.Source ".hidden-personal") "hidden personal file"
    [IO.File]::SetAttributes((Join-Path $fixture.Source ".hidden-personal"), [IO.FileAttributes]::Hidden)
    New-Item -ItemType Directory (Join-Path $fixture.Source "empty-personal-dir") | Out-Null

    # Launcher profiles live beside skills\ in the workbench; agents and settings live in the personal root.
    Set-FixtureFile (Join-Path $fixture.Workbench "task-profiles.json") "[{`"key`":`"quick`"}]"
    Set-FixtureFile (Join-Path $personal "agents\quick.agent.md") "generated agent"
    $agentHash = (Get-FileHash -LiteralPath (Join-Path $personal "agents\quick.agent.md")).Hash.ToLowerInvariant()
    Set-FixtureFile (Join-Path $personal "agents\.generated-task-class-agents.json") "{`"schemaVersion`":1,`"files`":[{`"key`":`"quick`",`"sha256`":`"$agentHash`"}]}"
    Set-FixtureFile (Join-Path $personal "agents\user-owned.agent.md") "user owned agent"
    Set-FixtureFile (Join-Path $personal "config.json") "{`"model`":`"fixture`"}"

    switch ($Mode) {
        "Junction" { New-Item -ItemType Junction -Path $fixture.Skills -Target $fixture.Source | Out-Null }
        "WrongJunction" {
            Set-FixtureFile (Join-Path $fixture.Other "foreign-skill\SKILL.md") "foreign skill"
            New-Item -ItemType Junction -Path $fixture.Skills -Target $fixture.Other | Out-Null
        }
        "RealDirectory" {
            Set-FixtureFile (Join-Path $fixture.Skills "grill-me\SKILL.md") "personal real copy"
            Set-FixtureFile (Join-Path $fixture.Skills "own-skill\SKILL.md") "own skill"
        }
        "NoSkills" { }
    }
    return $fixture
}

function Invoke-MigrationScript {
    param(
        [Parameter(Mandatory)]$Fixture,
        [switch]$Apply,
        [string]$Source,
        [switch]$DefaultSource,
        [string]$ArchiveRoot,
        [switch]$DefaultArchive,
        [switch]$DefaultPersonalRoot,
        [string[]]$ExtraArguments = @(),
        [string]$Shell = $script:PowerShellExe
    )

    $arguments = @("-NoProfile", "-NonInteractive")
    if ($Shell -like "*powershell.exe") { $arguments += @("-ExecutionPolicy", "Bypass") }
    $arguments += @("-File", $script:MigrationScript)
    if (-not $DefaultPersonalRoot) { $arguments += @("-PersonalRoot", $Fixture.Personal) }
    if (-not $DefaultSource) {
        $arguments += @("-SourceSkillsPath", $(if ($Source) { $Source } else { $Fixture.Source }))
    }
    if (-not $DefaultArchive) {
        $arguments += @("-ArchiveRoot", $(if ($ArchiveRoot) { $ArchiveRoot } else { $Fixture.Archive }))
    }
    if ($Apply) { $arguments += "-Apply" }
    $arguments += $ExtraArguments

    # The fake home only becomes USERPROFILE when the default personal root is under test: a child shell writes its own
    # startup caches below USERPROFILE (AppData\Local\Microsoft\PowerShell), which would otherwise show up as fixture writes.
    $oldProfile = $env:USERPROFILE
    if ($DefaultPersonalRoot) { $env:USERPROFILE = $Fixture.Home }
    try {
        $output = (& $Shell @arguments 2>&1 | Out-String)
        $exitCode = $LASTEXITCODE
    } finally {
        $env:USERPROFILE = $oldProfile
    }
    return [pscustomobject]@{ ExitCode = $exitCode; Output = $output }
}

function Format-Output($Result) {
    $text = [string]$Result.Output
    if ($text.Length -gt 900) { $text = $text.Substring(0, 900) + "..." }
    return "exit=$($Result.ExitCode) output=[$text]"
}

function Assert-ResultLine($Result, [string]$Expected, [int]$ExitCode, [string]$Context) {
    Assert-True ($Result.ExitCode -eq $ExitCode) "$Context : expected exit $ExitCode. $(Format-Output $Result)"
    Assert-True ($Result.Output -match "(?m)^Result:\s+$Expected\s*$") "$Context : expected 'Result: $Expected'. $(Format-Output $Result)"
}

function Get-ArchiveRunDirectories($Fixture, [string]$ArchiveBase = $Fixture.Archive) {
    if (-not (Test-Path -LiteralPath $ArchiveBase)) { return @() }
    return @(Get-ChildItem -LiteralPath $ArchiveBase -Directory -Force)
}

. (Join-Path $PSScriptRoot "workbench-setup.ps1")

function Assert-AgentSyncBlocked([string]$Root, [array]$Profiles) {
    Assert-True ($null -ne (Get-Command Update-TaskClassAgents -ErrorAction SilentlyContinue)) "Agent helper was not imported"
    $before = Get-TreeSnapshot $Root
    $errorText = ""
    try { Update-TaskClassAgents -MasterPath $Root -Profiles $Profiles -PersonalRoot $Root } catch { $errorText = $_.Exception.Message }
    Assert-True (-not [string]::IsNullOrWhiteSpace($errorText)) "Unsafe agent synchronization did not fail explicitly"
    Assert-True ($errorText -match "ownership|manifest|profile|agent key|agent hash") "Unexpected failure, not an ownership rejection: $errorText"
    Assert-SameSnapshot $before (Get-TreeSnapshot $Root) "Blocked synchronization changed files"
}

Run-Test "Agent ownership: unmanaged collisions block the entire plan before any write" {
    $root = New-FixtureRoot
    try {
        Set-FixtureFile (Join-Path $root "agents\review.agent.md") "personal review agent"
        $profiles = @(
            @{key="quick";label="Quick";description="Fixture";model="test-model";effort="high";context="default"}
            @{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"}
        )
        Assert-AgentSyncBlocked $root $profiles
    } finally { Remove-FixtureRoot $root }
}

Run-Test "Agent ownership: local modifications are neither overwritten nor deleted on retirement" {
    $root = New-FixtureRoot
    try {
        $profiles = @(@{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"})
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        Set-FixtureFile (Join-Path $root "agents\review.agent.md") "my edited generated agent"
        Assert-AgentSyncBlocked $root $profiles
        Assert-AgentSyncBlocked $root @()
    } finally { Remove-FixtureRoot $root }
}

Run-Test "Agent ownership: null profiles are invalid, not an instruction to retire all agents" {
    $root = New-FixtureRoot
    try {
        $profiles = @(@{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"})
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        Assert-AgentSyncBlocked $root $null
    } finally { Remove-FixtureRoot $root }
}

Run-Test "Agent ownership: unchanged agents and manifest retain their bytes and timestamps" {
    $root = New-FixtureRoot
    try {
        $profiles = @(@{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"})
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        $before = Get-TreeSnapshot $root
        $timestamps = @{}
        foreach ($file in @(Get-ChildItem -LiteralPath (Join-Path $root "agents") -File -Force)) {
            $timestamps[$file.FullName] = $file.LastWriteTimeUtc.Ticks
        }
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        Assert-SameSnapshot $before (Get-TreeSnapshot $root) "No-op synchronization changed content"
        foreach ($path in $timestamps.Keys) {
            Assert-True ((Get-Item -LiteralPath $path -Force).LastWriteTimeUtc.Ticks -eq $timestamps[$path]) "No-op synchronization rewrote $path"
        }
    } finally { Remove-FixtureRoot $root }
}

Run-Test "Agent ownership: legacy keys are adopted only when generated text matches; stale or modified entries block" {
    $root = New-FixtureRoot
    try {
        $profiles = @(@{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"})
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        $agent = Join-Path $root "agents\review.agent.md"
        $manifest = Join-Path $root "agents\.generated-task-class-agents.json"
        Set-FixtureFile $manifest '["review"]'
        $before = Get-NodeState $agent
        $timestamp = (Get-Item -LiteralPath $agent).LastWriteTimeUtc.Ticks
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        Assert-True ((Get-NodeState $agent) -ceq $before -and (Get-Item -LiteralPath $agent).LastWriteTimeUtc.Ticks -eq $timestamp) "Legacy adoption rewrote an identical agent"
        $state = Get-Content -LiteralPath $manifest -Raw | ConvertFrom-Json
        Assert-True ($state.schemaVersion -eq 1 -and @($state.files).Count -eq 1 -and $state.files[0].sha256 -match "^[a-f0-9]{64}$") "Legacy manifest was not upgraded to hash ownership"
        Set-FixtureFile $manifest '["review"]'
        Assert-AgentSyncBlocked $root @()
        Set-FixtureFile $agent "modified legacy agent"
        Assert-AgentSyncBlocked $root $profiles
    } finally { Remove-FixtureRoot $root }
}

Run-Test "Agent ownership: malformed, unsupported and unsafe manifests block without writes" {
    foreach ($content in @('{broken', 'null', '[null]', '{"schemaVersion":"1","files":[]}', '{"schemaVersion":99,"files":[]}', '["../outside"]', '["con"]', '["review","review"]', '{"schemaVersion":1,"files":[{"key":"review","sha256":"invalid"}]}')) {
        $root = New-FixtureRoot
        try {
            Set-FixtureFile (Join-Path $root "agents\.generated-task-class-agents.json") $content
            Assert-AgentSyncBlocked $root @(@{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"})
        } finally { Remove-FixtureRoot $root }
    }
}

Run-Test "Agent ownership: read-only updates and unsafe profile names block before writes" {
    $root = New-FixtureRoot
    try {
        $profiles = @(@{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"})
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        $agent = Join-Path $root "agents\review.agent.md"
        [IO.File]::SetAttributes($agent, [IO.FileAttributes]::ReadOnly)
        $profiles[0].effort = "max"
        Assert-AgentSyncBlocked $root $profiles
        Assert-AgentSyncBlocked $root @()
        [IO.File]::SetAttributes($agent, [IO.FileAttributes]::Normal)
        foreach ($key in @("../outside", "con", "lpt1")) {
            $profiles[0].key = $key
            Assert-AgentSyncBlocked $root $profiles
        }
    } finally { Remove-FixtureRoot $root }
}

Run-TestIf $script:OnWindows "Agent ownership: linked agents roots are never traversed" "directory junctions require Windows" {
    $root = New-FixtureRoot
    try {
        $outside = Join-Path $root "outside"
        Set-FixtureFile (Join-Path $outside "review.agent.md") "do not overwrite"
        New-Item -ItemType Junction -Path (Join-Path $root "agents") -Target $outside | Out-Null
        Assert-AgentSyncBlocked $root @(@{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"})
    } finally { Remove-FixtureRoot $root }
}

Run-Test "Agent ownership: unowned identical text is adopted without writes; BOM and EOL variants retain their bytes" {
    $root = New-FixtureRoot
    try {
        $profiles = @(@{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"})
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        $agent = Join-Path $root "agents\review.agent.md"
        $manifest = Join-Path $root "agents\.generated-task-class-agents.json"
        $text = [IO.File]::ReadAllText($agent).Replace("`r`n", "`n").Replace("`n", "`r`n")
        [IO.File]::WriteAllText($agent, $text, [Text.UTF8Encoding]::new($true))
        $before = Get-NodeState $agent
        $timestamp = (Get-Item -LiteralPath $agent).LastWriteTimeUtc.Ticks
        [IO.File]::Delete($manifest)
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        Assert-True ((Get-NodeState $agent) -ceq $before -and (Get-Item -LiteralPath $agent).LastWriteTimeUtc.Ticks -eq $timestamp) "Identical adoption rewrote the agent"
        Set-FixtureFile $manifest '"review"'
        Update-TaskClassAgents -MasterPath $root -Profiles $profiles -PersonalRoot $root
        Assert-True ((Get-NodeState $agent) -ceq $before) "Single-key legacy adoption changed bytes"
        Update-TaskClassAgents -MasterPath $root -Profiles @() -PersonalRoot $root
        Assert-True (-not (Test-Path -LiteralPath $agent)) "An empty profile set did not retire an unmodified owned agent"
    } finally { Remove-FixtureRoot $root }
}

Run-Test "Agent ownership: a read-only manifest blocks adoption before any agent write" {
    $root = New-FixtureRoot
    try {
        $manifest = Join-Path $root "agents\.generated-task-class-agents.json"
        Set-FixtureFile $manifest '[]'
        [IO.File]::SetAttributes($manifest, [IO.FileAttributes]::ReadOnly)
        Assert-AgentSyncBlocked $root @(@{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"})
    } finally { Remove-FixtureRoot $root }
}

Run-TestIf $script:OnWindows "Agent ownership: linked parent directories, agent paths and manifests block without following targets" "directory junctions require Windows" {
    foreach ($relative in @("agents\review.agent.md", "agents\.generated-task-class-agents.json", "personal")) {
        $root = New-FixtureRoot
        try {
            $outside = Join-Path $root "outside"
            Set-FixtureFile (Join-Path $outside "untouched.txt") "outside target"
            $link = Join-Path $root $relative
            New-Item -ItemType Directory -Path (Split-Path -Parent $link) -Force | Out-Null
            New-Item -ItemType Junction -Path $link -Target $outside | Out-Null
            if ($relative -eq "personal") {
                $before = Get-TreeSnapshot $root
                $errorText = ""
                try { Update-TaskClassAgents -MasterPath $root -Profiles @() -PersonalRoot (Join-Path $link ".copilot") } catch { $errorText = $_.Exception.Message }
                Assert-True ($errorText -match "ownership conflict") "Linked parent was not rejected"
                Assert-SameSnapshot $before (Get-TreeSnapshot $root) "Linked-parent synchronization changed files"
            } else {
                Assert-AgentSyncBlocked $root @(@{key="review";label="Review";description="Fixture";model="test-model";effort="high";context="default"})
            }
        } finally { Remove-FixtureRoot $root }
    }
}

Run-Test "Agent ownership: launcher exits nonzero before any menu or client on a synchronization conflict" {
    $root = New-FixtureRoot
    $oldProfile = $env:USERPROFILE
    try {
        $workbench = Join-Path $root "workbench"
        New-Item -ItemType Directory -Path (Join-Path $workbench "scripts") -Force | Out-Null
        Copy-Item -LiteralPath (Join-Path $script:RepoRoot "Start-CopilotWork.ps1") -Destination $workbench
        foreach ($name in @("model-id-parser.ps1", "model-launch-args.ps1", "workbench-setup.ps1", "workbench-session.ps1")) {
            Copy-Item -LiteralPath (Join-Path $PSScriptRoot $name) -Destination (Join-Path $workbench "scripts")
        }
        Set-FixtureFile (Join-Path $workbench "repos.json") '[]'
        Set-FixtureFile (Join-Path $workbench "task-profiles.json") '[{"key":"review","label":"Review","description":"Fixture","model":"test-model","effort":"high","context":"default"}]'
        $env:USERPROFILE = Join-Path $root "home"
        $agent = Join-Path $env:USERPROFILE ".copilot\agents\review.agent.md"
        Set-FixtureFile $agent "personal review agent"
        $before = Get-NodeState $agent
        $runner = Join-Path $root "launch-fixture.ps1"
        Set-FixtureFile $runner @'
function global:Read-Host { [IO.File]::WriteAllText((Join-Path $PSScriptRoot "unexpected-menu"), "called"); throw "Menu should not run" }
function global:copilot { [IO.File]::WriteAllText((Join-Path $PSScriptRoot "unexpected-client"), "called"); throw "Client should not run" }
& (Join-Path $PSScriptRoot "workbench\Start-CopilotWork.ps1")
exit $LASTEXITCODE
'@
        $output = & $script:PowerShellExe -NoProfile -ExecutionPolicy Bypass -File $runner 2>&1 | Out-String
        Assert-True ($LASTEXITCODE -eq 1 -and $output.Contains("Task-class agent preparation failed:")) "Launcher did not visibly stop with exit 1: $output"
        Assert-True (-not (Test-Path -LiteralPath (Join-Path $root "unexpected-menu")) -and -not (Test-Path -LiteralPath (Join-Path $root "unexpected-client"))) "Launcher continued after the conflict"
        Assert-True ((Get-NodeState $agent) -ceq $before) "Conflicting personal agent changed"
    } finally {
        $env:USERPROFILE = $oldProfile
        Remove-FixtureRoot $root
    }
}

Run-Test "Migration helper contract: plan-only by default, explicit -Apply, no broad deletion or link creation" {
    Assert-True (Test-Path -LiteralPath $script:MigrationScript) "scripts\Migrate-PersonalSkills.ps1 does not exist"
    $command = Get-Command -Name $script:MigrationScript
    Assert-True ($command.Parameters.ContainsKey("Apply") -and $command.Parameters["Apply"].ParameterType -eq [switch]) "-Apply must be an explicit switch"
    foreach ($parameter in @("PersonalRoot", "SourceSkillsPath", "ArchiveRoot", "RetireSkill")) {
        Assert-True ($command.Parameters.ContainsKey($parameter)) "Missing parameter -$parameter"
    }
    $text = [IO.File]::ReadAllText($script:MigrationScript)
    $code = ((($text -replace "(?s)<#.*?#>", "") -split "`r?`n") | Where-Object { $_ -notmatch "^\s*#" }) -join "`n"
    Assert-True ($code -notmatch "(?i)\bRemove-Item\b") "Migration helper must not use Remove-Item (no broad deletion)"
    Assert-True ($code -notmatch "(?i)Directory\]::Delete\([^)]*,\s*\`$true") "Migration helper must never delete recursively"
    Assert-True ($code -match "(?i)Directory\]::Delete\([^)]*,\s*\`$false\)") "The verified junction must be detached with a non-recursive delete"
    Assert-True ($code -notmatch "(?i)-ItemType\s+(Junction|SymbolicLink)|\bmklink\b") "Migration helper must not create links"
    Assert-True ($code -notmatch "(?i)\bgit\s+(add|commit|push|checkout|reset|clean|restore|switch|merge)\b") "Migration helper must not run Git mutations"
}

Run-TestIf $script:OnWindows "T16: plan-only run reports the migration and makes no writes (junction and live source intact)" "directory junctions require Windows" {
    $fx = New-MigrationFixture
    try {
        $rootBefore = Get-TreeSnapshot $fx.Root
        $result = Invoke-MigrationScript -Fixture $fx
        Assert-ResultLine $result "Planned" 0 "plan-only run"
        Assert-True ($result.Output -match "PLAN ONLY") "Plan-only banner missing. $(Format-Output $result)"
        foreach ($name in $script:RetiredSkillNames) {
            Assert-True ($result.Output.Contains("- $name")) "Plan does not list the approved legacy skill $name"
        }
        foreach ($name in @("my-personal-skill", "notes.txt")) {
            Assert-True ($result.Output.Contains("- $name")) "Plan does not list the preserved entry $name"
        }
        Assert-True (Test-IsLink $fx.Skills) "Plan-only run changed the junction"
        Assert-True (Test-SamePath (Get-LinkTarget $fx.Skills) $fx.Source) "Plan-only run repointed the junction"
        Assert-True (-not (Test-Path -LiteralPath $fx.Archive)) "Plan-only run created an archive"
        Assert-True (@(Get-ChildItem -LiteralPath $fx.Personal -Directory -Force | Where-Object Name -like "skills.migration-*").Count -eq 0) "Plan-only run created a staging directory"
        Assert-SameSnapshot $rootBefore (Get-TreeSnapshot $fx.Root) "Plan-only run changed the fixture tree"
        $again = Invoke-MigrationScript -Fixture $fx
        Assert-ResultLine $again "Planned" 0 "repeated plan-only run"
        Assert-SameSnapshot $rootBefore (Get-TreeSnapshot $fx.Root) "Repeated plan-only run changed the fixture tree"
    } finally {
        Remove-FixtureRoot $fx.Root
    }
}

Run-TestIf $script:OnWindows "T16: without -PersonalRoot and -ArchiveRoot the helper derives both from USERPROFILE\.copilot and the plan still writes nothing" "directory junctions require Windows" {
    $fx = New-MigrationFixture
    try {
        # The child shell writes its own startup caches below USERPROFILE (AppData), so only the Copilot and workbench trees are compared.
        $personalBefore = Get-TreeSnapshot $fx.Personal
        $workbenchBefore = Get-TreeSnapshot $fx.Workbench
        $result = Invoke-MigrationScript -Fixture $fx -DefaultPersonalRoot -DefaultArchive
        Assert-ResultLine $result "Planned" 0 "plan with the default personal root and archive"
        Assert-True ($result.Output.Contains($fx.Skills)) "The default personal skills path is not USERPROFILE\.copilot\skills. $(Format-Output $result)"
        Assert-True ($result.Output.Contains((Join-Path $fx.Personal "migration-archive"))) "The default archive is not USERPROFILE\.copilot\migration-archive. $(Format-Output $result)"
        Assert-True (Test-IsLink $fx.Skills) "Plan with defaults changed the junction"
        Assert-SameSnapshot $personalBefore (Get-TreeSnapshot $fx.Personal) "Plan with defaults changed the personal Copilot folder"
        Assert-SameSnapshot $workbenchBefore (Get-TreeSnapshot $fx.Workbench) "Plan with defaults changed the live workbench"
        Assert-True (-not (Test-Path -LiteralPath (Join-Path $fx.Personal "migration-archive"))) "Plan with defaults created the archive"
    } finally {
        Remove-FixtureRoot $fx.Root
    }
}

Run-TestIf $script:OnWindows "T17: explicit -Apply creates a real destination, preserves every asset and archives approved legacy skills outside discovery" "directory junctions require Windows" {
    $fx = New-MigrationFixture
    try {
        $sourceBefore = Get-TreeSnapshot $fx.Source
        $workbenchBefore = Get-TreeSnapshot $fx.Workbench
        $personalOtherBefore = @(Get-TreeSnapshot $fx.Personal | Where-Object { $_ -notmatch "^[LDF]\|skills([\\|]|$)" })
        $result = Invoke-MigrationScript -Fixture $fx -Apply
        Assert-ResultLine $result "Applied" 0 "apply run"

        Assert-True (-not (Test-IsLink $fx.Skills)) "Personal skills root is still a link after -Apply"
        Assert-True (Test-Path -LiteralPath $fx.Skills -PathType Container) "Real destination was not established"

        # Destination = source minus the approved legacy skills, byte for byte (hidden files and empty directories included).
        $expected = @($sourceBefore | Where-Object { $script:RetiredSkillNames -cnotcontains (Get-TopLevelName $_) })
        Assert-SameSnapshot $expected (Get-TreeSnapshot $fx.Skills) "Destination does not equal the preserved source content"
        foreach ($name in $script:RetiredSkillNames) {
            Assert-True (-not (Test-Path -LiteralPath (Join-Path $fx.Skills $name))) "Legacy skill $name is still discoverable in the destination"
        }
        Assert-True (((Get-Item -LiteralPath (Join-Path $fx.Skills ".hidden-personal") -Force).Attributes -band [IO.FileAttributes]::Hidden) -ne 0) "Hidden attribute of a personal file was lost"

        # Approved legacy material is archived outside skill discovery, complete and verified.
        $runs = @(Get-ArchiveRunDirectories $fx)
        Assert-True ($runs.Count -eq 1) "Expected exactly one archive run directory, found $($runs.Count)"
        $archived = Join-Path $runs[0].FullName "retired-skills"
        Assert-True (-not ((Join-Path $fx.Archive "x").StartsWith($fx.Skills, [StringComparison]::OrdinalIgnoreCase))) "Archive root is inside the skills discovery root"
        foreach ($name in $script:RetiredSkillNames) {
            Assert-SameSnapshot (Get-TreeSnapshot (Join-Path $fx.Source $name)) (Get-TreeSnapshot (Join-Path $archived $name)) "Archive of $name is incomplete"
        }
        foreach ($helper in @("estimate-session-duration.js", "extract-session-digest.js")) {
            $kept = Join-Path $archived "session-time-audit\scripts\$helper"
            $original = Join-Path $fx.Source "session-time-audit\scripts\$helper"
            Assert-True ((Test-Path -LiteralPath $kept) -and (Get-FileHash -LiteralPath $kept).Hash -eq (Get-FileHash -LiteralPath $original).Hash) "Legacy audit helper $helper was not archived byte-for-byte"
        }

        # Nothing else changed: live source, launcher profiles, generated agents, settings and unrelated personal files.
        Assert-SameSnapshot $sourceBefore (Get-TreeSnapshot $fx.Source) "Live source skills changed during -Apply"
        Assert-SameSnapshot $workbenchBefore (Get-TreeSnapshot $fx.Workbench) "Live workbench (profiles/source) changed during -Apply"
        Assert-SameSnapshot $personalOtherBefore @(Get-TreeSnapshot $fx.Personal | Where-Object { $_ -notmatch "^[LDF]\|skills([\\|]|$)" }) "Personal agents/settings changed during -Apply"
        Assert-True (@(Get-ChildItem -LiteralPath $fx.Personal -Directory -Force | Where-Object Name -like "skills.migration-*").Count -eq 0) "Staging directory was left behind"

        # The report records what was detached, archived and preserved.
        $reportPath = Join-Path $runs[0].FullName "migration-report.json"
        Assert-True (Test-Path -LiteralPath $reportPath) "migration-report.json was not written"
        $report = Get-Content -LiteralPath $reportPath -Raw | ConvertFrom-Json
        Assert-True ($report.result -eq "Applied" -and (Test-SamePath $report.detachedJunctionTarget $fx.Source)) "Report lost the detached junction target"
        Assert-True ((@($report.retiredSkills | ForEach-Object { $_.name } | Sort-Object) -join ",") -ceq (($script:RetiredSkillNames | Sort-Object) -join ",")) "Report does not list exactly the approved legacy skills"
        Assert-True (@($report.preservedEntries) -contains "my-personal-skill" -and @($report.preservedEntries) -notcontains "session-time-audit") "Report does not distinguish archived audit assets from unique personal entries"
        Assert-True ($report.sourceUnchanged -eq $true) "Report does not confirm that the source was left unchanged"
    } finally {
        Remove-FixtureRoot $fx.Root
    }
}

Run-TestIf $script:OnWindows "T17: legacy skills are archived outside discovery while unique personal skills and loose files stay in the real destination and the source keeps everything" "directory junctions require Windows" {
    $fx = New-MigrationFixture
    try {
        $sourceBefore = Get-TreeSnapshot $fx.Source
        $sourceNames = @(Get-ChildItem -LiteralPath $fx.Source -Force | ForEach-Object { $_.Name })
        $personalNames = @($sourceNames | Where-Object { $script:RetiredSkillNames -cnotcontains $_ } | Sort-Object)
        foreach ($expectedPersonal in @("my-personal-skill", "notes.txt", ".hidden-personal", "empty-personal-dir")) {
            Assert-True ($personalNames -contains $expectedPersonal) "Fixture is missing the personal entry $expectedPersonal"
        }

        $result = Invoke-MigrationScript -Fixture $fx -Apply
        Assert-ResultLine $result "Applied" 0 "apply run"
        foreach ($legacy in $script:RetiredSkillNames) { Assert-True ($result.Output.Contains("- $legacy")) "Output does not list the archived legacy skill $legacy" }
        foreach ($personal in @("my-personal-skill", "notes.txt")) { Assert-True ($result.Output.Contains("- $personal")) "Output does not list the preserved personal entry $personal" }

        # Legacy material: archived complete, and nothing but legacy material.
        $runs = @(Get-ArchiveRunDirectories $fx)
        Assert-True ($runs.Count -eq 1) "Expected exactly one archive run directory, found $($runs.Count)"
        $archivedNames = @(Get-ChildItem -LiteralPath (Join-Path $runs[0].FullName "retired-skills") -Force | ForEach-Object { $_.Name } | Sort-Object)
        Assert-True (($archivedNames -join ",") -ceq (($script:RetiredSkillNames | Sort-Object) -join ",")) "The archive must hold exactly the approved legacy skills, found: $($archivedNames -join ', ')"
        foreach ($personal in $personalNames) {
            Assert-True (-not (Test-Path -LiteralPath (Join-Path $runs[0].FullName "retired-skills\$personal"))) "Personal entry $personal was moved into the legacy archive"
        }
        # ...outside every skill discovery location (the personal skills root and the live source tree).
        foreach ($discovery in @($fx.Skills, $fx.Source)) {
            Assert-True (-not (Test-IsUnder $runs[0].FullName $discovery)) "The archive lies inside the discovery location $discovery"
        }

        # Unique personal material: exactly what remains in the real destination; no legacy name is discoverable any more.
        $destinationNames = @(Get-ChildItem -LiteralPath $fx.Skills -Force | ForEach-Object { $_.Name } | Sort-Object)
        Assert-True (($destinationNames -join ",") -ceq ($personalNames -join ",")) "The destination must hold exactly the personal entries, found: $($destinationNames -join ', ')"
        foreach ($legacy in $script:RetiredSkillNames) {
            Assert-True (-not (Test-Path -LiteralPath (Join-Path $fx.Skills $legacy))) "Legacy skill $legacy is still discoverable in the destination"
        }

        # The source is preserved: every legacy skill and every personal entry is still there, byte for byte.
        Assert-SameSnapshot $sourceBefore (Get-TreeSnapshot $fx.Source) "Live source skills changed during -Apply"
        foreach ($legacy in $script:RetiredSkillNames) {
            Assert-True (Test-Path -LiteralPath (Join-Path $fx.Source "$legacy\SKILL.md")) "Legacy skill $legacy was deleted from the source"
        }

        # The destination is an independent real copy, never a second path to the source.
        Set-FixtureFile (Join-Path $fx.Skills "my-personal-skill\SKILL.md") "edited in the real destination"
        Assert-SameSnapshot $sourceBefore (Get-TreeSnapshot $fx.Source) "Editing the destination changed the source (it is not an independent copy)"
    } finally {
        Remove-FixtureRoot $fx.Root
    }
}

$emptyMigrationShells = @($script:PowerShellExe)
if ($script:OnWindows -and (Get-Command powershell.exe -ErrorAction SilentlyContinue)) {
    $emptyMigrationShells += (Get-Command powershell.exe).Source
}
foreach ($shell in @($emptyMigrationShells | Select-Object -Unique)) {
    foreach ($scenario in @("LegacyOnly", "EmptySource")) {
        Run-TestIf $script:OnWindows "T17: $scenario migrates to an empty real directory under $shell" "directory junctions require Windows" {
            $fx = New-MigrationFixture
            try {
                foreach ($entry in @(Get-ChildItem -LiteralPath $fx.Source -Force)) {
                    if ($scenario -eq "EmptySource" -or $script:RetiredSkillNames -notcontains $entry.Name) {
                        Remove-FixtureNode $entry.FullName
                    }
                }
                $sourceBefore = Get-TreeSnapshot $fx.Source
                $rootBefore = Get-TreeSnapshot $fx.Root
                $expectedRetired = if ($scenario -eq "LegacyOnly") { @($script:RetiredSkillNames) } else { @() }
                $plan = Invoke-MigrationScript -Fixture $fx -Shell $shell
                Assert-ResultLine $plan "Planned" 0 "$scenario empty-destination plan"
                Assert-SameSnapshot $rootBefore (Get-TreeSnapshot $fx.Root) "Empty-destination planning changed the fixture"

                $apply = Invoke-MigrationScript -Fixture $fx -Apply -Shell $shell
                Assert-ResultLine $apply "Applied" 0 "$scenario empty-destination apply"
                Assert-True ((Test-Path -LiteralPath $fx.Skills -PathType Container) -and -not (Test-IsLink $fx.Skills)) "Empty real destination was not established"
                Assert-True (@(Get-ChildItem -LiteralPath $fx.Skills -Force).Count -eq 0) "Destination is not empty"
                $runs = @(Get-ArchiveRunDirectories $fx)
                Assert-True ($runs.Count -eq 1) "Expected one empty-destination migration archive"
                $archived = Join-Path $runs[0].FullName "retired-skills"
                Assert-SameSnapshot $sourceBefore (Get-TreeSnapshot $archived) "Empty-destination archive does not equal the original source"
                Assert-SameSnapshot $sourceBefore (Get-TreeSnapshot $fx.Source) "Empty-destination migration changed the source"
                $report = Get-Content -LiteralPath (Join-Path $runs[0].FullName "migration-report.json") -Raw | ConvertFrom-Json
                Assert-True ($report.result -eq "Applied" -and $report.sourceUnchanged -and @($report.preservedEntries).Count -eq 0) "Empty-destination report lost its verified result"
                $retiredNames = @($report.retiredSkills | ForEach-Object { $_.name } | Sort-Object)
                Assert-True (($retiredNames -join ",") -ceq (($expectedRetired | Sort-Object) -join ",")) "Empty-destination report has incorrect retired skills"
                Assert-True (@(Get-ChildItem -LiteralPath $fx.Personal -Directory -Force | Where-Object Name -like "skills.migration-*").Count -eq 0) "Empty-destination staging directory was left behind"
                $after = Get-TreeSnapshot $fx.Root
                $again = Invoke-MigrationScript -Fixture $fx -Apply -Shell $shell
                Assert-ResultLine $again "NoAction" 0 "$scenario empty-destination repeat"
                Assert-SameSnapshot $after (Get-TreeSnapshot $fx.Root) "Repeated empty-destination migration changed files"
            } finally {
                Remove-FixtureRoot $fx.Root
            }
        }
    }
}

Run-TestIf $script:OnWindows "T17: the default archive location is under the personal root but outside skill discovery" "directory junctions require Windows" {
    $fx = New-MigrationFixture
    try {
        $result = Invoke-MigrationScript -Fixture $fx -Apply -DefaultArchive
        Assert-ResultLine $result "Applied" 0 "apply with default archive"
        $archiveBase = Join-Path $fx.Personal "migration-archive"
        $runs = @(Get-ArchiveRunDirectories $fx $archiveBase)
        Assert-True ($runs.Count -eq 1) "Default archive run directory missing under $archiveBase"
        Assert-True ((Test-Path -LiteralPath (Join-Path $runs[0].FullName "retired-skills\grill-me\SKILL.md")) -and (Test-Path -LiteralPath (Join-Path $runs[0].FullName "migration-report.json"))) "Default archive is incomplete"
        Assert-True (-not (Test-Path -LiteralPath (Join-Path $fx.Skills "migration-archive"))) "Archive leaked into the skills root"
    } finally {
        Remove-FixtureRoot $fx.Root
    }
}

Run-TestIf $script:OnWindows "T17: an explicit -RetireSkill list replaces the approved defaults and everything else is preserved" "directory junctions require Windows" {
    $fx = New-MigrationFixture
    try {
        $sourceBefore = Get-TreeSnapshot $fx.Source
        $result = Invoke-MigrationScript -Fixture $fx -Apply -ExtraArguments @("-RetireSkill", "grill-me,tdd-implement")
        Assert-ResultLine $result "Applied" 0 "apply with explicit retire list"
        $expected = @($sourceBefore | Where-Object { @("grill-me", "tdd-implement") -cnotcontains (Get-TopLevelName $_) })
        Assert-SameSnapshot $expected (Get-TreeSnapshot $fx.Skills) "Destination does not equal the source minus the explicit retire list"
        $runs = @(Get-ArchiveRunDirectories $fx)
        $archived = @(Get-ChildItem -LiteralPath (Join-Path $runs[0].FullName "retired-skills") -Directory | ForEach-Object Name | Sort-Object)
        Assert-True (($archived -join ",") -ceq "grill-me,tdd-implement") "Archive contains more or less than the explicit retire list: $($archived -join ',')"
        Assert-SameSnapshot (Get-TreeSnapshot (Join-Path $fx.Source "session-time-audit")) (Get-TreeSnapshot (Join-Path $fx.Skills "session-time-audit")) "An explicit retire list excluding audit did not preserve its complete folder"
        Assert-SameSnapshot $sourceBefore (Get-TreeSnapshot $fx.Source) "Live source skills changed during -Apply"
    } finally {
        Remove-FixtureRoot $fx.Root
    }
}

Run-TestIf $script:OnWindows "T18: wrong targets, dangling or linked sources, unsafe archive roots and invalid names block without any write" "directory junctions require Windows" {
    # Junction aimed somewhere other than the expected source: plan and apply both block.
    $fx = New-MigrationFixture -Mode WrongJunction
    try {
        $before = Get-TreeSnapshot $fx.Root
        foreach ($apply in @($false, $true)) {
            $result = if ($apply) { Invoke-MigrationScript -Fixture $fx -Apply } else { Invoke-MigrationScript -Fixture $fx }
            Assert-ResultLine $result "Blocked" 1 "wrong-target junction (apply=$apply)"
            Assert-True ($result.Output -match "(?i)does not point to the expected source") "Wrong-target reason missing. $(Format-Output $result)"
            Assert-True (Test-SamePath (Get-LinkTarget $fx.Skills) $fx.Other) "Wrong-target junction was altered"
            Assert-SameSnapshot $before (Get-TreeSnapshot $fx.Root) "Blocked run changed the fixture (apply=$apply)"
        }
    } finally {
        Remove-FixtureRoot $fx.Root
    }

    # Running from a different checkout than the junction target (the isolated worktree case) blocks and says why.
    $fx = New-MigrationFixture
    try {
        $repoSkillsBefore = Get-NodeState (Join-Path $script:RepoRoot "skills")
        $before = Get-TreeSnapshot $fx.Root
        $result = Invoke-MigrationScript -Fixture $fx -Apply -DefaultSource
        Assert-ResultLine $result "Blocked" 1 "junction aimed at a different checkout than the helper's own"
        Assert-True ($result.Output.Contains("-SourceSkillsPath")) "Blocked output must explain -SourceSkillsPath. $(Format-Output $result)"
        Assert-SameSnapshot $before (Get-TreeSnapshot $fx.Root) "Blocked run changed the fixture"
        Assert-True ($repoSkillsBefore -ceq (Get-NodeState (Join-Path $script:RepoRoot "skills"))) "The helper's own checkout changed"
    } finally {
        Remove-FixtureRoot $fx.Root
    }

    # The expected source is gone: the junction dangles and there is nothing to verify or copy.
    $fx = New-MigrationFixture
    try {
        Remove-FixtureNode $fx.Source
        $before = Get-TreeSnapshot $fx.Root
        $result = Invoke-MigrationScript -Fixture $fx -Apply
        Assert-ResultLine $result "Blocked" 1 "dangling junction"
        Assert-True (Test-IsLink $fx.Skills) "The dangling junction was removed"
        Assert-SameSnapshot $before (Get-TreeSnapshot $fx.Root) "Blocked run changed the fixture"
    } finally {
        Remove-FixtureRoot $fx.Root
    }

    # A link nested inside the source tree cannot be copied safely.
    $fx = New-MigrationFixture
    try {
        Set-FixtureFile (Join-Path $fx.Other "outside\x.txt") "outside"
        New-Item -ItemType Junction -Path (Join-Path $fx.Source "my-personal-skill\linked") -Target (Join-Path $fx.Other "outside") | Out-Null
        $before = Get-TreeSnapshot $fx.Root
        $result = Invoke-MigrationScript -Fixture $fx -Apply
        Assert-ResultLine $result "Blocked" 1 "source tree with a nested link"
        Assert-True ($result.Output -match "(?i)link") "Nested-link reason missing. $(Format-Output $result)"
        Assert-SameSnapshot $before (Get-TreeSnapshot $fx.Root) "Blocked run changed the fixture"
    } finally {
        Remove-FixtureRoot $fx.Root
    }

    # Archives must live outside skill discovery and outside the source tree; names must be single safe segments.
    $fx = New-MigrationFixture
    try {
        $before = Get-TreeSnapshot $fx.Root
        foreach ($unsafe in @((Join-Path $fx.Skills "archive"), (Join-Path $fx.Source "archive"), $fx.Skills)) {
            $result = Invoke-MigrationScript -Fixture $fx -Apply -ArchiveRoot $unsafe
            Assert-ResultLine $result "Blocked" 1 "archive root $unsafe"
            Assert-True ($result.Output -match "(?i)archive") "Unsafe-archive reason missing. $(Format-Output $result)"
        }
        foreach ($badName in @("..\other", "nested/name", "..", ".")) {
            $result = Invoke-MigrationScript -Fixture $fx -Apply -ExtraArguments @("-RetireSkill", $badName)
            Assert-ResultLine $result "Blocked" 1 "retire name '$badName'"
            Assert-True ($result.Output -match "(?i)RetireSkill") "Invalid-name reason missing. $(Format-Output $result)"
        }
        Assert-SameSnapshot $before (Get-TreeSnapshot $fx.Root) "Blocked runs changed the fixture"
    } finally {
        Remove-FixtureRoot $fx.Root
    }
}

Run-TestIf $script:OnWindows "T18: real directories and absent roots are preserved and a repeated migration is a safe no-op" "directory junctions require Windows" {
    # An existing real directory is never replaced, even with -Apply.
    $fx = New-MigrationFixture -Mode RealDirectory
    try {
        $before = Get-TreeSnapshot $fx.Root
        foreach ($apply in @($false, $true)) {
            $result = if ($apply) { Invoke-MigrationScript -Fixture $fx -Apply } else { Invoke-MigrationScript -Fixture $fx }
            Assert-ResultLine $result "NoAction" 0 "real directory (apply=$apply)"
            Assert-True ($result.Output -match "(?i)real directory") "Real-directory explanation missing. $(Format-Output $result)"
            Assert-SameSnapshot $before (Get-TreeSnapshot $fx.Root) "Real directory run changed the fixture (apply=$apply)"
        }
        Assert-True (-not (Test-Path -LiteralPath $fx.Archive)) "A real directory run created an archive"
    } finally {
        Remove-FixtureRoot $fx.Root
    }

    # No personal skills root: nothing to do. A leftover staging directory from an interrupted run is reported, never guessed at or deleted.
    $fx = New-MigrationFixture -Mode NoSkills
    try {
        $before = Get-TreeSnapshot $fx.Root
        $result = Invoke-MigrationScript -Fixture $fx -Apply
        Assert-ResultLine $result "NoAction" 0 "absent personal skills root"
        Assert-SameSnapshot $before (Get-TreeSnapshot $fx.Root) "Absent-root run changed the fixture"
        Set-FixtureFile (Join-Path $fx.Personal "skills.migration-20990101-000000-deadbeef\keep.txt") "staged copy"
        $before = Get-TreeSnapshot $fx.Root
        $result = Invoke-MigrationScript -Fixture $fx -Apply
        Assert-ResultLine $result "Blocked" 1 "absent skills with a leftover staging directory"
        Assert-True ($result.Output.Contains("skills.migration-20990101-000000-deadbeef")) "Leftover staging directory was not reported. $(Format-Output $result)"
        Assert-SameSnapshot $before (Get-TreeSnapshot $fx.Root) "Leftover-staging run changed the fixture"
    } finally {
        Remove-FixtureRoot $fx.Root
    }

    # After a successful migration the root is a real directory: re-running is a no-op and never recreates a link.
    $fx = New-MigrationFixture
    try {
        $first = Invoke-MigrationScript -Fixture $fx -Apply
        Assert-ResultLine $first "Applied" 0 "first apply"
        $afterFirst = Get-TreeSnapshot $fx.Root
        foreach ($apply in @($false, $true)) {
            $again = if ($apply) { Invoke-MigrationScript -Fixture $fx -Apply } else { Invoke-MigrationScript -Fixture $fx }
            Assert-ResultLine $again "NoAction" 0 "repeated migration (apply=$apply)"
            Assert-SameSnapshot $afterFirst (Get-TreeSnapshot $fx.Root) "Repeated migration changed the migrated tree (apply=$apply)"
        }
        Assert-True (@(Get-ArchiveRunDirectories $fx).Count -eq 1) "Repeated migration created another archive"
        Assert-True (-not (Test-IsLink $fx.Skills)) "Repeated migration recreated a link"
    } finally {
        Remove-FixtureRoot $fx.Root
    }
}

function New-LauncherScaffold([string]$Root) {
    foreach ($directory in @("scripts", "config")) {
        New-Item -ItemType Directory -Path (Join-Path $Root $directory) -Force | Out-Null
    }
    Copy-Item -LiteralPath (Join-Path $script:RepoRoot "Start-CopilotWork.ps1") -Destination $Root
    foreach ($file in @("model-id-parser.ps1", "model-launch-args.ps1", "workbench-setup.ps1", "workbench-session.ps1")) {
        Copy-Item -LiteralPath (Join-Path $PSScriptRoot $file) -Destination (Join-Path $Root "scripts")
    }
    Copy-Item -LiteralPath (Join-Path $script:RepoRoot "config\model-capabilities.json") -Destination (Join-Path $Root "config")
    # skills\ is present on purpose: the retired launcher linked it into ~/.copilot/skills whenever it existed.
    Set-FixtureFile (Join-Path $Root "skills\legacy-fixture\SKILL.md") "legacy launcher fixture"
    @(@{name="Fixture";type="Generic";path=$Root}) | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $Root "repos.json")
    @(@{key="quick";label="Quick";description="Fixture";model="gpt-5.4";effort="medium";context="default";hint=""}) |
        ConvertTo-Json | Set-Content -LiteralPath (Join-Path $Root "task-profiles.json")
}

function Invoke-FixtureLauncher {
    # Runs the real launcher in a fixture workbench with a fake home, a stubbed menu and a stubbed copilot command.
    param([Parameter(Mandatory)][string]$Root, [Parameter(Mandatory)][string]$HomePath, [int]$Launches = 1)

    $savedEnvironment = @{}
    foreach ($name in @("USERPROFILE", "COPILOT_CUSTOM_INSTRUCTIONS_DIRS", "COPILOT_TASK_CLASS", "COPILOT_TASK_LABEL", "COPILOT_TASK_MODEL", "COPILOT_TASK_EFFORT", "COPILOT_TASK_CONTEXT")) {
        $savedEnvironment[$name] = [Environment]::GetEnvironmentVariable($name)
    }
    $oldLocation = Get-Location
    try {
        $env:USERPROFILE = $HomePath
        $workbenchTestState = @{ Answers = [Collections.Generic.Queue[string]]::new(); Launched = 0 }
        function Read-Host { $workbenchTestState.Answers.Dequeue() }
        function copilot {
            if ($args[0] -eq "help") { return 'Allowed values: "gpt-5.4"' }
            $workbenchTestState.Launched++
        }
        for ($launch = 0; $launch -lt $Launches; $launch++) {
            foreach ($answer in @("1", "1", "n", "")) { $workbenchTestState.Answers.Enqueue($answer) }
            & (Join-Path $Root "Start-CopilotWork.ps1") 6>$null
        }
        return $workbenchTestState.Launched
    } finally {
        Set-Location $oldLocation
        foreach ($name in $savedEnvironment.Keys) { [Environment]::SetEnvironmentVariable($name, $savedEnvironment[$name]) }
    }
}

Run-TestIf $script:OnWindows "T18: launcher relaunch never recreates, repoints or removes personal-skills ownership and keeps generated agents" "directory junctions require Windows" {
    foreach ($scenario in @("NoSkills", "WrongJunction", "RealDirectory", "Migrated")) {
        $fx = New-MigrationFixture -Mode $(if ($scenario -eq "Migrated") { "Junction" } else { $scenario })
        try {
            if ($scenario -eq "Migrated") {
                $applied = Invoke-MigrationScript -Fixture $fx -Apply
                Assert-ResultLine $applied "Applied" 0 "[$scenario] fixture migration"
            }
            $workbench = Join-Path $fx.Root "workbench"
            New-LauncherScaffold $workbench
            $skillsBefore = Get-NodeState $fx.Skills
            $otherBefore = if (Test-Path -LiteralPath $fx.Other) { Get-TreeSnapshot $fx.Other } else { @() }
            $sourceBefore = Get-TreeSnapshot $fx.Source
            $workbenchSkillsBefore = Get-TreeSnapshot (Join-Path $workbench "skills")
            $userAgentBefore = Get-NodeState (Join-Path $fx.Personal "agents\user-owned.agent.md")

            $launched = Invoke-FixtureLauncher -Root $workbench -HomePath $fx.Home -Launches 2
            Assert-True ($launched -eq 2) "[$scenario] launcher did not complete both launches"

            Assert-True ((Get-NodeState $fx.Skills) -ceq $skillsBefore) "[$scenario] launcher changed the personal skills root: before=[$skillsBefore] after=[$(Get-NodeState $fx.Skills)]"
            if ($scenario -eq "NoSkills") { Assert-True (-not (Test-Path -LiteralPath $fx.Skills)) "Launcher recreated the personal skills root" }
            if ($scenario -eq "Migrated") { Assert-True (-not (Test-IsLink $fx.Skills)) "Launcher recreated a whole-root link after the migration" }
            Assert-SameSnapshot $otherBefore $(if (Test-Path -LiteralPath $fx.Other) { Get-TreeSnapshot $fx.Other } else { @() }) "[$scenario] launcher changed a junction target"
            Assert-SameSnapshot $sourceBefore (Get-TreeSnapshot $fx.Source) "[$scenario] launcher changed the live source skills"
            Assert-SameSnapshot $workbenchSkillsBefore (Get-TreeSnapshot (Join-Path $workbench "skills")) "[$scenario] launcher changed the workbench skills"
            Assert-True ((Get-NodeState (Join-Path $fx.Personal "agents\user-owned.agent.md")) -ceq $userAgentBefore) "[$scenario] launcher changed a user-owned agent"
            $agent = Join-Path $fx.Personal "agents\quick.agent.md"
            Assert-True ((Test-Path -LiteralPath $agent) -and (Get-Content -LiteralPath $agent -Raw).Contains("gpt-5.4")) "[$scenario] launcher no longer generates task-class agents"
        } finally {
            Remove-FixtureRoot $fx.Root
        }
    }
}

Run-Test "T18: startup and setup helpers no longer define, call or document whole-root skills ownership" {
    . (Join-Path $PSScriptRoot "workbench-setup.ps1")
    Assert-True ($null -eq (Get-Command -Name Sync-PersonalSkills -ErrorAction SilentlyContinue)) "Sync-PersonalSkills is still defined"
    foreach ($relative in @("Start-CopilotWork.ps1", "scripts\workbench-setup.ps1")) {
        $text = [IO.File]::ReadAllText((Join-Path $script:RepoRoot $relative))
        Assert-True ($text -notmatch "Sync-PersonalSkills") "$relative still references Sync-PersonalSkills"
        Assert-True ($text -notmatch "(?i)-ItemType\s+Junction") "$relative still creates junctions"
        Assert-True ($text -notmatch "(?i)\.copilot[\\/]+skills|personalSkills") "$relative still manages ~/.copilot/skills"
    }
    Assert-True ((Get-Command -Name Update-TaskClassAgents -ErrorAction SilentlyContinue) -and (Get-Command -Name Get-WorkbenchSessionKickoff -ErrorAction SilentlyContinue)) "Agent generation or kickoff helper was lost"
}

Run-TestIf ($script:OnWindows -and [bool](Get-Command powershell.exe -ErrorAction SilentlyContinue)) "Migration helper also runs under Windows PowerShell 5.1" "powershell.exe is not available" {
    $fx = New-MigrationFixture
    try {
        $shell = (Get-Command powershell.exe).Source
        $sourceBefore = Get-TreeSnapshot $fx.Source
        $plan = Invoke-MigrationScript -Fixture $fx -Shell $shell
        Assert-ResultLine $plan "Planned" 0 "Windows PowerShell 5.1 plan"
        Assert-True (Test-IsLink $fx.Skills) "5.1 plan changed the junction"
        $apply = Invoke-MigrationScript -Fixture $fx -Apply -Shell $shell
        Assert-ResultLine $apply "Applied" 0 "Windows PowerShell 5.1 apply"
        Assert-True (-not (Test-IsLink $fx.Skills) -and (Test-Path -LiteralPath (Join-Path $fx.Skills "my-personal-skill\SKILL.md"))) "5.1 apply did not establish the real destination"
        Assert-True (-not (Test-Path -LiteralPath (Join-Path $fx.Skills "session-time-audit"))) "5.1 apply kept the legacy audit discoverable"
        $runs = @(Get-ArchiveRunDirectories $fx)
        foreach ($helper in @("estimate-session-duration.js", "extract-session-digest.js")) {
            $archivedHelper = Join-Path $runs[0].FullName "retired-skills\session-time-audit\scripts\$helper"
            Assert-True ((Test-Path -LiteralPath $archivedHelper) -and (Get-FileHash -LiteralPath $archivedHelper).Hash -eq (Get-FileHash -LiteralPath (Join-Path $fx.Source "session-time-audit\scripts\$helper")).Hash) "5.1 apply did not archive audit helper $helper unchanged"
        }
        Assert-SameSnapshot $sourceBefore (Get-TreeSnapshot $fx.Source) "5.1 apply changed the live source"
        $again = Invoke-MigrationScript -Fixture $fx -Apply -Shell $shell
        Assert-ResultLine $again "NoAction" 0 "Windows PowerShell 5.1 repeat"
    } finally {
        Remove-FixtureRoot $fx.Root
    }
}

# -------------------------------------------------------------------------------------------------
# T19: workbench ownership and routing (static checks, no model run or external checkout).
# -------------------------------------------------------------------------------------------------

function Read-RepoText([string]$RelativePath) {
    return [IO.File]::ReadAllText((Join-Path $script:RepoRoot $RelativePath))
}

function Get-WorkbenchGuidanceSurfaces {
    $surfaces = @{}
    foreach ($file in @(Get-ChildItem -LiteralPath (Join-Path $script:RepoRoot ".github\instructions") -Filter "*.md" -File)) {
        $surfaces["instructions\$($file.Name)"] = [IO.File]::ReadAllText($file.FullName)
    }
    foreach ($relative in @("AGENTS.md", "task-profiles.json", "README.md")) {
        $surfaces[$relative] = Read-RepoText $relative
    }
    return $surfaces
}

function Get-RoutingProblems {
    param([hashtable]$Surfaces)
    $problems = [Collections.Generic.List[string]]::new()
    $staleText = @(
        "/refine-requirements", "/tdd-implement", "/grill-me", "/reference-lookup", "/create-release", "/update-readme",
        "/estimate-task", "code-review-synthesis",
        "Always prefer the task-master skill", "Precedence: task-master skills", "Sanctioned exception", "Sync-PersonalSkills",
        "handles Git manually", "will handle Git commits", "Git stays manual", "Every Git mutation", "Preserve manual Git",
        "20-planning-first.instructions.md", "45-skills-and-review.instructions.md",
        "50-code-review.instructions.md", "60-git-boundaries.instructions.md"
    )
    foreach ($label in @($Surfaces.Keys)) {
        $normalized = $Surfaces[$label] -replace "\s+", " "
        foreach ($token in $staleText) {
            if ($normalized.Contains($token)) { $problems.Add("${label}: stale text '$token'") }
        }
    }

    $requirements = @{
        "AGENTS.md" = @("No particular instruction package or skill provider is required", "If no applicable user/project delivery policy is loaded", "ask the user before implementation or Git writes")
        "instructions\15-orchestrator-mode.instructions.md" = @("approved delivery stage", "Non-trivial work alone is not a reason to delegate", "model", "reasoning_effort", "context_tier")
        "README.md" = @("does not select a skill provider", "Migrate-PersonalSkills.ps1", "-Apply", "no separate checkout", "docs/legacy-skills-migration.md", "master checkout", "target repo", "does not update this alias")
    }
    foreach ($label in $requirements.Keys) {
        $normalized = $Surfaces[$label] -replace "\s+", " "
        foreach ($token in $requirements[$label]) {
            if (-not $normalized.Contains($token)) { $problems.Add("${label}: missing '$token'") }
        }
    }
    return @($problems)
}

Run-Test "T19: workbench guidance owns only routing and domain advice without requiring a policy package" {
    foreach ($name in @("20-planning-first", "45-skills-and-review", "50-code-review", "60-git-boundaries")) {
        Assert-True (-not (Test-Path -LiteralPath (Join-Path $script:RepoRoot ".github\instructions\$name.instructions.md"))) "Duplicate policy $name remains"
    }
    foreach ($name in @("10-model-selection", "15-orchestrator-mode", "30-d365-business-central", "40-d365-ce-power-platform")) {
        Assert-True (Test-Path -LiteralPath (Join-Path $script:RepoRoot ".github\instructions\$name.instructions.md")) "Retained guidance $name is missing"
    }
    $problems = @(Get-RoutingProblems (Get-WorkbenchGuidanceSurfaces))
    Assert-True ($problems.Count -eq 0) "Routing problems: $($problems -join '; ')"
}

Run-Test "T19: routing checks detect lost user-policy gates, provider independence and obsolete guidance" {
    $surfaces = Get-WorkbenchGuidanceSurfaces
    $baseline = @(Get-RoutingProblems $surfaces)
    Assert-True ($baseline.Count -eq 0) "Baseline guidance is not clean, so injected defects cannot be judged: $($baseline -join '; ')"
    $cases = @(
        @{ Surface = "AGENTS.md"; Old = "ask the user before implementation or Git writes"; New = "proceed without policy"; Expect = "ask the user before implementation or Git writes" }
        @{ Surface = "AGENTS.md"; Old = "No particular instruction package or skill provider is required"; New = "Install the required policy package"; Expect = "No particular instruction package or skill provider is required" }
        @{ Surface = "AGENTS.md"; Old = "# Copilot"; New = "Run /tdd-implement`n# Copilot"; Expect = "stale text '/tdd-implement'" }
        @{ Surface = "instructions\15-orchestrator-mode.instructions.md"; Old = "Non-trivial"; New = "Trivial"; Expect = "Non-trivial work alone is not a reason to delegate" }
        @{ Surface = "README.md"; Old = "Migrate-PersonalSkills.ps1"; New = "migration helper"; Expect = "Migrate-PersonalSkills.ps1" }
        @{ Surface = "task-profiles.json"; Old = '"hint"'; New = '"code-review-synthesis"'; Expect = "stale text 'code-review-synthesis'" }
    )
    foreach ($case in $cases) {
        $changed = $surfaces.Clone()
        $changed[$case.Surface] = ($surfaces[$case.Surface] -replace "\s+", " ").Replace($case.Old, $case.New)
        $found = @(Get-RoutingProblems $changed)
        Assert-True (($found -join "`n").Contains($case.Expect)) "Injected routing defect was not detected (expected '$($case.Expect)'; got: $($found -join '; '))"
    }
}

Run-Test "T19: workbench ships no skills; all retired and relocated directories are gone" {
    $skillsRoot = Join-Path $script:RepoRoot "skills"
    Assert-True (-not (Test-Path -LiteralPath $skillsRoot)) "The obsolete workbench skills source root is still present"
}

Run-Test "T19: legacy migration is documented separately without prescribing an installation reset" {
    $guide = Read-RepoText "docs\legacy-skills-migration.md"
    $normalized = $guide -replace "\s+", " "
    foreach ($term in @("upgrade compatibility", "plan-only by default", "-SourceSkillsPath", "-Apply", "-RetireSkill", "nothing is written", "real directory is never replaced", "no-op", "byte for byte", "migration-report.json", "no automatic rollback", "Git history", "explicit approval")) {
        Assert-True ($normalized.Contains($term)) "Legacy upgrade guide is missing '$term'"
    }
    Assert-True ($normalized.Contains("do not copy them into that directory")) "Native plugin skills must remain separately managed"
    Assert-True ($normalized.Contains("Do not remove personal skills or reset the installation")) "Upgrade guidance must not prescribe a reset"
    foreach ($relative in @("README.md", "scripts\Migrate-PersonalSkills.ps1")) {
        Assert-True (-not (Read-RepoText $relative).Contains("C:\Dev\00_MyStuff")) "$relative must not prescribe a developer-specific checkout"
    }
}

if ($script:Failed) { exit 1 }
