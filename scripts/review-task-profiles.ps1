Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-data-common.ps1")
. (Join-Path $PSScriptRoot "model-artificial-analysis.ps1")
. (Join-Path $PSScriptRoot "model-livebench.ps1")
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
. (Join-Path $PSScriptRoot "model-availability.ps1")
. (Join-Path $PSScriptRoot "model-admissibility.ps1")
. (Join-Path $PSScriptRoot "model-pricing-data.ps1")
. (Join-Path $PSScriptRoot "model-benchmark-evidence.ps1")
. (Join-Path $PSScriptRoot "model-profile-selection.ps1")
. (Join-Path $PSScriptRoot "model-selection-policy.ps1")
. (Join-Path $PSScriptRoot "model-review-report.ps1")

function Invoke-TaskProfileReview {
    param(
        [string]$RepoRoot = (Split-Path $PSScriptRoot -Parent),
        $Availability = $null,
        [hashtable]$Sources = $null,
        [scriptblock]$FetchPricing = { param($url) Invoke-TextFetch -Url $url },
        [switch]$ForceImmediateApply = ([string]$env:FORCE_BENCHMARK_CONSENSUS -match '^(?i:true|1)$'),
        [datetime]$NowUtc = [datetime]::UtcNow
    )
    $policy = Get-ModelPolicyConfig (Join-Path $RepoRoot "config\model-policy.json")
    $capabilities = (Get-ModelCapabilitiesCatalog (Join-Path $RepoRoot "config\model-capabilities.json")).models
    $aliasConfig = Read-ModelConfig (Join-Path $RepoRoot "config\model-ranking-aliases.json") 2
    $aliases = $aliasConfig.aliases
    if ($aliases -isnot [System.Collections.IDictionary]) { throw "Invalid benchmark aliases." }
    foreach ($id in $aliases.Keys) {
        foreach ($source in $aliases[$id].Keys) {
            if ($source -notin @("artificialAnalysis", "artificialAnalysisCodingAgents", "liveBench") -or
                $aliases[$id][$source] -isnot [System.Collections.IDictionary]) {
                throw "Invalid variant mapping: $id.$source"
            }
            foreach ($effort in $aliases[$id][$source].Keys) {
                if ($effort -notin @("none","minimal","low","medium","high","xhigh","max") -or $aliases[$id][$source][$effort] -isnot [string] -or
                    [string]::IsNullOrWhiteSpace($aliases[$id][$source][$effort])) {
                    throw "Invalid variant identity: $id.$source.$effort"
                }
            }
        }
    }
    $profilesPath = Join-Path $RepoRoot "task-profiles.json"
    $profiles = @(Get-Content -LiteralPath $profilesPath -Raw | ConvertFrom-Json)
    foreach ($profile in $profiles) {
        if (-not $policy.profileRequirements.Contains($profile.key) -or [string]::IsNullOrWhiteSpace($profile.model)) {
            throw "Invalid task profile: $($profile.key)"
        }
    }
    if ($null -eq $Availability) {
        $Availability = Get-ModelAvailability -Denylist $policy.denylist
    }
    $models = @($Availability.models | Sort-Object -Unique)
    $pricingAliases = (Read-ModelConfig (Join-Path $RepoRoot "config\model-pricing-aliases.json") 1).aliases
    $pricingOptions = @{
        SnapshotPath = Join-Path $RepoRoot "data\model-pricing-snapshot.json"
        Aliases = $pricingAliases
        FetchText = $FetchPricing
        NowUtc = $NowUtc
    }
    $pricing = Update-ModelPricingSnapshot @pricingOptions
    $snapshotPath = Join-Path $RepoRoot "data\model-ranking-snapshot.json"
    $previous = @{}
    if (Test-Path -LiteralPath $snapshotPath) {
        $previous = ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $snapshotPath -Raw)
    }
    if ($null -eq $Sources) {
        $Sources = @{
            artificialAnalysis = Get-ArtificialAnalysisIntelligenceIndexData
            artificialAnalysisCodingAgents = Get-ArtificialAnalysisCodingAgentIndexData
            liveBench = Get-LiveBenchData
        }
    }
    # Fetch timestamps are later than the run's start time.
    if (-not $PSBoundParameters.ContainsKey("NowUtc")) { $NowUtc = [datetime]::UtcNow }
    $resolvedSources = @{}
    $sourceDiagnostics = [System.Collections.Generic.List[string]]::new()
    foreach ($source in @("artificialAnalysis", "artificialAnalysisCodingAgents", "liveBench")) {
        $current = $Sources[$source]
        if ((Get-ObjectMemberValue $current "status") -eq "ok") {
            $resolvedSources[$source] = $current
            continue
        }
        $sourceDiagnostics.Add("${source}: $((Get-ObjectMemberValue $current 'message'))")
        $cached = Get-ObjectMemberValue (Get-ObjectMemberValue $previous "sources") $source
        if ($null -ne $cached -and (Get-ObjectMemberValue $cached "status") -in @("ok", "cached")) {
            $cached = ConvertTo-CanonicalModelData $cached
            $cached.status = "cached"
            $resolvedSources[$source] = $cached
        } else {
            $resolvedSources[$source] = $current
        }
    }
    $snapshot = [ordered]@{
        schemaVersion = 3
        generatedAtUtc = $NowUtc.ToUniversalTime().ToString("o")
        sources = $resolvedSources
        consensus = @{ profiles = @{} }
    }
    $results = [System.Collections.Generic.List[object]]::new()
    $changed = $false
    foreach ($profile in $profiles) {
        $requirement = $policy.profileRequirements[$profile.key]
        $candidates = Get-ProfileModelConfigurations -Profile $profile -Models $models -Capabilities $capabilities -Policy $policy
        $currentConfiguration = New-ModelConfiguration -Model $profile.model -Effort $profile.effort -Context $profile.context -CapabilityRecord $capabilities[$profile.model]
        $verdictConfigurations = @(@($candidates.configurations) + @($currentConfiguration) | Sort-Object -Property model,effort,context -Unique)
        $verdicts = @(foreach ($configuration in $verdictConfigurations) {
            $model = $configuration.model
            $priceRecord = $pricing.snapshot.models[$model]
            if (-not $pricingAliases.Contains($model) -or
                (Get-ObjectMemberValue $priceRecord "name") -ne $pricingAliases[$model]) {
                $priceRecord = $null
            }
            $admissibilityOptions = @{
                ModelId = $model
                ProfileKey = $profile.key
                AvailabilityVerified = $Availability.verified
                AvailableModels = $models
                Denylist = $policy.denylist
                CapabilityRecord = $capabilities[$model]
                PricingRecord = $priceRecord
                ProfileRequirement = $requirement
                ProfileContextTier = $configuration.context
                ProfileEffort = $configuration.effort
                CapabilityFreshnessDays = $policy.consensusPolicy.capabilityFreshnessDays
                PricingFreshnessDays = $policy.consensusPolicy.pricingFreshnessDays
                NowUtc = $NowUtc
            }
            Get-ModelAdmissibilityVerdict @admissibilityOptions
        })
        $evidence = Get-ProfileBenchmarkEvidence -Profile $profile -Configurations $candidates.configurations -Sources $resolvedSources `
            -Aliases $aliases -Capabilities $capabilities -Policy $policy -NowUtc $NowUtc
        $evidence.diagnostics = @($candidates.diagnostics) + @($evidence.diagnostics)
        $selection = Get-ProfileSelection -Profile $profile -Evidence $evidence.records -Verdicts $verdicts -Policy $policy -Aliases $aliases
        $oldProfiles = Get-ObjectMemberValue (Get-ObjectMemberValue $previous "consensus") "profiles"
        $oldState = Get-ObjectMemberValue $oldProfiles $profile.key
        $resolved = Resolve-ProfileSelectionState -CurrentModel $profile.model -Selection $selection `
            -State $oldState -ForceImmediateApply:$ForceImmediateApply -NowUtc $NowUtc
        $currentVerdict = @($verdicts | Where-Object {
            $_.modelId -eq $profile.model -and $_.effort -eq $currentConfiguration.effort -and $_.context -eq $currentConfiguration.context
        })[0]
        if (-not $resolved.applied -and @($currentVerdict.reasonCodes | Where-Object {$_ -in @("pricing_input_exceeds_ceiling","pricing_output_exceeds_ceiling")}).Count) {
            $resolved.status = "over_budget_retention; $($resolved.status)"
        }
        if (-not $Availability.verified) { $resolved.status = "retained_unverified_availability" }
        $fallback = Get-PreferredModelForProfilePolicy -ProfileKey $profile.key -ValidModels $models `
            -Policy $policy -AdmissibleModels @($verdicts | Where-Object admissible | ForEach-Object modelId | Sort-Object -Unique)
        $results.Add([pscustomobject]@{
            key = $profile.key
            currentModel = $profile.model
            finalModel = $resolved.finalModel
            currentConfiguration = $currentConfiguration
            finalConfiguration = $resolved.finalConfiguration
            effort = $profile.effort
            context = $profile.context
            selection = $selection
            resolution = $resolved
            evidence = $evidence
            verdicts = $verdicts
            requirement = $requirement
            fallback = $fallback
        })
        if ($resolved.applied) {
            $profile.model = $resolved.finalConfiguration.model
            if ($resolved.finalConfiguration.effort -ne "none") { $profile.effort = $resolved.finalConfiguration.effort }
            $profile.context = $resolved.finalConfiguration.context
            $changed = $true
        }
        $snapshot.consensus.profiles[$profile.key] = $resolved.state
    }
    $reportOptions = @{
        Results = @($results)
        Pricing = $pricing
        Sources = $resolvedSources
        SourceDiagnostics = @($sourceDiagnostics)
        Policy = $policy
        Availability = $Availability
        NowUtc = $NowUtc
        Forced = [bool]$ForceImmediateApply
    }
    $lines = Get-TaskProfileReviewReport @reportOptions
    Write-ModelJsonAtomic -SnapshotPath $snapshotPath -SnapshotObject $snapshot
    if ($changed) { Write-ModelJsonAtomic -SnapshotPath $profilesPath -SnapshotObject $profiles }
    $reportPath = Join-Path $RepoRoot "reports\task-profile-review.md"
    $reportDirectory = Split-Path $reportPath -Parent
    if (-not (Test-Path $reportDirectory)) { New-Item -ItemType Directory $reportDirectory -Force | Out-Null }
    Set-Content -LiteralPath $reportPath -Value ($lines -join "`n") -Encoding utf8
    Write-Host "Updated pricing, ranking snapshot and $reportPath"
    return [pscustomobject]@{
        results = @($results)
        pricing = $pricing
        snapshot = $snapshot
    }
}

if ($MyInvocation.InvocationName -ne '.') { Invoke-TaskProfileReview | Out-Null }
