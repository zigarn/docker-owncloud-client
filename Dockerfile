FROM alpine:3.4

MAINTAINER Alexandre Garnier <zigarn@gmail.com>

ARG BUILD_DATE=none
ARG VCS_REF=none
ARG VERSION=none

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="docker-owncloud-client" \
      org.label-schema.description="ownCloud client docker image for ownCloud synchronization" \
      org.label-schema.usage="https://github.com/zigarn/docker-owncloud-client/blob/$VCS_REF/README.md" \
      org.label-schema.url="https://github.com/zigarn/docker-owncloud-client" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/zigarn/docker-owncloud-client.git" \
      org.label-schema.vendor="Zigarn" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

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
ENV LANG 'C.UTF-8'

# Synchronization
ADD run_sync.sh /run_sync.sh
CMD /run_sync.sh
