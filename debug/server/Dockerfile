###
# Added for testing and debugging
# Do NOT use this file for actual use
##

FROM alpine:latest

# Dependencies
RUN apk update
RUN apk add \
          openssh \
          bash \
          rsync \
          supervisor
RUN rm -rf /var/cache/apk/*

# Setup configurations
RUN mkdir /var/run/sshd
ADD sshd.ini /etc/supervisor.d/sshd.ini

# Prepare SSH
RUN mkdir /root/.ssh
RUN chmod o-rwx /root/.ssh

EXPOSE 22

# Add an entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD /entrypoint.sh

ENTRYPOINT /entrypoint.sh

# server.Dockerfile
