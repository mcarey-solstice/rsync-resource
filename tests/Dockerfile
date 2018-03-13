###
#
##

FROM alpine:latest

# Dependencies
RUN apk update
RUN apk add \
          bash \
          jq \
          supervisor
RUN rm -rf /var/cache/apk/*

# Add the test code
ENV PATH /opt/tests/_bin:${PATH}

# Add an entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD /entrypoint.sh

# tests.Dockerfile
