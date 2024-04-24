#!/usr/bin/env bash
set -ex
wget -O /usr/share/vscode-server-linux-x64-web.tar.gz https://az764295.vo.msecnd.net/stable/8b3775030ed1a69b13e4f4c628c612102e30a681/vscode-server-linux-x64-web.tar.gz
# wget -O /usr/share/vscode-server-linux-x64-web.tar.gz  https://update.code.visualstudio.com/commit:$(curl https://update.code.visualstudio.com/api/commits/stable/server-linux-x64-web | cut -d '"' -f 2)/server-linux-x64/stable
cd /usr/share
tar xvzf vscode-server-linux-x64-web.tar.gz
rm -rf /usr/share/vscode-server-linux-x64-web.tar.gz
for plugin in ms-python.python ms-toolsai.jupyter MS-CEINTL.vscode-language-pack-zh-hans alefragnani.project-manager PKief.material-icon-theme alefragnani.bookmarks    ms-python.vscode-pylance donjayamanne.python-environment-manager ;do
/usr/share/vscode-server-linux-x64-web/bin/code-server   --install-extension $plugin
done
# Cleanup

#e170252f762678dec6ca2cc69aba1570769a5d39/

#https://update.code.visualstudio.com/commit:e170252f762678dec6ca2cc69aba1570769a5d39/server-linux-x64/stable