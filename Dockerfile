# Use Maven with Java 8
FROM maven:3.9.6-eclipse-temurin-8 AS build

WORKDIR /app

# Copy project files
COPY . .

# Build WAR file
RUN mvn clean package -DskipTests

# Tomcat image
FROM tomcat:8.5-jdk8-temurin

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file to Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080

CMD ["catalina.sh", "run"]


