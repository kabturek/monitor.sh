FROM multiarch/debian-debootstrap:armhf-stretch

LABEL maintainer="Marcin Domański <marcin@kabturek.info>" \
     description="monitor.sh script"

RUN set -x && \
    apt-get update && \
    apt-get install -y  --no-install-recommends \
        bash \
        bc \
        bluez \
        bluez-hcidump \
        ca-certificates \
        curl \
        git \
        mosquitto-clients \
        xxd 

RUN mkdir /monitor && \
    git clone https://github.com/andrewjfreyer/monitor.git /monitor

VOLUME ["/monitor", "/config"]
# Set up the entry point script and default command
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
WORKDIR /monitor
CMD ["/bin/bash", "monitor.sh", "-D", "/config"]
