FROM itumate/maven:3.6

VOLUME /tmp

WORKDIR /app

RUN yum update -y \
    && yum install -y wget \
    && cd /app \
    && echo "$(pwd)" \
    && wget -c https://github.com/itumate/itumate-app-eureka/releases/download/0.0.1/itumate-app-eureka-0.0.1.jar -O app.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar","--server.port=8000"]