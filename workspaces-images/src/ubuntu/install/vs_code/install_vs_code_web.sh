#!/usr/bin/env bash
set -ex

wget -O /usr/share/vscode-server-linux-x64-web.tar.gz  https://az764295.vo.msecnd.net/stable/$(curl https://update.code.visualstudio.com/api/commits/stable/server-linux-x64-web | cut -d '"' -f 2)/vscode-server-linux-x64-web.tar.gz
cd /usr/share
tar xvzf vscode-server-linux-x64-web.tar.gz
rm -rf /usr/share/vscode-server-linux-x64-web.tar.gz
# Cleanup

apt-get install -y python3-setuptools \
                   python3-venv \
                   python3-virtualenv \
                   python3-pip
pip3 install  ipykernel
apt-get autoclean
rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
