Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot "model-data-common.ps1")
. (Join-Path $PSScriptRoot "model-pricing-data.ps1")

function Get-RuntimeModelCatalog {
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        return @{status="unavailable";authenticated=$false;models=@();message="Node.js unavailable; install dependencies with npm ci."}
    }
    $output = @(& node (Join-Path $PSScriptRoot "get-runtime-models.mjs") 2>&1)
    try { $result = ConvertFrom-JsonAsHashtableCompat ($output -join "`n") }
    catch [System.ArgumentException] {
        return @{status="error";authenticated=$false;models=@();message="Runtime adapter returned invalid JSON; check Node.js and run npm ci."}
    }
    if ($null -eq $result -or (Get-ObjectMemberValue $result "status") -notin @("ok","unavailable","error")) {
        return @{status="error";authenticated=$false;models=@();message="Runtime adapter returned an invalid catalog envelope."}
    }
    return $result
}

function Get-OnboardingIdentityKey {
    param([string]$Value)
    return ($Value.ToLowerInvariant() -replace '[ ._-]', '')
}

function Resolve-ModelOnboarding {
    param($Availability, $RuntimeCatalog, $CapabilityCatalog, $AliasConfig, $PricingAliasConfig,
        [hashtable]$Sources, $PricingFetch, $Policy, [datetime]$NowUtc = [datetime]::UtcNow)
    $capabilities = ConvertTo-CanonicalModelData $CapabilityCatalog
    $aliases = ConvertTo-CanonicalModelData $AliasConfig
    $pricingAliases = ConvertTo-CanonicalModelData $PricingAliasConfig
    $rows = [System.Collections.Generic.List[object]]::new()
    $diagnostics = [System.Collections.Generic.List[string]]::new()
    $changes = [System.Collections.Generic.List[object]]::new()
    $rejectedMappings = [System.Collections.Generic.List[object]]::new()
    $runtimeFresh = (Get-ObjectMemberValue $RuntimeCatalog "status") -eq "ok" -and
        (Get-ObjectMemberValue $RuntimeCatalog "authenticated") -eq $true -and
        (Test-ModelDataFresh (Get-ObjectMemberValue $RuntimeCatalog "fetchedAtUtc") $Policy.consensusPolicy.discoveryFreshnessDays $NowUtc)
    $runtimeModels = if ($runtimeFresh) { @(Get-ObjectMemberValue $RuntimeCatalog "models") } else { @() }
    if (-not $runtimeFresh) {
        $diagnostics.Add("Recorded runtime metadata unavailable or unauthenticated: $((Get-ObjectMemberValue $RuntimeCatalog 'message')). Discovery is degraded. Refresh model metadata locally using your own credentials, then commit and push it; the remote review does not authenticate.")
    }
    $prices = @{}
    if ($PricingFetch.status -eq "ok") {
        try { $prices = ConvertFrom-GitHubPricingHtml $PricingFetch.content }
        catch [System.IO.InvalidDataException] { $diagnostics.Add("Onboarding pricing parse failed: $($_.Exception.Message)") }
    } else { $diagnostics.Add("Onboarding pricing fetch failed: $($PricingFetch.error)") }
    $runtimeById = @{}
    $componentSource=Get-ObjectMemberValue $Sources "artificialAnalysisComponents"
    $componentFresh=(Get-ObjectMemberValue $componentSource "status") -eq "ok" -and
        (Test-ModelDataFresh (Get-ObjectMemberValue $componentSource "fetchedAtUtc") $Policy.consensusPolicy.staleAfterDays $NowUtc)
    $identities=Get-ObjectMemberValue $componentSource "identities"
    $proofs=Get-ObjectMemberValue $aliases "onboardingProofs"
    if($componentFresh -and $identities -is [System.Collections.IDictionary] -and $proofs -is [System.Collections.IDictionary]){
        foreach($key in $proofs.Keys){
            $parts=$key.Split("/")
            if($parts.Count -ne 3 -or $parts[1] -ne "artificialAnalysis"){throw "Invalid onboarding proof key: $key"}
            $proof=$proofs[$key]
            $identity=Get-ObjectMemberValue $identities $proof.alias
            if($null -ne $identity -and (
                (Get-ObjectMemberValue $identity "status") -ne "verified" -or
                (Get-ObjectMemberValue $identity "releaseId") -ne $proof.releaseId -or
                (Get-ObjectMemberValue $identity "effort") -ne $proof.effort)){
                $rejectedMappings.Add(@{model=$parts[0];source=$parts[1];effort=$proof.effort;alias=$proof.alias})
            }
        }
    }
    $blocked = @("auto") + @($Policy.denylist)
    foreach ($record in $runtimeModels) {
        $id = Get-ObjectMemberValue $record "id"
        if ($id -isnot [string] -or $id -notmatch '^[a-z0-9][a-z0-9.-]*$') {
            $diagnostics.Add("Runtime model identity invalid; record ignored.")
            continue
        }
        if ($runtimeById.ContainsKey($id)) { $blocked += $id; $diagnostics.Add("${id}: duplicate runtime identity"); continue }
        $runtimeById[$id] = $record
        if ((Get-ObjectMemberValue $record "policyState") -eq "disabled") { $blocked += $id }
    }
    $discovered = @(@($Availability.models) + @($runtimeById.Keys) + @($capabilities.models.Keys) | Sort-Object -Unique)
    $available = @(if ($Availability.verified) { $Availability.models | Where-Object { $_ -notin $blocked } })
    foreach ($id in @($runtimeById.Keys | Sort-Object)) {
        $record = $runtimeById[$id]
        if ($id -notin $blocked -and (Get-ObjectMemberValue $record "policyState") -eq "enabled") { $available += $id }
    }
    foreach ($id in $discovered) {
        $reasons = [System.Collections.Generic.List[string]]::new()
        foreach($mapping in @($rejectedMappings | Where-Object model -eq $id)){
            $reasons.Add("artificialAnalysis/$($mapping.effort): published_identity_changed; mapping quarantined for this run")
        }
        $before = ConvertTo-CanonicalModelData @{
            capability=(Get-ObjectMemberValue $capabilities.models $id)
            benchmarks=(Get-ObjectMemberValue $aliases.aliases $id)
            pricing=(Get-ObjectMemberValue $pricingAliases.aliases $id)
        }
        $record = Get-ObjectMemberValue $runtimeById $id
        if ($id -in $blocked) {
            $reasons.Add("denylisted_disabled_virtual_or_ambiguous")
        } elseif ($null -eq $record -or (Get-ObjectMemberValue $record "policyState") -ne "enabled") {
            $reasons.Add("enabled_runtime_metadata_missing; existing facts retain their original verification dates")
        } else {
            $efforts = if(Test-ObjectMember $record "supportedReasoningEfforts"){,$record.supportedReasoningEfforts}else{$null}
            $effortMode = Get-ObjectMemberValue $record "reasoningEffort"
            $effortsValid = $efforts -is [array] -and $efforts.Count -gt 0 -and
                -not @($efforts | Where-Object { $_ -notin @("none","minimal","low","medium","high","xhigh","max") }).Count -and
                @($efforts | Sort-Object -Unique).Count -eq $efforts.Count
            $native = $effortMode -is [bool] -and -not $effortMode -and
                ($null -eq $efforts -or ($efforts -is [array] -and $efforts.Count -eq 0))
            $contexts = @("default")
            $contextTiers = if(Test-ObjectMember $record "supportedContextTiers"){,$record.supportedContextTiers}else{$null}
            $long = Get-ObjectMemberValue (Get-ObjectMemberValue $record "tokenPrices") "longContext"
            $longLimit = Get-ObjectMemberValue $long "maxPromptTokens"
            if ($null -eq $longLimit) { $longLimit = Get-ObjectMemberValue $long "contextMax" }
            $validLong = $long -is [System.Collections.IDictionary] -and (Test-ModelScore $longLimit 1 ([double]::MaxValue))
            if (($contextTiers -is [array] -and "long_context" -in $contextTiers) -or $validLong) { $contexts += "long_context" }
            $maxContext = Get-ObjectMemberValue $record "maxContextTokens"
            $validContext = (Test-ModelScore $maxContext 1 ([double]::MaxValue)) -and
                ($null -eq $long -or $validLong) -and
                ($null -eq $contextTiers -or ($contextTiers -is [array] -and
                    -not @($contextTiers | Where-Object { $_ -notin @("default","long_context") }).Count))
            $vision = Get-ObjectMemberValue $record "vision"
            $toolCalls = Get-ObjectMemberValue $record "toolCalls"
            if ($toolCalls -isnot [bool] -or -not $toolCalls -or -not $validContext -or
                (-not $native -and (-not $effortsValid -or $effortMode -isnot [bool] -or -not $effortMode))) {
                $reasons.Add("runtime_capabilities_incomplete_or_conflicting")
                if ($toolCalls -is [bool] -and -not $toolCalls) {
                    $blocked += $id
                    $available = @($available | Where-Object { $_ -ne $id })
                }
            } elseif ($null -ne $before.capability -and
                @($before.capability.supportedContexts | Where-Object { $_ -notin $contexts }).Count) {
                $reasons.Add("existing_context_facts_not_reverified; capability timestamp unchanged")
            } elseif ($null -ne $before.capability -and $null -ne $before.capability.vision -and $vision -isnot [bool]) {
                $reasons.Add("existing_vision_fact_not_reverified; capability timestamp unchanged")
            } else {
                $source = "copilot-sdk models.list; authenticated runtime $((Get-ObjectMemberValue $RuntimeCatalog 'runtimeVersion'))"
                $capabilities.models[$id] = @{
                    asOf=$RuntimeCatalog.fetchedAtUtc;capabilitySource=$source
                    vision=$(if ($vision -is [bool]) { $vision } else { $null });visionSource=$source
                    supportedContexts=$contexts
                    supportedEfforts=@(if (-not $native) { $efforts })
                    effortMode=$(if ($native) { "unsupported" } else { "supported" })
                }
            }
            $name = Get-ObjectMemberValue $record "name"
            $priceMatches = @($prices.Keys | Where-Object { $_ -ceq $name })
            $priceOwners = @($pricingAliases.aliases.Keys | Where-Object { $_ -ne $id -and $pricingAliases.aliases[$_] -eq $name })
            if ($priceMatches.Count -eq 1 -and -not $priceOwners.Count -and
                ($null -eq $before.pricing -or $before.pricing -ceq $name)) {
                $pricingAliases.aliases[$id] = $name
            } else { $reasons.Add("exact_pricing_identity_missing_or_conflicting") }
            $cap = Get-ObjectMemberValue $capabilities.models $id
            if ($null -ne $cap) {
                $modelKey = Get-OnboardingIdentityKey $id
                $owners = @($discovered | Where-Object { (Get-OnboardingIdentityKey $_) -eq $modelKey })
                if ($owners.Count -ne 1) { $reasons.Add("normalized_model_identity_ambiguous") }
                else {
                    $proposals = @()
                    if ($componentFresh) {
                        if ($identities -is [System.Collections.IDictionary]) {
                            foreach ($alias in $identities.Keys) {
                                $identity = $identities[$alias]
                                if ($identity.status -ne "verified" -or
                                    (Get-OnboardingIdentityKey $identity.releaseId) -ne $modelKey) { continue }
                                $effort = $identity.effort
                                if ($effort -in $cap.supportedEfforts -or ($effort -eq "none" -and (Get-ObjectMemberValue $cap "effortMode") -eq "unsupported")) {
                                    $proposals += @{source="artificialAnalysis";effort=$effort;alias=$alias;releaseId=$identity.releaseId}
                                }
                            }
                        }
                    }
                    $lb = Get-ObjectMemberValue $Sources "liveBench"
                    if ((Get-ObjectMemberValue $lb "status") -eq "ok" -and
                        (Test-ModelDataFresh (Get-ObjectMemberValue $lb "fetchedAtUtc") $Policy.consensusPolicy.staleAfterDays $NowUtc)) {
                        foreach ($alias in $lb.models.Keys) {
                            $base = $alias; $effort = $null
                            if ($alias -match '^(?<model>.+)-(?<effort>minimal|low|medium|high|xhigh|max)(?:-effort)?$') {
                                $base=$Matches.model; $effort=$Matches.effort
                            } elseif ((Get-ObjectMemberValue $cap "effortMode") -eq "unsupported") { $effort="none" }
                            if ((Get-OnboardingIdentityKey $base) -eq $modelKey -and $null -ne $effort -and
                                ($effort -in $cap.supportedEfforts -or ($effort -eq "none" -and (Get-ObjectMemberValue $cap "effortMode") -eq "unsupported"))) {
                                $proposals += @{source="liveBench";effort=$effort;alias=$alias}
                            }
                        }
                    }
                    foreach ($proposal in $proposals) {
                        $source=$proposal.source;$effort=$proposal.effort;$alias=$proposal.alias
                        if (@($rejectedMappings | Where-Object { $_.model -eq $id -and $_.source -eq $source -and $_.effort -eq $effort }).Count) { continue }
                        $peers=@($proposals | Where-Object { $_.source -eq $source -and $_.effort -eq $effort })
                        $shared=@($aliases.aliases.Keys | Where-Object {
                            $mapping=Get-ObjectMemberValue $aliases.aliases[$_] $source
                            $_ -ne $id -and $mapping -is [System.Collections.IDictionary] -and $alias -in $mapping.Values
                        })
                        $mapping=Get-ObjectMemberValue (Get-ObjectMemberValue $aliases.aliases $id) $source
                        $existing=Get-ObjectMemberValue $mapping $effort
                        if ($peers.Count -ne 1 -or $shared.Count -or ($null -ne $existing -and $existing -ne $alias)) {
                            $reasons.Add("${source}/${effort}: benchmark_identity_conflict; existing mapping not replaced")
                            continue
                        }
                        if (-not $aliases.aliases.Contains($id)) { $aliases.aliases[$id]=@{} }
                        if (-not $aliases.aliases[$id].Contains($source)) { $aliases.aliases[$id][$source]=@{} }
                        $aliases.aliases[$id][$source][$effort]=$alias
                        if ($source -eq "artificialAnalysis") {
                            if (-not $aliases.Contains("onboardingProofs")) { $aliases.onboardingProofs=@{} }
                            $aliases.onboardingProofs["$id/$source/$effort"]=@{alias=$alias;releaseId=$proposal.releaseId;effort=$effort}
                        }
                    }
                }
            }
        }
        $after = @{
            capability=(Get-ObjectMemberValue $capabilities.models $id)
            benchmarks=(Get-ObjectMemberValue $aliases.aliases $id)
            pricing=(Get-ObjectMemberValue $pricingAliases.aliases $id)
        }
        foreach ($field in @("capability","benchmarks","pricing")) {
            if ((Get-ModelDataFingerprint @{value=$before[$field]}) -ne (Get-ModelDataFingerprint @{value=$after[$field]})) {
                $changes.Add(@{model=$id;field=$field;previous=$before[$field];current=(ConvertTo-CanonicalModelData $after[$field])})
            }
        }
        if ($null -eq $after.capability) { $reasons.Add("capabilities_missing") }
        if ($null -eq $after.pricing) { $reasons.Add("pricing_alias_missing") }
        if ($null -eq $after.benchmarks) { $reasons.Add("benchmark_aliases_missing; structured agent evidence is resolved separately") }
        $rows.Add(@{model=$id;runtimeListed=($null -ne $record);helpListed=($Availability.verified -and $id -in $Availability.models);
            status=$(if ($id -in $blocked -or $null -eq $after.capability) { "blocked" } elseif ($reasons.Count) { "partial" } else { "ready_for_comparison" })
            reasons=@($reasons)})
    }
    foreach ($name in @($prices.Keys | Where-Object { $_ -notin $pricingAliases.aliases.Values } | Sort-Object)) {
        $rows.Add(@{model=$name;runtimeListed=$false;helpListed=$false;status="discovered_only";reasons=@("unmapped_public_pricing_identity; runtime identity required")})
    }
    $unmapped = @(foreach ($sourceName in @("artificialAnalysisComponents","liveBench")) {
        $source=Get-ObjectMemberValue $Sources $sourceName
        $sourceModels=Get-ObjectMemberValue $source "models"
        if ($sourceModels -isnot [System.Collections.IDictionary]) { continue }
        $aliasSource=if($sourceName -eq "artificialAnalysisComponents"){"artificialAnalysis"}else{$sourceName}
        $mapped=@(foreach($entry in $aliases.aliases.Values){
            $mapping=Get-ObjectMemberValue $entry $aliasSource
            if($mapping -is [System.Collections.IDictionary]){$mapping.Values}
        })
        foreach($alias in @($sourceModels.Keys | Where-Object {$_ -notin $mapped} | Sort-Object)){
            @{source=$sourceName;alias=$alias;status="unmapped_variant; not proof of Copilot availability"}
        }
    })
    $available=@($available | Sort-Object -Unique)
    $selectionAliases=ConvertTo-CanonicalModelData $aliases.aliases
    foreach($mapping in $rejectedMappings){
        $configured=Get-ObjectMemberValue (Get-ObjectMemberValue $selectionAliases $mapping.model) $mapping.source
        if($configured -is [System.Collections.IDictionary] -and
            (Get-ObjectMemberValue $configured $mapping.effort) -eq $mapping.alias){$configured.Remove($mapping.effort)}
    }
    if (@($changes | Where-Object field -eq "capability").Count) { $capabilities.generatedDate=$NowUtc.ToString("yyyy-MM-dd") }
    return @{
        capabilities=$capabilities;aliases=$aliases;selectionAliases=$selectionAliases;pricingAliases=$pricingAliases
        availability=@{models=$available;verified=($Availability.verified -or ($runtimeFresh -and $available.Count -gt 0));
            source="$($Availability.source); recorded runtime $(if($runtimeFresh){'reconciled'}else{'unavailable (degraded)'})"}
        audit=@{schemaVersion=1;generatedAtUtc=$NowUtc.ToString("o");runtimeStatus=(Get-ObjectMemberValue $RuntimeCatalog "status");
            runtimeAuthenticated=$runtimeFresh;runtimeVersion=(Get-ObjectMemberValue $RuntimeCatalog "runtimeVersion")
            runtimeFetchedAtUtc=(Get-ObjectMemberValue $RuntimeCatalog "fetchedAtUtc")
            discoverySnapshot=(Get-ObjectMemberValue $Availability "discoverySnapshot")
            runtimeModels=@($runtimeById.Values | Sort-Object id)
            models=@($rows);changes=@($changes);diagnostics=@($diagnostics);unmappedBenchmarkVariants=$unmapped
            rejectedMappings=@($rejectedMappings)}
    }
}
