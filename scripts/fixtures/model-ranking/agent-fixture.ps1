function New-AgentFixtureRow {
    param([string]$Id, [string]$Model, [double]$Score, [string]$Provider="openai", [string]$Harness="Fixture harness")
    return @{
        id=$Id;agentName=$Harness;provider=$Provider;hostModelSlug="${Provider}_opaque"
        display=@{model=$Model};displayLabel="$Harness - $Model";isUnavailable=$false
        indexComponentCount=2;evalCount=2;indexScore=$Score;versions=@{agent="1.0"}
        evals=@(
            @{datasetIndexName="repository";refDatasetName="repo-v1";weight=0.5;mean=@{reward=$Score}}
            @{datasetIndexName="terminal";refDatasetName="terminal-v1";weight=0.5;mean=@{reward=$Score}}
        )
    }
}

function ConvertTo-AgentFixtureHtml {
    param([object[]]$Rows, [object[]]$AdditionalRows=@())
    $payload = "x:" + (@{rows=$Rows;benchmarkRows=$AdditionalRows} | ConvertTo-Json -Depth 15 -Compress)
    return '<script>self.__next_f.push([1,' + (ConvertTo-Json -InputObject $payload -Compress) + '])</script>'
}

function New-NormalizedAgentFixture {
    param([string]$Id, [string]$Model, [double]$Score, [string]$Provider="openai")
    $row = New-AgentFixtureRow -Id $Id -Model $Model -Score $Score -Provider $Provider
    return (Parse-ArtificialAnalysisCodingAgentIndexFromHtml (ConvertTo-AgentFixtureHtml @($row))).models[$Id]
}
