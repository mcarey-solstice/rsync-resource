###
# Defines how to build the docker image
##

FROM alpine:latest

# Dependencies
RUN apk update
RUN apk add \
          rsync \
          openssh \
          sshpass \
          supervisor
RUN rm -rf /var/cache/apk/*

# Directory for scripts
RUN mkdir -p /opt/resources
ADD scripts/ /opt/resources/

# Set up entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD /entrypoint.sh

# Dockerfile
