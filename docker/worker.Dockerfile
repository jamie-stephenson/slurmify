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

# Docker containers max sys uid is 999 but slurm defaults to a larger one
RUN groupadd -r slurm && useradd -r -g slurm -u 999 slurm

RUN sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config

#   22: SSH
# 6818: Slurm D
EXPOSE 22 6818