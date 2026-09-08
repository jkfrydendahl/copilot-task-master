function Convert-ToYamlSingleQuoted {
    param([string]$Value)

    if ($null -eq $Value) {
        return "''"
    }

    return "'" + ($Value -replace "'", "''") + "'"
}

function Sync-PersonalSkills {
    # The CLI reads personal skills from ~/.copilot/skills in every repo. Keep that path
    # pointed at this folder's skills\ directory via a junction so the master folder stays
    # the single source of truth. Self-healing and non-fatal.
    param(
        [string]$MasterPath,
        [string]$PersonalRoot = (Join-Path $env:USERPROFILE ".copilot")
    )

    $skillsSource = Join-Path $MasterPath "skills"
    if (!(Test-Path $skillsSource)) { return }

    $personalSkills = Join-Path $PersonalRoot "skills"

    try {
        if (Test-Path $personalSkills) {
            $item = Get-Item $personalSkills -Force
            if ($item.LinkType -eq "Junction") {
                $current = @($item.Target)[0]
                if ($current -eq $skillsSource) { return }
                # Junction points elsewhere -> repoint it.
                $item.Delete()
                New-Item -ItemType Junction -Path $personalSkills -Target $skillsSource | Out-Null
                Write-Host "Re-pointed ~/.copilot/skills -> $skillsSource" -ForegroundColor DarkGray
            } else {
                # A real directory already exists; don't clobber the user's own skills.
                Write-Host "~/.copilot/skills exists and is not a junction; leaving it untouched." -ForegroundColor Yellow
                Write-Host "  Shared skills in '$skillsSource' will not be auto-linked." -ForegroundColor DarkGray
            }
        } else {
            New-Item -ItemType Junction -Path $personalSkills -Target $skillsSource | Out-Null
            Write-Host "Linked ~/.copilot/skills -> $skillsSource" -ForegroundColor DarkGray
        }
    } catch {
        Write-Host "Could not sync personal skills (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

function Update-TaskClassAgents {
    # Generate per-task-class custom agents in ~/.copilot/agents from task-profiles.json.
    # This gives an "augment" path: keep launch-time model selection, but also allow
    # task-level routing with explicit @agent keys inside an orchestrator session.
    param(
        [string]$MasterPath,
        [array]$Profiles,
        [string]$PersonalRoot = (Join-Path $env:USERPROFILE ".copilot")
    )

    $personalAgents = Join-Path $PersonalRoot "agents"
    $stateFile = Join-Path $personalAgents ".generated-task-class-agents.json"
    $skipKeys = @("triage", "orchestrator")

    $routeProfiles = @(
        $Profiles | Where-Object {
            $_ -and
            -not [string]::IsNullOrWhiteSpace($_.key) -and
            -not [string]::IsNullOrWhiteSpace($_.label) -and
            -not [string]::IsNullOrWhiteSpace($_.description) -and
            -not [string]::IsNullOrWhiteSpace($_.model) -and
            ($skipKeys -notcontains $_.key)
        }
    )

    if ($routeProfiles.Count -eq 0) { return }

    try {
        New-Item -ItemType Directory -Path $personalAgents -Force | Out-Null

        $previousKeys = @()
        if (Test-Path $stateFile) {
            try { $previousKeys = @(Get-Content $stateFile -Raw | ConvertFrom-Json) } catch { $previousKeys = @() }
        }

        $currentKeys = @()

        foreach ($profile in $routeProfiles) {
            $key = [string]$profile.key
            $label = [string]$profile.label
            $description = [string]$profile.description
            $model = [string]$profile.model
            $agentPath = Join-Path $personalAgents "$key.agent.md"

            $currentKeys += $key

            $nameYaml = Convert-ToYamlSingleQuoted $key
            $descYaml = Convert-ToYamlSingleQuoted ("Task-class specialist for {0}. Use when work matches: {1}" -f $label, $description)
            $modelYaml = Convert-ToYamlSingleQuoted $model
            $toolsLine = if ($key -eq "review") { "tools: ['read', 'search']`n" } else { "" }

            $agentContent = @"
---
name: $nameYaml
description: $descYaml
model: $modelYaml
$toolsLine---
You are the **$label** specialist for my Copilot task-class workflow.

Primary fit:
- $description

Operating rules:
- Focus on requests that clearly match this class.
- If a request appears out-of-class, say so briefly and recommend the better task-class agent key.
- Keep responses concise, actionable, and execution-oriented.
"@

            Set-Content -Path $agentPath -Value $agentContent -Encoding UTF8
        }

        $staleKeys = @($previousKeys | Where-Object { $_ -and ($currentKeys -notcontains $_) })
        foreach ($staleKey in $staleKeys) {
            $stalePath = Join-Path $personalAgents "$staleKey.agent.md"
            if (Test-Path $stalePath) {
                Remove-Item $stalePath -Force
            }
        }

        $currentKeys | ConvertTo-Json | Set-Content $stateFile -Encoding UTF8
    } catch {
        Write-Host "Could not sync task-class agents (non-fatal): $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

function Get-WorkbenchSessionKickoff {
    param(
        [Parameter(Mandatory)]$Profile,
        [Parameter(Mandatory)][string]$MasterPath
    )

    $kickoff = "Session initialized: task class = **$($Profile.label)** (``$($Profile.key)``), model = ``$($Profile.model)``, effort = ``$($Profile.effort)``, context = ``$($Profile.context)``. Class definition: $($Profile.description) Acknowledge briefly and await my task."
    $instructionName = if ($Profile.key -eq "orchestrator") {
        "15-orchestrator-mode.instructions.md"
    } else {
        "10-model-selection.instructions.md"
    }
    $instructionPath = Join-Path $MasterPath ".github\instructions\$instructionName"
    return "$kickoff Follow the $($Profile.key) workflow in the shared workbench instructions: $instructionPath"
}
