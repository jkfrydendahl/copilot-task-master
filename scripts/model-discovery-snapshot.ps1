Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")

function New-ModelDiscoverySnapshot {
    param($Availability, $RuntimeCatalog)
    $models = @(foreach ($model in @(Get-ObjectMemberValue $RuntimeCatalog "models")) {
        $clean = @{}
        foreach ($field in @("id","name","vision","toolCalls","reasoningEffort","maxContextTokens",
            "supportedReasoningEfforts","supportedContextTiers","policyState")) {
            if (-not (Test-ObjectMember $model $field)) { continue }
            $value=$model.$field
            $valid=if($null -eq $value){$true}
                elseif($field -in @("supportedReasoningEfforts","supportedContextTiers")){
                    $value -is [array] -and -not @($value | Where-Object {$_ -isnot [string]}).Count
                }elseif($field -in @("vision","toolCalls","reasoningEffort")){$value -is [bool]}
                elseif($field -eq "maxContextTokens"){Test-ModelScore $value 0 ([double]::MaxValue)}
                else{$value -is [string]}
            if($valid){$clean[$field]=$value}
        }
        $prices=Get-ObjectMemberValue $model "tokenPrices"
        if ($prices -is [System.Collections.IDictionary]) {
            $clean.tokenPrices=@{}
            foreach ($tier in @("default","longContext")) {
                $input=if($tier -eq "default"){$prices}else{Get-ObjectMemberValue $prices $tier}
                if ($null -eq $input) { continue }
                $output=@{}
                foreach ($field in @("inputPrice","outputPrice","cachePrice","cacheReadPrice","cacheWritePrice",
                    "cacheWrite1hPrice","batchSize","contextMax","maxPromptTokens")) {
                    $value=Get-ObjectMemberValue $input $field
                    if(Test-ModelScore $value 0 ([double]::MaxValue)){$output[$field]=$value}
                }
                if($tier -eq "default"){$clean.tokenPrices=$output}else{$clean.tokenPrices.longContext=$output}
            }
        }
        $clean
    })
    return @{
        schemaVersion=1
        observedAtUtc=(Get-ObjectMemberValue $RuntimeCatalog "fetchedAtUtc")
        availability=@{models=@($Availability.models);verified=$Availability.verified;source="locally captured CLI help"}
        runtime=@{
            status=(Get-ObjectMemberValue $RuntimeCatalog "status")
            authenticated=(Get-ObjectMemberValue $RuntimeCatalog "authenticated")
            source="copilot-sdk models.list; captured locally"
            runtimeVersion=$(if((Get-ObjectMemberValue $RuntimeCatalog "runtimeVersion") -is [string]){$RuntimeCatalog.runtimeVersion}else{$null})
            fetchedAtUtc=(Get-ObjectMemberValue $RuntimeCatalog "fetchedAtUtc")
            models=$models
        }
    }
}

function Resolve-ModelDiscoverySnapshot {
    param($Snapshot, [int]$MaxAgeDays, [datetime]$NowUtc=[datetime]::UtcNow)
    $observed=Get-ObjectMemberValue $Snapshot "observedAtUtc"
    $runtime=Get-ObjectMemberValue $Snapshot "runtime"
    $help=Get-ObjectMemberValue $Snapshot "availability"
    $models=if(Test-ObjectMember $runtime "models"){,$runtime.models}else{$null}
    $helpModels=if(Test-ObjectMember $help "models"){,$help.models}else{$null}
    $helpVerified=Get-ObjectMemberValue $help "verified"
    $authenticated=Get-ObjectMemberValue $runtime "authenticated"
    $status="invalid"
    if($null -eq $Snapshot){$status="missing"}
    elseif((Get-ObjectMemberValue $Snapshot "schemaVersion") -eq 1 -and
        $models -is [array] -and $models.Count -gt 0 -and $helpModels -is [array] -and
        $helpVerified -is [bool] -and $authenticated -is [bool] -and $authenticated -and
        (Get-ObjectMemberValue $runtime "status") -eq "ok"){
        $ids=@($models | ForEach-Object {Get-ObjectMemberValue $_ "id"})
        $badIds=@(@($ids)+@($helpModels) | Where-Object {$_ -isnot [string] -or $_ -notmatch '^[a-z0-9][a-z0-9.-]*$'})
        $runtimeDate=Get-ObjectMemberValue $runtime "fetchedAtUtc"
        if($ids.Count -eq $models.Count -and -not $badIds.Count -and
            @($ids | Sort-Object -Unique).Count -eq $ids.Count -and
            (Test-ModelDataFresh $observed ([int]::MaxValue) $NowUtc) -and
            (Test-ModelDataFresh $runtimeDate ([int]::MaxValue) $NowUtc) -and
            [datetime]$observed -eq [datetime]$runtimeDate){
            $status=if(Test-ModelDataFresh $observed $MaxAgeDays $NowUtc){"valid"}else{"expired"}
        }
    }
    $message="Local model-discovery snapshot is $status (validity: $MaxAgeDays days)."
    $source="local model-discovery snapshot; status=$status; observed=$observed; validity=$MaxAgeDays days; not live-verified by this review"
    if($status -eq "valid"){
        $clean=New-ModelDiscoverySnapshot -Availability $help -RuntimeCatalog $runtime
        $availability=$clean.availability
        $availability.source=$source
        $catalog=$clean.runtime
    }else{
        $message+=" Refresh locally with scripts\refresh-model-catalog.ps1 using your own credentials, then commit and push the metadata. Profile changes are blocked, including force."
        $availability=@{models=@();verified=$false;source=$source}
        $catalog=@{status="unavailable";authenticated=$false;models=@();message=$message}
    }
    $availability.discoverySnapshot=@{status=$status;observedAtUtc=$observed;maxAgeDays=$MaxAgeDays;message=$message}
    return @{availability=$availability;runtime=$catalog;status=$status;message=$message}
}

function Read-ModelDiscoverySnapshot {
    param([string]$Path, [int]$MaxAgeDays, [datetime]$NowUtc=[datetime]::UtcNow)
    $snapshot=$null
    if(Test-Path -LiteralPath $Path){
        $json=Get-Content -LiteralPath $Path -Raw
        try{
            $snapshot=if([string]::IsNullOrWhiteSpace($json)){@{schemaVersion="invalid"}}else{ConvertFrom-JsonAsHashtableCompat $json}
        }
        catch [System.ArgumentException] {$snapshot=@{schemaVersion="invalid"}}
        if($null -eq $snapshot){$snapshot=@{schemaVersion="invalid"}}
    }
    return Resolve-ModelDiscoverySnapshot -Snapshot $snapshot -MaxAgeDays $MaxAgeDays -NowUtc $NowUtc
}
