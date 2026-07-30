$script:CopilotModelIdPattern = '"(claude-[\w.\-]+|gpt-[\w.\-]+|gemini-[\w.\-]+|mai-[\w.\-]+)"'

function Get-CopilotModelIdsFromHelpText {
    [OutputType([string[]])]
    param([Parameter(Mandatory = $true)][string]$HelpText)

    return @(
        [regex]::Matches($HelpText, $script:CopilotModelIdPattern) |
            ForEach-Object { $_.Groups[1].Value } |
            Select-Object -Unique
    )
}
