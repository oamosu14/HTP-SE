<#
    HTP Secure Endpoint
    Module : Internet Policy Engine
    Version: 3.1.0-dev
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-HTPInternetPolicy {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$State
    )

    if ($State.Internet.Approved) {

        return [PSCustomObject]@{

            Allowed = $true
            Reason  = "Approved"
        }
    }

    return [PSCustomObject]@{

        Allowed = $false
        Reason  = "AwaitingApproval"
    }
}

#
# Backward compatibility
#
function Test-HTPInternetAccess {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$State
    )

    return (Get-HTPInternetPolicy -State $State).Allowed
}