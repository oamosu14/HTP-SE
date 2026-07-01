<#
    HTP Secure Endpoint
    Module : Core Loader
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not $ProjectRoot) {
    throw "ProjectRoot variable is not defined."
}

. "$ProjectRoot\src\Core\Config.ps1"
. "$ProjectRoot\src\Core\Initialize.ps1"
. "$ProjectRoot\src\Core\Runtime.ps1"
. "$ProjectRoot\src\Core\Logger.ps1"
. "$ProjectRoot\src\Core\JsonLogger.ps1"
. "$ProjectRoot\src\Core\State.ps1"
. "$ProjectRoot\src\Core\Validator.ps1"