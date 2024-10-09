#!/usr/bin/env bash
set -ex
# wget -O /usr/share/vscode-server-linux-x64-web.tar.gz https://az764295.vo.msecnd.net/stable/8b3775030ed1a69b13e4f4c628c612102e30a681/vscode-server-linux-x64-web.tar.

wget -O /tmp/openlens.deb https://github.com/MuhammedKalkan/OpenLens/releases/download/v6.5.2-366/OpenLens-6.5.2-366.amd64.deb
dpkg -i /tmp/openlens.deb
rm -rf /tmp/openlens.deb
mkdir -p /home/kasm-user/Desktop
mv $INST_SCRIPTS/openlens/OpenLens.desktop /home/kasm-user/Desktop/
mv $INST_SCRIPTS/openlens/.k8slens /home/kasm-user/
mv $INST_SCRIPTS/openlens/kubectl /usr/local/bin/
mv $INST_SCRIPTS/openlens/helm /usr/local/bin/
mkdir -p /home/kasm-user/.config/OpenLens/node_modules/
ln -s /home/kasm-user/.k8slens/extensions/openlens-plugins-integration-suite /home/kasm-user/.config/OpenLens/node_modules/openlens-plugins-integration-suite
mv $INST_SCRIPTS/openlens/lens-user-store.json   /home/kasm-user/.config/OpenLens/
mv $INST_SCRIPTS/openlens/lens-extensions.json   /home/kasm-user/.config/OpenLens/ 
# Cleanup

#e170252f762678dec6ca2cc69aba1570769a5d39/

#https://update.code.visualstudio.com/commit:e170252f762678dec6ca2cc69aba1570769a5d39/server-linux-x64/stable