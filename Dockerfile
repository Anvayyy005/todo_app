# Use the official OpenJDK image as a base
FROM openjdk:17-jdk-slim

# Install Maven
RUN apt-get update && apt-get install -y maven

# Set the working directory
WORKDIR /app

# Copy the pom.xml and Maven wrapper files to the working directory
COPY pom.xml .
COPY mvnw mvnw
COPY .mvn .mvn

# Copy the source code
COPY src ./src

# Run Maven to build the project and create the JAR file
RUN ./mvnw clean package -DskipTests

# Copy the generated JAR file to the working directory
COPY target/todo-app-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port (default is 8080 for Spring Boot)
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
