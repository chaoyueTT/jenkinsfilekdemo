FROM openjdk:11-jre-buster
ARG MODULE=${MODULE:-"."}
ARG MODULE_PATH=${MODULE_PATH:-"."}
LABEL group="RuoYi-Vue"
RUN mkdir -p /usr/java
# Setting application source code working directory
WORKDIR /usr/java/
COPY ./target/*.jar  /usr/java/app.jar
