FROM alpine:3.4

MAINTAINER Alexandre Garnier <zigarn@gmail.com>

# Install owncloud-client (2.2.0)
RUN echo -e '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main\n@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk add --no-cache owncloud-client@testing

# Data volumes
VOLUME /data /log

# Configuration
VOLUME /conf
RUN ln -s /conf/.netrc ~/.netrc
ENV SERVER ''
ENV PERIODICITY '0 * * * *'

# Synchronization
ADD run_sync.sh /run_sync.sh
CMD /run_sync.sh
