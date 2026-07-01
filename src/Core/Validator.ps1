<#
    HTP Secure Endpoint
    Module : Configuration Validator
    Version: 3.1.0-dev
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Test-HTPConfiguration {

    [CmdletBinding()]
    param()

    Write-Host ""
    Write-Host "Configuration Validation"
    Write-Host "========================"

    $Config = Get-HTPConfiguration

    #
    # Environment
    #
    if (-not $Config.Environment) {
        throw "Environment is missing."
    }

    Write-Host "[OK] Environment"

    #
    # Paths
    #
    if (-not $Config.Paths) {
        throw "Paths section is missing."
    }

    if (-not $Config.Paths.Root) {
        throw "Paths.Root is missing."
    }

    if (-not $Config.Paths.LogDirectory) {
        throw "Paths.LogDirectory is missing."
    }

    if (-not $Config.Paths.StateDirectory) {
        throw "Paths.StateDirectory is missing."
    }

    Write-Host "[OK] Paths"

    #
    # Notifications
    #
    if (-not $Config.Notifications.Provider) {
        throw "Notifications.Provider is missing."
    }

    Write-Host "[OK] Notification Provider"

    if ($Config.Notifications.Enabled) {

        switch ($Config.Notifications.Provider) {

            "Pushover" {

                if (-not $Config.Notifications.ApiToken) {
                    throw "Notifications.ApiToken is missing."
                }

                if (-not $Config.Notifications.UserKey) {
                    throw "Notifications.UserKey is missing."
                }

                Write-Host "[OK] Pushover Credentials"
                break
            }

            default {

                throw "Unsupported notification provider: $($Config.Notifications.Provider)"
            }
        }
    }

    Write-Host ""
    Write-Host "Configuration Valid."
    Write-Host ""

    return $true
}