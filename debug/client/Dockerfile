###
# Added for testing and debugging
# Do NOT use this file for actual use
##

FROM rsync-resource:test

# Dependencies
RUN apk update
RUN apk add \
          bash \
          pwgen
RUN rm -rf /var/cache/apk/*

# Add an entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD /entrypoint.sh

ENTRYPOINT /entrypoint.sh

# client.Dockerfile
