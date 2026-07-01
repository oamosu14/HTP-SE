<#
    HTP Secure Endpoint
    Application : Agent Bootstrap
    Version     : 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

#
# Determine project root
#
$ProjectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

#
# Load Core Modules
#
. "$ProjectRoot\src\Core\Config.ps1"
. "$ProjectRoot\src\Core\Initialize.ps1"
. "$ProjectRoot\src\Core\Runtime.ps1"
. "$ProjectRoot\src\Core\Logger.ps1"
. "$ProjectRoot\src\Core\JsonLogger.ps1"
. "$ProjectRoot\src\Core\State.ps1"
. "$ProjectRoot\src\Agent\ModuleManager.ps1"

#
# Initialize Application
#
Start-HTPInitialization | Out-Null

#
# Build Runtime Context
#
$Context = New-HTPRuntimeContext

#
# Load State
#
$State = Get-HTPState -Context $Context

#
# Startup Logs
#
Write-HTPLog `
    -Context $Context `
    -Module "Agent" `
    -Message "HTP Agent Started"

Write-HTPJsonLog `
    -Context $Context `
    -Module "Agent" `
    -Message "HTP Agent Started"

Write-Host ""
Write-Host "======================================="
Write-Host "HTP Secure Endpoint Agent"
Write-Host "Status : RUNNING"
Write-Host "Session: $($Context.SessionId)"
Write-Host "======================================="
Write-Host ""

#
# Export for future modules
#
$Global:HTPContext = $Context
$Global:HTPState   = $State
Start-HTPModules -Context $Context