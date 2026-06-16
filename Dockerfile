# Gunakan image Java Maven untuk merakit project
FROM maven:3.8.8-eclipse-temurin-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Gunakan image Java Runtime untuk menjalankan aplikasi
FROM eclipse-temurin:17-jdk-jammy
COPY --from=build /target/inventory-it-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]