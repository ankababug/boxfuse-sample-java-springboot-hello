FROM centos:7
USER root
COPY /target/hello.jar .
EXPOSE 8087
CMD ["java","-jar","hello.jar"]
