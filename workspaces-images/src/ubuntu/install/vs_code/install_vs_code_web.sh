#!/usr/bin/env bash
set -ex

BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
arch=arm64
fi
# cd /usr/share
wget -O /tmp/code.deb https://github.com/coder/code-server/releases/download/v4.97.2/code-server_4.97.2_${arch}.deb
apt install -y /tmp/code.deb
rm -rf /tmp/code.deb


mkdir -p $HOME/Desktop
BUILD_ARCH=$(uname -m)
chrome=chrome
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
chrome=chromium
fi
mv $INST_SCRIPTS/vs_code/VSCode-${chrome}.desktop $HOME/Desktop/




