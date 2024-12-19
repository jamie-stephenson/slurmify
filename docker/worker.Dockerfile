FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    vim \
    systemd \
    apt-utils \
    openssh-server \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config

EXPOSE 22