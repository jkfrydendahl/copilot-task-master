Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$script:Failed = 0

function Assert-True($Condition, $Message) {
    if (-not $Condition) { throw $Message }
}

function Run-Test($Name, [scriptblock]$Action) {
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
        $dictionary = $info | ConvertTo-Json | ConvertFrom-Json -AsHashtable
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

if ($script:Failed) { exit 1 }
