#!/usr/bin/env bash
set -ex

apt-get update  && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    uidmap \
    openssh-client \
    lxc \
    iptables
rm -rf /var/lib/apt/list/*


curl -sSL https://get.docker.com/ | sh
echo "kasm-user:${VNC_PW-password}" | chpasswd

adduser kasm-user docker
