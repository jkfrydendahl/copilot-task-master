<#
.SYNOPSIS
    Finds remote branches matching task IDs or name patterns.
.DESCRIPTION
    Searches remote branches for matches against numeric task IDs (matched as a prefix
    followed by a non-digit) or arbitrary name patterns (substring match).
.PARAMETER TaskIds
    One or more task IDs (numeric) or branch name patterns to search for.
.EXAMPLE
    .\Find-TaskBranches.ps1 -TaskIds 12450, 12500
.EXAMPLE
    .\Find-TaskBranches.ps1 -TaskIds "feature/auth", 12450
#>
param(
    [Parameter(Mandatory)]
    [string[]]$TaskIds
)

git fetch --all --prune 2>$null | Out-Null

$allRemoteBranches = git branch -r | ForEach-Object { $_.Trim() } | Where-Object { $_ -like 'origin/*' -and $_ -notlike 'origin/HEAD*' }

foreach ($taskId in $TaskIds) {
    $isNumeric = $taskId -match '^\d+$'

    if ($isNumeric) {
        # Numeric task ID: match as prefix followed by a non-digit character
        $matches = $allRemoteBranches | Where-Object {
            $branchName = $_ -replace '^origin/', ''
            $branchName -match "^$taskId\D"
        } | ForEach-Object { $_ -replace '^origin/', '' }
    } else {
        # Non-numeric: treat as a branch name or substring pattern
        $exactMatch = $allRemoteBranches | Where-Object {
            ($_ -replace '^origin/', '') -eq $taskId
        } | ForEach-Object { $_ -replace '^origin/', '' }

        if ($exactMatch) {
            $matches = $exactMatch
        } else {
            # Substring search
            $matches = $allRemoteBranches | Where-Object {
                ($_ -replace '^origin/', '') -like "*$taskId*"
            } | ForEach-Object { $_ -replace '^origin/', '' }
        }
    }

    $count = ($matches | Measure-Object).Count

    if ($count -eq 0) {
        Write-Host "Task $taskId : NO BRANCH FOUND" -ForegroundColor Red
    } elseif ($count -eq 1) {
        Write-Host "Task $taskId : $matches" -ForegroundColor Green
    } else {
        Write-Host "Task $taskId : MULTIPLE MATCHES" -ForegroundColor Yellow
        $matches | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
    }
}
