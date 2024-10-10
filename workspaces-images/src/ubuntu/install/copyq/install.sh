#!/usr/bin/env bash
set -ex
# wget -O /usr/share/vscode-server-linux-x64-web.tar.gz https://az764295.vo.msecnd.net/stable/8b3775030ed1a69b13e4f4c628c612102e30a681/vscode-server-linux-x64-web.tar.

wget -O /tmp/copyq.deb https://github.com/hluk/CopyQ/releases/download/v9.0.0/copyq_9.0.0_Debian_10-1_amd64.deb
apt update
apt install -y /tmp/copyq.deb
rm -rf /tmp/copyq.deb
mkdir -p $HOME/Desktop
mv $INST_SCRIPTS/copyq/CopyQ.desktop $HOME/Desktop/



#e170252f762678dec6ca2cc69aba1570769a5d39/

#https://update.code.visualstudio.com/commit:e170252f762678dec6ca2cc69aba1570769a5d39/server-linux-x64/stable