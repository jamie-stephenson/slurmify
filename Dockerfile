FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    systemd \
    apt-utils \
    build-essential \
    devscripts \
    debhelper \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD ./* /home/ubuntu/slurmify/

# Enable systemd in the container
STOPSIGNAL SIGRTMIN+3
CMD ["/lib/systemd/systemd"]

