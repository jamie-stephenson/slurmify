# Use Ubuntu as the base image
FROM ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages, including Git, systemd, and Debian development tools
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

# Enable systemd in the container
STOPSIGNAL SIGRTMIN+3
CMD ["/lib/systemd/systemd"]

