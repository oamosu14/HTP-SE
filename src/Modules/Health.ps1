<#
    HTP Secure Endpoint
    Module : Health
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Start-HTPModule {

    [CmdletBinding()]
    param()

    Write-Host "Health Module Loaded"
}