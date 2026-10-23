function Convert-ToYamlSingleQuoted {
    param([string]$Value)

    if ($null -eq $Value) {
        return "''"
    }

    return "'" + ($Value -replace "'", "''") + "'"
}

function Get-TaskAgentFileState([string]$Path) {
    try { $item = Get-Item -LiteralPath $Path -Force -ErrorAction Stop }
    catch [System.Management.Automation.ItemNotFoundException] {
        return [pscustomobject]@{ Hash = $null; Content = $null; ReadOnly = $false; Signature = "missing" }
    }
    if ($item.PSIsContainer -or ($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
        throw "Agent ownership conflict: '$Path' must be a plain file, not a directory or link."
    }
    $hash = (Get-FileHash -LiteralPath $Path -Algorithm SHA256 -ErrorAction Stop).Hash.ToLowerInvariant()
    return [pscustomobject]@{
        Hash = $hash
        Content = [IO.File]::ReadAllText($Path)
        ReadOnly = [bool]($item.Attributes -band [IO.FileAttributes]::ReadOnly)
        Signature = "$hash|$([int]$item.Attributes)"
    }
}

function Assert-TaskAgentDirectory([string]$Path) {
    $directory = [IO.DirectoryInfo]([IO.Path]::GetFullPath($Path))
    while ($null -ne $directory) {
        $item = $null
        try { $item = Get-Item -LiteralPath $directory.FullName -Force -ErrorAction Stop }
        catch [System.Management.Automation.ItemNotFoundException] { }
        if ($null -ne $item -and (-not $item.PSIsContainer -or ($item.Attributes -band [IO.FileAttributes]::ReparsePoint))) {
            throw "Agent ownership conflict: '$($directory.FullName)' must be a real directory, not a file or link."
        }
        $directory = $directory.Parent
    }
}

function Update-TaskClassAgents {
    param(
        [string]$MasterPath,
        [array]$Profiles,
        [string]$PersonalRoot = (Join-Path $env:USERPROFILE ".copilot")
    )

    if ($null -eq $Profiles) { throw "Task profiles must be supplied; only an explicit empty array may retire all verified owned agents." }
    $personalAgents = Join-Path ([IO.Path]::GetFullPath($PersonalRoot)) "agents"
    $stateFile = Join-Path $personalAgents ".generated-task-class-agents.json"
    $skipKeys = @("triage", "orchestrator")
    $validKeyPattern = "^(?!(?:con|prn|aux|nul|com[1-9]|lpt[1-9])$)[a-z][a-z0-9-]*$"
    Assert-TaskAgentDirectory $personalAgents
    $stateBefore = Get-TaskAgentFileState $stateFile
    $owned = @{}
    $legacy = $false
    if ($null -ne $stateBefore.Hash) {
        try {
            # Wrapping preserves empty and single-element arrays on Windows PowerShell too.
            $state = (ConvertFrom-Json -InputObject ('{"manifest":' + $stateBefore.Content + '}') -ErrorAction Stop).manifest
        } catch { throw "Invalid agent ownership manifest '$stateFile': $($_.Exception.Message)" }
        if ($state -is [array] -or $state -is [string]) {
            $legacy = $true
            $entries = @($state | ForEach-Object { [pscustomobject]@{ key = $_; sha256 = $null } })
        } elseif ($state -is [pscustomobject] -and $state.PSObject.Properties["schemaVersion"] -and ($state.schemaVersion -is [int] -or $state.schemaVersion -is [long]) -and $state.schemaVersion -eq 1 -and $state.PSObject.Properties["files"] -and $state.files -is [array]) {
            $entries = @($state.files)
        } else { throw "Unsupported agent ownership manifest '$stateFile'." }
        foreach ($entry in $entries) {
            if ($null -eq $entry -or -not $entry.PSObject.Properties["key"] -or $entry.key -isnot [string] -or $entry.key -cnotmatch $validKeyPattern -or $owned.ContainsKey($entry.key)) {
                throw "Invalid or duplicate agent key in '$stateFile'."
            }
            if (-not $legacy -and (-not $entry.PSObject.Properties["sha256"] -or $entry.sha256 -isnot [string] -or $entry.sha256 -cnotmatch "^[a-f0-9]{64}$")) {
                throw "Invalid agent hash in '$stateFile'."
            }
            $owned[$entry.key] = $entry.sha256
        }
    }
    . (Join-Path $PSScriptRoot "model-launch-args.ps1")
    $capabilities = @{}
    $catalogPath = Join-Path $MasterPath "config\model-capabilities.json"
    if (Test-Path -LiteralPath $catalogPath) {
        $capabilities = Get-LaunchCapabilitiesCatalog -CatalogPath $catalogPath
    }
    $desired = @{}
    foreach ($profile in $Profiles) {
        if ($null -eq $profile) { throw "A task profile is null." }
        if ($skipKeys -contains $profile.key) { continue }
        foreach ($property in @("key", "label", "description", "model")) {
            if ($profile.$property -isnot [string] -or [string]::IsNullOrWhiteSpace($profile.$property)) { throw "Task profile requires a nonempty '$property'." }
        }
        $key = $profile.key
        if ($key -cnotmatch $validKeyPattern -or $desired.ContainsKey($key)) { throw "Invalid or duplicate task profile key '$key'." }
        $label = $profile.label
        $description = $profile.description
        $nameYaml = Convert-ToYamlSingleQuoted $key
        $invocationJson = Get-CopilotTaskInvocationSettings -Profile $profile -CapabilitiesCatalog $capabilities | ConvertTo-Json -Compress
        $descYaml = Convert-ToYamlSingleQuoted ("Task-class specialist for {0}. Use when work matches: {1} Required task arguments: {2}" -f $label, $description, $invocationJson)
        $modelYaml = Convert-ToYamlSingleQuoted $profile.model
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

Required task tool arguments (caller responsibility): $invocationJson
These settings are not enforced by this Markdown or inherited from the orchestrator.
The caller must resolve the current approved profile and pass its model, effort (when supported),
and context explicitly. If the task tool cannot express that configuration, do not silently
substitute defaults; report the limitation and use the direct profile launcher instead.

Operating rules:
- Focus on requests that clearly match this class.
- If a request appears out-of-class, say so briefly and recommend the better task-class agent key.
- Keep responses concise, actionable, and execution-oriented.
"@
        $desired[$key] = $agentContent + [Environment]::NewLine
    }

    $actions = [Collections.Generic.List[object]]::new()
    $newOwned = @{}
    $observed = @{ $stateFile = $stateBefore.Signature }
    $utf8 = [Text.UTF8Encoding]::new($false)
    foreach ($key in @($desired.Keys | Sort-Object)) {
        $path = Join-Path $personalAgents "$key.agent.md"
        $current = Get-TaskAgentFileState $path
        $observed[$path] = $current.Signature
        if ($null -ne $current.Hash -and $current.Content.Replace("`r`n", "`n") -ceq $desired[$key].Replace("`r`n", "`n")) {
            $newOwned[$key] = $current.Hash
            continue
        }
        if ($null -ne $current.Hash -and (-not $owned.ContainsKey($key) -or $null -eq $owned[$key] -or $current.Hash -cne $owned[$key])) {
            throw "Agent ownership conflict: '$path' is unmanaged, modified locally, or has only unverifiable legacy ownership. Preserve or explicitly archive it before retrying."
        }
        if ($current.ReadOnly) { throw "Agent ownership conflict: '$path' is read-only." }
        $hasher = [Security.Cryptography.SHA256]::Create()
        try { $newOwned[$key] = ([BitConverter]::ToString($hasher.ComputeHash($utf8.GetBytes($desired[$key])))).Replace("-", "").ToLowerInvariant() }
        finally { $hasher.Dispose() }
        $actions.Add([pscustomobject]@{ Kind = "Write"; Path = $path; Content = $desired[$key] })
    }
    foreach ($key in @($owned.Keys | Sort-Object)) {
        if ($desired.ContainsKey($key)) { continue }
        $path = Join-Path $personalAgents "$key.agent.md"
        $current = Get-TaskAgentFileState $path
        $observed[$path] = $current.Signature
        if ($null -eq $current.Hash) { continue }
        if ($null -eq $owned[$key] -or $current.Hash -cne $owned[$key] -or $current.ReadOnly) {
            throw "Agent ownership conflict: retired '$path' is modified, read-only, or has unverifiable legacy ownership; it will not be deleted."
        }
        $actions.Add([pscustomobject]@{ Kind = "Delete"; Path = $path; Content = $null })
    }
    if ($newOwned.Count -eq 0 -and $owned.Count -eq 0 -and $null -eq $stateBefore.Hash) { return }
    $stateChanged = $legacy -or $null -eq $stateBefore.Hash -or $newOwned.Count -ne $owned.Count
    foreach ($key in $newOwned.Keys) {
        if (-not $owned.ContainsKey($key) -or $newOwned[$key] -cne $owned[$key]) { $stateChanged = $true }
    }
    if ($stateChanged -and $stateBefore.ReadOnly) { throw "Agent ownership manifest '$stateFile' is read-only." }
    Assert-TaskAgentDirectory $personalAgents
    foreach ($path in $observed.Keys) {
        if ((Get-TaskAgentFileState $path).Signature -cne $observed[$path]) { throw "Agent ownership conflict: '$path' changed during planning." }
    }
    if ($actions.Count -eq 0 -and -not $stateChanged) { return }
    New-Item -ItemType Directory -Path $personalAgents -Force -ErrorAction Stop | Out-Null
    foreach ($action in $actions) {
        Assert-TaskAgentDirectory $personalAgents
        if ((Get-TaskAgentFileState $action.Path).Signature -cne $observed[$action.Path]) { throw "Agent ownership conflict: '$($action.Path)' changed before applying the plan." }
        if ($action.Kind -eq "Write") { [IO.File]::WriteAllText($action.Path, $action.Content, $utf8) }
        else { Remove-Item -LiteralPath $action.Path -Force -ErrorAction Stop }
    }
    if ($stateChanged) {
        Assert-TaskAgentDirectory $personalAgents
        if ((Get-TaskAgentFileState $stateFile).Signature -cne $stateBefore.Signature) { throw "Agent ownership manifest '$stateFile' changed during synchronization." }
        $files = @($newOwned.Keys | Sort-Object | ForEach-Object { [ordered]@{ key = $_; sha256 = $newOwned[$_] } })
        $content = [ordered]@{ schemaVersion = 1; files = $files } | ConvertTo-Json -Depth 4
        [IO.File]::WriteAllText($stateFile, $content + [Environment]::NewLine, $utf8)
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
    return "$kickoff Follow the $($Profile.key) model-routing guidance in the workbench instructions: $instructionPath"
}
