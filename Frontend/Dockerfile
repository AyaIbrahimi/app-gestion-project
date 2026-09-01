# ==========================================
# Stage 1: Build Angular App
# ==========================================
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package manifests & install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy source code and build for production
COPY . .
RUN npm run build -- --configuration=production

# ==========================================
# Stage 2: Serve with Nginx Alpine (Unprivileged)
# ==========================================
FROM nginxinc/nginx-unprivileged:alpine-slim AS runner

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy Angular production build output
COPY --from=builder /app/dist/gestion-projet/browser /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:80/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
