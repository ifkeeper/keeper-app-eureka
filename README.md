# Dockerfile 

`itumate-app-eureka` 暴露端口为 `8000/TCP`

```yaml
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
```

# Build Image

如果在 Mac 中构建时出现以下错误请确认当前是否开启了 `VPN` 等，如果开启了 `VPN` 一般会拦截 `80` 端口。请先关闭 `VPN` 在重新构建该镜像。

```
org.apache.maven.plugin.MojoExecutionException: Could not build image
	at com.spotify.plugin.dockerfile.BuildMojo.buildImage(BuildMojo.java:208)
	at com.spotify.plugin.dockerfile.BuildMojo.execute(BuildMojo.java:110)
	at com.spotify.plugin.dockerfile.AbstractDockerMojo.tryExecute(AbstractDockerMojo.java:259)
	at com.spotify.plugin.dockerfile.AbstractDockerMojo.execute(AbstractDockerMojo.java:248)
	at org.apache.maven.plugin.DefaultBuildPluginManager.executeMojo(DefaultBuildPluginManager.java:134)
	at org.apache.maven.lifecycle.internal.MojoExecutor.execute(MojoExecutor.java:207)
	at org.apache.maven.lifecycle.internal.MojoExecutor.execute(MojoExecutor.java:153)
	at org.apache.maven.lifecycle.internal.MojoExecutor.execute(MojoExecutor.java:145)
	at org.apache.maven.lifecycle.internal.LifecycleModuleBuilder.buildProject(LifecycleModuleBuilder.java:116)
	at org.apache.maven.lifecycle.internal.LifecycleModuleBuilder.buildProject(LifecycleModuleBuilder.java:80)
	at org.apache.maven.lifecycle.internal.builder.singlethreaded.SingleThreadedBuilder.build(SingleThreadedBuilder.java:51)
	at org.apache.maven.lifecycle.internal.LifecycleStarter.execute(LifecycleStarter.java:128)
	at org.apache.maven.DefaultMaven.doExecute(DefaultMaven.java:307)
	at org.apache.maven.DefaultMaven.doExecute(DefaultMaven.java:193)
	at org.apache.maven.DefaultMaven.execute(DefaultMaven.java:106)
	at org.apache.maven.cli.MavenCli.execute(MavenCli.java:863)
	at org.apache.maven.cli.MavenCli.doMain(MavenCli.java:288)
	at org.apache.maven.cli.MavenCli.main(MavenCli.java:199)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.codehaus.plexus.classworlds.launcher.Launcher.launchEnhanced(Launcher.java:289)
	at org.codehaus.plexus.classworlds.launcher.Launcher.launch(Launcher.java:229)
	at org.codehaus.plexus.classworlds.launcher.Launcher.mainWithExitCode(Launcher.java:415)
	at org.codehaus.plexus.classworlds.launcher.Launcher.main(Launcher.java:356)
	at org.codehaus.classworlds.Launcher.main(Launcher.java:47)
Caused by: com.spotify.docker.client.exceptions.DockerRequestException: Request error: GET unix://localhost:80/version: 503, body: Unable to round-trip http request to upstream: dial tcp 127.0.0.1:80: connect: connection refused
	at com.spotify.docker.client.DefaultDockerClient.propagate(DefaultDockerClient.java:2820)
	at com.spotify.docker.client.DefaultDockerClient.request(DefaultDockerClient.java:2692)
	at com.spotify.docker.client.DefaultDockerClient.version(DefaultDockerClient.java:580)
	at com.spotify.docker.client.DefaultDockerClient.authRegistryHeader(DefaultDockerClient.java:2871)
	at com.spotify.docker.client.DefaultDockerClient.build(DefaultDockerClient.java:1478)
	at com.spotify.docker.client.DefaultDockerClient.build(DefaultDockerClient.java:1445)
	at com.spotify.plugin.dockerfile.BuildMojo.buildImage(BuildMojo.java:201)
	... 26 more
Caused by: com.spotify.docker.client.shaded.javax.ws.rs.ServiceUnavailableException: HTTP 503 Service Unavailable
	at com.spotify.docker.client.shaded.org.glassfish.jersey.client.JerseyInvocation.convertToException(JerseyInvocation.java:1023)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.client.JerseyInvocation.translate(JerseyInvocation.java:816)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.client.JerseyInvocation.access$700(JerseyInvocation.java:92)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.client.JerseyInvocation$5.completed(JerseyInvocation.java:773)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.client.ClientRuntime.processResponse(ClientRuntime.java:198)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.client.ClientRuntime.access$300(ClientRuntime.java:79)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.client.ClientRuntime$2.run(ClientRuntime.java:180)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.internal.Errors$1.call(Errors.java:271)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.internal.Errors$1.call(Errors.java:267)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.internal.Errors.process(Errors.java:315)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.internal.Errors.process(Errors.java:297)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.internal.Errors.process(Errors.java:267)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.process.internal.RequestScope.runInScope(RequestScope.java:340)
	at com.spotify.docker.client.shaded.org.glassfish.jersey.client.ClientRuntime$3.run(ClientRuntime.java:210)
	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
	at java.util.concurrent.FutureTask.run(FutureTask.java:266)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
```