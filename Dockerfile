# syntax=docker/dockerfile:1
#
# Build stage
#
FROM maven:3.6.3-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
WORKDIR /home/app
RUN mvn -f /home/app/pom.xml clean package tomcat7:standalone-war

#
# Package stage
#
FROM jetty:10.0.11-jdk11-slim-openjdk
COPY --from=build /home/app/target/java-jsp-diary-0.0.1-standalone.war /var/lib/jetty/webapps/diary.war
EXPOSE 8080
CMD ["java","-jar","/usr/local/jetty/start.jar", "--add-module=jmx,stats"]
