FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    vim \
    sudo \
    apt-utils \
    build-essential \
    devscripts \
    debhelper \
    openssh-server \
    openssh-client \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Docker containers max sys uid is 999 but slurm defaults to a larger one
RUN groupadd -r slurm && useradd -r -g slurm -u 999 slurm

COPY .. /home/ubuntu/slurmify/

#   22: SSH
# 6817: Slurm Ctl D
# 6818: Slurm D
EXPOSE 22 6817 6818