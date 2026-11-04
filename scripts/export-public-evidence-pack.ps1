param(
    [Parameter(Mandatory)][string]$BaselinePath,
    [Parameter(Mandatory)][string]$SourcePacketPath,
    [Parameter(Mandatory)][string]$OutputPath,
    [datetime]$AsOfUtc = [datetime]::UtcNow,
    [string]$SupplementalPacketPath,
    [string]$BankingUnitProofPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
. (Join-Path $PSScriptRoot "model-benchmark-evidence.ps1")
. (Join-Path $PSScriptRoot "model-aa-components.ps1")
. (Join-Path $PSScriptRoot "model-tau-banking-data.ps1")

$repoRoot = Split-Path $PSScriptRoot -Parent
$baseline = Read-ModelConfig $BaselinePath 1
$packet = Read-ModelConfig $SourcePacketPath 1
$policy = Get-ModelPolicyConfig (Join-Path $repoRoot "config\model-policy.json")
$aliases = Read-ModelConfig (Join-Path $repoRoot "config\model-ranking-aliases.json") 2
$capabilities = Read-ModelConfig (Join-Path $repoRoot "config\model-capabilities.json") 2
$sources = Get-ObjectMemberValue $packet "resolvedSources"
if ($sources -isnot [System.Collections.IDictionary]) { throw "Source packet requires resolvedSources." }
if ($baseline.policyVersion -ne $policy.selectionPolicy.version -or
    $baseline.profiles.Count -ne $script:KnownTaskProfileKeys.Count -or
    @($baseline.profiles.profile | Sort-Object -Unique).Count -ne $script:KnownTaskProfileKeys.Count -or
    @($baseline.profiles.profile | Where-Object { $_ -notin $script:KnownTaskProfileKeys }).Count) {
    throw "Baseline must describe all nine profiles under the unchanged selection policy."
}
if ((Get-ObjectMemberValue $baseline "discoveryStatus") -ne "valid" -or
    -not (Test-ModelDataFresh $baseline.discoveryObservedAtUtc $policy.consensusPolicy.discoveryFreshnessDays $AsOfUtc)) {
    throw "Baseline discovery is stale or invalid; frozen eligibility cannot be presented as current."
}
$inputPaths = @(
    "task-profiles.json", "config\model-policy.json", "config\model-capabilities.json",
    "config\model-ranking-aliases.json", "config\model-pricing-aliases.json",
    "data\model-discovery-snapshot.json", "data\model-pricing-snapshot.json", "data\model-ranking-snapshot.json"
)
if ($baseline.inputs.Count -ne $inputPaths.Count) { throw "Baseline requires eight input fingerprints." }
foreach ($relativePath in $inputPaths) {
    $expected = @($baseline.inputs | Where-Object path -CEQ $relativePath)
    $hash = (Get-FileHash -LiteralPath (Join-Path $repoRoot $relativePath) -Algorithm SHA256).Hash
    if ($expected.Count -ne 1 -or $hash -ine $expected[0].sha256) {
        throw "Baseline input differs: $relativePath"
    }
}
if (Test-Path -LiteralPath $OutputPath) { throw "Refusing to overwrite an existing evidence pack: $OutputPath" }

$captureRoot = Split-Path (Get-Item -LiteralPath $SourcePacketPath).FullName -Parent
foreach ($capture in $packet.captures) {
    if ([IO.Path]::GetFileName($capture.savedFile) -cne $capture.savedFile) {
        throw "Capture paths must be filenames relative to the source packet."
    }
    $hash = (Get-FileHash -LiteralPath (Join-Path $captureRoot $capture.savedFile) -Algorithm SHA256).Hash
    if ($hash -ine $capture.sha256) { throw "Capture hash differs: $($capture.savedFile)" }
}
$componentCapture = @($packet.captures | Where-Object url -CEQ $sources.artificialAnalysisComponents.sourceUrl)
if ($componentCapture.Count -ne 1) { throw "Source packet requires one matching AA component capture." }
$capture = $componentCapture[0]
$html = Get-Content -LiteralPath (Join-Path $captureRoot $capture.savedFile) -Raw
$fetch = { param($url) @{status="ok";content=$html} }
$anchor = ([uri]$capture.url).Segments[-1]
$original = Get-AAComponentData -ModelSlugs @($anchor) -FetchText $fetch
if ($original.status -ne "ok" -or $original.sourceVersion -ne $sources.artificialAnalysisComponents.sourceVersion) {
    throw "Captured page does not reproduce its original component observation."
}
$expanded = Get-AAComponentData -ModelSlugs @($anchor) -FetchText $fetch -IncludeVersionedBenchmarks
if ($expanded.status -ne "ok") { throw $expanded.message }
$expanded.fetchedAtUtc = $capture.capturedAtUtc
$sources.artificialAnalysisComponents = ConvertTo-CanonicalModelData $expanded
$newDefinitions = @{}
foreach ($metric in $expanded.metricDefinitions.Keys) {
    $newDefinitions["artificialAnalysisComponents.$metric"] = $expanded.metricDefinitions[$metric]
}
$evidenceAliases = ConvertTo-CanonicalModelData $aliases.aliases
$supplemental = $null
$lineageCandidates = 0
if (-not [string]::IsNullOrWhiteSpace($BankingUnitProofPath) -and [string]::IsNullOrWhiteSpace($SupplementalPacketPath)) {
    throw "Banking unit proof requires a supplemental submission packet."
}
if (-not [string]::IsNullOrWhiteSpace($SupplementalPacketPath)) {
    $reference = ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $SupplementalPacketPath -Raw)
    if ($reference.packetType -ne "tau-bench-banking-admission-data" -or $reference.dataOnly -ne $true -or
        $reference.notRouteOrBandApproval -ne $true -or
        $reference.baseline.sha256 -ine (Get-FileHash -LiteralPath $BaselinePath -Algorithm SHA256).Hash) {
        throw "Supplemental packet must be data-only and match the pinned baseline."
    }
    $documents = @(foreach ($submission in $reference.submissions) {
        $source = $submission.source
        if ($source.url -notmatch '^https://' -or
            -not (Test-ModelDataFresh $source.retrievedAtUtc ([int]::MaxValue) $AsOfUtc)) {
            throw "Supplemental submissions require a source URL and original retrieval timestamp."
        }
        if ((Get-FileHash -LiteralPath $source.path -Algorithm SHA256).Hash -ine $source.sha256) {
            throw "Supplemental submission hash differs: $($source.path)"
        }
        [ordered]@{
            source=$source;model=$submission.model
            publicationDate=(Get-ObjectMemberValue (Get-ObjectMemberValue $submission "dates") "publicationDate")
            document=ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $source.path -Raw)
        }
    })
    $coverage = @(foreach ($profile in $baseline.profiles) {
        $matched = @($reference.submissions | Where-Object {
            $model = $_.model.canonical
            $effort = $_.model.explicitEffort
            @($profile.eligibleConfigurations | Where-Object { $_.model -ceq $model -and $_.effort -ceq $effort }).Count
        })
        [ordered]@{
            profile=$profile.profile;context=$profile.context
            distinctModels=@($matched | ForEach-Object { $_.model.canonical } | Sort-Object -Unique).Count
            configurations=@($matched | ForEach-Object { @{model=$_.model.canonical;effort=$_.model.explicitEffort;context=$profile.context} })
            scoreAdmission=$false;selectionActive=$false
        }
    })
    if ($reference.independenceLineage.benchmarkLineageIndependent -eq $true -and
        @($coverage | Where-Object { $_.distinctModels -ge 2 }).Count) { $lineageCandidates = 1 }
    $supplemental = [ordered]@{
        status="reference_only_units_unverified"
        packetSha256=(Get-FileHash -LiteralPath $SupplementalPacketPath -Algorithm SHA256).Hash
        admissionPacket=$reference;originalSubmissions=$documents;eligibleConfigurationCoverage=$coverage
        limitation="Raw published values retained without conversion. Native units/range are unverified, so these scores are not admitted to numeric comparisons or selection."
    }
    if (-not [string]::IsNullOrWhiteSpace($BankingUnitProofPath)) {
        $proof = Read-ModelConfig $BankingUnitProofPath 1
        if ($proof.benchmarkVersion -ne "1.0.1" -or $proof.referenceRevision -cnotmatch '^[a-f0-9]{40}$' -or
            $proof.captures.Count -ne 2) { throw "Invalid Banking unit-proof provenance." }
        $proofPaths = @{schema="web/leaderboard/public/submissions/schema.json";producer="src/tau2/scripts/leaderboard/submission.py"}
        foreach ($role in $proofPaths.Keys) {
            $captureForRole = @($proof.captures | Where-Object role -CEQ $role)
            if ($captureForRole.Count -ne 1) { throw "Banking unit proof requires one $role capture." }
            $unitCapture = $captureForRole[0]
            $expectedUrl = "https://raw.githubusercontent.com/sierra-research/tau2-bench/$($proof.referenceRevision)/$($proofPaths[$role])"
            if ($unitCapture.url -cne $expectedUrl -or
                -not (Test-ModelDataFresh $unitCapture.retrievedAtUtc ([int]::MaxValue) $AsOfUtc) -or
                (Get-FileHash -LiteralPath $unitCapture.path -Algorithm SHA256).Hash -ine $unitCapture.sha256) {
                throw "Banking unit-proof capture provenance/hash differs: $role"
            }
        }
        $schemaCapture = @($proof.captures | Where-Object role -CEQ "schema")[0]
        $normalized = ConvertFrom-TauBankingSubmissions -Documents $documents `
            -Schema (ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $schemaCapture.path -Raw)) `
            -SchemaSource $schemaCapture -ReferenceRevision $proof.referenceRevision `
            -EligibleConfigurations @($baseline.profiles | ForEach-Object eligibleConfigurations) -Capabilities $capabilities.models
        $sources.tauBenchBanking = $normalized.source
        foreach ($model in $normalized.aliases.Keys) {
            if (-not $evidenceAliases.Contains($model)) { $evidenceAliases[$model] = @{} }
            $evidenceAliases[$model]["tauBenchBanking"] = $normalized.aliases[$model]
        }
        foreach ($metric in $normalized.metricDefinitions.Keys) {
            $newDefinitions["tauBenchBanking.$metric"] = $normalized.metricDefinitions[$metric]
        }
        $supplemental.status = "admitted_data_only"
        $supplemental.unitProof = $proof
        $supplemental.unitProofSha256 = (Get-FileHash -LiteralPath $BankingUnitProofPath -Algorithm SHA256).Hash
        $supplemental.limitation = "Native pass^1 percentages normalized without conversion; inactive metrics only. Declared standard self-submissions, not independent replication or proof of CLI context. Publication dates remain unknown."
        foreach ($row in $coverage) { $row.scoreAdmission = $true }
    }
}
$dataOnlyPolicy = @{
    consensusPolicy=$policy.consensusPolicy
    evidenceMetrics=$newDefinitions
    selectionPolicy=@{profiles=@{
        "public-evidence-only"=@{evidenceRoutes=@();qualification=@{dimensions=@()};supportingMetrics=@($newDefinitions.Keys)}
    }}
}
$profiles = @(foreach ($profile in $baseline.profiles) {
    $configurations = @($profile.eligibleConfigurations | ForEach-Object {
        New-ModelConfiguration -Model $_.model -Effort $_.effort -Context $_.context
    })
    $evidence = Get-ProfileBenchmarkEvidence -Profile @{key=$profile.profile;context=$profile.context} `
        -Configurations $configurations -Sources $sources -Aliases $evidenceAliases `
        -Capabilities $capabilities.models -Policy $policy -NowUtc $AsOfUtc
    $contract = $policy.selectionPolicy.profiles[$profile.profile]
    $dimensions = @(@{key="primary";evidenceRoutes=$contract.evidenceRoutes}) + @($contract.qualification.dimensions)
    $intersection = @($configurations.configurationId)
    $coverage = @(foreach ($dimension in $dimensions) {
        $pool = Get-MetricEvidencePool -Routes $dimension.evidenceRoutes -Definitions $policy.evidenceMetrics `
            -Eligible $evidence.records -MinimumModels 2
        $poolIds = @($pool.pool | ForEach-Object configurationId)
        $intersection = @($intersection | Where-Object { $_ -in $poolIds })
        [ordered]@{
            dimension=$dimension.key;metric=(Get-ObjectMemberValue $pool "metricKey")
            distinctModels=@($pool.pool | ForEach-Object model | Sort-Object -Unique).Count
            configurations=$pool.pool.Count
            cached=$(if ($pool.pool.Count) { $pool.pool[0].cached } else { $null })
            publicationDateUnknown=@($pool.pool | Where-Object publicationAgeUnknown).Count
            publicationFreshConfigurations=@($pool.pool | Where-Object { -not $_.publicationAgeUnknown }).Count
            diagnostics=$pool.diagnostics
        }
    })
    $baselineDimensions = @(Get-ObjectMemberValue $profile "dimensions" | Where-Object { $null -ne $_ })
    $baselineIntersection = @($configurations.configurationId)
    foreach ($dimension in $baselineDimensions) {
        $selected = @($dimension.routes | Where-Object metric -EQ $dimension.selectedMetric)
        $ids = @($selected | ForEach-Object {
            $_.configurations | ForEach-Object {
                (New-ModelConfiguration -Model $_.model -Effort $_.effort -Context $_.context).configurationId
            }
        })
        $baselineIntersection = @($baselineIntersection | Where-Object { $_ -in $ids })
    }
    $additional = Get-ProfileBenchmarkEvidence -Profile @{key="public-evidence-only";context=$profile.context} `
        -Configurations $configurations -Sources $sources -Aliases $evidenceAliases `
        -Capabilities $capabilities.models -Policy $dataOnlyPolicy -NowUtc $AsOfUtc
    $additionalPools = @(foreach ($metricKey in @($newDefinitions.Keys | Sort-Object)) {
        $records = @($additional.records | Where-Object metricKey -EQ $metricKey)
        $pool = Get-MetricEvidencePool -Routes @($metricKey) -Definitions $newDefinitions -Eligible $records -MinimumModels 2
        [ordered]@{
            metric=$metricKey;distinctModels=@($records | ForEach-Object model | Sort-Object -Unique).Count
            configurations=$records.Count;selectionActive=$false
            comparableCohort=$pool.pool.Count -gt 0;comparisonDiagnostics=$pool.diagnostics
            publicationFreshConfigurations=@($records | Where-Object { -not $_.publicationAgeUnknown }).Count
        }
    })
    [ordered]@{
        profile=$profile.profile;incumbent=$profile.incumbent
        eligibleConfigurations=$profile.eligibleConfigurations
        existingRouteCoverage=$coverage
        baselineMeasuredIntersectionCount=$(if ($baselineDimensions.Count) { $baselineIntersection.Count } else { $null })
        measuredIntersection=@($configurations | Where-Object configurationId -In $intersection)
        incumbentCompletelyMeasured=$profile.incumbent.configurationId -in $intersection
        inactiveAdditionalCoverage=$additionalPools
        records=@($evidence.records);inactiveAdditionalRecords=@($additional.records)
        diagnostics=@($evidence.diagnostics) + @($additional.diagnostics)
    }
})
$measuredProfiles = @($profiles | Where-Object { $_.measuredIntersection.Count -gt 0 }).Count
$incumbentProfiles = @($profiles | Where-Object incumbentCompletelyMeasured).Count
$additionalCohorts = @()
if ($null -ne $supplemental -and $supplemental.status -eq "admitted_data_only") {
    $additionalCohorts = @($profiles.inactiveAdditionalCoverage | Where-Object {
        $_.metric -eq "tauBenchBanking.pass1" -and $_.comparableCohort
    } | ForEach-Object { $newDefinitions[$_.metric].benchmarkId } | Sort-Object -Unique)
}
$additionalIndependent = @($additionalCohorts | Where-Object {
    $sources.tauBenchBanking.lineageIndependenceStatus -eq "verified_disjoint_from_frozen_inputs"
}).Count
foreach ($relativePath in $inputPaths) {
    $expected = @($baseline.inputs | Where-Object path -CEQ $relativePath)[0]
    if ((Get-FileHash -LiteralPath (Join-Path $repoRoot $relativePath) -Algorithm SHA256).Hash -ine $expected.sha256) {
        throw "Input changed during export: $relativePath"
    }
}
$result = [ordered]@{
    schemaVersion=1;packId=[IO.Path]::GetFileNameWithoutExtension($OutputPath)
    status="candidate_not_accepted";asOfUtc=$AsOfUtc.ToUniversalTime().ToString("o")
    method="Offline captured-public-data normalization and measurement coverage only; no selection, confirmation, fetches or model-task evaluations."
    baselineSha256=(Get-FileHash -LiteralPath $BaselinePath -Algorithm SHA256).Hash
    sourcePacketSha256=(Get-FileHash -LiteralPath $SourcePacketPath -Algorithm SHA256).Hash
    normalizationInputs=@(foreach ($file in @(
        "export-public-evidence-pack.ps1","model-aa-component-data.ps1","model-aa-components.ps1",
        "model-benchmark-evidence.ps1","model-data-common.ps1","model-configuration.ps1",
        "model-policy-config.ps1","model-role-evidence.ps1","model-release-data.ps1","model-agent-identity.ps1","model-tau-banking-data.ps1"
    )) {
        @{path="scripts\$file";sha256=(Get-FileHash -LiteralPath (Join-Path $PSScriptRoot $file) -Algorithm SHA256).Hash}
    })
    frozenInputs=$baseline.inputs;selectionPolicyVersion=$policy.selectionPolicy.version
    captures=$packet.captures;sources=$sources;inactiveMetricDefinitions=$newDefinitions
    acquisitionDiagnostics=@(Get-ObjectMemberValue $packet "diagnostics" | Where-Object { $null -ne $_ })
    profiles=$profiles
    supplementalEvidence=$supplemental
    acceptance=[ordered]@{
        requiredMeasuredProfiles=9;existingRouteMeasuredProfiles=$measuredProfiles
        requiredCompleteIncumbentProfiles=6;completeIncumbentProfiles=$incumbentProfiles
        requiredAdditionalIndependentLineages=1;additionalIndependentLineages=$additionalIndependent
        additionalComparableDatasetCohorts=$additionalCohorts;independentResultReplications=0
        independenceLimitation="Native-unit proof establishes score admission, not disjointness from the frozen AA aggregate, whose dataset/methodology versions are unknown. Earlier packet independence claims are retained as historical claims, not acceptance proof."
        additionalIndependentLineageCandidates=$lineageCandidates
        targetsMet=$false
        limitation="Coverage uses unchanged existing role routes. Additional metrics remain inactive; Banking admission requires a separate verified unit-proof capture. Full data targets remain unmet."
    }
    limitations=@(
        "Unknown publication dates count only as flagged configuration coverage, not proven publication freshness.",
        "Published benchmark settings do not prove Copilot CLI behavior or the requested context tier.",
        "New benchmark metrics are inactive; no routes, quality bands, profiles or selection state were changed.",
        "This candidate pack requires additional evidence and explicit user acceptance before selection work."
    )
}
Write-ModelJsonAtomic -SnapshotPath $OutputPath -SnapshotObject $result -NoClobber
Write-Host "Candidate evidence pack: $OutputPath"
Write-Host "Existing-route measured profiles: $measuredProfiles/9; complete incumbent comparisons: $incumbentProfiles/6 required."
