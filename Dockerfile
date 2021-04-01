FROM openjdk:11
COPY app app
WORKDIR app
RUN ./gradlew build 
