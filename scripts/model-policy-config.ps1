Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")
$script:KnownTaskProfileKeys=@("orchestrator","quick","default-development","agentic-implementation","deep-reasoning","review","visual-ui","mechanical","triage")

function Read-ModelConfig {
    param([string]$Path, [int]$Version)
    $value=ConvertFrom-JsonAsHashtableCompat (Get-Content -LiteralPath $Path -Raw -ErrorAction Stop)
    if ($value -isnot [System.Collections.IDictionary] -or $value.schemaVersion -ne $Version) { throw "Invalid schemaVersion in $Path; expected $Version." }
    return $value
}

function Assert-ModelConfigNumber {
    param($Value,[string]$Field,[switch]$Positive)
    if (($Value -isnot [int] -and $Value -isnot [long] -and $Value -isnot [double] -and $Value -isnot [decimal]) -or
        -not [double]::IsFinite([double]$Value) -or $Value -lt 0 -or ($Positive -and $Value -le 0)) {
        throw "$Field must be a finite $(if ($Positive) {'positive'} else {'nonnegative'}) number."
    }
}

function Get-ModelPolicyConfig {
    param([Parameter(Mandatory)][string]$PolicyPath)
    $p=Read-ModelConfig $PolicyPath 4
    foreach ($field in @("familyPatterns","classPreferences","evidenceMetrics","profileRequirements","consensusPolicy","selectionPolicy")) {
        if ($p[$field] -isnot [System.Collections.IDictionary]) { throw "Missing/invalid policy object: $field" }
    }
    if ($p.denylist -isnot [array]) { throw "Policy denylist must be an array." }
    $discoveryDays=Get-ObjectMemberValue $p.consensusPolicy "discoveryFreshnessDays"
    if(($discoveryDays -isnot [int] -and $discoveryDays -isnot [long]) -or $discoveryDays -lt 1){
        throw "consensusPolicy.discoveryFreshnessDays must be a positive integer."
    }
    foreach ($id in $p.evidenceMetrics.Keys) {
        $metric = $p.evidenceMetrics[$id]
        if ($metric -isnot [System.Collections.IDictionary] -or
            $metric["source"] -notin @("artificialAnalysis","artificialAnalysisCodingAgents","artificialAnalysisComponents","liveBench") -or
            $id -cne "$($metric['source']).$($metric['metric'])") { throw "Invalid evidence metric '$id'." }
        Assert-ModelConfigNumber $metric["min"] "$id.min"
        Assert-ModelConfigNumber $metric["max"] "$id.max" -Positive
        if ($metric.min -ge $metric.max) { throw "Invalid score range for '$id'." }
        foreach ($field in @("label","scale","limitation")) {
            if ([string]::IsNullOrWhiteSpace([string]$metric[$field])) { throw "Missing $id.$field." }
        }
        if ($metric["lineage"] -isnot [array] -or -not $metric.lineage.Count) { throw "Missing lineage for '$id'." }
    }
    $strategies = $p.selectionPolicy["profiles"]
    if ($strategies -isnot [System.Collections.IDictionary]) { throw "selectionPolicy.profiles must be an object." }
    foreach ($key in $strategies.Keys) {
        if ($key -notin $script:KnownTaskProfileKeys) { throw "Unknown selection profile '$key'." }
    }
    foreach ($key in $script:KnownTaskProfileKeys) {
        foreach ($map in @("profileRequirements","classPreferences")) {
            if (-not $p[$map].Contains($key)) { throw "$map missing profile '$key'." }
        }
        $req=$p.profileRequirements[$key]
        foreach ($field in @("inputCeilingPerMillion","outputCeilingPerMillion")) { Assert-ModelConfigNumber $req[$field] "$key.$field" }
        foreach ($field in @("requiresVision","requiresCliAgent","costSensitive")) {
            if ($req[$field] -isnot [bool]) { throw "$key.$field must be boolean." }
        }
        if (-not $req.costSensitive) { throw "A hard budget is required for $key." }
        $strategy = $strategies[$key]
        if ($strategy -isnot [System.Collections.IDictionary] -or $strategy["strategy"] -notin @("quality_first", "value_balanced")) {
            throw "Missing/invalid selection strategy for '$key'."
        }
        $configuration = Get-ObjectMemberValue $strategy "configurationSelection"
        if ($configuration -isnot [System.Collections.IDictionary] -or
            $configuration["mode"] -ne "bounded_effort" -or $configuration["effortChangePolicy"] -ne "automatic") {
            throw "Invalid configuration selection for '$key'; automatic bounded effort is required."
        }
        $efforts = $configuration["allowedEfforts"]
        if ($efforts -isnot [array] -or -not $efforts.Count -or
            @($efforts | Where-Object { $_ -isnot [string] -or $_ -notin @("minimal","low","medium","high","xhigh","max") }).Count -or
            @($efforts | Select-Object -Unique).Count -ne $efforts.Count) {
            throw "Invalid allowedEfforts for '$key'; specify unique supported effort names."
        }
        if ($strategy.Contains("maxAutomaticCostIncreasePercent")) {
            throw "Incumbent-relative cost limits are obsolete for '$key'; use the fixed hard budget."
        }
        foreach ($field in @("evidenceRoutes","supportingMetrics")) {
            $metrics = $strategy[$field]
            if ($metrics -isnot [array] -or ($field -eq "evidenceRoutes" -and -not $metrics.Count) -or
                @($metrics | Where-Object { $_ -isnot [string] -or -not $p.evidenceMetrics.Contains($_) }).Count -or
                @($metrics | Select-Object -Unique).Count -ne $metrics.Count) {
                throw "Invalid $field for '$key'."
            }
        }
        if (@($strategy.supportingMetrics | Where-Object { $_ -in $strategy.evidenceRoutes }).Count) {
            throw "A metric cannot both decide and support '$key'."
        }
        $qualification = $strategy["qualification"]
        if ($qualification -isnot [System.Collections.IDictionary] -or
            ($qualification["minimumModels"] -isnot [int] -and $qualification["minimumModels"] -isnot [long]) -or $qualification.minimumModels -lt 2 -or
            $qualification["dimensions"] -isnot [array]) {
            throw "Invalid qualification for '$key'; at least two distinct comparison models are required."
        }
        $dimensionKeys = @("primary")
        $usedMetrics = @($strategy.evidenceRoutes) + @($strategy.supportingMetrics)
        foreach ($dimension in $qualification.dimensions) {
            if ($dimension -isnot [System.Collections.IDictionary] -or
                [string]::IsNullOrWhiteSpace([string]$dimension["key"]) -or $dimension.key -in $dimensionKeys) {
                throw "Invalid or duplicate qualification dimension for '$key'."
            }
            $dimensionKeys += $dimension.key
            $routes = $dimension["evidenceRoutes"]
            $bands = $dimension["qualityBands"]
            if ($routes -isnot [array] -or -not $routes.Count -or
                $bands -isnot [System.Collections.IDictionary]) {
                throw "Missing qualification routes/bands for '$key.$($dimension.key)'."
            }
            foreach ($metric in $routes) {
                if ($metric -isnot [string] -or -not $p.evidenceMetrics.Contains($metric) -or $metric -in $usedMetrics) {
                    throw "Unknown or reused qualification metric '$metric' for '$key'."
                }
                $usedMetrics += $metric
                Assert-ModelConfigNumber $bands[$metric] "$key.$($dimension.key).$metric"
                $definition = $p.evidenceMetrics[$metric]
                if ($bands[$metric] -gt ($definition.max - $definition.min)) {
                    throw "Qualification band exceeds '$metric' scale."
                }
            }
            if (@($bands.Keys | Where-Object { $_ -notin $routes }).Count) {
                throw "Unknown qualification band for '$key.$($dimension.key)'."
            }
        }
        if ($strategy.strategy -eq "value_balanced") {
            $bands = $strategy["qualityBands"]
            if ($bands -isnot [System.Collections.IDictionary]) { throw "Missing qualityBands for '$key'." }
            $metrics = $strategy.evidenceRoutes
            foreach ($metric in $metrics) {
                Assert-ModelConfigNumber $bands[$metric] "$key.qualityBands.$metric"
                $definition = $p.evidenceMetrics[$metric]
                if ($bands[$metric] -gt ($definition.max - $definition.min)) { throw "Quality band exceeds '$metric' scale." }
            }
            foreach ($metric in $bands.Keys) {
                if ($metric -notin $metrics) { throw "Unknown quality band '$metric' for '$key'." }
            }
        }
        if ($p.classPreferences[$key] -isnot [array]) { throw "classPreferences.$key must be an array." }
        foreach ($family in $p.classPreferences[$key]) {
            if (-not $p.familyPatterns.Contains($family)) { throw "Unknown family '$family'." }
            [regex]::new($p.familyPatterns[$family]) | Out-Null
        }
    }
    foreach ($field in @("staleAfterDays","capabilityFreshnessDays","pricingFreshnessDays","benchmarkMaxPublicationAgeDays")) {
        Assert-ModelConfigNumber $p.consensusPolicy[$field] "consensusPolicy.$field" -Positive
    }
    foreach ($field in @("version","referenceInputTokens","referenceOutputTokens")) {
        Assert-ModelConfigNumber $p.selectionPolicy[$field] "selectionPolicy.$field" -Positive
    }
    if ([string]::IsNullOrWhiteSpace($p.selectionPolicy.referenceUsageDescription)) { throw "Missing reference usage description." }
    if ((Get-ObjectMemberValue $p.selectionPolicy "costTieBreak") -ne "newest_verified_release") {
        throw "selectionPolicy.costTieBreak must be newest_verified_release."
    }
    return $p
}

function Get-ModelCapabilitiesCatalog {
    param([Parameter(Mandatory)][string]$CatalogPath)
    $catalog=Read-ModelConfig $CatalogPath 2
    if ($catalog.models -isnot [System.Collections.IDictionary]) { throw "Capabilities models must be an object." }
    foreach ($id in $catalog.models.Keys) {
        $record=$catalog.models[$id]
        if ($record -isnot [System.Collections.IDictionary]) { throw "Invalid capability record: $id" }
        foreach ($field in @("asOf","capabilitySource","vision","supportedContexts","supportedEfforts")) {
            if (-not $record.Contains($field)) { throw "Missing capabilities $id.$field" }
        }
        if ($record.Contains("pricing") -or $record.Contains("pricingUnavailable")) { throw "Embedded capability pricing is no longer supported: $id" }
        if ($null -ne $record.vision -and $record.vision -isnot [bool]) { throw "Invalid vision flag for $id." }
        if ($record.vision -eq $true -and [string]::IsNullOrWhiteSpace($record.visionSource)) { throw "Missing vision provenance for $id." }
        foreach ($field in @("supportedContexts","supportedEfforts")) {
            if ($record[$field] -isnot [array]) { throw "$id.$field must be an array." }
        }
        if ($record.Contains("effortMode") -and $record.effortMode -notin @("supported","unsupported")) { throw "Invalid effortMode for $id." }
    }
    return $catalog
}
