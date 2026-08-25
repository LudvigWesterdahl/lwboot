#
# Build stage
#
FROM eclipse-temurin:17-alpine AS build

ARG CUSTOMER_MODULE
RUN if [ -z "${CUSTOMER_MODULE}" ]; then echo "ERROR: CUSTOMER_MODULE build argument is required!" && exit 1; fi

ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
COPY . $HOME
RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml --projects main --also-make --activate-profiles ${CUSTOMER_MODULE} clean package
RUN mkdir -p $HOME/target
RUN mv /usr/app/main/target/*.jar $HOME/target

#
# For debug purposes
#
ENTRYPOINT ["sleep", "infinity"]

#
# Package stage
#
FROM eclipse-temurin:17-alpine

# To allow font size estimations with java awt
# RUN apk add --no-cache freetype fontconfig ttf-dejavu

ARG ACTIVE_PROFILE
RUN if [ -z "${ACTIVE_PROFILE}" ]; then echo "ERROR: ACTIVE_PROFILE build argument is required!" && exit 1; fi

ENV ENV_ACTIVE_PROFILE=${ACTIVE_PROFILE}

# Ensures we are not running with root
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
ARG JAR_FILE=/usr/app/target/*.jar
COPY --from=build $JAR_FILE /app/runner.jar
WORKDIR /app
# The application server port
EXPOSE 8080

#ENTRYPOINT ["sleep", "infinity"]
ENTRYPOINT ["java", "-jar", "runner.jar", "--spring.profiles.active=${ENV_ACTIVE_PROFILE}"]
