Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"
. (Join-Path $PSScriptRoot "model-onboarding.ps1")
. (Join-Path $PSScriptRoot "model-availability.ps1")
. (Join-Path $PSScriptRoot "model-policy-config.ps1")
. (Join-Path $PSScriptRoot "model-discovery-snapshot.ps1")

function Update-LocalModelDiscovery {
    param(
        [string]$RepoRoot=(Split-Path $PSScriptRoot -Parent),
        [scriptblock]$RuntimeProbe={Get-RuntimeModelCatalog},
        [scriptblock]$HelpProbe={Get-ModelAvailability},
        [datetime]$NowUtc=[datetime]::UtcNow
    )
    $policy=Get-ModelPolicyConfig (Join-Path $RepoRoot "config\model-policy.json")
    $runtime=& $RuntimeProbe
    $help=& $HelpProbe
    if(-not $PSBoundParameters.ContainsKey("NowUtc")){$NowUtc=[datetime]::UtcNow}
    $snapshot=New-ModelDiscoverySnapshot -Availability $help -RuntimeCatalog $runtime
    $check=Resolve-ModelDiscoverySnapshot -Snapshot $snapshot -MaxAgeDays $policy.consensusPolicy.discoveryFreshnessDays -NowUtc $NowUtc
    if($check.status -ne "valid"){
        throw "Local discovery failed; previous snapshot was not overwritten. Authenticate your local CLI with your own account and retry. $($check.message) $((Get-ObjectMemberValue $runtime 'message'))"
    }
    $path=Join-Path $RepoRoot "data\model-discovery-snapshot.json"
    Write-ModelJsonAtomic -SnapshotPath $path -SnapshotObject $snapshot
    Write-Host "Refreshed sanitized model metadata: $path"
    Write-Host "Observed locally at $($snapshot.observedAtUtc); valid for $($policy.consensusPolicy.discoveryFreshnessDays) days. Review and commit/push this metadata before running the remote review Action. Credentials were not exported."
    return $snapshot
}

if($MyInvocation.InvocationName -ne '.'){Update-LocalModelDiscovery | Out-Null}
