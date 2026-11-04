Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-agent-identity.ps1")

function ConvertFrom-TauBankingSubmissions {
    param(
        [Parameter(Mandatory)][object[]]$Documents,
        [Parameter(Mandatory)][hashtable]$Schema,
        [Parameter(Mandatory)]$SchemaSource,
        [Parameter(Mandatory)][string]$ReferenceRevision,
        [Parameter(Mandatory)][object[]]$EligibleConfigurations,
        [Parameter(Mandatory)][hashtable]$Capabilities
    )
    if (-not $Documents.Count) { throw "Banking normalization requires captured submissions." }
    $properties = Get-ObjectMemberValue (Get-ObjectMemberValue (Get-ObjectMemberValue $Schema '$defs') "DomainResults") "properties"
    foreach ($k in 1..4) {
        $field = Get-ObjectMemberValue $properties "pass_$k"
        $numeric = @(Get-ObjectMemberValue $field "anyOf" | Where-Object { (Get-ObjectMemberValue $_ "type") -eq "number" })
        if ($numeric.Count -ne 1 -or -not (Test-ModelScore (Get-ObjectMemberValue $numeric[0] "minimum") 0 0) -or
            -not (Test-ModelScore (Get-ObjectMemberValue $numeric[0] "maximum") 100 100) -or
            (Get-ObjectMemberValue $field "description") -cne "Pass^$k success rate percentage") {
            throw "Banking native units/range are not established by the captured schema: pass_$k"
        }
    }
    $definition = @{
        source="tauBenchBanking";metric="pass1";benchmarkId="tau2-bench-banking-knowledge-v1.0.1-pass1"
        label="tau2-bench v1.0.1 Banking pass^1 (alltools)";min=0;max=100;scale="success rate percentage"
        lineage=@("tau2-bench")
        limitation="Declared standard Sierra self-submissions; four trials, GPT-5.2 low simulator. Not independently replicated. Unknown publication dates; external harness/context, not Copilot CLI."
        unitProvenance=@{url=$SchemaSource.url;sha256=$SchemaSource.sha256;referenceRevision=$ReferenceRevision}
    }
    $knownModels = @($EligibleConfigurations | ForEach-Object model | Sort-Object -Unique)
    $models = @{}
    $identities = @{}
    $aliases = @{}
    $cohort = $null
    $cohortFingerprint = $null
    $providers = @{Anthropic="anthropic";OpenAI="openai";xAI="xai"}
    foreach ($capture in $Documents) {
        if ($capture.source.url -cnotmatch '^https://raw\.githubusercontent\.com/sierra-research/tau2-bench/(?:main|[a-f0-9]{40})/web/leaderboard/public/submissions/[^/]+/submission\.json$') {
            throw "Banking numeric admission requires an official submission source URL."
        }
        $raw = $capture.document
        $methodology = Get-ObjectMemberValue $raw "methodology"
        $verification = Get-ObjectMemberValue $methodology "verification"
        $results = Get-ObjectMemberValue (Get-ObjectMemberValue $raw "results") "banking_knowledge"
        $notes = [string](Get-ObjectMemberValue $methodology "notes")
        if ((Get-ObjectMemberValue $methodology "tau2_bench_version") -ne "1.0.1" -or
            (Get-ObjectMemberValue $methodology "user_simulator") -ne "gpt-5.2" -or
            (Get-ObjectMemberValue $raw "modality") -ne "text" -or
            (Get-ObjectMemberValue $raw "submission_type") -ne "standard" -or
            (Get-ObjectMemberValue $raw "submitting_organization") -ne "Sierra" -or
            (Get-ObjectMemberValue $results "retrieval_config") -ne "alltools" -or
            (Get-ObjectMemberValue $verification "modified_prompts") -ne $false -or
            (Get-ObjectMemberValue $verification "omitted_questions") -ne $false -or
            $notes -notmatch '\bGPT-5\.2 low-reasoning user simulation, four trials, and seed (?<seed>[0-9]+)\b') {
            throw "Banking submission does not establish the admitted v1.0.1 standard four-trial protocol."
        }
        $currentCohort = @{
            benchmarkVersion="1.0.1";domain="banking_knowledge";retrieval="alltools";modality="text"
            userSimulator="gpt-5.2";userSimulatorEffort="low";trials=4;seed=[int]$Matches.seed
            submissionType="standard";publisher="Sierra"
        }
        $currentFingerprint = Get-ModelDataFingerprint $currentCohort
        if ($null -ne $cohortFingerprint -and $currentFingerprint -cne $cohortFingerprint) {
            throw "Banking submissions contain incompatible cohorts."
        }
        $cohort = $currentCohort
        $cohortFingerprint = $currentFingerprint
        $effort = Get-ObjectMemberValue $raw "reasoning_effort"
        $organization = Get-ObjectMemberValue $raw "model_organization"
        if ($effort -notin @("none","minimal","low","medium","high","xhigh","max") -or
            $organization -isnot [string] -or -not $providers.ContainsKey($organization)) {
            throw "Banking model/provider/effort must be explicit."
        }
        $name = Get-ObjectMemberValue $raw "model_name"
        $publishedLabel = if ($effort -eq "none") { $name } else { "$name ($effort)" }
        $identity = Resolve-AgentModelIdentities -Records @{submission=@{
            identitySchemaVersion=1;publishedModel=$publishedLabel;provider=$providers[$organization];variantId="standard"
        }} -KnownModels $knownModels -Capabilities $Capabilities
        if ($identity.records.Count -ne 1) { throw "Banking identity unresolved: $($identity.diagnostics -join '; ')" }
        $resolved = $identity.records[0]
        if ($resolved.effort -cne $effort -or -not @($EligibleConfigurations | Where-Object {
            $_.model -ceq $resolved.model -and $_.effort -ceq $effort
        }).Count) { throw "Banking model/effort is not in the frozen eligible configurations." }
        $expected = Get-ObjectMemberValue $capture "model"
        if ($null -ne $expected -and ($expected.canonical -cne $resolved.model -or $expected.explicitEffort -cne $effort)) {
            throw "Banking packet identity differs from the published submission."
        }
        foreach ($k in 1..4) {
            if (-not (Test-ModelScore (Get-ObjectMemberValue $results "pass_$k") 0 100)) {
                throw "Banking native score missing or invalid: $($resolved.model) pass_$k"
            }
        }
        $alias = "$($resolved.model)/$effort"
        if ($models.ContainsKey($alias)) { throw "Duplicate Banking model/effort: $alias" }
        $models[$alias] = @{
            name=$publishedLabel;effort=$effort;pass1=$results.pass_1
            evaluationDate=(Get-ObjectMemberValue $methodology "evaluation_date")
            submissionDate=(Get-ObjectMemberValue $raw "submission_date")
            modelRelease=(Get-ObjectMemberValue $raw "model_release")
            source=$capture.source;harness="tau2-bench v1.0.1 standard";suiteFingerprint=$cohortFingerprint
            versions=@{benchmark="1.0.1";methodologyReference=$ReferenceRevision;deployedEvaluator=$null}
        }
        $identities[$alias] = @{status="verified";model=$resolved.model;effort=$effort;publishedModel=$name}
        if (-not $aliases.ContainsKey($resolved.model)) { $aliases[$resolved.model] = @{} }
        $aliases[$resolved.model][$effort] = $alias
    }
    $publicationDates = @($Documents | ForEach-Object { [string](Get-ObjectMemberValue $_ "publicationDate") } | Sort-Object -Unique)
    if ($publicationDates.Count -ne 1) { throw "Banking publication dates differ; separate observations are required." }
    $sourceDate = if ([string]::IsNullOrWhiteSpace($publicationDates[0])) { $null } else { $publicationDates[0] }
    $retrieved = @($Documents | ForEach-Object { [datetime]$_.source.retrievedAtUtc } | Sort-Object)[0]
    return @{
        aliases=$aliases;metricDefinitions=@{pass1=$definition}
        source=@{
            status="ok";models=$models;identities=$identities;sourceDate=$sourceDate
            fetchedAtUtc=$retrieved.ToUniversalTime().ToString("o")
            sourceUrl="https://raw.githubusercontent.com/sierra-research/tau2-bench/main/web/leaderboard/public/submissions/manifest.json"
            sourceVersion=(Get-ModelDataFingerprint @{models=$models;cohort=$cohort;unitDefinition=$definition})
            datasetVersion="banking_knowledge-v1.0.1";methodologyVersion="tau2-bench-v1.0.1-standard"
            evaluatorRevision=$null;methodologyReferenceRevision=$ReferenceRevision;cohort=$cohort
            metricDefinitions=@{pass1=$definition};diagnostics=@()
            resultReplicationIndependent=$false
            lineageIndependenceStatus="unverified_against_frozen_aggregate_composition"
        }
    }
}
