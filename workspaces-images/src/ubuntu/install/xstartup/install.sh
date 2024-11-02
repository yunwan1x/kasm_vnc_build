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
BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
exit 0
fi
strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
