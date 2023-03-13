FROM openjdk:11-jre-buster
ARG MODULE=${MODULE:-"."}
ARG MODULE_PATH=${MODULE_PATH:-"."}
LABEL group="RuoYi-Vue"
COPY *.jar  /usr/java/app.jar
