#!/usr/bin/env bash
set -ex
# wget -O /usr/share/vscode-server-linux-x64-web.tar.gz https://az764295.vo.msecnd.net/stable/8b3775030ed1a69b13e4f4c628c612102e30a681/vscode-server-linux-x64-web.tar.
BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
arch=arm64
fi

wget -O /tmp/openlens.deb https://github.com/MuhammedKalkan/OpenLens/releases/download/v6.5.2-366/OpenLens-6.5.2-366.${arch}.deb
dpkg -i /tmp/openlens.deb
rm -rf /tmp/openlens.deb
mkdir -p $HOME/Desktop
mv $INST_SCRIPTS/openlens/OpenLens.desktop $HOME/Desktop/
mv $INST_SCRIPTS/openlens/.k8slens $HOME

BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
arch=arm64
fi
wget -O /tmp/helm.tgz https://get.helm.sh/helm-v3.16.2-linux-${arch}.tar.gz
cd /tmp/
tar xvzf helm.tgz
mv linux-${arch}/helm /usr/local/bin/
chmod +x /usr/local/bin/helm

wget -O /usr/local/bin/kubectl  https://dl.k8s.io/v1.29.10/bin/linux/${arch}/kubectl
chmod +x /usr/local/bin/kubectl

rm -rf /tmp/*


mkdir -p $HOME/.config/OpenLens/node_modules/
ln -s $HOME/.k8slens/extensions/openlens-plugins-integration-suite $HOME/.config/OpenLens/node_modules/openlens-plugins-integration-suite
mv $INST_SCRIPTS/openlens/lens-user-store.json   $HOME/.config/OpenLens/
mv $INST_SCRIPTS/openlens/lens-extensions.json   $HOME/.config/OpenLens/ 
# Cleanup

#e170252f762678dec6ca2cc69aba1570769a5d39/

#https://update.code.visualstudio.com/commit:e170252f762678dec6ca2cc69aba1570769a5d39/server-linux-x64/stable
