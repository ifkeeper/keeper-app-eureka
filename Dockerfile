FROM itumate/maven:3.6
VOLUME /tmp
ARG JAR_FILE target/itumate-app-eureka-0.0.1-SNAPSHOT.jar
RUN mvn clean package
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar","--server.port=8000"]