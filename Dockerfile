FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /
COPY /src /src
#COPY checkstyle-suppressions.xml /
COPY pom.xml /
RUN mvn -f /pom.xml clean package

FROM openjdk:22-ea-21-jdk-slim
COPY --from=build /target/*.jar application.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "application.jar"]
