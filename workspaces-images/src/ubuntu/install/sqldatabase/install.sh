#!/usr/bin/env bash
set -ex
# wget -O /usr/share/vscode-server-linux-x64-web.tar.gz https://az764295.vo.msecnd.net/stable/8b3775030ed1a69b13e4f4c628c612102e30a681/vscode-server-linux-x64-web.tar.
BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
arch=arm64
exit 0
fi
wget -O /tmp/dbeaver.deb https://dbeaver.io/files/dbeaver-ce_latest_${arch}.deb
apt update
apt install -y /tmp/dbeaver.deb
rm -rf /tmp/dbeaver.deb
mkdir -p $HOME/Desktop
mv $INST_SCRIPTS/sqldatabase/dbeaver-ce.desktop $HOME/Desktop/
mkdir -p /home/kasm-user/.local/share
mv $INST_SCRIPTS/sqldatabase/DBeaverData /home/kasm-user/.local/share/
chown -R 1000:1000 /home/kasm-user/.local/share/DBeaverData


#e170252f762678dec6ca2cc69aba1570769a5d39/

#https://update.code.visualstudio.com/commit:e170252f762678dec6ca2cc69aba1570769a5d39/server-linux-x64/stable