Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "model-pricing-data.ps1")
$script:Failed = 0
function Assert-True($Condition, $Message) { if (-not $Condition) { throw $Message } }
function Run-Test($Name, [scriptblock]$Action) {
    try { & $Action; Write-Host "PASS: $Name" } catch { $script:Failed++; Write-Host "FAIL: $Name -- $_" }
}
$html = @'
<table><thead><tr><th>Model</th><th>Tier</th><th>Threshold (input tokens)</th><th>Input</th><th>Cached input</th><th>Cache write</th><th>Output</th></tr></thead>
<tbody><tr><td>Example One</td><td>Default</td><td>&le; 200K</td><td>$2.00</td><td>$0.20</td><td>$2.50</td><td>$10.00</td></tr>
<tr><td>Example One</td><td>Long context</td><td>&gt; 200K</td><td>$4.00</td><td>$0.40</td><td>$5.00</td><td>$15.00</td></tr></tbody></table>
'@
Run-Test "Parses exact rates, cache prices and thresholds" {
    $p = ConvertFrom-GitHubPricingHtml $html
    Assert-True ($p["Example One"].default.inputPerMillion -eq 2) "Input"
    Assert-True ($p["Example One"].default.cacheWritePerMillion -eq 2.5) "Cache write"
    Assert-True ($p["Example One"].long_context.thresholdInputTokens -eq 200000) "Threshold"
    Assert-True ($p["Example One"].long_context.outputPerMillion -eq 15) "Long price"
}
Run-Test "Rejects malformed, negative, ambiguous and nonfinite prices" {
    foreach ($bad in @("", $html.Replace('$2.00', '$-2'), $html.Replace('$2.00', 'NaN'), ($html + $html), $html.Replace('<th>Output</th>', '<th>Unknown</th>'))) {
        $threw = $false
        try { ConvertFrom-GitHubPricingHtml $bad | Out-Null } catch [System.IO.InvalidDataException] { $threw = $true }
        Assert-True $threw "Bad pricing accepted"
    }
}
Run-Test "Refresh uses explicit aliases and preserves missing model timestamps" {
    $old = @{ schemaVersion = 1; models = @{ absent = @{ verifiedAtUtc = "2026-08-01T00:00:00Z"; tiers = @{ default = @{inputPerMillion=1; outputPerMillion=5} } } } }
    $r = Resolve-ModelPricingRefresh -Previous $old -Aliases @{ one = "Example One"; absent = "Missing" } -FetchResult @{status="ok"; content=$html} -NowUtc ([datetime]"2026-09-08Z")
    Assert-True ($r.snapshot.models.one.tiers.default.outputPerMillion -eq 10) "Current price"
    Assert-True ($r.snapshot.models.absent.verifiedAtUtc -eq "2026-08-01T00:00:00Z") "Missing timestamp changed"
    Assert-True ($r.diagnostics -match "Missing") "Missing row not reported"
    Assert-True (-not $old.models.ContainsKey("one")) "Previous snapshot mutated"
}
Run-Test "Fetch and parse failure preserve last known good data" {
    $old = @{schemaVersion=1; models=@{one=@{verifiedAtUtc="2026-08-01Z"; tiers=@{default=@{inputPerMillion=1;outputPerMillion=5}}}}}
    foreach ($f in @(@{status="error";error="HTTP 503"}, @{status="ok";content="<html>changed</html>"})) {
        $before = $old | ConvertTo-Json -Depth 10
        $r = Resolve-ModelPricingRefresh -Previous $old -Aliases @{one="Example One"} -FetchResult $f
        Assert-True (-not $r.shouldWrite) "Failure requests write"
        Assert-True (($r.snapshot | ConvertTo-Json -Depth 10) -eq $before) "Fallback mutated"
        Assert-True ($r.diagnostics.Count -gt 0) "Silent failure"
    }
}
Run-Test "Rejects duplicate local aliases rather than duplicating a price identity" {
    $threw = $false
    try { Resolve-ModelPricingRefresh -Aliases @{one="Example One";two="Example One"} -FetchResult @{status="ok";content=$html} } catch { $threw=$true }
    Assert-True $threw "Ambiguous local config accepted"
}
Run-Test "Pricing file refresh is atomic on failure and does not touch capabilities" {
    $root = Join-Path ([System.IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory $root | Out-Null
    $path = Join-Path $root "prices.json"
    try {
        $r = Update-ModelPricingSnapshot -SnapshotPath $path -Aliases @{one="Example One"} -FetchText { param($url) @{status="ok";content=$html} }
        $before = [System.IO.File]::ReadAllBytes($path)
        $r = Update-ModelPricingSnapshot -SnapshotPath $path -Aliases @{one="Example One"} -FetchText { param($url) @{status="ok";content="bad"} }
        Assert-True ($r.status -eq "degraded") "Failure state"
        Assert-True ([Convert]::ToBase64String($before) -eq [Convert]::ToBase64String([System.IO.File]::ReadAllBytes($path))) "Failed refresh changed disk"
    } finally { if (Test-Path $path) { Remove-Item -LiteralPath $path }; Remove-Item -LiteralPath $root }
}
Run-Test "Price change detection ignores JSON property ordering" {
    $r=Resolve-ModelPricingRefresh -Aliases @{one="Example One"} -FetchResult @{status="ok";content=$html}
    $old=$r.snapshot
    foreach ($keys in @(@("long_context","default"),@("default","long_context"))) {
        $tiers=[ordered]@{};foreach($key in $keys){$tiers[$key]=$old.models.one.tiers[$key]}
        $old.models.one.tiers=$tiers
        $r=Resolve-ModelPricingRefresh -Previous $old -Aliases @{one="Example One"} -FetchResult @{status="ok";content=$html}
        Assert-True ($r.changes.Count -eq 0) "Ordering reported as price change"
    }
}
Run-Test "Missing published tier retains the whole model and its verification date" {
    $r=Resolve-ModelPricingRefresh -Aliases @{one="Example One"} -FetchResult @{status="ok";content=$html} -NowUtc ([datetime]"2026-09-01Z")
    $missingTier=$html -replace '(?s)<tr><td>Example One</td><td>Long context</td>.*?</tr>',''
    $s=Resolve-ModelPricingRefresh -Previous $r.snapshot -Aliases @{one="Example One"} -FetchResult @{status="ok";content=$missingTier} -NowUtc ([datetime]"2026-09-08Z")
    Assert-True ($s.snapshot.models.one.verifiedAtUtc -eq $r.snapshot.models.one.verifiedAtUtc) "Partial tier refreshed timestamp"
    Assert-True ($s.snapshot.models.one.tiers.Contains("long_context")) "Known tier discarded"
}
if ($script:Failed) { exit 1 }
