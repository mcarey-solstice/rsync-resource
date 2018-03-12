###
# Added for testing and debugging
# Do NOT use this file for actual use
##

FROM rsync-resource:test

RUN apk update
RUN apk add bash pwgen

COPY entrypoint.sh /entrypoint.sh

CMD /entrypoint.sh

# test.Dockerfile
