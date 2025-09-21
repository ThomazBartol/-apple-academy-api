FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn -q -DskipTests package

FROM eclipse-temurin:21-jre
ENV APP_HOME=/opt/app \
    JAVA_OPTS=""
WORKDIR ${APP_HOME}

COPY --from=build /app/target/*.jar app.jar
EXPOSE 8083
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar app.jar" ]
