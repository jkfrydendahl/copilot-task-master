Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
. (Join-Path $PSScriptRoot "model-availability.ps1")
. (Join-Path $PSScriptRoot "model-selection-policy.ps1")
. (Join-Path $PSScriptRoot "model-admissibility.ps1")
$repo=Split-Path $PSScriptRoot -Parent
$script:Failed=0
function Assert-True($Condition,$Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name,[scriptblock]$Action) {
    try { &$Action; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $_" }
}
Run-Test "All profiles enforce the approved fixed hard budgets" {
    $p=Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
    Assert-True ($p.denylist -contains "claude-fable-5") "Denylist"
    $hard=@($p.profileRequirements.Keys | Where-Object {$p.profileRequirements[$_].costSensitive})
    Assert-True ($hard.Count -eq 9) "Budget modes"
    $ceilings=@{
        quick=@(2,10);mechanical=@(2,10);triage=@(2,10);orchestrator=@(3,15)
        "default-development"=@(4,20);"visual-ui"=@(5,25);review=@(5,30)
        "agentic-implementation"=@(10,50);"deep-reasoning"=@(10,45)
    }
    foreach ($key in $ceilings.Keys) {
        $req=$p.profileRequirements[$key]
        Assert-True ($req.inputCeilingPerMillion -eq $ceilings[$key][0] -and $req.outputCeilingPerMillion -eq $ceilings[$key][1]) "Wrong approved ceiling: $key"
        foreach ($field in @("inputPerMillion","outputPerMillion")) {
            $tier=@{inputPerMillion=$ceilings[$key][0];outputPerMillion=$ceilings[$key][1]}
            foreach ($excess in @(0,0.000001)) {
                $price=@{verifiedAtUtc="2026-09-09";tiers=@{default=$tier}}
                $cap=@{asOf="2026-09-09";vision=$true;supportedContexts=@("default");supportedEfforts=@("low")}
                $v=Get-ModelAdmissibilityVerdict -ModelId one -ProfileKey $key -AvailabilityVerified $true -AvailableModels @("one") `
                    -CapabilityRecord $cap -PricingRecord $price -ProfileRequirement $req -ProfileContextTier default -ProfileEffort low -NowUtc ([datetime]"2026-09-09Z")
                Assert-True ($v.admissible -eq ($excess -eq 0)) "Hard ceiling boundary failed: $key $field"
                $tier[$field]+=0.000001
            }
        }
    }
    Assert-True ($p.profileArtificialAnalysisMetrics["agentic-implementation"] -eq "coding") "Explicit agentic AA coding fallback"
}
Run-Test "All profiles use explicit source-specific value bands without incumbent-relative limits" {
    $p = Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
    foreach ($key in $p.profileRequirements.Keys) {
        $strategy = $p.selectionPolicy.profiles[$key]
        Assert-True ($strategy.strategy -eq "value_balanced") "Missing value strategy for $key"
        Assert-True (-not $strategy.Contains("maxAutomaticCostIncreasePercent")) "Obsolete incumbent-relative limit for $key"
        $aaMetric = "artificialAnalysis.$($p.profileArtificialAnalysisMetrics[$key])Index"
        $lbMetric = "liveBench.$($p.profileLiveBenchCategories[$key])"
        Assert-True ($strategy.qualityBands[$aaMetric] -eq 3 -and $strategy.qualityBands[$lbMetric] -eq 3) "Explicit metric bands missing"
    }
    Assert-True ($p.selectionPolicy.profiles["agentic-implementation"].qualityBands["artificialAnalysisCodingAgents.codingAgentIndex"] -eq 0.03) "Agent index band used the wrong scale"
}
Run-Test "Invalid strategies and incomplete or nonnumeric bands fail validation" {
    $path = Join-Path ([IO.Path]::GetTempPath()) "$([guid]::NewGuid().ToString('N')).json"
    try {
        foreach ($mutate in @(
            { param($p) $p.selectionPolicy.Remove("profiles") },
            { param($p) $p.selectionPolicy.profiles.Remove("review") },
            { param($p) $p.selectionPolicy.profiles.orchestrator.strategy = "cheapest" },
            { param($p) $p.selectionPolicy.profiles.orchestrator.maxAutomaticCostIncreasePercent = 0 },
            { param($p) $p.profileRequirements.review.costSensitive = $false },
            { param($p) $p.selectionPolicy.profiles.review.Remove("configurationSelection") },
            { param($p) $p.selectionPolicy.profiles["agentic-implementation"].qualityBands.Remove("artificialAnalysisCodingAgents.codingAgentIndex") },
            { param($p) $p.selectionPolicy.profiles.orchestrator.qualityBands.Remove("liveBench.instructionFollowing") },
            { param($p) $p.selectionPolicy.profiles.orchestrator.qualityBands["artificialAnalysis.intelligenceIndex"] = -1 },
            { param($p) $p.selectionPolicy.profiles.orchestrator.qualityBands["artificialAnalysis.intelligenceIndex"] = "3" },
            { param($p) $p.selectionPolicy.profiles.orchestrator.qualityBands["liveBench.typo"] = 3 },
            { param($p) $p.selectionPolicy.profiles["typo"] = @{strategy="quality_first"} }
        )) {
            $p = Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
            & $mutate $p
            $p | ConvertTo-Json -Depth 15 | Set-Content -LiteralPath $path
            $threw = $false
            try { Get-ModelPolicyConfig $path | Out-Null } catch { $threw = $true }
            Assert-True $threw "Invalid selection policy accepted"
        }
    } finally {
        if (Test-Path -LiteralPath $path) { Remove-Item -LiteralPath $path }
    }
}
Run-Test "Legacy schema and malformed current capabilities fail loudly" {
    $path = Join-Path ([IO.Path]::GetTempPath()) "$([guid]::NewGuid().ToString('N')).json"
    try {
        foreach ($mutate in @(
            { param($c) $c.schemaVersion = 1 },
            { param($c) $c.models["claude-sonnet-5"].vision = "true" },
            { param($c) $c.models["claude-sonnet-5"].Remove("supportedContexts") },
            { param($c) $c.models["claude-sonnet-5"].pricing = @{default=@{inputPerMillion=1}} }
        )) {
            $catalog = Get-ModelCapabilitiesCatalog (Join-Path $repo "config\model-capabilities.json")
            & $mutate $catalog
            $catalog | ConvertTo-Json -Depth 15 | Set-Content -LiteralPath $path
            $threw = $false
            try { Get-ModelCapabilitiesCatalog $path | Out-Null } catch { $threw = $true }
            Assert-True $threw "Invalid capabilities accepted"
        }
    } finally {
        if (Test-Path -LiteralPath $path) { Remove-Item -LiteralPath $path }
    }
}
Run-Test "Capabilities contain no prices and preserve launcher effort semantics" {
    $c=(Get-ModelCapabilitiesCatalog (Join-Path $repo "config\model-capabilities.json")).models
    Assert-True ($c["claude-haiku-4.5"].effortMode -eq "unsupported") "Haiku effort"
    Assert-True ($c.ContainsKey("gpt-6-astra") -and $c.ContainsKey("grok-4.6")) "New models omitted"
    foreach ($r in $c.Values) {
        Assert-True (-not $r.ContainsKey("pricing")) "Prices still embedded"
        if ($r.vision) {Assert-True ([bool]$r.visionSource) "Vision guessed"}
    }
    Run-Test "Schema v2 validates values beyond the version field" {
        $path=Join-Path ([System.IO.Path]::GetTempPath()) "$([guid]::NewGuid().ToString('N')).json"
        try {
            foreach ($mutate in @(
                {param($p) $p.profileRequirements.quick.inputCeilingPerMillion=-1},
                {param($p) $p.profileRequirements.Remove("review")},
                {param($p) $p.Remove("profileRequirements")},
                {param($p) $p.consensusPolicy.pricingFreshnessDays=0},
                {param($p) $p.profileArtificialAnalysisMetrics.review="unknown"},
                {param($p) $p.profileRequirements.review.costSensitive="false"}
            )) {
                $p=Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
                &$mutate $p
                $p | ConvertTo-Json -Depth 15 | Set-Content -LiteralPath $path
                $threw=$false
                try { Get-ModelPolicyConfig $path | Out-Null } catch { $threw=$true; Assert-True ($_ -notmatch "schemaVersion") "Only schema was tested" }
                Assert-True $threw "Accepted invalid v2 policy"
            }
        } finally { if (Test-Path -LiteralPath $path) { Remove-Item -LiteralPath $path } }
    }
}
Run-Test "Verified CLI discovery and unverified fallback remain distinct" {
    $v=Get-ModelAvailability -CliProbe {@("gpt-6-astra","grok-4.6")} -GhProbe {@()} -Denylist @("grok-4.6")
    Assert-True ($v.verified -and $v.models.Count -eq 1) "Discovery filtering"
    $f=Get-ModelAvailability -CliProbe {@()} -GhProbe {@()} -FallbackModels @("one")
    Assert-True (-not $f.verified -and $f.models[0] -eq "one") "Fallback verified"
}
Run-Test "CLI model-id parsing covers current provider families" {
    $models=Get-ModelsFromHelpText 'Allowed values: "gpt-6-astra", "grok-4.6", "gemini-3.8-flash", "mai-code-1.1-flash", "claude-sonnet-5"'
    Assert-True ($models -contains "gpt-6-astra" -and $models -contains "grok-4.6") "Model discovery parser"
}
Run-Test "Family fallback is config-derived and constrained by admissibility" {
    $p=Get-ModelSelectionPolicy
    Assert-True ($p.classPreferences["default-development"][0] -eq "sonnet-family") "Policy config"
    $v=Get-PreferredModelForProfilePolicy -ProfileKey "default-development" -ValidModels @("claude-sonnet-5","gpt-5.6-terra") -AdmissibleModels @("gpt-5.6-terra")
    Assert-True ($v -eq "gpt-5.6-terra") "Inadmissible baseline"
    $v=Get-PreferredModelForProfilePolicy -ProfileKey "default-development" -ValidModels @("claude-sonnet-5") -AdmissibleModels @()
    Assert-True ($null -eq $v) "Empty eligible fallback pool"
}
Run-Test "All capability, availability and denylist gates report independently" {
    $now=[datetime]"2026-09-08Z"
    $req=@{inputCeilingPerMillion=2;outputCeilingPerMillion=10;requiresVision=$true;requiresCliAgent=$true;costSensitive=$true}
    $cap=@{asOf="2026-01-01";vision=$null;supportedContexts=@("default");supportedEfforts=@("low")}
    $price=@{verifiedAtUtc="2026-01-01";tiers=@{default=@{inputPerMillion=5;outputPerMillion=30}}}
    $v=Get-ModelAdmissibilityVerdict -ModelId "one" -ProfileKey "quick" -AvailabilityVerified $false -AvailableModels @() -Denylist @("one") `
        -CapabilityRecord $cap -PricingRecord $price -ProfileRequirement $req -ProfileContextTier "long_context" -ProfileEffort "high" -NowUtc $now
    foreach($reason in @("denylisted","not_available","unverified_availability_freezes_promotion","cli_agent_incompatible","capabilities_stale","vision_unknown","context_unsupported","effort_unsupported","pricing_stale","pricing_input_exceeds_ceiling","pricing_output_exceeds_ceiling")) {
        Assert-True ($v.reasonCodes -contains $reason) "Missing gate $reason"
    }
}
Run-Test "Sol vision has explicit provenance and admits the configured Visual/UI variant" {
    $policy = Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
    $cap = (Get-ModelCapabilitiesCatalog (Join-Path $repo "config\model-capabilities.json")).models["gpt-5.6-sol"]
    Assert-True ($cap.vision -eq $true -and $cap.visionSource -eq "https://artificialanalysis.ai/models/gpt-5-6-sol-medium") "Sol vision not supported by a matched published source"
    $price = @{verifiedAtUtc="2026-09-09";tiers=@{default=@{inputPerMillion=4;outputPerMillion=20}}}
    $verdict = Get-ModelAdmissibilityVerdict -ModelId "gpt-5.6-sol" -ProfileKey "visual-ui" `
        -AvailabilityVerified $true -AvailableModels @("gpt-5.6-sol") -CapabilityRecord $cap -PricingRecord $price `
        -ProfileRequirement $policy.profileRequirements["visual-ui"] -ProfileContextTier "default" -ProfileEffort "medium" `
        -NowUtc ([datetime]"2026-09-09Z")
    Assert-True ($verdict.admissible -and $verdict.warningCodes.Count -eq 0) "Verified vision or approved Visual/UI budget rejected Sol"
}
Run-Test "Every profile preauthorizes its task-appropriate effort range" {
    $p=Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
    Assert-True ($p.selectionPolicy.version -eq 5) "Configuration policy version not advanced"
    $ranges=@{
        quick="low";mechanical="low";triage="low";orchestrator="low,medium"
        "default-development"="medium,high";review="medium,high";"visual-ui"="medium,high"
        "agentic-implementation"="high,xhigh,max";"deep-reasoning"="high,xhigh,max"
    }
    foreach ($key in $ranges.Keys) {
        $selection=$p.selectionPolicy.profiles[$key].configurationSelection
        Assert-True ($selection.mode -eq "bounded_effort" -and $selection.effortChangePolicy -eq "automatic") "Missing automatic authorization: $key"
        Assert-True (($selection.allowedEfforts -join ",") -eq $ranges[$key]) "Wrong effort range: $key"
    }
}
Run-Test "Invalid or obsolete effort policies fail rather than silently changing authorization" {
    $path=Join-Path ([IO.Path]::GetTempPath()) "$([guid]::NewGuid().ToString('N')).json"
    try {
        foreach ($mutate in @(
            {param($s) $s.mode="maximum"},
            {param($s) $s.effortChangePolicy="manual"},
            {param($s) $s.Remove("effortChangePolicy")},
            {param($s) $s.allowedEfforts=@()},
            {param($s) $s.allowedEfforts="high"},
            {param($s) $s.allowedEfforts=@("high","high")},
            {param($s) $s.allowedEfforts=@("high","typo")},
            {param($s) $s.allowedEfforts=@("none")}
        )) {
            $p=Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
            $s=@{mode="bounded_effort";effortChangePolicy="automatic";allowedEfforts=@("high","xhigh","max")}
            & $mutate $s
            $p.selectionPolicy.profiles["agentic-implementation"].configurationSelection=$s
            $p | ConvertTo-Json -Depth 15 | Set-Content -LiteralPath $path
            $threw=$false
            try { Get-ModelPolicyConfig $path | Out-Null } catch { $threw=$true }
            Assert-True $threw "Invalid effort policy accepted"
        }
    } finally { if (Test-Path -LiteralPath $path) { Remove-Item -LiteralPath $path } }
}
Run-Test "Configuration candidates intersect all task ranges and preserve native no-effort behavior" {
    . (Join-Path $PSScriptRoot "model-configuration.ps1")
    $p=Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
    $profile=@{key="agentic-implementation";model="one";effort="high";context="default"}
    $caps=@{
        one=@{supportedEfforts=@("low","high")}
        two=@{supportedEfforts=@("medium","high","xhigh","max")}
        native=@{effortMode="unsupported";supportedEfforts=@()}
    }
    $result=Get-ProfileModelConfigurations -Profile $profile -Models @("one","two","native","unknown") -Capabilities $caps -Policy $p
    Assert-True ($result.configurations.Count -eq 5) "Unsupported efforts invented or native configuration lost"
    Assert-True (@($result.configurations | Where-Object model -eq "one").Count -eq 1) "High-only model expanded beyond capabilities"
    Assert-True (($result.configurations | Where-Object model -eq "native").effort -eq "none") "No-effort model invented a flag"
    Assert-True ($result.diagnostics -match "unknown.*capabilities_missing") "Missing capability diagnostic"
    Assert-True (@($result.configurations.configurationId | Select-Object -Unique).Count -eq 5) "Configuration identity collision"
    $profile.key="review"
    $review=Get-ProfileModelConfigurations -Profile $profile -Models @("one","two","native") -Capabilities $caps -Policy $p
    Assert-True ($review.configurations.Count -eq 4 -and @($review.configurations | Where-Object effort -eq "medium").Count -eq 1) "Review did not expand its allowed range"
    $caps.all=@{supportedEfforts=@("minimal","low","medium","high","xhigh","max")}
    foreach ($key in $p.selectionPolicy.profiles.Keys) {
        $profile.key=$key
        $range=$p.selectionPolicy.profiles[$key].configurationSelection.allowedEfforts
        $expanded=Get-ProfileModelConfigurations -Profile $profile -Models @("all","native") -Capabilities $caps -Policy $p
        Assert-True ($expanded.configurations.Count -eq $range.Count+1) "Incorrect candidate count: $key"
        Assert-True (@($expanded.configurations | Where-Object {$_.effort -ne "none" -and $_.effort -notin $range}).Count -eq 0) "Unauthorized effort: $key"
    }
    $empty=Get-ProfileModelConfigurations -Profile $profile -Models @() -Capabilities $caps -Policy $p
    Assert-True ($empty.configurations.Count -eq 0) "Empty model list became a candidate"
}
Run-Test "Configuration identity includes effort and context but not source metadata" {
    . (Join-Path $PSScriptRoot "model-configuration.ps1")
    $high=New-ModelConfiguration -Model one -Effort high -Context default
    $xhigh=New-ModelConfiguration -Model one -Effort xhigh -Context default
    $long=New-ModelConfiguration -Model one -Effort high -Context long_context
    Assert-True ($high.configurationId -ne $xhigh.configurationId -and $high.configurationId -ne $long.configurationId) "Configuration identities merged"
    $repeat=New-ModelConfiguration -Model one -Effort high -Context default
    Assert-True ($repeat.configurationId -eq $high.configurationId) "Unstable identity"
}
if ($script:Failed) { exit 1 }
