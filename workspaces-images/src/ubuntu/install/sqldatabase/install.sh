#!/usr/bin/env bash
set -ex
BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
arch=arm64
fi
wget -O /tmp/dbeaver.deb https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v5.1.0-beta.12/beekeeper-studio_5.1.0-beta.12_${arch}.deb

apt install /tmp/dbeaver.deb
mv $INST_SCRIPTS/sqldatabase/BeekeeperStudio.desktop $HOME/Desktop/
mkdir -p $HOME/.config/beekeeper-studio/
mv $INST_SCRIPTS/sqldatabase/app.db $HOME/.config/beekeeper-studio/