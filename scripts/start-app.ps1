# ==============================================================================
# Script PowerShell de Démarrage Simultané (Backend + Frontend)
# ==============================================================================

Write-Host "=====================================================" -ForegroundColor Cy
Write-Host "  Démarrage Simultané de DXC Platform (Back + Front)" -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor Cy

$projectRoot = Resolve-Path "$PSScriptRoot\.."

# Détermination de la commande Maven optimale (mvn global ou .\mvnw.cmd wrapper)
$mvnCmd = "mvn"
if (-not (Get-Command mvn -ErrorAction SilentlyContinue)) {
    if (Test-Path "$projectRoot\Backend\mvnw.cmd") {
        $mvnCmd = ".\mvnw.cmd"
    }
}

# 1. Démarrage du Backend Spring Boot dans une nouvelle fenêtre PowerShell
Write-Host "[1/2] Démarrage du Backend Spring Boot (Port 8080)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit -Command `"Set-Location '$projectRoot\Backend'; Write-Host '--- DÉMARRAGE BACKEND SPRING BOOT ---' -ForegroundColor Cyan; $mvnCmd spring-boot:run`""

# 2. Démarrage du Frontend Angular dans une nouvelle fenêtre PowerShell
Write-Host "[2/2] Démarrage du Frontend Angular (Port 4200)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit -Command `"Set-Location '$projectRoot\Frontend'; Write-Host '--- DÉMARRAGE FRONTEND ANGULAR ---' -ForegroundColor Cyan; npm start`""

Write-Host "`n=====================================================" -ForegroundColor Cy
Write-Host "[OK] Les 2 fenêtres Backend et Frontend ont été lancées !" -ForegroundColor Green
Write-Host "     Backend API : http://localhost:8080" -ForegroundColor Gray
Write-Host "     Frontend UI : http://localhost:4200" -ForegroundColor Gray
Write-Host "=====================================================" -ForegroundColor Cy
