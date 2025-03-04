#!/usr/bin/env bash
set -ex
# wget -O /usr/share/vscode-server-linux-x64-web.tar.gz https://az764295.vo.msecnd.net/stable/8b3775030ed1a69b13e4f4c628c612102e30a681/vscode-server-linux-x64-web.tar.
BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
arch=arm64
cd /tmp
wget -O /tmp/dbeaver.tgz https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.aarch64-nojdk.tar.gz 
tar xvzf  /tmp/dbeaver.tgz
wget -O /tmp/java17.tgz https://download.oracle.com/java/17/archive/jdk-17.0.12_linux-aarch64_bin.tar.gz
tar xvzf java17.tgz 
mv  jdk-17.0.12 jre
mv jre /tmp/dbeaver/
mv dbeaver dbeaver-ce
mv dbeaver-ce /usr/share/
rm -rf /tmp/java17.tgz
rm -rf /tmp/dbeaver.tgz
sed -i 's/dbeaver.png/icon.xpm/' $INST_SCRIPTS/sqldatabase/dbeaver-ce.desktop
else


wget -O /tmp/dbeaver.deb https://dbeaver.io/files/dbeaver-ce_latest_${arch}.deb
apt update
apt install -y /tmp/dbeaver.deb
rm -rf /tmp/dbeaver.deb
fi
mkdir -p $HOME/Desktop
mv $INST_SCRIPTS/sqldatabase/dbeaver-ce.desktop $HOME/Desktop/
mkdir -p $HOME/.local/share
mv $INST_SCRIPTS/sqldatabase/DBeaverData $HOME/.local/share/
chown -R 1000:1000 $HOME/.local/share/DBeaverData
#e170252f762678dec6ca2cc69aba1570769a5d39/

#https://update.code.visualstudio.com/commit:e170252f762678dec6ca2cc69aba1570769a5d39/server-linux-x64/stable