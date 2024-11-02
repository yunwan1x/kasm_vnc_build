#!/usr/bin/env bash
set -ex
# wget -O /usr/share/vscode-server-linux-x64-web.tar.gz https://az764295.vo.msecnd.net/stable/8b3775030ed1a69b13e4f4c628c612102e30a681/vscode-server-linux-x64-web.tar.
BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
exit 0
fi
wget -O /tmp/deepin.deb http://archive.ubuntu.com/ubuntu/pool/universe/d/deepin-terminal/deepin-terminal_5.0.0+ds1-1_amd64.deb

apt update
apt install -y /tmp/deepin.deb
rm -rf /tmp/deepin.deb
mkdir -p $HOME/Desktop
mv $INST_SCRIPTS/deepin_terminal/Terminal.desktop $HOME/Desktop/



#e170252f762678dec6ca2cc69aba1570769a5d39/

#https://update.code.visualstudio.com/commit:e170252f762678dec6ca2cc69aba1570769a5d39/server-linux-x64/stable