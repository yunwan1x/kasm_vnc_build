#!/usr/bin/env bash
set -ex
BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
exit 0
fi
mv $INST_SCRIPTS/sqldatabase/navicat17-premium/navicat.desktop $HOME/Desktop/
chmod +x  $HOME/Desktop/navicat.desktop
mv $INST_SCRIPTS/sqldatabase/navicat17-premium /opt/


