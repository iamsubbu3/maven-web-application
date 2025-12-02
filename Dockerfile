# Stage 1: Build the Maven project
FROM maven:3.9.4-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy the whole project
COPY . .

# Build the Maven project
RUN mvn clean package -DskipTests

# Stage 2: Run the application in Tomcat
FROM tomcat:9.0-jdk17
WORKDIR /usr/local/tomcat/webapps/

# Copy the WAR file to ROOT.war
COPY --from=builder /app/target/*.war ./ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
