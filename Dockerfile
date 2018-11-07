FROM alpine:3.8

LABEL maintainer="Marcin Domański <marcin@kabturek.info>" \
     description="monitor.sh script"

RUN set -x && \
    apk --no-cache add bash mosquitto-clients bluez bluez-deprecated bc git curl

RUN mkdir /monitor && \
    git clone https://github.com/andrewjfreyer/monitor.git /monitor

VOLUME ["/monitor", "/config"]
# Set up the entry point script and default command
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
WORKDIR /monitor
CMD ["/bin/bash", "monitor.sh", "-D", "/config"]
