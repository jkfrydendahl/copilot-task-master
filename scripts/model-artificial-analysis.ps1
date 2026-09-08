Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

$script:ArtificialAnalysisLlmModelsApiUrl = "https://artificialanalysis.ai/api/v2/data/llms/models"
$script:ArtificialAnalysisCodingAgentsUrl = "https://artificialanalysis.ai/agents/coding-agents"

function Invoke-ArtificialAnalysisApiFetch {
    [OutputType([pscustomobject])]
    param(
        [Parameter(Mandatory = $true)][string]$Url,
        [string]$ApiKeyEnvVarName = "ARTIFICIAL_ANALYSIS_API_KEY",
        [int]$TimeoutSec = 30
    )

    $apiKey = [Environment]::GetEnvironmentVariable($ApiKeyEnvVarName, "Process")
    if ([string]::IsNullOrWhiteSpace([string]$apiKey)) {
        return [pscustomobject]@{
            status = "error"
            value = $null
            error = "Missing or empty environment variable '$ApiKeyEnvVarName'."
            statusCode = $null
            retryAfterSeconds = $null
            rateLimitLimit = $null
            rateLimitRemaining = $null
            rateLimitReset = $null
        }
    }

    try {
        $headers = @{
            "User-Agent" = "copilot-task-master-model-ranking"
            "x-api-key" = $apiKey
        }
        $response = Invoke-WebRequest -Uri $Url -TimeoutSec $TimeoutSec -Headers $headers

        $parsed = $null
        if (-not [string]::IsNullOrWhiteSpace([string]$response.Content)) {
            $parsed = ConvertFrom-JsonAsHashtableCompat -JsonText ([string]$response.Content)
        }

        return [pscustomobject]@{
            status = "ok"
            value = $parsed
            error = $null
            statusCode = [int]$response.StatusCode
            retryAfterSeconds = $null
            rateLimitLimit = [string]$response.Headers["X-RateLimit-Limit"]
            rateLimitRemaining = [string]$response.Headers["X-RateLimit-Remaining"]
            rateLimitReset = [string]$response.Headers["X-RateLimit-Reset"]
        }
    } catch {
        $statusCode = $null
        $retryAfter = $null
        $rateLimitLimit = $null
        $rateLimitRemaining = $null
        $rateLimitReset = $null
        $message = $_.Exception.Message

        if ($null -ne $_.Exception.Response) {
            try { $statusCode = [int]$_.Exception.Response.StatusCode } catch { }
            try { $retryAfter = [string]$_.Exception.Response.Headers["Retry-After"] } catch { }
            try { $rateLimitLimit = [string]$_.Exception.Response.Headers["X-RateLimit-Limit"] } catch { }
            try { $rateLimitRemaining = [string]$_.Exception.Response.Headers["X-RateLimit-Remaining"] } catch { }
            try { $rateLimitReset = [string]$_.Exception.Response.Headers["X-RateLimit-Reset"] } catch { }
        }

        if ($statusCode -eq 429 -and -not [string]::IsNullOrWhiteSpace($retryAfter)) {
            $message = "Artificial Analysis API rate limited (HTTP 429). Retry-After: $retryAfter seconds."
        }

        return [pscustomobject]@{
            status = "error"
            value = $null
            error = $message
            statusCode = $statusCode
            retryAfterSeconds = $retryAfter
            rateLimitLimit = $rateLimitLimit
            rateLimitRemaining = $rateLimitRemaining
            rateLimitReset = $rateLimitReset
        }
    }
}

function Get-ModelScoreFingerprint {
    param(
        [Parameter(Mandatory = $true)][System.Collections.IDictionary]$Models,
        [Parameter(Mandatory = $true)][string]$ScoreProperty
    )
    $parts = foreach ($key in @($Models.Keys | Sort-Object)) {
        $score = Get-ObjectMemberValue -InputObject $Models[$key] -Name $ScoreProperty
        if ($null -ne $score) {
            "{0}={1}" -f $key, ([double]$score).ToString("R", [System.Globalization.CultureInfo]::InvariantCulture)
        }
    }
    if (@($parts).Count -eq 0) { return $null }
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes(($parts -join "`n"))
        return ([System.BitConverter]::ToString($sha.ComputeHash($bytes))).Replace("-", "").ToLowerInvariant()
    } finally {
        $sha.Dispose()
    }
}

function Get-ArtificialAnalysisSourceDateFromApiResponse {
    [OutputType([string])]
    param(
        [Parameter(Mandatory = $true)]$ApiResponse
    )

    foreach ($field in @("source_date", "sourceDate", "updated_at", "updatedAt", "last_updated", "lastUpdated", "generated_at", "generatedAt", "as_of_date", "asOfDate")) {
        $value = Get-ObjectMemberValue -InputObject $ApiResponse -Name $field
        if ([string]::IsNullOrWhiteSpace([string]$value)) { continue }
        $parsed = $null
        $styles = [System.Globalization.DateTimeStyles]::AssumeUniversal -bor [System.Globalization.DateTimeStyles]::AdjustToUniversal
        if ([datetime]::TryParse([string]$value, [System.Globalization.CultureInfo]::InvariantCulture, $styles, [ref]$parsed)) {
            return $parsed.ToString("yyyy-MM-dd")
        }
    }

    return $null
}

function Parse-ArtificialAnalysisLlmModelsFromApiResponse {
    [OutputType([pscustomobject])]
    param(
        [Parameter(Mandatory = $true)]$ApiResponse,
        [string]$SourceNameForMessages = "Artificial Analysis"
    )

    if ($null -eq $ApiResponse) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "$SourceNameForMessages API response was empty."
            models = @{}
            sourceDate = $null
        }
    }

    $data = Get-ObjectMemberValue -InputObject $ApiResponse -Name "data"
    if ($null -eq $data) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "$SourceNameForMessages API response did not contain a 'data' array."
            models = @{}
            sourceDate = $null
        }
    }

    $rows = @($data)
    if ($rows.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "$SourceNameForMessages API response contained an empty 'data' array."
            models = @{}
            sourceDate = $null
        }
    }

    $models = @{}
    foreach ($row in $rows) {
        $slug = [string](Get-ObjectMemberValue -InputObject $row -Name "slug")
        $name = [string](Get-ObjectMemberValue -InputObject $row -Name "name")
        if ([string]::IsNullOrWhiteSpace($slug)) { continue }

        $evaluations = Get-ObjectMemberValue -InputObject $row -Name "evaluations"
        if ($null -eq $evaluations) { continue }
        $intelligenceRaw = Get-ObjectMemberValue -InputObject $evaluations -Name "artificial_analysis_intelligence_index"
        $codingRaw = Get-ObjectMemberValue -InputObject $evaluations -Name "artificial_analysis_coding_index"

        $intelligence = $null
        if ($null -ne $intelligenceRaw) {
            $parsedIntelligence = 0.0
            if ([double]::TryParse(([string]$intelligenceRaw), [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$parsedIntelligence)) {
                $intelligence = $parsedIntelligence
            }
        }

        $coding = $null
        if ($null -ne $codingRaw) {
            $parsedCoding = 0.0
            if ([double]::TryParse(([string]$codingRaw), [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$parsedCoding)) {
                $coding = $parsedCoding
            }
        }

        if ($null -eq $intelligence -and $null -eq $coding) { continue }

        if ($models.ContainsKey($slug)) {
            $existingIntelligence = Get-ObjectMemberValue -InputObject $models[$slug] -Name "intelligenceIndex"
            $existingCoding = Get-ObjectMemberValue -InputObject $models[$slug] -Name "codingIndex"
            $intelligenceChanged = ($null -ne $existingIntelligence -or $null -ne $intelligence) -and ($null -eq $existingIntelligence -or $null -eq $intelligence -or [math]::Abs([double]$existingIntelligence - [double]$intelligence) -gt 0.000001)
            $codingChanged = ($null -ne $existingCoding -or $null -ne $coding) -and ($null -eq $existingCoding -or $null -eq $coding -or [math]::Abs([double]$existingCoding - [double]$coding) -gt 0.000001)
            if ($intelligenceChanged -or $codingChanged) {
                return [pscustomobject]@{
                    status = "unavailable"
                    message = "$SourceNameForMessages API data was ambiguous for model slug '$slug'."
                    models = @{}
                    sourceDate = $null
                }
            }
            continue
        }

        $entry = [ordered]@{
            slug = $slug; name = $name
            id = (Get-ObjectMemberValue $row "id")
            evaluations = $evaluations
        }
        $entry["intelligenceIndex"] = $intelligence
        $entry["codingIndex"] = $coding
        $models[$slug] = [pscustomobject]$entry
    }

    if ($models.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "$SourceNameForMessages API parsing found no numeric intelligence/coding index records."
            models = @{}
            sourceDate = $null
        }
    }

    return [pscustomobject]@{
        status = "ok"
        message = "Parsed Artificial Analysis Data API model records."
        models = $models
        sourceDate = Get-ArtificialAnalysisSourceDateFromApiResponse -ApiResponse $ApiResponse
    }
}

function Get-ArtificialAnalysisIntelligenceIndexData {
    [OutputType([pscustomobject])]
    param(
        [string]$Url = $script:ArtificialAnalysisLlmModelsApiUrl,
        [scriptblock]$FetchJson = $null,
        [string]$ApiKeyEnvVarName = "ARTIFICIAL_ANALYSIS_API_KEY"
    )

    $fetchedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
    if ($null -eq $FetchJson) {
        $FetchJson = { param($u, $envVarName) Invoke-ArtificialAnalysisApiFetch -Url $u -ApiKeyEnvVarName $envVarName -TimeoutSec 30 }
    }

    $fetchResult = & $FetchJson $Url $ApiKeyEnvVarName
    if ($fetchResult.status -ne "ok") {
        $message = "Fetch failed: $($fetchResult.error)"
        if ((Get-ObjectMemberValue -InputObject $fetchResult -Name "statusCode") -eq 429) {
            $retryAfter = Get-ObjectMemberValue -InputObject $fetchResult -Name "retryAfterSeconds"
            if (-not [string]::IsNullOrWhiteSpace([string]$retryAfter)) {
                $message = "Fetch failed: Artificial Analysis API rate limited (HTTP 429). Retry-After: $retryAfter seconds."
            }
        }
        return [pscustomobject]@{
            status = "error"
            message = $message
            models = @{}
            sourceDate = $null
            fetchedAtUtc = $fetchedAtUtc
            sourceUrl = $Url
        }
    }

    $parsed = Parse-ArtificialAnalysisLlmModelsFromApiResponse -ApiResponse $fetchResult.value -SourceNameForMessages "Artificial Analysis intelligence index"
    $intelligenceVersion = if ($parsed.status -eq "ok") { Get-ModelScoreFingerprint -Models $parsed.models -ScoreProperty "intelligenceIndex" } else { $null }
    $codingVersion = if ($parsed.status -eq "ok") { Get-ModelScoreFingerprint -Models $parsed.models -ScoreProperty "codingIndex" } else { $null }
    return [pscustomobject]@{
        status = $parsed.status
        message = $parsed.message
        models = $parsed.models
        sourceDate = $parsed.sourceDate
        sourceVersion = if ($parsed.status -eq "ok") { "$intelligenceVersion|$codingVersion" } else { $null }
        fetchedAtUtc = $fetchedAtUtc
        sourceUrl = $Url
    }
}

function Parse-ArtificialAnalysisCodingAgentIndexFromHtml {
    [OutputType([pscustomobject])]
    param(
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Html
    )

    # As of 2026-09: AA does not document a Data API endpoint for the harness-
    # specific Coding Agents leaderboard variants, so this parser remains the
    # authoritative source for coding-agent benchmark data.
    if ([string]::IsNullOrWhiteSpace($Html)) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "Artificial Analysis Coding Agents HTML was empty."
            models = @{}
            sourceDate = $null
        }
    }

    $normalizedHtml = $Html -replace '\\+"', '"'
    $pattern = '"label":"(?<label>[^"]+)","codingAgentsIndex":(?<codingAgentIndex>-?\d+(?:\.\d+)?)'
    $matches = [regex]::Matches($normalizedHtml, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    if ($matches.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "Artificial Analysis embedded coding-agent records with codingAgentsIndex were not found."
            models = @{}
            sourceDate = $null
        }
    }

    $models = @{}
    foreach ($match in $matches) {
        $label = [string]$match.Groups["label"].Value
        $scoreText = [string]$match.Groups["codingAgentIndex"].Value

        $score = 0.0
        if (-not [double]::TryParse($scoreText, [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$score)) {
            continue
        }

        if ($models.ContainsKey($label)) {
            if ([math]::Abs([double]$models[$label].codingAgentIndex - $score) -gt 0.000001) {
                return [pscustomobject]@{
                    status = "unavailable"
                    message = "Artificial Analysis coding-agent data was ambiguous for label '$label'."
                    models = @{}
                    sourceDate = $null
                }
            }
            continue
        }

        $models[$label] = [pscustomobject]@{
            label = $label
            name = $label
            codingAgentIndex = $score
        }
    }

    if ($models.Count -eq 0) {
        return [pscustomobject]@{
            status = "unavailable"
            message = "Artificial Analysis coding-agent parsing found no numeric records."
            models = @{}
            sourceDate = $null
        }
    }

    return [pscustomobject]@{
        status = "ok"
        message = "Parsed embedded coding-agent records."
        models = $models
        sourceDate = $null
    }
}

function Get-ArtificialAnalysisCodingAgentIndexData {
    [OutputType([pscustomobject])]
    param(
        [string]$Url = $script:ArtificialAnalysisCodingAgentsUrl,
        [scriptblock]$FetchText = $null
    )

    $fetchedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
    if ($null -eq $FetchText) {
        $FetchText = { param($u) Invoke-TextFetch -Url $u -TimeoutSec 30 }
    }

    $fetchResult = & $FetchText $Url
    if ($fetchResult.status -ne "ok") {
        return [pscustomobject]@{
            status = "error"
            message = "Fetch failed: $($fetchResult.error)"
            models = @{}
            sourceDate = $null
            fetchedAtUtc = $fetchedAtUtc
            sourceUrl = $Url
        }
    }

    $parsed = Parse-ArtificialAnalysisCodingAgentIndexFromHtml -Html ([string]$fetchResult.content)
    return [pscustomobject]@{
        status = $parsed.status
        message = $parsed.message
        models = $parsed.models
        sourceDate = $parsed.sourceDate
        sourceVersion = if ($parsed.status -eq "ok") { Get-ModelScoreFingerprint -Models $parsed.models -ScoreProperty "codingAgentIndex" } else { $null }
        fetchedAtUtc = $fetchedAtUtc
        sourceUrl = $Url
    }
}
