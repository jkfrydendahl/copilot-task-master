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
    $p=Read-ModelConfig $PolicyPath 2
    foreach ($field in @("familyPatterns","classPreferences","profileLiveBenchCategories","profileArtificialAnalysisMetrics","profileRequirements","consensusPolicy","selectionPolicy")) {
        if ($p[$field] -isnot [System.Collections.IDictionary]) { throw "Missing/invalid policy object: $field" }
    }
    if ($p.denylist -isnot [array]) { throw "Policy denylist must be an array." }
    $strategies = $p.selectionPolicy["profiles"]
    if ($strategies -isnot [System.Collections.IDictionary]) { throw "selectionPolicy.profiles must be an object." }
    foreach ($key in $strategies.Keys) {
        if ($key -notin $script:KnownTaskProfileKeys) { throw "Unknown selection profile '$key'." }
    }
    foreach ($key in $script:KnownTaskProfileKeys) {
        foreach ($map in @("profileRequirements","classPreferences","profileLiveBenchCategories","profileArtificialAnalysisMetrics")) {
            if (-not $p[$map].Contains($key)) { throw "$map missing profile '$key'." }
        }
        $req=$p.profileRequirements[$key]
        foreach ($field in @("inputCeilingPerMillion","outputCeilingPerMillion")) { Assert-ModelConfigNumber $req[$field] "$key.$field" }
        foreach ($field in @("requiresVision","requiresCliAgent","costSensitive")) {
            if ($req[$field] -isnot [bool]) { throw "$key.$field must be boolean." }
        }
        if ($req.costSensitive -ne ($key -in @("quick","mechanical","triage"))) { throw "Unexpected hard/advisory budget policy for $key." }
        if ($p.profileArtificialAnalysisMetrics[$key] -notin @("coding","intelligence")) { throw "Unknown AA metric for $key." }
        if ($p.profileLiveBenchCategories[$key] -notin @("coding","agenticCoding","reasoning","instructionFollowing")) { throw "Unknown LiveBench category for $key." }
        $strategy = $strategies[$key]
        if ($strategy -isnot [System.Collections.IDictionary] -or $strategy["strategy"] -notin @("quality_first", "value_balanced")) {
            throw "Missing/invalid selection strategy for '$key'."
        }
        if ($strategy.strategy -eq "value_balanced") {
            $bands = $strategy["qualityBands"]
            if ($bands -isnot [System.Collections.IDictionary]) { throw "Missing qualityBands for '$key'." }
            $metrics = @("artificialAnalysis.$($p.profileArtificialAnalysisMetrics[$key])Index", "liveBench.$($p.profileLiveBenchCategories[$key])")
            if ($key -eq "agentic-implementation") { $metrics += "artificialAnalysisCodingAgents.codingAgentIndex" }
            foreach ($metric in $metrics) {
                Assert-ModelConfigNumber $bands[$metric] "$key.qualityBands.$metric"
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
