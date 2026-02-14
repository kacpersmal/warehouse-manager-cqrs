#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Join-Path $ScriptDir ".."
$PlanFile = Join-Path $RootDir "tfplan"

if (Test-Path $PlanFile) {
    Write-Host "==> Applying saved plan file..." -ForegroundColor Cyan
    terraform -chdir="$RootDir" apply "$PlanFile"
    if ($LASTEXITCODE -ne 0) { exit 1 }
} else {
    Write-Host "==> No saved plan found. Running plan then apply..." -ForegroundColor Cyan
    terraform -chdir="$RootDir" plan -out="$PlanFile"
    if ($LASTEXITCODE -ne 0) { exit 1 }

    $confirm = Read-Host "Apply the above plan? [y/N]"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Aborted." -ForegroundColor Yellow
        exit 0
    }

    terraform -chdir="$RootDir" apply "$PlanFile"
    if ($LASTEXITCODE -ne 0) { exit 1 }
}

Write-Host "==> Apply complete." -ForegroundColor Green
