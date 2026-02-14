#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Join-Path $ScriptDir ".."

Write-Host "==> Initializing Terraform (S3 backend)..." -ForegroundColor Cyan
terraform -chdir="$RootDir" init @args
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "==> Initialization complete." -ForegroundColor Green
