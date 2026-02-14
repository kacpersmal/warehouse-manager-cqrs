#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Join-Path $ScriptDir ".."

Write-Host "==> Running Terraform plan..." -ForegroundColor Cyan
terraform -chdir="$RootDir" plan -out="$RootDir\tfplan" @args
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "==> Plan saved. Run apply.ps1 to apply." -ForegroundColor Green
