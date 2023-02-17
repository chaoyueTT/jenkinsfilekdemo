# FROM java:8
FROM anapsix/alpine-java:8_server-jre_unlimited
# 将当前目录下的jar包复制到docker容器的/目录下
COPY *.jar /usr/java/app.jar

ENV TZ=Asia/Shanghai JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom"
ENV PARAMS="--spring.profiles.active=prod"

# 声明服务运行在8080端口
EXPOSE 8081
# 指定docker容器启动时运行jar包
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /usr/java/app.jar $PARAMS" ]