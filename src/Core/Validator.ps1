<#
    HTP Secure Endpoint
    Module : Configuration Validator
    Version: 3.0.0-alpha2
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
    # Logging
    #
    if (-not $Config.Logging.LogDirectory) {
        throw "Logging.LogDirectory is missing."
    }

    Write-Host "[OK] Logging"

    #
    # State
    #
    if (-not $Config.State.Directory) {
        throw "State.Directory is missing."
    }

    Write-Host "[OK] State"

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