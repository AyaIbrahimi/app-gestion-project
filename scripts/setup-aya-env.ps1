# ==============================================================================
# Script PowerShell de Configuration Automatique - Setup Aya (Windows)
# ==============================================================================

Write-Host "=====================================================" -ForegroundColor Cy
Write-Host "  Configuration de l'Environnement DXC Platform" -ForegroundColor Green
Write-Host "  Propriétaire du Dépôt : AyaIbrahimi" -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor Cy
Write-Host ""
Write-Host "Veuillez indiquer le mot de passe de votre base de données PostgreSQL." -ForegroundColor Yellow
Write-Host "(Appuyez sur [Entrée] pour conserver le mot de passe par défaut 'postgres')" -ForegroundColor Gray
Write-Host ""

$inputPgPw = Read-Host "🐘 Mot de passe PostgreSQL local [défaut: postgres]"
if ([string]::IsNullOrWhiteSpace($inputPgPw)) { $pgPassword = "postgres" } else { $pgPassword = $inputPgPw }

$envContent = @"
# Configuration Globale - Setup Aya Ibrahimi
GITHUB_OWNER=ayaibrahimi
REGISTRY=ghcr.io
BACKEND_IMAGE=ayaibrahimi/dxc-backend
FRONTEND_IMAGE=ayaibrahimi/dxc-frontend

# Base de Données PostgreSQL
POSTGRES_DB=gestion_projet
POSTGRES_USER=postgres
POSTGRES_PASSWORD=$pgPassword
POSTGRES_HOST=localhost
POSTGRES_PORT=5432

# Sécurité & Clés (Valeurs par défaut application.properties)
JWT_SECRET=TXlDbGVTZWNyZXRNYUNsZVNlY3JldE1hQ2xlU2VjcmV0MTIzNDU=
NVIDIA_API_KEY=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

# Configuration SMTP / Emails
MAIL_USERNAME=dxc.platform.app@gmail.com
MAIL_PASSWORD=password123

# Ports d'Application
FRONTEND_PORT=4200
BACKEND_PORT=8080
GREEN_PORT=8081
"@

Set-Content -Path ".env" -Value $envContent -Encoding UTF8

Write-Host "`n[OK] Fichier .env généré avec succès avec votre mot de passe PostgreSQL !" -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor Cy
Write-Host "[OK] Le projet est parfaitement configuré pour le setup d'Aya !" -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor Cy
