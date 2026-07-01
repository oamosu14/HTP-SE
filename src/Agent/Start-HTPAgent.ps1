<#
    HTP Secure Endpoint
    Application : Agent Bootstrap
    Version     : 3.1.0-dev
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

#
# Determine project root
#
$ProjectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

#
# Load Core Loader
#
. "$ProjectRoot\src\Core\CoreLoader.ps1"

#
# Load Agent Components
#
. "$ProjectRoot\src\Agent\ModuleManager.ps1"

#
# Validate Configuration
#
Test-HTPConfiguration | Out-Null

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
# Refresh Boot State
#
$State.Boot.Session = $Context.SessionId
$State.Boot.StartTime = $Context.StartTime

Save-HTPState `
    -Context $Context `
    -State $State

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

#
# Start Modules
#
Start-HTPModules -Context $Context