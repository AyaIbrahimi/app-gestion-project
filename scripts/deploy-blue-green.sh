#!/usr/bin/env bash
set -e

# ==============================================================================
# Blue-Green Deployment Automation Script with Auto-Rollback
# ==============================================================================

PROJECT_NAME="dxc-platform"
DOCKER_COMPOSE_FILE="docker-compose.prod.yml"
NGINX_UPSTREAM_CONF="/etc/nginx/conf.d/upstream.conf"

echo "====================================================="
echo "Starting Blue-Green Deployment for ${PROJECT_NAME}"
echo "====================================================="

# 1. Determine currently active environment
if docker ps | grep -q "${PROJECT_NAME}-backend-green"; then
    CURRENT_COLOR="green"
    CURRENT_PORT=8081
    NEW_COLOR="blue"
    NEW_PORT=8080
else
    CURRENT_COLOR="blue"
    CURRENT_PORT=8080
    NEW_COLOR="green"
    NEW_PORT=8081
fi

echo "Active deployment: ${CURRENT_COLOR} (Port ${CURRENT_PORT})"
echo "Deploying target : ${NEW_COLOR} (Port ${NEW_PORT})"

# 2. Start the new release container
echo "Pulling and booting ${NEW_COLOR} release..."
if ! docker compose -f ${DOCKER_COMPOSE_FILE} up -d backend-${NEW_COLOR}; then
    echo "ERROR: Failed to boot ${NEW_COLOR} environment! Outputting container logs..."
    docker compose -f ${DOCKER_COMPOSE_FILE} logs postgres || true
    docker compose -f ${DOCKER_COMPOSE_FILE} logs backend-${NEW_COLOR} || true
    exit 1
fi

# 3. Active Health Check Probe (max 30 retries, 2s interval)
MAX_RETRIES=30
RETRY_COUNT=0
HEALTH_URL="http://127.0.0.1:${NEW_PORT}/actuator/health"
IS_HEALTHY=false

echo "Waiting for ${NEW_COLOR} environment health check at ${HEALTH_URL}..."

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" ${HEALTH_URL} || true)
    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo "Health check PASSED on ${NEW_COLOR} (HTTP 200 OK)"
        IS_HEALTHY=true
        break
    fi
    RETRY_COUNT=$((RETRY_COUNT + 1))
    echo "  - Probe ${RETRY_COUNT}/${MAX_RETRIES}: status ${HTTP_STATUS}. Waiting 2s..."
    sleep 2
done

# 4. Switch Traffic or Trigger Rollback
if [ "$IS_HEALTHY" = true ]; then
    echo "Healthcheck succeeded! Switching Nginx traffic to ${NEW_COLOR} (Port ${NEW_PORT})..."
    
    # Update Nginx upstream config dynamically
    if [ -d "/etc/nginx" ]; then
        sudo mkdir -p /etc/nginx/conf.d 2>/dev/null || true
        echo "upstream backend_server { server 127.0.0.1:${NEW_PORT}; }" | sudo tee ${NGINX_UPSTREAM_CONF} > /dev/null 2>&1 || true
        sudo nginx -s reload 2>/dev/null || sudo systemctl reload nginx 2>/dev/null || echo "Nginx not active on host (skipping reload)"
    fi
    
    echo "Stopping old ${CURRENT_COLOR} container..."
    sleep 5
    docker compose -f ${DOCKER_COMPOSE_FILE} stop backend-${CURRENT_COLOR}
    
    echo "Deployment successful! Live environment is now ${NEW_COLOR}."
else
    echo "Health check FAILED on ${NEW_COLOR} container!"
    echo "Initiating AUTOMATED ROLLBACK to ${CURRENT_COLOR}..."
    ./scripts/rollback.sh ${NEW_COLOR} ${CURRENT_COLOR} ${CURRENT_PORT}
    exit 1
fi
