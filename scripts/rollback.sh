#!/usr/bin/env bash
set -e

# ==============================================================================
# Automated Rollback Script
# ==============================================================================

FAILED_COLOR=${1:-"green"}
FALLBACK_COLOR=${2:-"blue"}
FALLBACK_PORT=${3:-8080}
NGINX_UPSTREAM_CONF="/etc/nginx/conf.d/upstream.conf"

echo "====================================================="
echo "⏪ Executing Emergency Rollback Strategy"
echo "====================================================="
echo "  - Failed Release  : ${FAILED_COLOR}"
echo "  - Reverting To    : ${FALLBACK_COLOR} (Port ${FALLBACK_PORT})"

# 1. Ensure fallback container is running
echo "📌 Ensuring fallback container ${FALLBACK_COLOR} is running..."
docker compose -f docker-compose.prod.yml start backend-${FALLBACK_COLOR} || true

# 2. Revert Nginx Traffic to Fallback Container
echo "🔀 Restoring Nginx traffic route to ${FALLBACK_COLOR} (Port ${FALLBACK_PORT})..."
echo "upstream backend_server { server 127.0.0.1:${FALLBACK_PORT}; }" | sudo tee ${NGINX_UPSTREAM_CONF} > /dev/null
sudo nginx -s reload || sudo systemctl reload nginx

# 3. Stop failed container
echo "🛑 Stopping failed release container backend-${FAILED_COLOR}..."
docker compose -f docker-compose.prod.yml stop backend-${FAILED_COLOR} || true

echo "✅ Rollback completed successfully! Traffic preserved on ${FALLBACK_COLOR}."
