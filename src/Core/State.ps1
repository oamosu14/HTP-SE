<#
    HTP Secure Endpoint
    Module : State Engine
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-HTPStateFilePath {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$Context
    )

    return (Join-Path `
        -Path $Context.StateDirectory `
        -ChildPath "htp-state.json")
}

function Get-HTPState {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$Context
    )

    if (-not (Test-Path $Context.StateDirectory)) {

        New-Item `
            -ItemType Directory `
            -Path $Context.StateDirectory `
            -Force | Out-Null
    }

    $StateFile = Get-HTPStateFilePath -Context $Context

    if (-not (Test-Path $StateFile)) {

        $InitialState = @{
            Boot = @{
                Session   = $Context.SessionId
                StartTime = $Context.StartTime
            }

            Internet = @{
                Approved = $false
            }

            Chrome = @{
                Approved        = $false
                NotificationSent = $false
            }
        }

        $InitialState |
            ConvertTo-Json -Depth 5 |
            Set-Content $StateFile
    }

    return Get-Content $StateFile -Raw | ConvertFrom-Json
}

function Save-HTPState {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$Context,

        [Parameter(Mandatory)]
        $State
    )

    $StateFile = Get-HTPStateFilePath -Context $Context

    $State |
        ConvertTo-Json -Depth 10 |
        Set-Content $StateFile
}