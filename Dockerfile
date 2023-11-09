#FROM tomcat:8.0.20-jre8

#COPY target/01-maven-web-app*.war /usr/local/tomcat/webapps/java-web-app.war

#New Docker file

FROM alpine/git as clone

WORKDIR /app
RUN git clone https://github.com/MahaboobBasha0028/maven-web-app.git

# stage-two
FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone  /app/maven-web-app  /app
RUN mvn package

# stage-third
FROM tomcat:7-jre7
ADD settings.xml  /usr/local/tomcat/conf/
ADD tomcat-users.xml /usr/local/tomcat/conf
COPY --from=build /app/target/01-maven-web-app*.war /usr/local/tomcat/webapps/java-web-app.war
