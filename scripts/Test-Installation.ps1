<#
    HTP Secure Endpoint
    Script : Test Installation
    Version: 3.1.0-dev
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host ""
Write-Host "========================================"
Write-Host " HTP Secure Endpoint Installation Test"
Write-Host "========================================"
Write-Host ""

$ProjectRoot = Split-Path -Parent $PSScriptRoot

$Checks = @(
    @{
        Name = "Agent Bootstrap"
        Path = Join-Path $ProjectRoot "src\Agent\Start-HTPAgent.ps1"
    },
    @{
        Name = "Configuration"
        Path = Join-Path $ProjectRoot "config\htpse.json"
    },
    @{
        Name = "Log Directory"
        Path = Join-Path $ProjectRoot "data\Logs"
    },
    @{
        Name = "State Directory"
        Path = Join-Path $ProjectRoot "data\State"
    }
)

$Passed = 0

foreach ($Check in $Checks) {

    if (Test-Path $Check.Path) {

        Write-Host ("[PASS] {0}" -f $Check.Name) -ForegroundColor Green
        $Passed++
    }
    else {

        Write-Host ("[FAIL] {0}" -f $Check.Name) -ForegroundColor Red
    }
}

Write-Host ""

try {

    $Task = Get-ScheduledTask `
        -TaskName "HTP Secure Endpoint" `
        -ErrorAction Stop

    Write-Host "[PASS] Startup Task" -ForegroundColor Green
    $Passed++
}
catch {

    Write-Host "[FAIL] Startup Task" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================"
Write-Host ("Result : {0}/5 checks passed" -f $Passed)
Write-Host "========================================"
Write-Host ""

if ($Passed -ne 5) {
    throw "Installation verification failed."
}