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
$aa=@{status="ok";sourceDate=$null;fetchedAtUtc="2026-09-08Z";sourceUrl="https://example.test/aa";sourceVersion="aa-v1";models=@{"one-medium"=@{name="One medium";codingIndex=50;intelligenceIndex=60};"one-max"=@{codingIndex=90;intelligenceIndex=90}}}
$lb=@{status="ok";sourceDate="2026-09-01";fetchedAtUtc="2026-09-08Z";sourceUrl="https://example.test/lb";sourceVersion="lb-v1";models=@{"one-lb"=@{coding=80}}}
function Evidence($Sources=@{artificialAnalysis=$aa;liveBench=$lb}, $Mapping=$aliases, $Profile=$profile, $Caps=@{}) {
    Get-ProfileBenchmarkEvidence -Profile $Profile -Models @("one") -Sources $Sources -Aliases $Mapping -Capabilities $Caps -Policy $policy -NowUtc $now
}
Run-Test "Fixed effort uses exact variant and carries provenance" {
    $r=Evidence
    Assert-True ($r.records.Count -eq 2) "Expected both sources"
    $e=@($r.records | Where-Object source -eq artificialAnalysis)[0]
    Assert-True ($e.score -eq 60 -and $e.alias -eq "one-medium") "Used max score"
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
            gemini=(New-NormalizedAgentFixture gemini "Gemini 3.8 Flash" 0.4186 google)
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
        effort="none";context="default";sourceVersion="fixture-aa";cached=$false;publicationAgeUnknown=$true}
    $selection = Get-ProfileSelection -Profile $agentProfile -Evidence (@($r.records) + @($fallback)) `
        -Verdicts $verdicts -Policy $configuredPolicy -Aliases @{}
    Assert-True ($selection.winner.model -eq "claude-opus-5" -and $selection.winner.effort -eq "max" -and
        $selection.decidingSource -eq "artificialAnalysisCodingAgents") "Specialized source/configuration lost"
    $agentProfile.effort="medium"
    $r = Get-ProfileBenchmarkEvidence -Profile $agentProfile -Models $models -Sources $sources `
        -Aliases @{} -Capabilities $caps -Policy $configuredPolicy -NowUtc ([datetime]"2026-09-09Z")
    Assert-True ($r.records.Count -eq 1 -and $r.records[0].model -eq "gemini-3.8-flash" -and $r.records[0].effort -eq "none") "Native evidence changed with requested profile effort"
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
    Assert-True ($records.Count -eq 2 -and $records[0].score -eq 60 -and $records[1].score -eq 90) "Effort-specific evidence conflated"
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
Run-Test "API aggregates reject fallback identities and published effort mismatches" {
    foreach ($name in @("One (Medium, Default Fallback)", "One + Two", "One (Medium, Ensemble)", "One (High)")) {
        $source=ConvertTo-CanonicalModelData $aa
        $source.models["one-medium"].name=$name
        $r=Evidence -Sources @{artificialAnalysis=$source}
        Assert-True ($r.records.Count -eq 0 -and $r.diagnostics -match "identity") "Aggregate identity accepted: $name"
    }
    $source=ConvertTo-CanonicalModelData $aa
    $source.models["one-medium"].name="One (High)"
    $r=Evidence -Sources @{artificialAnalysis=$source} -Mapping @{one=@{artificialAnalysis=@{none="one-medium"}}} -Caps @{one=@{effortMode="unsupported"}}
    Assert-True ($r.records.Count -eq 0) "Native configuration borrowed published High"
}
Run-Test "Agent effort casing is normalized without admitting fallback or native conflicts" {
    foreach ($effort in @("None","Max","Xhigh","HIGH")) {
        $row=New-NormalizedAgentFixture one "GPT-one ($effort)" 0.7 openai
        $r=Resolve-AgentModelIdentities -Records @{one=$row} -KnownModels @("gpt-one")
        Assert-True ($r.records.Count -eq 1 -and $r.records[0].effort -ceq $effort.ToLowerInvariant()) "Effort casing not normalized"
    }
    foreach ($label in @("GPT-one (Max, Default Fallback)", "GPT-one (Automatic)")) {
        $r=Resolve-AgentModelIdentities -Records @{one=(New-NormalizedAgentFixture one $label 0.7 openai)} -KnownModels @("gpt-one")
        Assert-True ($r.records.Count -eq 0) "Invalid agent identity admitted"
    }
    $r=Resolve-AgentModelIdentities -Records @{one=(New-NormalizedAgentFixture one "Gemini 3.8 Flash (High)" 0.7 google)} `
        -KnownModels @("gemini-3.8-flash") -Capabilities @{"gemini-3.8-flash"=@{effortMode="unsupported"}}
    Assert-True ($r.records.Count -eq 0 -and $r.diagnostics -match "explicit_effort_conflicts_with_native_model") "Native mismatch admitted"
}
Run-Test "Explicit controlled none agent evidence remains distinct from native no-effort invocation" {
    $row=New-NormalizedAgentFixture one "GPT-one (none)" 0.7 openai
    $policy=Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
    $profile=@{key="agentic-implementation";model="gpt-one";effort="high";context="default"}
    $caps=@{"gpt-one"=@{effortMode="supported";supportedEfforts=@("none","high")}}
    $configuration=New-ModelConfiguration -Model gpt-one -Effort none -Context default -CapabilityRecord $caps["gpt-one"]
    $source=@{status="ok";fetchedAtUtc="2026-09-08Z";sourceDate=$null;models=@{one=$row}}
    $result=Get-ProfileBenchmarkEvidence -Profile $profile -Configurations @($configuration) `
        -Sources @{artificialAnalysisCodingAgents=$source} -Aliases @{} -Capabilities $caps -Policy $policy -NowUtc ([datetime]"2026-09-08Z")
    Assert-True ($result.records.Count -eq 1 -and $result.records[0].effort -eq "none") "Explicit supported none agent variant was discarded"
    $native=Resolve-AgentModelIdentities -Records @{one=$row} -KnownModels @("gpt-one") `
        -Capabilities @{"gpt-one"=@{effortMode="unsupported"}}
    Assert-True ($native.records.Count -eq 0 -and $native.diagnostics -match "explicit_effort_conflicts_with_native_model") "Controlled none was silently relabelled as native invocation"
}
Run-Test "API aggregate confirmation is independent of other aggregate metrics" {
    $source=ConvertTo-CanonicalModelData $aa
    $first=Evidence -Sources @{artificialAnalysis=$source}
    $source.sourceVersion="changed-api";$source.models["one-medium"].codingIndex=51
    $second=Evidence -Sources @{artificialAnalysis=$source}
    Assert-True ($first.records[0].sourceVersion -eq $second.records[0].sourceVersion) "Coding change confirmed intelligence"
    $source.models["one-medium"].intelligenceIndex=61
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
Run-Test "Inactive versioned metrics fingerprint benchmark and published configuration identity" {
    $definition=@{source="artificialAnalysisComponents";metric="frontierCode20";benchmarkId="frontiercode-2-0";min=0;max=1}
    $legacyDefinition=@{source="artificialAnalysisComponents";metric="lcr";min=0;max=1}
    $source=@{models=@{"one-high"=@{frontierCode20=0.5;lcr=0.8}};
        identities=@{"one-high"=@{status="verified";releaseId="one";effort="high"}};evaluatorRevision=$null}
    $first=Get-SourceMetricObservation $source $definition
    $legacy=Get-SourceMetricObservation $source $legacyDefinition
    $source.identities["one-high"].releaseId="one-revised"
    $changed=Get-SourceMetricObservation $source $definition
    Assert-True ($changed.version -ne $first.version -and $changed.identity -eq $first.identity) "Published configuration identity ignored"
    Assert-True ((Get-SourceMetricObservation $source $legacyDefinition).version -eq $legacy.version) "Inactive identity data changed legacy observations"
    $definition.benchmarkId="frontiercode-3-0"
    Assert-True ((Get-SourceMetricObservation $source $definition).identity -ne $changed.identity) "Different benchmark generation reused an identity"
    $source.evaluatorRevision="verified-revision"
    Assert-True ((Get-SourceMetricObservation $source $definition).identity -ne
        (Get-SourceMetricObservation @{models=$source.models;identities=$source.identities} $definition).identity) "Known evaluator revision ignored"
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
Run-Test "Coverage audit aliases preserve all nineteen exact published model efforts" {
    $aliases=(Read-ModelConfig (Join-Path $PSScriptRoot "..\config\model-ranking-aliases.json") 2).aliases
    $expected=@(
        @("claude-opus-4.8","artificialAnalysis","max","claude-opus-4-8"),
        @("claude-opus-4.7","artificialAnalysis","max","claude-opus-4-7"),
        @("claude-sonnet-4.6","artificialAnalysis","max","claude-sonnet-4-6-adaptive"),
        @("gpt-5.5","artificialAnalysis","low","gpt-5-5-low"),
        @("gpt-5.5","artificialAnalysis","medium","gpt-5-5-medium"),
        @("gpt-5.5","artificialAnalysis","high","gpt-5-5-high"),
        @("gpt-5.5","artificialAnalysis","xhigh","gpt-5-5"),
        @("gpt-5.4","artificialAnalysis","low","gpt-5-4-low"),
        @("gpt-5.4","artificialAnalysis","xhigh","gpt-5-4"),
        @("gpt-5.4-mini","artificialAnalysis","medium","gpt-5-4-mini-medium"),
        @("gpt-5.4-mini","artificialAnalysis","xhigh","gpt-5-4-mini"),
        @("gpt-5.3-codex","artificialAnalysis","xhigh","gpt-5-3-codex"),
        @("gemini-3.5-flash","artificialAnalysis","medium","gemini-3-5-flash-medium"),
        @("gemini-3.5-flash","artificialAnalysis","high","gemini-3-5-flash"),
        @("gemini-3.6-flash","artificialAnalysis","high","gemini-3-6-flash"),
        @("gemini-3.5-flash","liveBench","high","gemini-3.5-flash-high"),
        @("gemini-3.6-flash","liveBench","high","gemini-3.6-flash-high"),
        @("gemini-3.7-flash","liveBench","high","gemini-3.7-flash-high"),
        @("gpt-6-astra","liveBench","max","gpt-6-astra-max")
    )
    foreach ($entry in $expected) {
        $model,$source,$effort,$alias=$entry
        Assert-True ($aliases[$model][$source][$effort] -eq $alias) "Missing exact coverage mapping: $model/$source/$effort"
    }
    Assert-True (-not $aliases["gemini-3.5-flash"].artificialAnalysis.Contains("low")) "Minimal borrowed as low"
    Assert-True (-not $aliases["claude-opus-4.7"].artificialAnalysis.Contains("high")) "Contradictory non-reasoning mapping"
}
$usageWorkload=@{id=$policy.selectionPolicy.measuredCost.workload;fingerprint="workload-fingerprint"}
$usageMedium=New-ModelConfiguration one medium default
$usageMax=New-ModelConfiguration one max default
function Usage-Row([string]$Effort,[long]$InputTokens,[long]$OutputTokens,[long]$Reasoning) {
    @{status="verified";name="One ($Effort)";effort=$Effort;releaseId="one";inputTokens=$InputTokens;outputTokens=$OutputTokens
        answerTokens=$OutputTokens-$Reasoning;reasoningTokens=$Reasoning;workloadFingerprint=$usageWorkload.fingerprint}
}
function Usage-Source {
    @{
        status="ok";sourceDate=$null;fetchedAtUtc="2026-09-08Z";sourceUrl="https://example.test/components";sourceVersion="page1"
        models=@{"one-medium"=@{name="One medium";automationBench=0.6;enterpriseOpsGym=0.4;lcr=0.8;ifbench=0.7}
            "one-max"=@{name="One max";automationBench=0.7;enterpriseOpsGym=0.5;lcr=0.85;ifbench=0.75}}
        identities=@{"one-medium"=@{status="verified";releaseId="one";effort="medium"};"one-max"=@{status="verified";releaseId="one";effort="max"}}
        releases=@{"one-medium"=@(@{date="2026-08-01";releaseId="one";effort="medium"});"one-max"=@(@{date="2026-08-01";releaseId="one";effort="max"})}
        usage=@{schemaVersion=1;workload=@{id=$usageWorkload.id;fingerprint=$usageWorkload.fingerprint}
            models=@{"one-medium"=(Usage-Row medium 1000000 100000 20000);"one-max"=(Usage-Row max 2000000 400000 300000)}}
    }
}
function Usage-For($Source,$Mapping=$aliases,$UsagePolicy=$policy) {
    Get-ProfileUsageEvidence -Configurations @($usageMedium,$usageMax) -Source $Source -Aliases $Mapping -Policy $UsagePolicy -NowUtc $now
}
Run-Test "Usage evidence is matched to each exact configuration and keeps the workload identity" {
    $u=Usage-For (Usage-Source)
    Assert-True ($u.enabled -and $u.workload.id -eq $policy.selectionPolicy.measuredCost.workload -and $u.workload.fingerprint -eq "workload-fingerprint") "Workload identity missing"
    $medium=$u.configurations[$usageMedium.configurationId]
    $max=$u.configurations[$usageMax.configurationId]
    Assert-True ($medium.status -eq "valid" -and $medium.alias -eq "one-medium" -and $medium.inputTokens -eq 1000000 -and
        $medium.outputTokens -eq 100000 -and $medium.reasons.Count -eq 0 -and $medium.workloadId -eq $usageWorkload.id) "Medium usage was not matched to its own alias"
    Assert-True ($max.status -eq "valid" -and $max.alias -eq "one-max" -and $max.inputTokens -eq 2000000 -and $max.outputTokens -eq 400000) "Max usage borrowed another effort's consumption"
}
Run-Test "Every unusable consumption condition is explicit and scoped to the configuration it affects" {
    $cases=@(
        @{name="cached source";reason="usage_source_cached";scope="all";mutate={param($s) $s.status="cached"}}
        @{name="failed source";reason="usage_source_unavailable";scope="all";mutate={param($s) $s.status="error"}}
        @{name="stale retrieval";reason="usage_source_stale";scope="all";mutate={param($s) $s.fetchedAtUtc="2026-01-01"}}
        @{name="stale publication";reason="usage_source_stale";scope="all";mutate={param($s) $s.sourceDate="2026-01-01"}}
        @{name="no usage section";reason="usage_missing";scope="all";mutate={param($s) $s.Remove("usage")}}
        @{name="no usage table";reason="usage_missing";scope="all";mutate={param($s) $s.usage.Remove("models")}}
        @{name="workload id mismatch";reason="usage_workload_mismatch";scope="all";mutate={param($s) $s.usage.workload.id="other-workload"}}
        @{name="blank workload fingerprint";reason="usage_workload_mismatch";scope="all";mutate={param($s) $s.usage.workload.fingerprint=" "}}
        @{name="conflicting release dates";reason="usage_identity_unverified";scope="all";mutate={param($s) $s.releases["one-max"]=@(@{date="2026-08-02";releaseId="one";effort="max"})}}
        @{name="missing row";reason="usage_missing";scope="max";mutate={param($s) $s.usage.models.Remove("one-max")}}
        @{name="row workload fingerprint";reason="usage_workload_mismatch";scope="max";mutate={param($s) $s.usage.models["one-max"].workloadFingerprint="stale"}}
        @{name="parser conflict";reason="usage_conflicting";scope="max";mutate={param($s) $s.usage.models["one-max"]=@{status="invalid";name="One";reasons=@("usage_conflicting")}}}
        @{name="parser workload mismatch";reason="usage_workload_mismatch";scope="max";mutate={param($s) $s.usage.models["one-max"]=@{status="invalid";reasons=@("usage_workload_mismatch")}}}
        @{name="parser invalid counts";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"]=@{status="invalid";reasons=@("usage_counts_invalid")}}}
        @{name="parser invalid without reason";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"]=@{status="invalid"}}}
        @{name="NaN input";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"].inputTokens=[double]::NaN}}
        @{name="infinite input";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"].inputTokens=[double]::PositiveInfinity}}
        @{name="negative input";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"].inputTokens=-5}}
        @{name="zero input";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"].inputTokens=0}}
        @{name="fractional input";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"].inputTokens=1.5}}
        @{name="text input";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"].inputTokens="100"}}
        @{name="null input";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"].inputTokens=$null}}
        @{name="NaN output";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"].outputTokens=[double]::NaN}}
        @{name="negative reasoning";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"].reasoningTokens=-1}}
        @{name="answer plus reasoning differs from output";reason="usage_counts_invalid";scope="max";mutate={param($s) $s.usage.models["one-max"].answerTokens=1}}
        @{name="conflicting identity";reason="usage_identity_unverified";scope="max";mutate={param($s) $s.identities["one-max"].status="conflicting"}}
        @{name="published effort differs";reason="usage_identity_unverified";scope="max";mutate={param($s) $s.identities["one-max"].effort="high"}}
        @{name="blank release id";reason="usage_identity_unverified";scope="max";mutate={param($s) $s.identities["one-max"].releaseId=" "}}
        @{name="no identity";reason="usage_identity_unverified";scope="max";mutate={param($s) $s.identities.Remove("one-max")}}
        @{name="row effort differs";reason="usage_identity_unverified";scope="max";mutate={param($s) $s.usage.models["one-max"].effort="high"}}
        @{name="row release differs";reason="usage_identity_unverified";scope="max";mutate={param($s) $s.usage.models["one-max"].releaseId="two"}}
        @{name="named effort differs";reason="usage_identity_unverified";scope="max";mutate={param($s) $s.usage.models["one-max"].name="One (high)"}}
        @{name="fallback composite";reason="usage_identity_unverified";scope="max";mutate={param($s) $s.usage.models["one-max"].name="One (Max, Default Fallback)"}}
        @{name="combined models";reason="usage_identity_unverified";scope="max";mutate={param($s) $s.usage.models["one-max"].name="One + Two"}}
    )
    foreach ($case in $cases) {
        $source=Usage-Source
        & $case.mutate $source
        $u=Usage-For $source
        $medium=$u.configurations[$usageMedium.configurationId]
        $max=$u.configurations[$usageMax.configurationId]
        Assert-True ($max.status -eq "invalid" -and @($max.reasons).Count -eq 1 -and $max.reasons[0] -eq $case.reason -and
            $null -eq $max.inputTokens -and $null -eq $max.outputTokens) "$($case.name): expected only $($case.reason), got '$(@($max.reasons) -join ',')'"
        if ($case.scope -eq "all") {
            Assert-True ($medium.status -eq "invalid" -and $medium.reasons -contains $case.reason) "$($case.name): source-wide defect left a usable configuration"
        } else {
            Assert-True ($medium.status -eq "valid" -and $medium.inputTokens -eq 1000000) "$($case.name): one configuration's defect invalidated another"
        }
    }
}
Run-Test "Usage evidence never guesses an alias or lets two configurations share one row" {
    $u=Usage-For (Usage-Source) @{one=@{artificialAnalysis=@{medium="one-medium"}}}
    Assert-True ($u.configurations[$usageMedium.configurationId].status -eq "valid" -and
        $u.configurations[$usageMax.configurationId].reasons -contains "usage_alias_not_configured") "A missing max alias borrowed another effort"
    $u=Usage-For (Usage-Source) @{one=@{artificialAnalysis=@{medium="one-medium";max="one-medium"}}}
    Assert-True (@($u.configurations.Values | Where-Object { $_.reasons -contains "usage_alias_ambiguous" }).Count -eq 2) "One row supplied different efforts"
    $u=Usage-For (Usage-Source) @{one=$aliases.one;two=@{artificialAnalysis=@{max="one-max"}}}
    Assert-True ($u.configurations[$usageMax.configurationId].status -eq "invalid" -and
        $u.configurations[$usageMax.configurationId].reasons -contains "usage_alias_ambiguous") "An alias shared across models was accepted"
}
Run-Test "Usage evidence is inert without an enabled measured-cost policy" {
    $absent=$policy.Clone()
    $absent.selectionPolicy=$policy.selectionPolicy.Clone()
    $absent.selectionPolicy.Remove("measuredCost")
    $disabled=$policy.Clone()
    $disabled.selectionPolicy=$policy.selectionPolicy.Clone()
    $disabled.selectionPolicy.measuredCost=@{enabled=$false;workload=$usageWorkload.id;missingUsagePolicy="profile_fallback";description="off"}
    Assert-True ($null -eq (Usage-For (Usage-Source) $aliases $absent)) "Usage produced without a measured-cost policy"
    Assert-True ($null -eq (Usage-For (Usage-Source) $aliases $disabled)) "Usage produced while measured cost is disabled"
}
Run-Test "Benchmark evidence carries captured usage without turning it into a score observation" {
    $current=@{key="orchestrator";effort="medium";context="default"}
    $read={
        param($source,$activePolicy=$policy)
        Get-ProfileBenchmarkEvidence -Profile $current -Configurations @($usageMedium,$usageMax) -Sources @{artificialAnalysisComponents=$source} `
            -Aliases $aliases -Policy $activePolicy -NowUtc $now
    }
    $source=Usage-Source
    $first=& $read $source
    Assert-True ($first.usage.configurations[$usageMax.configurationId].status -eq "valid" -and
        $first.usage.configurations[$usageMax.configurationId].outputTokens -eq 400000) "Evidence did not carry usage"
    $source.usage.models["one-max"].inputTokens=3000000
    $second=& $read $source
    Assert-True ($second.usage.configurations[$usageMax.configurationId].inputTokens -eq 3000000) "Changed usage was not carried"
    Assert-True ((Get-ModelDataFingerprint $first.records) -eq (Get-ModelDataFingerprint $second.records)) "A usage-only change altered the benchmark observations"
    $absent=$policy.Clone()
    $absent.selectionPolicy=$policy.selectionPolicy.Clone()
    $absent.selectionPolicy.Remove("measuredCost")
    Assert-True ($null -eq (& $read $source $absent).usage) "Usage was built without a measured-cost policy"
}
if ($script:Failed) { exit 1 }
