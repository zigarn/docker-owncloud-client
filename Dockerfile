FROM alpine:3.12

ARG BUILD_DATE=none
ARG VCS_REF=none
ARG VERSION=none

LABEL maintainer="Alexandre Garnier <zigarn@gmail.com>" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="docker-nextcloud-client" \
      org.label-schema.description="Nextcloud client docker image for Nextcloud synchronization" \
      org.label-schema.usage="https://github.com/zigarn/docker-nextcloud-client/blob/$VCS_REF/README.md" \
      org.label-schema.url="https://github.com/zigarn/docker-nextcloud-client" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/zigarn/docker-nextcloud-client.git" \
      org.label-schema.vendor="Zigarn" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

# Install nextcloud-client (2.6.4)
RUN apk add --no-cache nextcloud-client

# Data volumes
VOLUME /data /log

# Configuration
VOLUME /conf
RUN ln -s /conf/.netrc ~/.netrc
ENV SERVER ''
ENV DAVPATH '/remote.php/dav'
ENV PERIODICITY '0 * * * *'
ENV LANG 'C.UTF-8'

# Synchronization
ADD run_sync.sh /run_sync.sh
CMD /run_sync.sh
