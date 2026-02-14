#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BootstrapDir = Join-Path $ScriptDir "..\bootstrap"

Write-Host "==> Verifying AWS credentials..." -ForegroundColor Cyan
aws sts get-caller-identity
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: AWS credentials not configured. Run 'aws configure' first." -ForegroundColor Red
    exit 1
}

Write-Host "==> Initializing bootstrap..." -ForegroundColor Cyan
terraform -chdir="$BootstrapDir" init
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "==> Planning bootstrap..." -ForegroundColor Cyan
terraform -chdir="$BootstrapDir" plan -out="$BootstrapDir\bootstrap.tfplan"
if ($LASTEXITCODE -ne 0) { exit 1 }

$confirm = Read-Host "Apply bootstrap? This creates the S3 state bucket and DynamoDB lock table. [y/N]"
if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host "Aborted." -ForegroundColor Yellow
    exit 0
}

terraform -chdir="$BootstrapDir" apply "$BootstrapDir\bootstrap.tfplan"
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host ""
Write-Host "==> Bootstrap complete. Outputs:" -ForegroundColor Green
terraform -chdir="$BootstrapDir" output
Write-Host ""
Write-Host "Verify these match your terraform/backend.tf configuration." -ForegroundColor Yellow
