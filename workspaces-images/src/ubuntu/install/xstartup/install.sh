#!/usr/bin/env bash
set -ex
mkdir -p $HOME/.local/share/code-server/User/
chown 1000:0 $STARTUPDIR/settings.json
mv  $STARTUPDIR/settings.json  $HOME/.local/share/code-server/User/
mkdir -p /usr/share/cheat/
chown -R 1000:0 $STARTUPDIR/cheat
chown -R 1000:0 $STARTUPDIR/examples
mv $STARTUPDIR/cheat/others /usr/share/cheat/
mv $STARTUPDIR/cheat $HOME/Uploads/
cp -rf /usr/share/cert $STARTUPDIR/examples
mv $STARTUPDIR/examples $HOME/Uploads/
mkdir -p $HOME/.config/xfce4/terminal/
mv $STARTUPDIR/terminalrc $HOME/.config/xfce4/terminal/
mv -f  $STARTUPDIR/websocket.conf /etc/nginx/conf.d

# k9s skin
mkdir -p  /root/.config/k9s/skins
mkdir -p  $HOME/.config/k9s/skins
cp  $STARTUPDIR/k9s/skins/*  /root/.config/k9s/skins
cp  $STARTUPDIR/k9s/config.yaml  /root/.config/k9s
cp  $STARTUPDIR/k9s/plugins.yaml  /root/.config/k9s
echo alias k9s=\"sudo k9s \" >> ${ZDOTDIR:-$HOME}/.zshrc
BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
exit 0
fi
echo "deb http://mirrors.cloud.aliyuncs.com/ubuntu/ jammy main restricted universe multiverse">>/etc/apt/sources.list
apt update
apt install -y libc6 g++-11
rm -rf /var/lib/apt/list/*
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
exit 0
fi
strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
# strip --remove-section=.note.ABI-tag /opt/navicat17-premium/usr/lib/libQt6Core.so.6


