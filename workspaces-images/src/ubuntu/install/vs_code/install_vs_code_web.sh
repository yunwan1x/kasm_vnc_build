#!/usr/bin/env bash
set -ex
wget -O /usr/share/vscode-server-linux-x64-web.tar.gz  https://az764295.vo.msecnd.net/stable/$(curl https://update.code.visualstudio.com/api/commits/stable/server-linux-x64-web | cut -d '"' -f 2)/vscode-server-linux-x64-web.tar.gz
cd /usr/share
tar xvzf vscode-server-linux-x64-web.tar.gz
rm -rf /usr/share/vscode-server-linux-x64-web.tar.gz
for plugin in ms-python.python ms-toolsai.jupyter MS-CEINTL.vscode-language-pack-zh-hans alefragnani.project-manager PKief.material-icon-theme alefragnani.bookmarks  eamodio.gitlens cweijan.vscode-office ms-vscode-remote.remote-ssh ms-python.vscode-pylance donjayamanne.python-environment-manager yy0931.vscode-sqlite3-editor;do
/usr/share/vscode-server-linux-x64-web/bin/code-server --user-data-dir /home/kasm-user  --install-extension $plugin
done
# Cleanup

