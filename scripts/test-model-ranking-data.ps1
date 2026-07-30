Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "model-ranking-data.ps1")

$fixtureRoot = Join-Path $PSScriptRoot "fixtures/model-ranking"
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

$script:Passed = 0
$script:Failed = 0

function Assert-True {
    param(
        [Parameter(Mandatory = $true)][bool]$Condition,
        [Parameter(Mandatory = $true)][string]$Message
    )
    if (-not $Condition) {
        throw $Message
    }
}

function Run-Test {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][scriptblock]$Action
    )

    try {
        & $Action
        $script:Passed++
        Write-Host "PASS: $Name"
    } catch {
        $script:Failed++
        Write-Host "FAIL: $Name -- $($_.Exception.Message)"
    }
}

Run-Test "Valid AA fixture parsing" {
    $html = Get-Content -Path (Join-Path $fixtureRoot "aa-valid.html") -Raw
    $parsed = Parse-ArtificialAnalysisAgenticIndexFromHtml -Html $html
    Assert-True ($parsed.status -eq "ok") "Expected AA parse status ok."
    Assert-True ($parsed.models.ContainsKey("claude-sonnet-5")) "Expected claude-sonnet-5 in AA records."
}

Run-Test "AA malformed data fails safely" {
    $html = Get-Content -Path (Join-Path $fixtureRoot "aa-malformed.html") -Raw
    $parsed = Parse-ArtificialAnalysisAgenticIndexFromHtml -Html $html
    Assert-True ($parsed.status -eq "unavailable") "Malformed AA should be unavailable."
}

Run-Test "Valid LiveBench CSV/category parsing" {
    $csv = Get-Content -Path (Join-Path $fixtureRoot "livebench-valid.csv") -Raw
    $categories = Get-Content -Path (Join-Path $fixtureRoot "livebench-categories-valid.json") -Raw
    $parsed = Parse-LiveBenchData -CsvText $csv -CategoriesJsonText $categories -SourceDate "2026-06-25"
    Assert-True ($parsed.status -eq "ok") "Expected LiveBench parse status ok."
    Assert-True ($parsed.models.ContainsKey("claude-opus-5-max-effort")) "Expected claude-opus-5-max-effort model."
}

Run-Test "LiveBench malformed data fails safely" {
    $csv = Get-Content -Path (Join-Path $fixtureRoot "livebench-malformed.csv") -Raw
    $parsed = Parse-LiveBenchData -CsvText $csv -CategoriesJsonText "" -SourceDate "2026-06-25"
    Assert-True ($parsed.status -eq "unavailable") "Malformed LiveBench should be unavailable."
}

Run-Test "Explicit mapping only unmapped is n/a" {
    $aliases = @{
        "claude-sonnet-5" = @{ artificialAnalysis = "claude-sonnet-5"; liveBench = "claude-sonnet-5-xhigh-effort" }
        "unmapped-model" = @{ artificialAnalysis = $null; liveBench = $null }
    }
    $aa = [pscustomobject]@{
        status = "ok"; message = "ok"; sourceDate = "2026-06-30"; fetchedAtUtc = "2026-06-30T00:00:00Z"; sourceUrl = "x"
        models = @{ "claude-sonnet-5" = [pscustomobject]@{ slug = "claude-sonnet-5"; name = "Claude Sonnet 5"; agenticIndex = 46.6 } }
    }
    $lb = [pscustomobject]@{
        status = "ok"; message = "ok"; sourceDate = "2026-06-25"; fetchedAtUtc = "2026-06-25T00:00:00Z"; sourceUrl = "y"
        models = @{ "claude-sonnet-5-xhigh-effort" = [pscustomobject]@{ coding = 80; agenticCoding = 70; reasoning = 85; instructionFollowing = 72 } }
    }
    $resolved = Resolve-ModelRankingSnapshot -ValidModels @("claude-sonnet-5", "unmapped-model") -Aliases $aliases -ArtificialAnalysisData $aa -LiveBenchData $lb
    Assert-True ($resolved.snapshot.models."unmapped-model".artificialAnalysis.bucket -eq "n/a") "Unmapped AA should be n/a."
    Assert-True ($resolved.snapshot.models."unmapped-model".liveBench.buckets.coding -eq "n/a") "Unmapped LB should be n/a."
}

Run-Test "Buckets deterministic and less than three scored are competitive" {
    $bucketed = Get-RankingBucketAssignments -ScoresByModel @{ a = 10; b = 20; c = $null }
    Assert-True ($bucketed.a -eq "competitive") "Expected competitive for <3 scored."
    Assert-True ($bucketed.b -eq "competitive") "Expected competitive for <3 scored."
    Assert-True ($bucketed.c -eq "n/a") "Expected n/a for missing."
}

Run-Test "Fallback snapshot used when live sources fail" {
    $fallback = ConvertFrom-Json (Get-Content -Path (Join-Path $fixtureRoot "snapshot-fallback-stale.json") -Raw)
    $aliases = @{ "claude-sonnet-5" = @{ artificialAnalysis = "claude-sonnet-5"; liveBench = "claude-sonnet-5-xhigh-effort" } }
    $aa = [pscustomobject]@{ status = "error"; message = "fail"; models = @{}; sourceDate = $null; fetchedAtUtc = "x"; sourceUrl = "x" }
    $lb = [pscustomobject]@{ status = "error"; message = "fail"; models = @{}; sourceDate = $null; fetchedAtUtc = "y"; sourceUrl = "y" }
    $resolved = Resolve-ModelRankingSnapshot -ValidModels @("claude-sonnet-5") -Aliases $aliases -ArtificialAnalysisData $aa -LiveBenchData $lb -FallbackSnapshot $fallback -NowUtc ([datetime]"2026-03-01T00:00:00Z")
    Assert-True ($resolved.snapshot.status -eq "fallback") "Expected fallback status."
    Assert-True ([bool]$resolved.snapshot.fallbackUsed) "Expected fallbackUsed true."
}

Run-Test "Partial source success does not replace last-good snapshot" {
    $fallback = ConvertFrom-Json (Get-Content -Path (Join-Path $fixtureRoot "snapshot-fallback-stale.json") -Raw)
    $aliases = @{ "claude-sonnet-5" = @{ artificialAnalysis = "claude-sonnet-5"; liveBench = "claude-sonnet-5-xhigh-effort" } }
    $aa = [pscustomobject]@{
        status = "ok"; message = "ok"; sourceDate = "2026-07-24"; fetchedAtUtc = "x"; sourceUrl = "x"
        models = @{ "claude-sonnet-5" = [pscustomobject]@{ slug = "claude-sonnet-5"; name = "Claude Sonnet 5"; agenticIndex = 46.6 } }
    }
    $lb = [pscustomobject]@{ status = "error"; message = "fail"; models = @{}; sourceDate = $null; fetchedAtUtc = "y"; sourceUrl = "y" }
    $resolved = Resolve-ModelRankingSnapshot -ValidModels @("claude-sonnet-5") -Aliases $aliases -ArtificialAnalysisData $aa -LiveBenchData $lb -FallbackSnapshot $fallback
    Assert-True ($resolved.snapshot.status -eq "partial") "Expected partial status."
    Assert-True (-not [bool]$resolved.shouldWriteSnapshot) "Partial data must not replace last-good snapshot."
    Assert-True ($resolved.snapshot.models."claude-sonnet-5".artificialAnalysis.bucket -eq "competitive") "Expected current valid AA data in advisory result."
}

Run-Test "No snapshot and both fail returns unavailable without throwing" {
    $aliases = @{ "claude-sonnet-5" = @{ artificialAnalysis = "claude-sonnet-5"; liveBench = "claude-sonnet-5-xhigh-effort" } }
    $aa = [pscustomobject]@{ status = "error"; message = "fail"; models = @{}; sourceDate = $null; fetchedAtUtc = "x"; sourceUrl = "x" }
    $lb = [pscustomobject]@{ status = "error"; message = "fail"; models = @{}; sourceDate = $null; fetchedAtUtc = "y"; sourceUrl = "y" }
    $resolved = Resolve-ModelRankingSnapshot -ValidModels @("claude-sonnet-5") -Aliases $aliases -ArtificialAnalysisData $aa -LiveBenchData $lb
    Assert-True ($resolved.snapshot.status -eq "unavailable") "Expected unavailable status."
}

Run-Test "Empty placeholder snapshot is not treated as fallback" {
    $placeholder = [pscustomobject]@{
        schemaVersion = 1
        generatedAtUtc = $null
        staleAfterDays = 45
        status = "unavailable"
        stale = $false
        fallbackUsed = $false
        models = [pscustomobject]@{}
    }
    $aliases = @{ "claude-sonnet-5" = @{ artificialAnalysis = "claude-sonnet-5"; liveBench = "claude-sonnet-5-xhigh-effort" } }
    $aa = [pscustomobject]@{ status = "error"; message = "fail"; models = @{}; sourceDate = $null; fetchedAtUtc = "x"; sourceUrl = "x" }
    $lb = [pscustomobject]@{ status = "error"; message = "fail"; models = @{}; sourceDate = $null; fetchedAtUtc = "y"; sourceUrl = "y" }
    $resolved = Resolve-ModelRankingSnapshot -ValidModels @("claude-sonnet-5") -Aliases $aliases -ArtificialAnalysisData $aa -LiveBenchData $lb -FallbackSnapshot $placeholder
    Assert-True ($resolved.snapshot.status -eq "unavailable") "Empty placeholder should not become fallback."
    Assert-True (-not [bool]$resolved.snapshot.fallbackUsed) "Empty placeholder should not set fallbackUsed."
}

Run-Test "Stale snapshot is labelled stale" {
    $fallback = ConvertFrom-Json (Get-Content -Path (Join-Path $fixtureRoot "snapshot-fallback-stale.json") -Raw)
    $aliases = @{ "claude-sonnet-5" = @{ artificialAnalysis = "claude-sonnet-5"; liveBench = "claude-sonnet-5-xhigh-effort" } }
    $aa = [pscustomobject]@{ status = "error"; message = "fail"; models = @{}; sourceDate = $null; fetchedAtUtc = "x"; sourceUrl = "x" }
    $lb = [pscustomobject]@{ status = "error"; message = "fail"; models = @{}; sourceDate = $null; fetchedAtUtc = "y"; sourceUrl = "y" }
    $resolved = Resolve-ModelRankingSnapshot -ValidModels @("claude-sonnet-5") -Aliases $aliases -ArtificialAnalysisData $aa -LiveBenchData $lb -FallbackSnapshot $fallback -NowUtc ([datetime]"2026-07-30T00:00:00Z")
    Assert-True ([bool]$resolved.snapshot.stale) "Expected stale flag."
}

Run-Test "Regression safety integration does not alter selection contract" {
    $reviewScript = Get-Content -Path (Join-Path $PSScriptRoot "review-task-profiles.ps1") -Raw
    $selectionIdx = $reviewScript.IndexOf("Get-PreferredModelForProfile")
    $rankingIdx = $reviewScript.IndexOf("Get-AdvisoryModelRankingSnapshot")
    Assert-True ($selectionIdx -ge 0) "Selection function reference missing."
    Assert-True ($rankingIdx -gt $selectionIdx) "Ranking invocation should appear after selection logic."
    Assert-True ($reviewScript -match '\$preferredModel = Get-PreferredModelForProfile -ProfileKey \$profileKey -ValidModels \$validModels') "Expected selection call to remain based on valid model policy only."
}

Run-Test "Report renders buckets for hyphenated model IDs" {
    $snapshot = ConvertFrom-Json @'
{
  "status": "ok",
  "stale": false,
  "fallbackUsed": false,
  "message": "fixture",
  "attribution": {
    "artificialAnalysisUrl": "https://example.test/aa",
    "liveBenchUrl": "https://example.test/lb"
  },
  "sourceStatus": {
    "artificialAnalysis": { "sourceDate": "2026-07-24", "fetchedAtUtc": "2026-07-30T00:00:00Z" },
    "liveBench": { "sourceDate": "2026-06-25", "fetchedAtUtc": "2026-07-30T00:00:00Z" }
  },
  "models": {
    "claude-sonnet-5": {
      "artificialAnalysis": { "bucket": "competitive" },
      "liveBench": {
        "buckets": {
          "coding": "top",
          "agenticCoding": "competitive",
          "reasoning": "top",
          "instructionFollowing": "competitive"
        }
      }
    }
  }
}
'@
    $lines = Get-ModelRankingReportLines -Snapshot $snapshot -ValidModels @("claude-sonnet-5")
    Assert-True (($lines -join "`n") -match '\| claude-sonnet-5 \| competitive \| top \| competitive \| top \| competitive \|') "Expected rendered buckets for hyphenated model ID."
}

Run-Test "Report renders live ordered dictionary snapshots" {
    $snapshot = [ordered]@{
        status = "ok"
        stale = $false
        fallbackUsed = $false
        message = "fixture"
        attribution = [ordered]@{
            artificialAnalysisUrl = "https://example.test/aa"
            liveBenchUrl = "https://example.test/lb"
        }
        sourceStatus = [ordered]@{
            artificialAnalysis = [ordered]@{ sourceDate = "2026-07-24"; fetchedAtUtc = "2026-07-30T00:00:00Z" }
            liveBench = [ordered]@{ sourceDate = "2026-06-25"; fetchedAtUtc = "2026-07-30T00:00:00Z" }
        }
        models = [ordered]@{
            "claude-sonnet-5" = [ordered]@{
                artificialAnalysis = [ordered]@{ bucket = "top" }
                liveBench = [ordered]@{
                    buckets = [ordered]@{
                        coding = "competitive"
                        agenticCoding = "top"
                        reasoning = "top"
                        instructionFollowing = "competitive"
                    }
                }
            }
        }
    }
    $lines = Get-ModelRankingReportLines -Snapshot $snapshot -ValidModels @("claude-sonnet-5")
    Assert-True (($lines -join "`n") -match '\| claude-sonnet-5 \| top \| competitive \| top \| top \| competitive \|') "Expected rendered buckets from ordered dictionary snapshot."
}

Write-Host ""
Write-Host "Tests passed: $script:Passed"
Write-Host "Tests failed: $script:Failed"
if ($script:Failed -gt 0) {
    exit 1
}
