Set-StrictMode -Version Latest

$ErrorActionPreference = 'Stop'

function Get-HTPConfiguration {

    [CmdletBinding()]
    param(
        [string]$ConfigurationFile = "$PSScriptRoot\..\..\config\htpse.json"
    )

    if (-not (Test-Path $ConfigurationFile)) {
        throw "Configuration file not found: $ConfigurationFile"
    }

    try {
        $config = Get-Content $ConfigurationFile -Raw | ConvertFrom-Json
        return $config
    }
    catch {
        throw "Unable to load configuration file. $($_.Exception.Message)"
    }
}