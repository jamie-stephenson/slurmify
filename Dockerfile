FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    vim \
    systemd \
    apt-utils \
    build-essential \
    devscripts \
    debhelper \
    openssh-server \
    openssh-client \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . /home/ubuntu/slurmify/

# Enable systemd in the container
STOPSIGNAL SIGRTMIN+3
CMD ["/lib/systemd/systemd"]

