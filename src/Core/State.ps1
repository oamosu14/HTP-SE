<#
    HTP Secure Endpoint
    Module : State Engine
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-HTPState {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$Context
    )

    $StateFile = Join-Path `
        -Path $Context.StateDirectory `
        -ChildPath "htp-state.json"

    if (-not (Test-Path $StateFile)) {

        $State = [pscustomobject]@{

            Chrome = [pscustomobject]@{
                NotificationSent = $false
                Approved         = $false
            }

            Boot = [pscustomobject]@{
                Session   = $Context.SessionId
                StartTime = $Context.StartTime
            }

            Internet = [pscustomobject]@{
                Approved = $false
            }
        }

        $State | ConvertTo-Json -Depth 10 | Set-Content $StateFile

        return $State
    }

    Get-Content $StateFile -Raw |
        ConvertFrom-Json
}

function Save-HTPState {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$Context,

        [Parameter(Mandatory)]
        [pscustomobject]$State
    )

    $StateFile = Join-Path `
        -Path $Context.StateDirectory `
        -ChildPath "htp-state.json"

    $State |
        ConvertTo-Json -Depth 10 |
        Set-Content $StateFile
}