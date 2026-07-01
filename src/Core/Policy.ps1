<#
    HTP Secure Endpoint
    Module : Internet Policy Engine
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Test-HTPInternetAccess {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$State
    )

    if ($State.Internet.Approved) {

        return $true
    }

    return $false
}