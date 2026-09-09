Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-benchmark-evidence.ps1")
$script:Failed = 0
function Assert-True($Condition, $Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name, [scriptblock]$Action) {
    try { & $Action; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $_" }
}
$now=[datetime]"2026-09-08Z"
$profile=@{key="default-development";effort="medium";context="default"}
$policy=@{profileArtificialAnalysisMetrics=@{"default-development"="coding"};profileLiveBenchCategories=@{"default-development"="coding"};consensusPolicy=@{staleAfterDays=45;benchmarkMaxPublicationAgeDays=90}}
$aliases=@{one=@{artificialAnalysis=@{medium="one-medium";max="one-max"};liveBench=@{medium="one-lb"}}}
$aa=@{status="ok";sourceDate=$null;fetchedAtUtc="2026-09-08Z";sourceUrl="https://example.test/aa";sourceVersion="aa-v1";models=@{"one-medium"=@{name="One medium";codingIndex=50;intelligenceIndex=60};"one-max"=@{codingIndex=90}}}
$lb=@{status="ok";sourceDate="2026-09-01";fetchedAtUtc="2026-09-08Z";sourceUrl="https://example.test/lb";sourceVersion="lb-v1";models=@{"one-lb"=@{coding=80}}}
function Evidence($Sources=@{artificialAnalysis=$aa;liveBench=$lb}, $Mapping=$aliases, $Profile=$profile, $Caps=@{}) {
    Get-ProfileBenchmarkEvidence -Profile $Profile -Models @("one") -Sources $Sources -Aliases $Mapping -Capabilities $Caps -Policy $policy -NowUtc $now
}
Run-Test "Fixed effort uses exact variant and carries provenance" {
    $r=Evidence
    Assert-True ($r.records.Count -eq 2) "Expected both sources"
    $e=@($r.records | Where-Object source -eq artificialAnalysis)[0]
    Assert-True ($e.score -eq 50 -and $e.alias -eq "one-medium") "Used max score"
    Assert-True ($e.publicationAgeUnknown -and $e.effort -eq "medium") "Provenance"
}
Run-Test "Unmatched configuration is excluded rather than substituted" {
    $r=Evidence -Mapping @{one=@{artificialAnalysis=@{max="one-max"}}}
    Assert-True ($r.records.Count -eq 0) "Max substituted for medium"
    Assert-True ($r.diagnostics.Count -gt 0) "Missing match not reported"
}
Run-Test "Independent sources and missing LB cost data do not gate evidence" {
    $r=Evidence -Sources @{artificialAnalysis=$aa;liveBench=@{status="error";message="HTTP503"}}
    Assert-True ($r.records.Count -eq 1 -and $r.records[0].source -eq "artificialAnalysis") "AA blocked"
    $r=Evidence -Sources @{artificialAnalysis=@{status="error";message="no key"};liveBench=$lb}
    Assert-True ($r.records.Count -eq 1 -and $r.records[0].source -eq "liveBench") "LB blocked"
}
Run-Test "Known publication age and retrieval age are separate gates" {
    $old=$lb.Clone();$old.sourceDate="2026-01-01"
    Assert-True ((Evidence -Sources @{liveBench=$old}).records.Count -eq 0) "Old publication"
    $old=$aa.Clone();$old.fetchedAtUtc="2026-01-01"
    Assert-True ((Evidence -Sources @{artificialAnalysis=$old}).records.Count -eq 0) "Old retrieval"
    Assert-True ((Evidence -Sources @{artificialAnalysis=$aa}).records.Count -eq 1) "Unknown date should be disclosed, not fabricated"
}
Run-Test "Unsupported effort models use explicitly declared no-effort variant" {
    $r=Evidence -Mapping @{one=@{artificialAnalysis=@{none="one-medium"}}} -Caps @{one=@{effortMode="unsupported"}}
    Assert-True ($r.records.Count -eq 1 -and $r.records[0].effort -eq "none") "Unsupported effort semantics"
}
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
. (Join-Path $PSScriptRoot "model-profile-selection.ps1")
Run-Test "Configured coding-agent aliases preserve exact efforts and external harness identity" {
    $root = Split-Path $PSScriptRoot -Parent
    $configuredPolicy = Get-ModelPolicyConfig (Join-Path $root "config\model-policy.json")
    $configuredAliases = (Read-ModelConfig (Join-Path $root "config\model-ranking-aliases.json") 2).aliases
    $caps = (Get-ModelCapabilitiesCatalog (Join-Path $root "config\model-capabilities.json")).models
    $agents = @{
        status="ok";sourceDate=$null;fetchedAtUtc="2026-09-09Z";sourceUrl="https://artificialanalysis.ai/agents/coding-agents"
        sourceVersion="fixture-agents";models=@{
            "Opencode - Gemini 3.8 Flash (high)"=@{codingAgentIndex=0.61}
            "Grok Build - Grok 4.5 (high)"=@{codingAgentIndex=0.64}
            "Codex - GPT-6 Astra (max)"=@{codingAgentIndex=0.67}
        }
    }
    $agentProfile = @{key="agentic-implementation";model="gpt-5.6-sol";effort="high";context="default"}
    $models = @("gemini-3.8-flash","grok-4.5","gpt-6-astra")
    $sources = @{artificialAnalysisCodingAgents=$agents}
    $r = Get-ProfileBenchmarkEvidence -Profile $agentProfile -Models $models -Sources $sources `
        -Aliases $configuredAliases -Capabilities $caps -Policy $configuredPolicy -NowUtc ([datetime]"2026-09-09Z")
    Assert-True ($r.records.Count -eq 2) "Missing high-effort agent aliases or max substituted for high"
    foreach ($record in $r.records) {
        Assert-True ($record.source -eq "artificialAnalysisCodingAgents" -and $record.harness -eq "external agent harness, not Copilot CLI") "Harness provenance lost"
        Assert-True ($record.alias -match '\(high\)$' -and $record.effort -eq "high") "Effort mismatch"
    }
    $verdicts = @(foreach ($model in $models) {
        @{modelId=$model;effort="high";context="default";admissible=$true;reasonCodes=@();pricing=@{inputPerMillion=1;outputPerMillion=5}}
    })
    $fallback = [pscustomobject]@{model="gemini-3.8-flash";score=99;source="artificialAnalysis";metric="codingIndex";
        effort="high";context="default";sourceVersion="fixture-aa";cached=$false;publicationAgeUnknown=$true}
    $selection = Get-ProfileSelection -Profile $agentProfile -Evidence (@($r.records) + @($fallback)) `
        -Verdicts $verdicts -Policy $configuredPolicy -Aliases $configuredAliases
    Assert-True ($selection.winner.model -eq "grok-4.5" -and $selection.decidingSource -eq "artificialAnalysisCodingAgents") "Harness source did not outrank LLM coding fallback"

    foreach ($effort in @("medium","max")) {
        $agentProfile.effort = $effort
        $r = Get-ProfileBenchmarkEvidence -Profile $agentProfile -Models $models -Sources $sources `
            -Aliases $configuredAliases -Capabilities $caps -Policy $configuredPolicy -NowUtc ([datetime]"2026-09-09Z")
        if ($effort -eq "medium") {
            Assert-True ($r.records.Count -eq 0 -and $r.diagnostics.Count -gt 0) "High/max harness scores substituted for medium"
        } else {
            Assert-True ($r.records.Count -eq 1 -and $r.records[0].model -eq "gpt-6-astra") "Missing exact Astra max harness"
        }
    }
}
Run-Test "Explicit configurations retain exact aliases and identities for every effort" {
    . (Join-Path $PSScriptRoot "model-configuration.ps1")
    $configurations=@(
        New-ModelConfiguration -Model one -Effort medium -Context default
        New-ModelConfiguration -Model one -Effort max -Context default
    )
    $r=Get-ProfileBenchmarkEvidence -Profile $profile -Models @("one") -Configurations $configurations `
        -Sources @{artificialAnalysis=$aa;liveBench=$lb} -Aliases $aliases -Policy $policy -NowUtc $now
    $records=@($r.records | Where-Object source -eq artificialAnalysis)
    Assert-True ($records.Count -eq 2 -and $records[0].score -eq 50 -and $records[1].score -eq 90) "Effort-specific evidence conflated"
    Assert-True ($records[0].configurationId -ne $records[1].configurationId -and $records[1].effort -eq "max") "Configuration provenance missing"
    Assert-True (@($r.records | Where-Object source -eq liveBench).Count -eq 1 -and $r.diagnostics -match "effort 'max'") "Missing max evidence borrowed medium"
}
if ($script:Failed) { exit 1 }
