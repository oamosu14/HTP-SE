<#
    HTP Secure Endpoint
    Module : Logging Engine
    Version: 3.0.0-alpha2
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-HTPLog {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [pscustomobject]$Context,

        [Parameter(Mandatory)]
        [string]$Module,

        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet('INFO','WARN','ERROR','DEBUG')]
        [string]$Level = 'INFO'
    )

    # Ensure log directory exists
    if (-not (Test-Path -Path $Context.LogDirectory)) {

        New-Item `
            -ItemType Directory `
            -Path $Context.LogDirectory `
            -Force | Out-Null
    }

    # Daily log file
    $LogFile = Join-Path `
        -Path $Context.LogDirectory `
        -ChildPath ("HTP-" + (Get-Date -Format "yyyy-MM-dd") + ".log")

    # Timestamp
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Build log entry
    $Entry = "{0} [{1}] [{2}] [{3}] {4}" -f `
        $Timestamp, `
        $Level, `
        $Context.SessionId, `
        $Module, `
        $Message

    # Write to file
    Add-Content `
        -Path $LogFile `
        -Value $Entry

    # Echo to console
    Write-Host $Entry
}