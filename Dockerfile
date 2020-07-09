FROM openjdk
ARG version
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz

COPY target/integrationjar.jar /integrationjar.jar

ENTRYPOINT ["java", "-Dspring.profiles.active=container", "-jar", "/integrationjar.jar"]