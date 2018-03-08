###
# Defines how to build the docker image
##

FROM alpine:latest

RUN apk update
RUN apk add rsync openssh

RUN mkdir -p /opt/resources

COPY src/ /opt/resources/

# Dockerfile
