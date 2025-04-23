#!/usr/bin/env bash
set -ex
BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
exit 0
fi
mv $INST_SCRIPTS/sqldatabase/navicat17-premium/navicat.desktop $HOME/Desktop/
mv $INST_SCRIPTS/sqldatabase/navicat17-premium/reset-navicat.sh /usr/local/bin/
chmod +x  $HOME/Desktop/navicat.desktop
chmod +x /usr/local/bin/reset-navicat.sh
mv $INST_SCRIPTS/sqldatabase/navicat17-premium /opt/


