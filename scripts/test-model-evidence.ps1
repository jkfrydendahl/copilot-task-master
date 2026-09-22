Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-benchmark-evidence.ps1")
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
$script:Failed = 0
function Assert-True($Condition, $Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name, [scriptblock]$Action) {
    try { & $Action; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $_" }
}
$now=[datetime]"2026-09-08Z"
$profile=@{key="default-development";effort="medium";context="default"}
$policy=Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
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
. (Join-Path $PSScriptRoot "model-artificial-analysis.ps1")
. (Join-Path $PSScriptRoot "fixtures\model-ranking\agent-fixture.ps1")
Run-Test "Structured agent evidence resolves new efforts and harnesses without aliases" {
    $root = Split-Path $PSScriptRoot -Parent
    $configuredPolicy = Get-ModelPolicyConfig (Join-Path $root "config\model-policy.json")
    $caps = (Get-ModelCapabilitiesCatalog (Join-Path $root "config\model-capabilities.json")).models
    $agents = @{
        status="ok";sourceDate=$null;fetchedAtUtc="2026-09-09Z";sourceUrl="https://artificialanalysis.ai/agents/coding-agents"
        sourceVersion="fixture-agents";models=@{
            gemini=(New-NormalizedAgentFixture gemini "Gemini 3.8 Flash (high)" 0.4186 google)
            opus=(New-NormalizedAgentFixture opus "Opus 5 (max)" 0.5973 anthropic)
            grok=(New-NormalizedAgentFixture grok "Grok 4.6 (xhigh)" 0.4697 xai)
        }
    }
    $agentProfile = @{key="agentic-implementation";model="gemini-3.8-flash";effort="high";context="default"}
    $models = @("gemini-3.8-flash","claude-opus-5","grok-4.6")
    $configs = Get-ProfileModelConfigurations -Profile $agentProfile -Models $models -Capabilities $caps -Policy $configuredPolicy
    $sources = @{artificialAnalysisCodingAgents=$agents}
    $r = Get-ProfileBenchmarkEvidence -Profile $agentProfile -Configurations $configs.configurations -Sources $sources `
        -Aliases @{} -Capabilities $caps -Policy $configuredPolicy -NowUtc ([datetime]"2026-09-09Z")
    Assert-True ($r.records.Count -eq 3) "Structured variants did not resolve without aliases"
    foreach ($record in $r.records) {
        Assert-True ($record.source -eq "artificialAnalysisCodingAgents" -and $record.harness -match "variant .*external agent harness, not Copilot CLI") "Harness provenance lost"
        Assert-True ($record.sourceMetadata.components.Count -eq 2) "Component coverage lost"
    }
    $verdicts = @(foreach ($config in $configs.configurations) {
        @{modelId=$config.model;effort=$config.effort;context="default";admissible=$true;reasonCodes=@();pricing=@{inputPerMillion=1;outputPerMillion=5}}
    })
    $fallback = [pscustomobject]@{model="gemini-3.8-flash";score=99;source="artificialAnalysis";metric="codingIndex";
        effort="high";context="default";sourceVersion="fixture-aa";cached=$false;publicationAgeUnknown=$true}
    $selection = Get-ProfileSelection -Profile $agentProfile -Evidence (@($r.records) + @($fallback)) `
        -Verdicts $verdicts -Policy $configuredPolicy -Aliases @{}
    Assert-True ($selection.winner.model -eq "claude-opus-5" -and $selection.winner.effort -eq "max" -and
        $selection.decidingSource -eq "artificialAnalysisCodingAgents") "Specialized source/configuration lost"
    $agentProfile.effort="medium"
    $r = Get-ProfileBenchmarkEvidence -Profile $agentProfile -Models $models -Sources $sources `
        -Aliases @{} -Capabilities $caps -Policy $configuredPolicy -NowUtc ([datetime]"2026-09-09Z")
    Assert-True ($r.records.Count -eq 0 -and $r.diagnostics.Count) "Another effort supplied medium evidence"
}
Run-Test "Agent resolution rejects composites, unknown efforts, providers and ambiguous identities" {
    $known=@("gpt-one","claude-opus-5","gemini-3.8-flash")
    foreach ($entry in @(
        @("GPT-one (max) (with fallback)","openai"),
        @("GPT-one + GPT-two (max)","openai"),
        @("GPT-one","openai"),
        @("GPT-one (automatic)","openai"),
        @("GPT-one (high)","google"),
        @("GPT-unknown (high)","openai")
    )) {
        $r=Resolve-AgentModelIdentities -Records @{one=(New-NormalizedAgentFixture one $entry[0] 0.7 $entry[1])} -KnownModels $known
        Assert-True ($r.records.Count -eq 0 -and $r.diagnostics.Count) "Ambiguous identity accepted: $($entry[0])"
    }
    $row=New-NormalizedAgentFixture one "Gemini 3.8 Flash (high)" 0.7 google
    $r=Resolve-AgentModelIdentities -Records @{one=$row} -KnownModels @("gemini-3.8-flash","gemini-3-8-flash")
    Assert-True ($r.records.Count -eq 0) "Normalization collision picked a model"
    $copy=$row.Clone();$copy.variantId="second";$copy.harness="Another harness"
    $r=Resolve-AgentModelIdentities -Records @{one=$row;two=$copy} -KnownModels $known
    Assert-True ($r.records.Count -eq 0 -and $r.diagnostics -match "ambiguous_agent_variants") "Highest-scoring/default harness chosen implicitly"
    $r=Resolve-AgentModelIdentities -Records @{old=@{label="Gemini 3.8 Flash (high)";codingAgentIndex=0.9}} -KnownModels $known
    Assert-True ($r.records.Count -eq 0 -and $r.diagnostics -match "identity_metadata_missing") "Legacy labels silently upgraded"
    $native=New-NormalizedAgentFixture native "Claude Haiku 4.5" 0.6 anthropic
    $r=Resolve-AgentModelIdentities -Records @{native=$native} -KnownModels @("claude-haiku-4.5") `
        -Capabilities @{"claude-haiku-4.5"=@{effortMode="unsupported"}}
    Assert-True ($r.records.Count -eq 1 -and $r.records[0].effort -eq "none") "Native effort semantics lost"
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
Run-Test "Gemini LiveBench high alias never supplies medium evidence and preserves supporting metrics" {
    $root = Split-Path $PSScriptRoot -Parent
    $p = Get-ModelPolicyConfig (Join-Path $root "config\model-policy.json")
    $mapping = (Read-ModelConfig (Join-Path $root "config\model-ranking-aliases.json") 2).aliases
    $source = @{
        status="ok";sourceDate="2026-09-01";fetchedAtUtc="2026-09-14Z";sourceVersion="lb-high";models=@{
            "gemini-3.8-flash-high"=@{reasoning=89.29325;instructionFollowing=81.4125}
        }
    }
    $current = @{key="orchestrator";model="gemini-3.8-flash";effort="high";context="default"}
    $configurations = @(foreach ($effort in @("medium","high")) {
        New-ModelConfiguration -Model "gemini-3.8-flash" -Effort $effort -Context default
    })
    foreach ($status in @("ok","cached")) {
        $source.status = $status
        $r = Get-ProfileBenchmarkEvidence -Profile $current -Configurations $configurations -Sources @{liveBench=$source} `
            -Aliases $mapping -Policy $p -NowUtc ([datetime]"2026-09-14Z")
        Assert-True ($r.records.Count -eq 1 -and $r.records[0].effort -eq "high") "High score borrowed for medium"
        Assert-True ($r.records[0].metric -eq "instructionFollowing" -and $r.records[0].score -eq 81.4125 -and
            $r.records[0].sourceMetadata.reasoning -eq 89.29325) "Supporting metrics lost or substituted"
        Assert-True ($r.records[0].cached -eq ($status -eq "cached")) "Cached status lost"
    }
    $source.sourceDate = "2026-01-01"
    $r = Get-ProfileBenchmarkEvidence -Profile $current -Configurations $configurations -Sources @{liveBench=$source} `
        -Aliases $mapping -Policy $p -NowUtc ([datetime]"2026-09-14Z")
    Assert-True ($r.records.Count -eq 0 -and $r.diagnostics -match "publication_stale") "Expired supporting evidence admitted"
}
Run-Test "Role evidence keeps exact public components separate and fingerprints only deciding data" {
    $p=Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
    $current=@{key="orchestrator";effort="medium";context="default"}
    $source=@{status="ok";fetchedAtUtc="2026-09-08Z";sourceDate=$null;sourceUrl="https://example.test/components";
        sourceVersion="page1";models=@{"one-medium"=@{name="One medium";automationBench=0.6;enterpriseOpsGym=0.4;lcr=0.8;ifbench=0.7}}}
    $read={Get-ProfileBenchmarkEvidence -Profile $current -Models @("one") -Sources @{artificialAnalysisComponents=$source;artificialAnalysis=$aa} -Aliases $aliases -Policy $p -NowUtc $now}
    $first=& $read
    Assert-True ($first.records.Count -eq 4 -and @($first.records | Where-Object source -eq artificialAnalysis).Count -eq 0) "Hidden aggregate deciding evidence or missing support"
    $deciding=@($first.records | Where-Object metric -eq automationBench)[0]
    Assert-True ($deciding.score -eq 0.6 -and $deciding.alias -eq "one-medium" -and
        $deciding.configurationId -eq (New-ModelConfiguration one medium default).configurationId) "Exact component identity lost"
    $source.models["one-medium"].lcr=0.9;$source.sourceVersion="page2"
    $second=& $read
    Assert-True (($second.records | Where-Object metric -eq automationBench).sourceVersion -eq $deciding.sourceVersion) "Support/page churn changed deciding observation"
    $source.models["one-medium"].automationBench=1.1
    $invalid=& $read
    Assert-True (@($invalid.records | Where-Object metric -eq automationBench).Count -eq 0 -and $invalid.diagnostics -match "score_missing_or_invalid") "Native scale not enforced"
}
Run-Test "Components never borrow another effort or accept composite model identities" {
    $p=Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
    $current=@{key="orchestrator";effort="medium";context="default"}
    foreach($record in @(
        @{name="One (medium) with fallback";automationBench=0.8},
        @{name="One";effort="high";automationBench=0.8}
    )) {
        $source=@{status="ok";fetchedAtUtc="2026-09-08Z";sourceDate=$null;models=@{"one-medium"=$record}}
        $r=Get-ProfileBenchmarkEvidence -Profile $current -Models @("one") -Sources @{artificialAnalysisComponents=$source} -Aliases $aliases -Policy $p -NowUtc $now
        Assert-True ($r.records.Count -eq 0 -and $r.diagnostics -match "identity") "Composite/other effort accepted"
    }
}
Run-Test "API aggregate confirmation is independent of other aggregate metrics" {
    $source=ConvertTo-CanonicalModelData $aa
    $first=Evidence -Sources @{artificialAnalysis=$source}
    $source.sourceVersion="changed-api";$source.models["one-medium"].intelligenceIndex=95
    $second=Evidence -Sources @{artificialAnalysis=$source}
    Assert-True ($first.records[0].sourceVersion -eq $second.records[0].sourceVersion) "Intelligence change confirmed coding"
    $source.models["one-medium"].codingIndex=51
    $third=Evidence -Sources @{artificialAnalysis=$source}
    Assert-True ($first.records[0].sourceVersion -ne $third.records[0].sourceVersion) "Deciding score change not observed"
}
Run-Test "Invalid unrelated scores do not change a usable metric observation" {
    $source=ConvertTo-CanonicalModelData $aa
    $source.models["one-max"].codingIndex="invalid-one"
    $first=Evidence -Sources @{artificialAnalysis=$source}
    $source.models["one-max"].codingIndex="invalid-two"
    $second=Evidence -Sources @{artificialAnalysis=$source}
    Assert-True ($first.records[0].sourceVersion -eq $second.records[0].sourceVersion) "Invalid row churn became confirmation evidence"
}
Run-Test "Ambiguous aliases and invalid artifact dates cannot authorize evidence" {
    $mapping=@{one=@{artificialAnalysis=@{medium="one-medium";max="one-medium"}}}
    $r=Evidence -Sources @{artificialAnalysis=$aa} -Mapping $mapping
    Assert-True ($r.records.Count -eq 0 -and $r.diagnostics -match "alias_ambiguous") "One row supplied different efforts"
    foreach($date in @("invalid","2026-09-09Z")) {
        $source=ConvertTo-CanonicalModelData $lb;$source.artifactPublishedAtUtc=$date
        $r=Evidence -Sources @{liveBench=$source}
        Assert-True ($r.records.Count -eq 0 -and $r.diagnostics -match "artifact_publication_invalid") "Invalid/future artifact date accepted"
    }
}
if ($script:Failed) { exit 1 }
