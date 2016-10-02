FROM alpine:3.4
RUN \
    apk update && \
    apk upgrade && \
    apk add docker && \
    true
ENTRYPOINT \
    docker run --interactive --tty --rm --volume ${DOT_SSH}:/root/.ssh:ro $(docker volume ls -q | while read VOLUME; do echo " --volume ${VOLUME}:/source/${VOLUME}:ro "; done) emorymerryman/rsync:0.0.1 --verbose --archive --delete --progress /source/ ${TARGET}:volumes && \
    true