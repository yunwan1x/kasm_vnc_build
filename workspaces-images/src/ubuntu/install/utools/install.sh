#!/usr/bin/env bash
set -ex
# wget -O /usr/share/vscode-server-linux-x64-web.tar.gz https://az764295.vo.msecnd.net/stable/8b3775030ed1a69b13e4f4c628c612102e30a681/vscode-server-linux-x64-web.tar.
BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
exit 0
fi

apt install -y $INST_SCRIPTS/utools/utools_7.2.1_amd64.deb
rm -rf /tmp/copyq.deb
mkdir -p $HOME/Desktop
mv $INST_SCRIPTS/utools/uTools.desktop $HOME/Desktop/