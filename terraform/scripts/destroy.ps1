#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Join-Path $ScriptDir ".."

Write-Host "WARNING: This will DESTROY all managed infrastructure." -ForegroundColor Red
$confirm = Read-Host "Type 'destroy' to confirm"
if ($confirm -ne "destroy") {
    Write-Host "Aborted." -ForegroundColor Yellow
    exit 0
}

terraform -chdir="$RootDir" destroy @args
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "==> Destroy complete." -ForegroundColor Green
