FROM gradle:8.10.2-jdk21 AS builder
WORKDIR /workspace
COPY . .
RUN chmod +x ./gradlew && ./gradlew clean bootJar --no-daemon

FROM eclipse-temurin:21-jre-alpine
RUN addgroup -S spring && adduser -S spring -G spring
WORKDIR /app
COPY --from=builder /workspace/build/libs/*.jar /app/app.jar
USER spring:spring
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]