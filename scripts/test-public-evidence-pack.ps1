Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-aa-components.ps1")
. (Join-Path $PSScriptRoot "model-configuration.ps1")
. (Join-Path $PSScriptRoot "model-tau-banking-data.ps1")

$root = Join-Path ([IO.Path]::GetTempPath()) ("public-evidence-pack-" + [guid]::NewGuid().ToString("N"))
[void](New-Item -ItemType Directory -Path $root)
$repoRoot = Split-Path $PSScriptRoot -Parent
$exporter = Join-Path $PSScriptRoot "export-public-evidence-pack.ps1"
$baselinePath = Join-Path $root "baseline.json"
$packetPath = Join-Path $root "packet.json"
$outputPath = Join-Path $root "pack.json"
$now = [datetime]::UtcNow

function Assert-True($Condition, $Message) {
    if (-not $Condition) { throw $Message }
}
function Assert-ExportFailure($Message) {
    $failed = $false
    try { & $exporter -BaselinePath $baselinePath -SourcePacketPath $packetPath -OutputPath $outputPath -AsOfUtc $now }
    catch { $failed = $_.Exception.Message -like "*$Message*" }
    Assert-True $failed "Expected explicit failure: $Message"
}
function Assert-ActionFailure([scriptblock]$Action, [string]$Message) {
    $failed = $false
    try { & $Action }
    catch { $failed = $_.Exception.Message -like "*$Message*" }
    Assert-True $failed "Expected explicit failure: $Message"
}

try {
    $row=@{slug="gpt-6-1-sol-high";name="GPT-6.1 Sol (high)";effort="high";release=@{slug="gpt-6-1-sol"};
        lcr=0.8;automationBenchPartialScore=0.6;intelligenceIndexEvaluations=@(@{slug="frontiercode-2-0";score=0.5})}
    $json="x:" + (@{models=@($row)} | ConvertTo-Json -Depth 20 -Compress)
    $html='<script>self.__next_f.push([1,' + (ConvertTo-Json -InputObject $json -Compress) + '])</script>'
    $capturePath=Join-Path $root "aa.txt"
    [IO.File]::WriteAllText($capturePath,$html,[Text.UTF8Encoding]::new($false))
    $source=Get-AAComponentData -ModelSlugs @("gpt-6-1-sol-high") -FetchText {param($url) @{status="ok";content=$html}}
    $capturedAt=$now.AddMinutes(-5).ToString("o")
    $packet=@{
        schemaVersion=1;resolvedSources=@{artificialAnalysisComponents=$source}
        captures=@(@{url=$source.sourceUrl;savedFile="aa.txt";capturedAtUtc=$capturedAt;
            sha256=(Get-FileHash -LiteralPath $capturePath -Algorithm SHA256).Hash})
    }
    $paths=@(
        "task-profiles.json","config\model-policy.json","config\model-capabilities.json",
        "config\model-ranking-aliases.json","config\model-pricing-aliases.json",
        "data\model-discovery-snapshot.json","data\model-pricing-snapshot.json","data\model-ranking-snapshot.json"
    )
    $capabilities=ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath (Join-Path $repoRoot "config\model-capabilities.json") -Raw)
    $policy=ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath (Join-Path $repoRoot "config\model-policy.json") -Raw)
    $taskProfiles=ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath (Join-Path $repoRoot "task-profiles.json") -Raw)
    $baseline=@{
        schemaVersion=1;policyVersion=$policy.selectionPolicy.version;discoveryObservedAtUtc=$now.ToString("o");discoveryStatus="valid"
        inputs=@(foreach($path in $paths) {
            @{path=$path;sha256=(Get-FileHash -LiteralPath (Join-Path $repoRoot $path) -Algorithm SHA256).Hash}
        })
        profiles=@(foreach($profile in $taskProfiles) {
            $configuration=New-ModelConfiguration -Model $profile.model -Effort $profile.effort -Context $profile.context `
                -CapabilityRecord $capabilities.models[$profile.model]
            @{profile=$profile.key;context=$profile.context;incumbent=$configuration;
                eligibleConfigurations=@($configuration)}
        })
    }
    Write-ModelJsonAtomic $baselinePath $baseline
    Write-ModelJsonAtomic $packetPath $packet
    & $exporter -BaselinePath $baselinePath -SourcePacketPath $packetPath -OutputPath $outputPath -AsOfUtc $now
    $pack=ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $outputPath -Raw)
    Assert-True ($pack.profiles.Count -eq 9 -and $pack.status -eq "candidate_not_accepted") "Incorrect pack shape or claimed acceptance"
    Assert-True (-not $pack.acceptance.targetsMet -and $pack.acceptance.additionalIndependentLineages -eq 0) "AA components claimed independent evidence"
    Assert-True ($pack.sources.artificialAnalysisComponents.fetchedAtUtc -eq $capturedAt -and
        $null -eq $pack.sources.artificialAnalysisComponents.sourceDate) "Offline parsing invented fresh retrieval/publication"
    Assert-True ($pack.inactiveMetricDefinitions.ContainsKey("artificialAnalysisComponents.frontierCode20") -and
        @($pack.profiles.inactiveAdditionalCoverage | Where-Object selectionActive).Count -eq 0) "New metrics activated"
    foreach($inputFile in $baseline.inputs) {
        Assert-True ((Get-FileHash -LiteralPath (Join-Path $repoRoot $inputFile.path) -Algorithm SHA256).Hash -eq $inputFile.sha256) "Selection input changed"
    }
    Write-Host "PASS: Offline pack preserves nine-profile shape, original dates, inactive metrics and selection inputs"

    $packHash=(Get-FileHash -LiteralPath $outputPath -Algorithm SHA256).Hash
    Assert-ExportFailure "Refusing to overwrite"
    Assert-True ((Get-FileHash -LiteralPath $outputPath -Algorithm SHA256).Hash -eq $packHash) "Existing pack overwritten"
    $failed=$false
    try { Write-ModelJsonAtomic $outputPath @{unexpected="replacement"} -NoClobber }
    catch { $failed=$true }
    Assert-True ($failed -and (Get-FileHash -LiteralPath $outputPath -Algorithm SHA256).Hash -eq $packHash) "Atomic no-clobber write replaced an existing pack"
    Remove-Item -LiteralPath $outputPath
    $directoryDestination=Join-Path $root "existing-directory.json"
    [void](New-Item -ItemType Directory -Path $directoryDestination)
    $failed=$false
    try { Write-ModelJsonAtomic $directoryDestination @{unexpected="nested file"} -NoClobber }
    catch { $failed=$true }
    Assert-True ($failed -and @(Get-ChildItem -LiteralPath $directoryDestination -File).Count -eq 0 -and
        @(Get-ChildItem -LiteralPath $root -Filter "*.tmp").Count -eq 0) "No-clobber write moved inside a directory or leaked a temporary file"
    Push-Location $root
    try { Write-ModelJsonAtomic ".\relative.json" @{relative=$true} -NoClobber }
    finally { Pop-Location }
    Assert-True (Test-Path -LiteralPath (Join-Path $root "relative.json")) "Native no-clobber move used the process directory instead of the PowerShell location"
    $rawPath=Join-Path $root "reference.json"
    Write-ModelJsonAtomic $rawPath @{metrics=@{pass_1=48.71134020618557}}
    $referencePath=Join-Path $root "reference-packet.json"
    $reference=@{
        packetType="tau-bench-banking-admission-data";dataOnly=$true;notRouteOrBandApproval=$true
        baseline=@{sha256=(Get-FileHash -LiteralPath $baselinePath -Algorithm SHA256).Hash}
        independenceLineage=@{benchmarkLineageIndependent=$true;resultsIndependentlyReplicated=$false}
        submissions=@(@{
            model=@{canonical="gpt-6.1-sol";explicitEffort="high"}
            source=@{path=$rawPath;url="https://example.test/results.json";retrievedAtUtc=$capturedAt;
                sha256=(Get-FileHash -LiteralPath $rawPath -Algorithm SHA256).Hash}
        })
    }
    Write-ModelJsonAtomic $referencePath $reference
    & $exporter -BaselinePath $baselinePath -SourcePacketPath $packetPath -OutputPath $outputPath -AsOfUtc $now `
        -SupplementalPacketPath $referencePath
    $referencePack=ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $outputPath -Raw)
    Assert-True ($referencePack.supplementalEvidence.status -eq "reference_only_units_unverified" -and
        $referencePack.supplementalEvidence.originalSubmissions[0].document.metrics.pass_1 -eq 48.71134020618557 -and
        @($referencePack.supplementalEvidence.eligibleConfigurationCoverage | Where-Object scoreAdmission).Count -eq 0 -and
        -not $referencePack.acceptance.targetsMet) "Unverified native units were normalized or admitted"
    Write-Host "PASS: Supplemental evidence preserves raw values and recomputes eligibility without admitting unverified units"
    Remove-Item -LiteralPath $outputPath

    $schema=@{'$defs'=@{DomainResults=@{properties=@{}}}}
    foreach($k in 1..4) {
        $schema.'$defs'.DomainResults.properties["pass_$k"]=@{
            description="Pass^$k success rate percentage"
            anyOf=@(@{type="number";minimum=0;maximum=100},@{type="null"})
        }
    }
    $schemaPath=Join-Path $root "schema.json"
    $producerPath=Join-Path $root "producer.py"
    Write-ModelJsonAtomic $schemaPath $schema
    [IO.File]::WriteAllText($producerPath,"# Offline provenance fixture",[Text.UTF8Encoding]::new($false))
    $proofPath=Join-Path $root "unit-proof.json"
    $revision="1111111111111111111111111111111111111111"
    $proof=@{
        schemaVersion=1;benchmarkVersion="1.0.1";referenceRevision=$revision
        captures=@(
            @{role="schema";path=$schemaPath;sha256=(Get-FileHash -LiteralPath $schemaPath -Algorithm SHA256).Hash;
                retrievedAtUtc=$now.ToString("o");url="https://raw.githubusercontent.com/sierra-research/tau2-bench/$revision/web/leaderboard/public/submissions/schema.json"},
            @{role="producer";path=$producerPath;sha256=(Get-FileHash -LiteralPath $producerPath -Algorithm SHA256).Hash;
                retrievedAtUtc=$now.ToString("o");url="https://raw.githubusercontent.com/sierra-research/tau2-bench/$revision/src/tau2/scripts/leaderboard/submission.py"}
        )
    }
    Write-ModelJsonAtomic $proofPath $proof
    $specs=@(
        @{model="claude-opus-5";name="Claude Opus 5";effort="max";organization="Anthropic"},
        @{model="gpt-5.6-sol";name="GPT-5.6-sol";effort="xhigh";organization="OpenAI"}
    )
    $agentic=@($baseline.profiles | Where-Object profile -EQ "agentic-implementation")[0]
    $documents=@(foreach($spec in $specs) {
        $configuration=New-ModelConfiguration -Model $spec.model -Effort $spec.effort -Context $agentic.context `
            -CapabilityRecord $capabilities.models[$spec.model]
        $agentic.eligibleConfigurations+=@($configuration)
        $doc=@{
            model_name=$spec.name;model_organization=$spec.organization;reasoning_effort=$spec.effort
            submitting_organization="Sierra";modality="text";submission_type="standard";submission_date="2026-08-04"
            results=@{banking_knowledge=@{pass_1=48.71134020618557;pass_2=39.0;pass_3=34.0;pass_4=31.0;retrieval_config="alltools"}}
            methodology=@{tau2_bench_version="1.0.1";user_simulator="gpt-5.2";evaluation_date="2026-08-03"
                notes="Banking_knowledge evaluation with AllTools retrieval, GPT-5.2 low-reasoning user simulation, four trials, and seed 300."
                verification=@{modified_prompts=$false;omitted_questions=$false}}
        }
        $path=Join-Path $root "$($spec.model).json"
        Write-ModelJsonAtomic $path $doc
        @{document=$doc;model=@{canonical=$spec.model;explicitEffort=$spec.effort};publicationDate=$null
            source=@{path=$path;sha256=(Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash;retrievedAtUtc=$capturedAt
                url="https://raw.githubusercontent.com/sierra-research/tau2-bench/main/web/leaderboard/public/submissions/fixture-$($spec.model)/submission.json"}}
    })
    $eligible=@($baseline.profiles | ForEach-Object eligibleConfigurations)
    $normalize={ ConvertFrom-TauBankingSubmissions -Documents $documents -Schema $schema -SchemaSource $proof.captures[0] `
        -ReferenceRevision $revision -EligibleConfigurations $eligible -Capabilities $capabilities.models }
    $normalized=& $normalize
    Assert-True ($normalized.source.models["claude-opus-5/max"].pass1 -eq 48.71134020618557 -and
        $normalized.metricDefinitions.pass1.max -eq 100 -and $null -eq $normalized.source.sourceDate -and
        $normalized.source.fetchedAtUtc -eq $capturedAt -and $null -eq $normalized.source.evaluatorRevision) "Native score/dates/revision changed"
    foreach($score in @(0,100)) {
        $documents[0].document.results.banking_knowledge.pass_1=$score
        Assert-True ((& $normalize).source.models["claude-opus-5/max"].pass1 -eq $score) "Legal native boundary rejected"
    }
    foreach($score in @(-1,101,"48.7",$null)) {
        $documents[0].document.results.banking_knowledge.pass_1=$score
        Assert-ActionFailure $normalize "native score missing or invalid"
    }
    $documents[0].document.results.banking_knowledge.pass_1=48.71134020618557
    $documents[1].document.methodology.notes=$documents[1].document.methodology.notes.Replace("seed 300","seed 301")
    Assert-ActionFailure $normalize "incompatible cohorts"
    $documents[1].document.methodology.notes=$documents[1].document.methodology.notes.Replace("seed 301","seed 300")
    $documents[0].document.reasoning_effort=$null
    Assert-ActionFailure $normalize "effort must be explicit"
    $documents[0].document.reasoning_effort="max"
    $documents[0].model.explicitEffort="high"
    Assert-ActionFailure $normalize "packet identity differs"
    $documents[0].model.explicitEffort="max"
    $schema.'$defs'.DomainResults.properties.pass_1.anyOf[0].maximum=1
    Assert-ActionFailure $normalize "native units/range"
    $schema.'$defs'.DomainResults.properties.pass_1.anyOf[0].maximum=100
    $nativeDocument=ConvertTo-CanonicalModelData $documents[0]
    $nativeDocument.document.model_name="GPT Native Fixture"
    $nativeDocument.document.model_organization="OpenAI"
    $nativeDocument.document.reasoning_effort="none"
    $nativeDocument.model.canonical="gpt-native-fixture"
    $nativeDocument.model.explicitEffort="none"
    $nativeNormalize={ ConvertFrom-TauBankingSubmissions -Documents @($nativeDocument) -Schema $schema -SchemaSource $proof.captures[0] `
        -ReferenceRevision $revision -EligibleConfigurations @(@{model="gpt-native-fixture";effort="none"}) `
        -Capabilities @{"gpt-native-fixture"=@{effortMode="unsupported"}} }
    Assert-True ((& $nativeNormalize).source.identities["gpt-native-fixture/none"].effort -eq "none") "Explicit native configuration rejected"
    $nativeDocument.document.reasoning_effort=$null
    Assert-ActionFailure $nativeNormalize "effort must be explicit"
    Write-Host "PASS: Banking preserves native percentages and rejects invalid units/scores, mixed cohorts and unresolved effort/identity"

    Write-ModelJsonAtomic $baselinePath $baseline
    $reference.baseline.sha256=(Get-FileHash -LiteralPath $baselinePath -Algorithm SHA256).Hash
    $reference.submissions=@($documents | ForEach-Object { @{model=$_.model;source=$_.source;dates=@{publicationDate=$null}} })
    Write-ModelJsonAtomic $referencePath $reference
    & $exporter -BaselinePath $baselinePath -SourcePacketPath $packetPath -OutputPath $outputPath -AsOfUtc $now `
        -SupplementalPacketPath $referencePath -BankingUnitProofPath $proofPath
    $admitted=ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $outputPath -Raw)
    $bankingPool=@($admitted.profiles.inactiveAdditionalCoverage | Where-Object { $_.metric -eq "tauBenchBanking.pass1" -and $_.comparableCohort })
    Assert-True ($admitted.supplementalEvidence.status -eq "admitted_data_only" -and $bankingPool.Count -gt 0 -and
        $admitted.acceptance.additionalComparableDatasetCohorts.Count -eq 1 -and
        $admitted.acceptance.additionalIndependentLineages -eq 0 -and $admitted.acceptance.independentResultReplications -eq 0 -and
        -not $admitted.acceptance.targetsMet -and @($admitted.profiles.inactiveAdditionalCoverage | Where-Object selectionActive).Count -eq 0) "Incorrect native admission, lineage count or activation"
    Assert-True ($admitted.sources.tauBenchBanking.fetchedAtUtc -eq $capturedAt -and
        $admitted.sources.tauBenchBanking.models["claude-opus-5/max"].pass1 -eq 48.71134020618557 -and
        @($admitted.profiles | ForEach-Object { $_.inactiveAdditionalRecords } | Where-Object { $_.source -eq "tauBenchBanking" -and -not $_.publicationAgeUnknown }).Count -eq 0) "Admission refreshed old dates or converted scores"
    Remove-Item -LiteralPath $outputPath
    foreach($submission in $reference.submissions) { $submission.dates.publicationDate=$now.AddDays(-91).ToString("o") }
    Write-ModelJsonAtomic $referencePath $reference
    & $exporter -BaselinePath $baselinePath -SourcePacketPath $packetPath -OutputPath $outputPath -AsOfUtc $now `
        -SupplementalPacketPath $referencePath -BankingUnitProofPath $proofPath
    $stale=ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $outputPath -Raw)
    Assert-True ($stale.acceptance.additionalComparableDatasetCohorts.Count -eq 0 -and
        @($stale.profiles | ForEach-Object { $_.inactiveAdditionalRecords } | Where-Object source -EQ "tauBenchBanking").Count -eq 0) "Known stale publication counted as unknown/current"
    Remove-Item -LiteralPath $outputPath
    foreach($submission in $reference.submissions) { $submission.dates.publicationDate=$null }
    $second=$documents[1]
    $second.document.model_name="Claude Opus 5"
    $second.document.model_organization="Anthropic"
    $second.document.reasoning_effort="high"
    $second.model.canonical="claude-opus-5"
    $second.model.explicitEffort="high"
    Write-ModelJsonAtomic $second.source.path $second.document
    $second.source.sha256=(Get-FileHash -LiteralPath $second.source.path -Algorithm SHA256).Hash
    $agentic.eligibleConfigurations+=@(New-ModelConfiguration -Model "claude-opus-5" -Effort "high" -Context $agentic.context `
        -CapabilityRecord $capabilities.models["claude-opus-5"])
    Write-ModelJsonAtomic $baselinePath $baseline
    $reference.baseline.sha256=(Get-FileHash -LiteralPath $baselinePath -Algorithm SHA256).Hash
    $reference.submissions=@($documents | ForEach-Object { @{model=$_.model;source=$_.source;dates=@{publicationDate=$null}} })
    Write-ModelJsonAtomic $referencePath $reference
    & $exporter -BaselinePath $baselinePath -SourcePacketPath $packetPath -OutputPath $outputPath -AsOfUtc $now `
        -SupplementalPacketPath $referencePath -BankingUnitProofPath $proofPath
    $singleModel=ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $outputPath -Raw)
    Assert-True ($singleModel.acceptance.additionalComparableDatasetCohorts.Count -eq 0 -and
        @($singleModel.profiles.inactiveAdditionalCoverage | Where-Object { $_.metric -eq "tauBenchBanking.pass1" -and $_.comparableCohort }).Count -eq 0) "Multiple efforts counted as distinct comparison models"
    Remove-Item -LiteralPath $outputPath
    $proof.captures[0].sha256="invalid"
    Write-ModelJsonAtomic $proofPath $proof
    Assert-ActionFailure { & $exporter -BaselinePath $baselinePath -SourcePacketPath $packetPath -OutputPath $outputPath `
        -AsOfUtc $now -SupplementalPacketPath $referencePath -BankingUnitProofPath $proofPath } "unit-proof capture provenance/hash differs"
    Assert-True (-not (Test-Path -LiteralPath $outputPath)) "Invalid proof produced a pack"
    foreach($inputFile in $baseline.inputs) {
        Assert-True ((Get-FileHash -LiteralPath (Join-Path $repoRoot $inputFile.path) -Algorithm SHA256).Hash -eq $inputFile.sha256) "Native admission changed selection input"
    }
    Write-Host "PASS: Banking pools require two distinct eligible models/current dates; unit proof does not prove independence or change selection inputs"
    $baseline.inputs[0].sha256="invalid"
    Write-ModelJsonAtomic $baselinePath $baseline
    Assert-ExportFailure "Baseline input differs"
    $baseline.inputs[0].sha256=(Get-FileHash -LiteralPath (Join-Path $repoRoot $paths[0]) -Algorithm SHA256).Hash
    Write-ModelJsonAtomic $baselinePath $baseline
    $packet.captures[0].sha256="invalid"
    Write-ModelJsonAtomic $packetPath $packet
    Assert-ExportFailure "Capture hash differs"
    $packet.captures[0].sha256=(Get-FileHash -LiteralPath $capturePath -Algorithm SHA256).Hash
    $packet.resolvedSources.artificialAnalysisComponents.sourceVersion="invalid"
    Write-ModelJsonAtomic $packetPath $packet
    Assert-ExportFailure "does not reproduce"
    $baseline.discoveryObservedAtUtc=$now.AddDays(-8).ToString("o")
    Write-ModelJsonAtomic $baselinePath $baseline
    Assert-ExportFailure "discovery is stale"
    Assert-True (-not (Test-Path -LiteralPath $outputPath)) "Rejected export produced a pack"
    Write-Host "PASS: Export rejects overwritten packs, changed inputs/captures, incompatible normalization and stale eligibility"
} finally {
    Remove-Item -LiteralPath $root -Recurse -Force
}
