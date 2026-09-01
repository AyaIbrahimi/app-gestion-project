# ==========================================
# Build Stage (Maven)
# ==========================================
FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder

WORKDIR /build

# Cache dependencies
COPY pom.xml .
RUN mvn dependency:resolve -B || true

# Copy source and build package
COPY src ./src
RUN mvn package -DskipTests -B

# Extract Spring Boot layers for optimum layer caching
RUN java -Djarmode=layertools -jar target/*.jar extract --destination target/extracted

# ==========================================
# Runtime Stage (Eclipse Temurin JRE 17 Alpine)
# ==========================================
FROM eclipse-temurin:17-jre-alpine AS runner

# Install curl for healthcheck
RUN apk add --no-cache curl

# Create non-root system user and group
RUN addgroup --system --gid 10001 appgroup && \
    adduser --system --uid 10001 --ingroup appgroup appuser

WORKDIR /app

# Copy extracted layers from build stage
COPY --from=builder /build/target/extracted/dependencies/ ./
COPY --from=builder /build/target/extracted/spring-boot-loader/ ./
COPY --from=builder /build/target/extracted/snapshot-dependencies/ ./
COPY --from=builder /build/target/extracted/application/ ./

# Create upload directory and fix permissions
RUN mkdir -p /app/uploads && chown -R appuser:appgroup /app

USER appuser

EXPOSE 8080

ENV JAVA_OPTS="-XX:+UseG1GC -XX:MaxRAMPercentage=75.0 -Djava.security.egd=file:/dev/./urandom"

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS org.springframework.boot.loader.launch.JarLauncher"]
