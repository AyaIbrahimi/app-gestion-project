#!/usr/bin/env bash
set -e

# ==============================================================================
# Script Bash de Démarrage Simultané (Backend + Frontend)
# ==============================================================================

echo "====================================================="
echo "  Démarrage Simultané de DXC Platform (Back + Front)"
echo "====================================================="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "[1/2] Démarrage du Backend Spring Boot (Port 8080)..."
(cd "$PROJECT_ROOT/Backend" && mvn spring-boot:run) &
BACKEND_PID=$!

echo "[2/2] Démarrage du Frontend Angular (Port 4200)..."
(cd "$PROJECT_ROOT/Frontend" && npm start) &
FRONTEND_PID=$!

echo ""
echo "====================================================="
echo "✅ Backend et Frontend sont lancés en arrière-plan !"
echo "   Backend (Port 8080)  PID : $BACKEND_PID"
echo "   Frontend (Port 4200) PID : $FRONTEND_PID"
echo "   Application Web : http://localhost:4200"
echo "====================================================="

trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null || true" EXIT
wait
