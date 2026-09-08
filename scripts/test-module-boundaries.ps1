Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$script:Failed = 0

function Assert-True($Condition, $Message) {
    if (-not $Condition) { throw $Message }
}

function Run-Test($Name, [scriptblock]$Action) {
    try {
        & $Action
        Write-Host "PASS: $Name"
    } catch {
        $script:Failed++
        Write-Host "FAIL: $Name -- $_"
    }
}

Run-Test "Policy and shared data load without benchmark provider dependencies" {
    . (Join-Path $PSScriptRoot "model-data-common.ps1")
    . (Join-Path $PSScriptRoot "model-policy-config.ps1")
    . (Join-Path $PSScriptRoot "model-admissibility.ps1")

    $policy = Get-ModelPolicyConfig (Join-Path $PSScriptRoot "..\config\model-policy.json")
    Assert-True ($policy.schemaVersion -eq 2) "Policy failed to load"
    Assert-True (-not (Get-Command Get-LiveBenchData -ErrorAction SilentlyContinue)) "Policy imported LiveBench"
    Assert-True (-not (Get-Command Get-ArtificialAnalysisIntelligenceIndexData -ErrorAction SilentlyContinue)) "Policy imported AA"
    Assert-True (-not (Get-Command Resolve-ModelRankingSnapshot -ErrorAction SilentlyContinue)) "Legacy ranking API remains"
}

Run-Test "Shared member access, JSON dates and canonical identities retain their contracts" {
    . (Join-Path $PSScriptRoot "model-data-common.ps1")
    $json = ConvertFrom-JsonAsHashtableCompat '{"date":"2026-09-08T00:00:00Z","items":[],"enabled":false}'
    Assert-True ($json.date -is [string] -and $json.items.Count -eq 0) "JSON dates/arrays changed"
    foreach ($record in @(@{zero=0;flag=$false}, [pscustomobject]@{zero=0;flag=$false})) {
        Assert-True ((Get-ObjectMemberValue $record "zero") -eq 0) "Zero lost"
        Assert-True ((Get-ObjectMemberValue $record "flag") -eq $false) "False lost"
        Assert-True ($null -eq (Get-ObjectMemberValue $record "absent")) "Missing member changed"
    }
    Assert-True ((Get-ModelDataFingerprint @{a=1;b=@(2,3)}) -eq (Get-ModelDataFingerprint @{b=@(2,3);a=1})) "Ordering changed identity"
    Assert-True (-not (Test-ModelDataFresh "invalid" 45 ([datetime]"2026-09-08Z"))) "Invalid date accepted"
}

Run-Test "Provider modules expose adapters without the retired ranking pipeline" {
    . (Join-Path $PSScriptRoot "model-artificial-analysis.ps1")
    . (Join-Path $PSScriptRoot "model-livebench.ps1")
    Assert-True ([bool](Get-Command Get-LiveBenchData)) "LiveBench missing"
    Assert-True ([bool](Get-Command Get-ArtificialAnalysisIntelligenceIndexData)) "AA missing"
    Assert-True (-not (Get-Command Get-AdvisoryModelRankingSnapshot -ErrorAction SilentlyContinue)) "Legacy entry point remains"
    Assert-True (-not (Test-Path (Join-Path $PSScriptRoot "model-ranking-data.ps1"))) "Obsolete monolith remains"
}

if ($script:Failed) { exit 1 }
