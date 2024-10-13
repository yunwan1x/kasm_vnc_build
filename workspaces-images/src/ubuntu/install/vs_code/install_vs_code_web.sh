#!/usr/bin/env bash
set -ex


# cd /usr/share
wget -O /tmp/code.deb https://github.com/coder/code-server/releases/download/v4.93.1/code-server_4.93.1_amd64.deb
apt install -y /tmp/code.deb
rm -rf /tmp/code.deb


mkdir -p $HOME/Desktop
mv $INST_SCRIPTS/vs_code/VSCode.desktop $HOME/Desktop/




