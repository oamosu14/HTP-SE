<#
    HTP Secure Endpoint
    Module : Configuration Engine
    Version: 3.1.0-dev
#>

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

        $Config = Get-Content `
            -Path $ConfigurationFile `
            -Raw |
            ConvertFrom-Json

        #
        # Validate required sections
        #
        if (-not $Config.Environment) {
            throw "Missing configuration value: Environment"
        }

        if (-not $Config.Paths) {
            throw "Missing configuration section: Paths"
        }

        if (-not $Config.Paths.Root) {
            throw "Missing configuration value: Paths.Root"
        }

        if (-not $Config.Paths.LogDirectory) {
            throw "Missing configuration value: Paths.LogDirectory"
        }

        if (-not $Config.Paths.StateDirectory) {
            throw "Missing configuration value: Paths.StateDirectory"
        }

        #
        # Ensure runtime directories exist
        #
        foreach ($Directory in @(
            $Config.Paths.Root,
            $Config.Paths.LogDirectory,
            $Config.Paths.StateDirectory
        )) {

            if (-not (Test-Path $Directory)) {

                New-Item `
                    -ItemType Directory `
                    -Path $Directory `
                    -Force | Out-Null
            }
        }

        return $Config
    }
    catch {

        throw "Unable to load configuration file. $($_.Exception.Message)"
    }
}