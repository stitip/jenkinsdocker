FROM openjdk
ARG version

COPY target/integrationjar.jar /integrationjar.jar

ENTRYPOINT ["java", "-Dspring.profiles.active=container", "-jar", "/integrationjar.jar"]