###
# Defines how to build the docker image
##

FROM alpine:latest

RUN apk update
RUN apk add rsync openssh supervisor

RUN mkdir -p /opt/resources

COPY src/ /opt/resources/

COPY entrypoint.sh /entrypoint.sh

CMD /entrypoint.sh

# Dockerfile
