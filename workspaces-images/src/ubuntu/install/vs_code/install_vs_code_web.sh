#!/usr/bin/env bash
set -ex

wget -O /usr/share/vscode-server-linux-x64-web.tar.gz  https://az764295.vo.msecnd.net/stable/$(curl https://update.code.visualstudio.com/api/commits/stable/server-linux-x64-web | cut -d '"' -f 2)/vscode-server-linux-x64-web.tar.gz
cd /usr/share
tar xvzf vscode-server-linux-x64-web.tar.gz





# Cleanup
apt-get autoclean
rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
