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
Run-Test "Real policy is complete with exactly three hard-budget profiles" {
    $p=Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
    Assert-True ($p.denylist -contains "claude-fable-5") "Denylist"
    $hard=@($p.profileRequirements.Keys | Where-Object {$p.profileRequirements[$_].costSensitive})
    Assert-True ($hard.Count -eq 3 -and $hard -contains "triage") "Budget modes"
    Assert-True ($p.profileArtificialAnalysisMetrics["agentic-implementation"] -eq "coding") "Explicit agentic AA coding fallback"
}
Run-Test "Four lightweight profiles use explicit value bands; execution profiles stay quality-first" {
    $p = Get-ModelPolicyConfig (Join-Path $repo "config\model-policy.json")
    foreach ($key in $p.profileRequirements.Keys) {
        $strategy = $p.selectionPolicy.profiles[$key]
        if ($key -in @("orchestrator", "quick", "mechanical", "triage")) {
            Assert-True ($strategy.strategy -eq "value_balanced") "Missing value strategy for $key"
            $aaMetric = "artificialAnalysis.$($p.profileArtificialAnalysisMetrics[$key])Index"
            $lbMetric = "liveBench.$($p.profileLiveBenchCategories[$key])"
            Assert-True ($strategy.qualityBands[$aaMetric] -eq 3 -and $strategy.qualityBands[$lbMetric] -eq 3) "Explicit metric bands missing"
        } else {
            Assert-True ($strategy.strategy -eq "quality_first") "Execution profile changed: $key"
        }
    }
}
Run-Test "Invalid strategies and incomplete or nonnumeric bands fail validation" {
    $path = Join-Path ([IO.Path]::GetTempPath()) "$([guid]::NewGuid().ToString('N')).json"
    try {
        foreach ($mutate in @(
            { param($p) $p.selectionPolicy.Remove("profiles") },
            { param($p) $p.selectionPolicy.profiles.Remove("review") },
            { param($p) $p.selectionPolicy.profiles.orchestrator.strategy = "cheapest" },
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
if ($script:Failed) { exit 1 }
