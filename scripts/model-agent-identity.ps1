Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

function ConvertTo-AgentModelName {
    param([string]$Name)
    return ($Name.Trim().ToLowerInvariant() -replace '[ ._-]+', '-')
}

function Resolve-AgentModelIdentities {
    param(
        [System.Collections.IDictionary]$Records,
        [AllowEmptyCollection()][string[]]$KnownModels,
        [hashtable]$Capabilities = @{}
    )
    $diagnostics = [System.Collections.Generic.List[string]]::new()
    $resolved = [System.Collections.Generic.List[object]]::new()
    # Provider namespaces, not a list of benchmark model/effort/harness labels.
    $prefixes = @{
        anthropic="claude-";openai="gpt-";google="gemini-";xai="grok-";moonshotai="kimi-"
        microsoft="mai-";deepseek="deepseek-";zai="glm-";alibaba_cloud="qwen";meta="muse-"
    }
    foreach ($key in @($Records.Keys | Sort-Object)) {
        $row = $Records[$key]
        if ((Get-ObjectMemberValue $row "identitySchemaVersion") -ne 1) {
            $diagnostics.Add("${key}: identity_metadata_missing (legacy label-only records cannot authorize selection)")
            continue
        }
        $label = Get-ObjectMemberValue $row "publishedModel"
        $provider = Get-ObjectMemberValue $row "provider"
        if ($label -isnot [string] -or $provider -isnot [string] -or -not $prefixes.ContainsKey($provider)) {
            $diagnostics.Add("${key}: model_or_provider_unresolved")
            continue
        }
        $effort = $null
        if ($label -cmatch '^(?<model>[A-Za-z0-9][A-Za-z0-9 ._-]*) \((?<effort>minimal|low|medium|high|xhigh|max)\)$') {
            $name = $Matches.model
            $effort = $Matches.effort
        } elseif ($label -cmatch '^[A-Za-z0-9][A-Za-z0-9 ._-]*$') {
            $name = $label
        } else {
            $diagnostics.Add("${key}: composite_or_ambiguous_model_label '$label'")
            continue
        }
        $normalized = ConvertTo-AgentModelName $name
        if ($provider -eq "anthropic" -and -not $normalized.StartsWith("claude-")) { $normalized = "claude-$normalized" }
        $matches = @($KnownModels | Sort-Object -Unique | Where-Object {
            $_.StartsWith($prefixes[$provider], [StringComparison]::OrdinalIgnoreCase) -and
            (ConvertTo-AgentModelName $_) -ceq $normalized
        })
        if ($matches.Count -ne 1) {
            $diagnostics.Add("${key}: model_identity_unresolved_or_ambiguous '$label'")
            continue
        }
        $model = $matches[0]
        $native = (Get-ObjectMemberValue $Capabilities[$model] "effortMode") -eq "unsupported"
        if ($null -eq $effort) {
            if (-not $native) {
                $diagnostics.Add("${key}: effort_not_explicit '$label'")
                continue
            }
            $effort = "none"
        } elseif ($native) {
            $diagnostics.Add("${key}: explicit_effort_conflicts_with_native_model")
            continue
        }
        $resolved.Add([pscustomobject]@{model=$model;effort=$effort;record=$row})
    }
    $unique = @(foreach ($group in @($resolved | Group-Object model,effort)) {
        if ($group.Count -ne 1) {
            $diagnostics.Add("$($group.Name): ambiguous_agent_variants ($(@($group.Group.record.variantId) -join ', '))")
        } else {
            $group.Group[0]
        }
    })
    return @{records=$unique;diagnostics=@($diagnostics)}
}
