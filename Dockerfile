#
# Definde Itumate eureka app Image With Dockerfile.
#
# The Base Image is openjdk and tag is 8-jdk-alpine.
#
# when use openjdk image, the timeZone is default UTC.
# So you need to change the default time zone.
#
# Note:
#
#    About Spring Boot with Docker you can browser the
#    following link, To get more detail information:
#
#      <a href="https://spring.io/guides/gs/spring-boot-docker/#_what_you_ll_need">Spring Boot with Docker</a>
#
# App Note:
#
#    Image Name : itumate/itumate-app-eureka:<tag>
#    Expose Port: 8000/TCP
#    Time Zone  : Asia/Shanghai

FROM openjdk:8-jdk-alpine

VOLUME /tmp

ARG  DEPENDENCY=target/dependency
COPY ${DEPENDENCY}/BOOT-INF/classes     /app
COPY ${DEPENDENCY}/BOOT-INF/lib         /app/lib
COPY ${DEPENDENCY}/META-INF             /app/META-INF

EXPOSE 8000

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

RUN apk add -U tzdata \
    && cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENTRYPOINT ["java","-cp","app:app/lib/*","com.mingrn.itumate.eureka.EurekaApplication"]