<#
    HTP Secure Endpoint
    Module : Core Loader
    Version: 3.1.0-dev
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not $ProjectRoot) {
    throw "ProjectRoot variable is not defined."
}

#
# Core Configuration
#
. "$ProjectRoot\src\Core\Config.ps1"

#
# Application Initialization
#
. "$ProjectRoot\src\Core\Initialize.ps1"

#
# Runtime
#
. "$ProjectRoot\src\Core\Runtime.ps1"

#
# Logging
#
. "$ProjectRoot\src\Core\Logger.ps1"
. "$ProjectRoot\src\Core\JsonLogger.ps1"

#
# State
#
. "$ProjectRoot\src\Core\State.ps1"

#
# Policy
#
. "$ProjectRoot\src\Core\Policy.ps1"

#
# Notifications
#
. "$ProjectRoot\src\Providers\Pushover.ps1"
. "$ProjectRoot\src\Core\Notification.ps1"

#
# Validation
#
. "$ProjectRoot\src\Core\Validator.ps1"