Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"
. (Join-Path $PSScriptRoot "review-task-profiles.ps1")
. (Join-Path $PSScriptRoot "refresh-model-catalog.ps1")
$script:Failed=0
$now=[datetime]"2026-09-23Z"
function Assert-True($Condition,$Message){if(-not $Condition){throw $Message}}
function Run-Test($Name,[scriptblock]$Action){
    try{& $Action;Write-Host "PASS: $Name"}catch{$script:Failed++;Write-Host "FAIL: $Name -- $_";Write-Host $_.ScriptStackTrace}
}
function New-OnboardingFixture {
    @{
        Availability=@{models=@("old");verified=$true;source="fixture help"}
        RuntimeCatalog=@{status="ok";authenticated=$true;fetchedAtUtc="2026-09-23Z";runtimeVersion="fixture";models=@(
            @{id="future-1.0";name="Future 1.0";policyState="enabled";toolCalls=$true;vision=$true;reasoningEffort=$true;
                supportedReasoningEfforts=@("low","high");maxContextTokens=1000000}
        )}
        CapabilityCatalog=@{schemaVersion=2;models=@{old=@{asOf="2026-09-08";capabilitySource="fixture";vision=$null;supportedEfforts=@("low","high");supportedContexts=@("default")}}}
        AliasConfig=@{schemaVersion=2;aliases=@{old=@{artificialAnalysis=@{low="old-low";high="old-high"}}}}
        PricingAliasConfig=@{schemaVersion=1;aliases=@{old="Old"}}
        PricingFetch=@{status="ok";content='<table><tr><th>Model</th><th>Input</th><th>Output</th></tr><tr><td>Old</td><td>$1</td><td>$5</td></tr><tr><td>Future 1.0</td><td>$0.5</td><td>$2.5</td></tr></table>'}
        Sources=@{
            artificialAnalysis=@{status="ok";fetchedAtUtc="2026-09-23Z";models=@{"old-low"=@{codingIndex=80};"future-1-0-low"=@{codingIndex=82}}}
            artificialAnalysisComponents=@{status="ok";fetchedAtUtc="2026-09-23Z";models=@{};identities=@{
                "future-1-0-low"=@{status="verified";releaseId="future-1-0";effort="low"}
                "future-1-0"=@{status="verified";releaseId="future-1-0";effort="high"}
            }}
            liveBench=@{status="ok";fetchedAtUtc="2026-09-23Z";models=@{"future-1.0-high"=@{coding=80}}}
        }
        Policy=(Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json"))
        NowUtc=$now
    }
}
Run-Test "Verified new models are onboarded without family or version allowlists" {
    $f=New-OnboardingFixture;$before=Get-ModelDataFingerprint $f;$r=Resolve-ModelOnboarding @f
    Assert-True ($r.capabilities.models["future-1.0"].supportedEfforts -join "," -eq "low,high") "Explicit efforts lost"
    Assert-True ($r.capabilities.models["future-1.0"].supportedContexts -join "," -eq "default") "Large context limit inferred a tier"
    Assert-True ($r.aliases.aliases["future-1.0"].artificialAnalysis.low -eq "future-1-0-low") "Structured AA mapping missing"
    Assert-True ($r.aliases.aliases["future-1.0"].liveBench.high -eq "future-1.0-high") "Explicit LB effort missing"
    Assert-True ($r.pricingAliases.aliases["future-1.0"] -eq "Future 1.0" -and $r.availability.models -contains "future-1.0") "Price/discovery registration missing"
    Assert-True ((Get-ModelDataFingerprint $f) -eq $before) "Pure resolver mutated inputs"
}
Run-Test "Runtime omissions retain help-listed peers; explicit denials and auto do not" {
    $f=New-OnboardingFixture;$f.RuntimeCatalog.models+=@(
        @{id="old";policyState="disabled"},@{id="auto";policyState="enabled"}
    )
    $r=Resolve-ModelOnboarding @f
    Assert-True ($r.availability.models -notcontains "old" -and $r.availability.models -notcontains "auto") "Disabled/virtual models admitted"
    $f=New-OnboardingFixture;$r=Resolve-ModelOnboarding @f
    Assert-True ($r.availability.models -contains "old") "Missing from runtime treated as unavailable"
    Assert-True ($r.capabilities.models.old.asOf -eq "2026-09-08") "Unverified old facts refreshed"
}
Run-Test "Unauthenticated, stale and failed discovery cannot onboard or refresh" {
    foreach($change in @(
        {param($f)$f.RuntimeCatalog.authenticated=$false},
        {param($f)$f.RuntimeCatalog.fetchedAtUtc="2026-01-01"},
        {param($f)$f.RuntimeCatalog.status="error"}
    )){
        $f=New-OnboardingFixture;&$change $f;$r=Resolve-ModelOnboarding @f
        Assert-True (-not $r.capabilities.models.Contains("future-1.0") -and $r.audit.changes.Count -eq 0) "Untrusted facts accepted"
        Assert-True ($r.audit.diagnostics -match "degraded") "Degradation hidden"
    }
    Run-Test "One runtime-verified model cannot certify the hardcoded fallback list" {
        $f=New-OnboardingFixture;$f.Availability.verified=$false;$f.Availability.source="hardcoded fallback"
        $r=Resolve-ModelOnboarding @f
        Assert-True ($r.availability.verified -and $r.availability.models -contains "future-1.0") "Verified runtime model lost"
        Assert-True ($r.availability.models -notcontains "old") "Unverified fallback became live availability"
    }
    Run-Test "AA auto-mapping rejects contradictory non-reasoning labels" {
        $json=@{models=@(@{slug="one-non-reasoning";name="One (non-reasoning)";release=@{slug="one"};effort=@{slug="high"};lcr=0.8})} | ConvertTo-Json -Depth 10 -Compress
        $html='<script>self.__next_f.push([1,'+(ConvertTo-Json -InputObject $json -Compress)+'])</script>'
        $parsed=ConvertFrom-AAComponentPage $html
        Assert-True ($parsed.identities["one-non-reasoning"].status -eq "conflicting") "Contradictory effort automatically mapped"
    }
}
Run-Test "Missing or malformed effort, tool or context facts block new capabilities" {
    foreach($change in @(
        {param($r)$r.Remove("supportedReasoningEfforts")},
        {param($r)$r.supportedReasoningEfforts=@("imaginary")},
        {param($r)$r.reasoningEffort="true"},
        {param($r)$r.toolCalls=$false},
        {param($r)$r.maxContextTokens="1000000"},
        {param($r)$r.tokenPrices=@{longContext="unknown"}}
    )){
        $f=New-OnboardingFixture;&$change $f.RuntimeCatalog.models[0];$r=Resolve-ModelOnboarding @f
        Assert-True (-not $r.capabilities.models.Contains("future-1.0")) "Incomplete capabilities inferred"
    }
}
Run-Test "Native effort and explicit extended tiers are supported without effort substitution" {
    $f=New-OnboardingFixture;$model=$f.RuntimeCatalog.models[0];$model.reasoningEffort=$false;$model.Remove("supportedReasoningEfforts")
    $model.supportedContextTiers=@("default","long_context")
    $r=Resolve-ModelOnboarding @f
    Assert-True ($r.capabilities.models["future-1.0"].effortMode -eq "unsupported") "Native effort missing"
    Assert-True ($r.capabilities.models["future-1.0"].supportedEfforts -is [array] -and
        $r.capabilities.models["future-1.0"].supportedEfforts.Count -eq 0) "Native capability catalog would serialize null efforts"
    Assert-True ($r.capabilities.models["future-1.0"].supportedContexts -contains "long_context") "Explicit tier lost"
    Assert-True (-not $r.aliases.aliases.Contains("future-1.0")) "High benchmark borrowed for native model"
}
Run-Test "Native and singleton effort capabilities survive persistence and catalog validation" {
    $path=Join-Path ([System.IO.Path]::GetTempPath()) ("onboarding-capabilities-"+[guid]::NewGuid().ToString("N")+".json")
    try{
        foreach($native in @($true,$false)){
            $f=New-OnboardingFixture
            $model=$f.RuntimeCatalog.models[0]
            $model.reasoningEffort=-not $native
            $model.supportedReasoningEfforts=@("high")
            if($native){$model.Remove("supportedReasoningEfforts")}
            $r=Resolve-ModelOnboarding @f
            $r.capabilities | ConvertTo-Json -Depth 15 | Set-Content -LiteralPath $path
            $stored=Get-ModelCapabilitiesCatalog $path
            $efforts=$stored.models["future-1.0"].supportedEfforts
            Assert-True ($efforts -is [array]) "Persisted effort collection is not an array"
            if($native){
                Assert-True ($efforts.Count -eq 0) "Native model gained an effort during persistence"
            }else{
                Assert-True ($efforts.Count -eq 1 -and $efforts[0] -eq "high") "Singleton effort changed during persistence"
            }
        }
    }finally{
        if(Test-Path -LiteralPath $path){Remove-Item -LiteralPath $path}
    }
}
Run-Test "Incomplete revalidation cannot refresh older long-context or vision facts" {
    $f=New-OnboardingFixture
    $f.CapabilityCatalog.models["future-1.0"]=@{asOf="2026-09-01";capabilitySource="prior";vision=$true;visionSource="prior";supportedEfforts=@("low","high");supportedContexts=@("default","long_context")}
    $r=Resolve-ModelOnboarding @f
    Assert-True ($r.capabilities.models["future-1.0"].asOf -eq "2026-09-01") "Partial observation refreshed whole record"
    $f.RuntimeCatalog.models[0].tokenPrices=@{longContext=@{maxPromptTokens=900000}}
    $r=Resolve-ModelOnboarding @f
    Assert-True ($r.capabilities.models["future-1.0"].asOf -eq "2026-09-23Z") "Fully reverified facts did not refresh"
    $f.RuntimeCatalog.models[0].Remove("vision");$r=Resolve-ModelOnboarding @f
    Assert-True ($r.capabilities.models["future-1.0"].asOf -eq "2026-09-01") "Missing vision became newly verified"
}
Run-Test "Ambiguous benchmark identities and unspecified efforts remain unmapped" {
    $f=New-OnboardingFixture
    $f.Sources.artificialAnalysisComponents.identities["another-low"]=@{status="verified";releaseId="future-1-0";effort="low"}
    $f.Sources.liveBench.models=@{"future-1.0"=@{coding=99}}
    $r=Resolve-ModelOnboarding @f
    Assert-True (-not $r.aliases.aliases["future-1.0"].artificialAnalysis.Contains("low")) "Ambiguous effort guessed"
    Assert-True (-not $r.aliases.aliases["future-1.0"].Contains("liveBench")) "Unspecified effort guessed"
    Assert-True ($r.audit.unmappedBenchmarkVariants.Count -eq 1) "Unmapped discovery vanished"
}
Run-Test "Cached or composite benchmark metadata cannot create aliases" {
    $f=New-OnboardingFixture;$f.Sources.artificialAnalysisComponents.status="cached";$f.Sources.liveBench.status="cached"
    $r=Resolve-ModelOnboarding @f
    Assert-True (-not $r.aliases.aliases.Contains("future-1.0")) "Cached aliases automatically verified"
    $f=New-OnboardingFixture
    foreach($identity in $f.Sources.artificialAnalysisComponents.identities.Values){$identity.status="blocked"}
    $r=Resolve-ModelOnboarding @f
    Assert-True (-not $r.aliases.aliases["future-1.0"].Contains("artificialAnalysis")) "Composite benchmark admitted"
}
Run-Test "Conflicting price identity does not overwrite an existing alias" {
    $f=New-OnboardingFixture;$f.PricingAliasConfig.aliases["future-1.0"]="Another product"
    $r=Resolve-ModelOnboarding @f
    Assert-True ($r.pricingAliases.aliases["future-1.0"] -eq "Another product") "Price identity overwritten"
    Assert-True (($r.audit.models | Where-Object model -eq "future-1.0").reasons -match "pricing_identity") "Conflict hidden"
}
Run-Test "Duplicate runtime and normalized model identities cannot silently resolve" {
    $f=New-OnboardingFixture;$f.RuntimeCatalog.models+=@($f.RuntimeCatalog.models[0].Clone())
    $r=Resolve-ModelOnboarding @f
    Assert-True ($r.availability.models -notcontains "future-1.0") "Duplicate runtime identity admitted"
    $f=New-OnboardingFixture;$f.Availability.models+=@("future-1-0")
    $r=Resolve-ModelOnboarding @f
    Assert-True (-not $r.aliases.aliases.Contains("future-1.0")) "Punctuation collision resolved arbitrarily"
}
Run-Test "Existing alias additions are tracked without rewriting an established mapping" {
    $f=New-OnboardingFixture;$f.AliasConfig.aliases["future-1.0"]=@{artificialAnalysis=@{low="manually-verified"}}
    $r=Resolve-ModelOnboarding @f
    Assert-True ($r.aliases.aliases["future-1.0"].artificialAnalysis.low -eq "manually-verified") "Established alias changed"
    Assert-True (@($r.audit.changes | Where-Object { $_.model -eq "future-1.0" -and $_.field -eq "benchmarks" }).Count -eq 1) "Additions not tracked"
}
Run-Test "Published identity changes quarantine onboarded aliases without overwriting their proof" {
    $f=New-OnboardingFixture;$first=Resolve-ModelOnboarding @f
    $f.AliasConfig=$first.aliases
    $f.Sources.artificialAnalysisComponents.identities["future-1-0-low"].releaseId="different-product"
    $second=Resolve-ModelOnboarding @f
    Assert-True ($second.audit.rejectedMappings.Count -eq 1) "Reassigned source identity not detected"
    Assert-True (-not $second.selectionAliases["future-1.0"].artificialAnalysis.Contains("low")) "Reassigned identity supplied a score"
    Assert-True ($second.aliases.aliases["future-1.0"].artificialAnalysis.low -eq "future-1-0-low") "Stored mapping silently overwritten"
    Assert-True ($second.aliases.onboardingProofs["future-1.0/artificialAnalysis/low"].releaseId -eq "future-1-0") "Original proof replaced"
    $f.RuntimeCatalog.status="error"
    Assert-True ((Resolve-ModelOnboarding @f).audit.rejectedMappings.Count -eq 1) "Runtime outage revived contradicted identity"
}
Run-Test "Same-run onboarding persists catalogs and enters normal profile qualification" {
    $root=Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    foreach($dir in @("config","data","reports")){New-Item -ItemType Directory (Join-Path $root $dir) -Force | Out-Null}
    try{
        $f=New-OnboardingFixture
        Copy-Item (Join-Path $PSScriptRoot "..\config\model-policy.json") (Join-Path $root "config")
        $f.CapabilityCatalog | ConvertTo-Json -Depth 15 | Set-Content (Join-Path $root "config\model-capabilities.json")
        $f.AliasConfig | ConvertTo-Json -Depth 15 | Set-Content (Join-Path $root "config\model-ranking-aliases.json")
        $f.PricingAliasConfig | ConvertTo-Json -Depth 15 | Set-Content (Join-Path $root "config\model-pricing-aliases.json")
        ConvertTo-Json -InputObject @(@{key="quick";model="old";effort="low";context="default"}) | Set-Content (Join-Path $root "task-profiles.json")
        $review=Invoke-TaskProfileReview -RepoRoot $root -Availability $f.Availability -RuntimeCatalog $f.RuntimeCatalog `
            -Sources $f.Sources -FetchPricing {param($u)$f.PricingFetch} -ForceImmediateApply -NowUtc $now
        Assert-True ($review.results[0].finalModel -eq "future-1.0") "New model did not reach comparison"
        $caps=Get-ModelCapabilitiesCatalog (Join-Path $root "config\model-capabilities.json")
        Assert-True ($caps.models.Contains("future-1.0")) "Verified capabilities not persistent"
        $storedAliases=Read-ModelConfig (Join-Path $root "config\model-ranking-aliases.json") 2
        Assert-True ($storedAliases.onboardingProofs["future-1.0/artificialAnalysis/low"].releaseId -eq "future-1-0") "Identity proof not persistent"
        $audit=Get-Content (Join-Path $root "data\model-onboarding-snapshot.json") -Raw
        $report=Get-Content (Join-Path $root "reports\task-profile-review.md") -Raw
        Assert-True ($audit.Contains("future-1.0") -and $report.Contains("Model discovery and onboarding")) "Audit/report missing"
    }finally{
        foreach($file in @(Get-ChildItem -LiteralPath $root -File -Recurse)){Remove-Item -LiteralPath $file.FullName}
        foreach($dir in @("config","data","reports")){Remove-Item -LiteralPath (Join-Path $root $dir)}
        Remove-Item -LiteralPath $root
    }
}
Run-Test "Discovery export strips credentials/account identity and preserves singleton arrays" {
    $f=New-OnboardingFixture
    $f.RuntimeCatalog.token="secret-marker";$f.RuntimeCatalog.login="account-marker"
    $model=$f.RuntimeCatalog.models[0];$model.secret="secret-marker";$model.supportedReasoningEfforts=@("high")
    $model.supportedContextTiers=@("default");$model.tokenPrices=@{inputPrice=50;token="secret-marker";longContext=@{maxPromptTokens=900000;login="account-marker"}}
    $snapshot=New-ModelDiscoverySnapshot $f.Availability $f.RuntimeCatalog
    $json=$snapshot | ConvertTo-Json -Depth 15
    Assert-True ($json -notmatch "secret-marker|account-marker") "Sensitive fields exported"
    $roundTrip=ConvertFrom-JsonAsHashtableCompat $json
    Assert-True ($roundTrip.runtime.models[0].supportedReasoningEfforts -is [array]) "Singleton effort array flattened"
    Assert-True ((Resolve-ModelDiscoverySnapshot $roundTrip 7 $now).status -eq "valid") "Single-model snapshot invalid"
    $r=Resolve-ModelOnboarding @f
    Assert-True ($r.capabilities.models["future-1.0"].supportedEfforts -join "," -eq "high") "Singleton effort was not onboarded"
    Assert-True ($r.capabilities.models["future-1.0"].supportedEfforts -is [array]) "Singleton capability catalog would serialize a scalar effort"
    $model.vision=@{token="secret-marker"};$model.tokenPrices.inputPrice=@{token="secret-marker"}
    $model.supportedContextTiers=@(@{token="secret-marker"});$f.RuntimeCatalog.runtimeVersion=@{token="secret-marker"}
    $json=(New-ModelDiscoverySnapshot $f.Availability $f.RuntimeCatalog) | ConvertTo-Json -Depth 15
    Assert-True ($json -notmatch "secret-marker|account-marker") "Nested unexpected values bypassed export allowlist"
}
Run-Test "Discovery validity is inclusive at seven days and cannot be renewed by the envelope" {
    $f=New-OnboardingFixture;$snapshot=New-ModelDiscoverySnapshot $f.Availability $f.RuntimeCatalog
    Assert-True ((Resolve-ModelDiscoverySnapshot $snapshot 7 $now.AddDays(7)).status -eq "valid") "Exact expiry boundary rejected"
    Assert-True ((Resolve-ModelDiscoverySnapshot $snapshot 7 $now.AddDays(7).AddSeconds(1)).status -eq "expired") "Expired snapshot accepted"
    $snapshot.observedAtUtc=$now.AddDays(7).ToString("o")
    Assert-True ((Resolve-ModelDiscoverySnapshot $snapshot 7 $now.AddDays(7)).status -eq "invalid") "Envelope date laundered observation age"
}
Run-Test "Malformed, future, unauthenticated and duplicate discovery snapshots fail closed" {
    foreach($change in @(
        {param($s)$s.schemaVersion=99},
        {param($s)$s.runtime.authenticated=$false},
        {param($s)$s.runtime.models="not-an-array"},
        {param($s)$s.runtime.models+=@($s.runtime.models[0])},
        {param($s)$s.availability.models="old"},
        {param($s)$s.observedAtUtc="invalid"},
        {param($s)$s.observedAtUtc="9999-01-01";$s.runtime.fetchedAtUtc="9999-01-01"}
    )){
        $f=New-OnboardingFixture;$s=New-ModelDiscoverySnapshot $f.Availability $f.RuntimeCatalog;&$change $s
        $r=Resolve-ModelDiscoverySnapshot $s 7 $now
        Assert-True ($r.status -eq "invalid" -and -not $r.availability.verified -and $r.availability.models.Count -eq 0) "Invalid snapshot authorized models"
    }
}
Run-Test "Local refresh and remote review use a sanitized persistent snapshot without remote authentication" {
    $root=Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    foreach($dir in @("config","data","reports")){New-Item -ItemType Directory (Join-Path $root $dir) -Force | Out-Null}
    try{
        $f=New-OnboardingFixture
        Copy-Item (Join-Path $PSScriptRoot "..\config\model-policy.json") (Join-Path $root "config")
        $f.CapabilityCatalog | ConvertTo-Json -Depth 15 | Set-Content (Join-Path $root "config\model-capabilities.json")
        $f.AliasConfig | ConvertTo-Json -Depth 15 | Set-Content (Join-Path $root "config\model-ranking-aliases.json")
        $f.PricingAliasConfig | ConvertTo-Json -Depth 15 | Set-Content (Join-Path $root "config\model-pricing-aliases.json")
        ConvertTo-Json -InputObject @(@{key="quick";model="old";effort="low";context="default"}) | Set-Content (Join-Path $root "task-profiles.json")
        $path=Join-Path $root "data\model-discovery-snapshot.json"
        Update-LocalModelDiscovery -RepoRoot $root -RuntimeProbe {$f.RuntimeCatalog} -HelpProbe {$f.Availability} -NowUtc $now | Out-Null
        $before=Get-Content $path -Raw
        $failed=$false
        try{
            Update-LocalModelDiscovery -RepoRoot $root -RuntimeProbe {@{status="error";authenticated=$false;models=@();message="fixture outage"}} `
                -HelpProbe {$f.Availability} -NowUtc $now | Out-Null
        }catch{$failed=$true}
        Assert-True ($failed -and (Get-Content $path -Raw) -ceq $before) "Failed refresh replaced good snapshot"
        function Get-RuntimeModelCatalog {throw "Remote review must not authenticate"}
        function Get-ModelAvailability {throw "Remote review must not discover accounts"}
        foreach($days in @(1,2)){
            $r=Invoke-TaskProfileReview -RepoRoot $root -Sources $f.Sources -FetchPricing {param($u)$f.PricingFetch} -ForceImmediateApply -NowUtc $now.AddDays($days)
            Assert-True ($r.results[0].finalModel -eq "future-1.0") "Committed local metadata not used"
            $caps=Get-ModelCapabilitiesCatalog (Join-Path $root "config\model-capabilities.json")
            Assert-True ($caps.models["future-1.0"].asOf -eq "2026-09-23Z") "Remote review renewed capability age"
            Assert-True ((Get-Content $path -Raw) -ceq $before) "Review rewrote local observation"
        }
        $f.Sources.artificialAnalysis.models["old-low"].codingIndex=100
        $r=Invoke-TaskProfileReview -RepoRoot $root -Sources $f.Sources -FetchPricing {param($u)$f.PricingFetch} -ForceImmediateApply -NowUtc $now.AddDays(7).AddSeconds(1)
        Assert-True (-not $r.results[0].resolution.applied -and $r.onboarding.discoverySnapshot.status -eq "expired") "Force bypassed expiry"
        foreach($json in @("{broken","", "null")){
            Set-Content $path $json
            $r=Invoke-TaskProfileReview -RepoRoot $root -Sources $f.Sources -FetchPricing {param($u)$f.PricingFetch} -ForceImmediateApply -NowUtc $now
            Assert-True (-not $r.results[0].resolution.applied -and $r.onboarding.discoverySnapshot.status -eq "invalid") "Malformed snapshot authorized changes"
        }
        Remove-Item -LiteralPath $path
        $r=Invoke-TaskProfileReview -RepoRoot $root -Sources $f.Sources -FetchPricing {param($u)$f.PricingFetch} -ForceImmediateApply -NowUtc $now
        Assert-True (-not $r.results[0].resolution.applied -and $r.onboarding.discoverySnapshot.status -eq "missing") "Missing snapshot authorized changes"
        $report=Get-Content (Join-Path $root "reports\task-profile-review.md") -Raw
        Assert-True ($report.Contains("not live-verified") -and $report.Contains("7 days")) "Recorded availability presented as live"
    }finally{
        foreach($file in @(Get-ChildItem -LiteralPath $root -File -Recurse)){Remove-Item -LiteralPath $file.FullName}
        foreach($dir in @("config","data","reports")){Remove-Item -LiteralPath (Join-Path $root $dir)}
        Remove-Item -LiteralPath $root
    }
}
& node --test (Join-Path $PSScriptRoot "test-runtime-models.mjs")
if($LASTEXITCODE -ne 0){$script:Failed++}
if($script:Failed){exit 1}
