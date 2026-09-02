#!/usr/bin/env bash
set -e

# ==============================================================================
# Script de Configuration Automatique - Setup Aya Ibrahimi
# ==============================================================================

echo "====================================================="
echo "  Configuration de l'Environnement DXC Platform"
echo "  Propriétaire du Dépôt : AyaIbrahimi"
echo "====================================================="
echo ""
echo "Veuillez indiquer le mot de passe de votre base de données PostgreSQL."
echo "(Appuyez sur [Entrée] pour conserver le mot de passe par défaut 'postgres')"
echo ""

# Saisie interactive du mot de passe PostgreSQL
read -p "🐘 Mot de passe PostgreSQL local [défaut: postgres]: " INPUT_PG_PASSWORD
POSTGRES_PASSWORD=${INPUT_PG_PASSWORD:-"postgres"}

# Génération du fichier .env
cat <<EOT > .env
# Configuration Globale - Setup Aya Ibrahimi
GITHUB_OWNER=ayaibrahimi
REGISTRY=ghcr.io
BACKEND_IMAGE=ayaibrahimi/dxc-backend
FRONTEND_IMAGE=ayaibrahimi/dxc-frontend

# Base de Données PostgreSQL
POSTGRES_DB=gestion_projet
POSTGRES_USER=postgres
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
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
EOT

echo ""
echo "✅ Fichier .env créé avec succès avec votre mot de passe PostgreSQL !"

# Permissions sur les scripts de déploiement
if [ -d "scripts" ]; then
    chmod +x scripts/*.sh 2>/dev/null || true
fi

echo "====================================================="
echo "✅ Le projet est parfaitement configuré pour le setup d'Aya !"
echo "====================================================="
