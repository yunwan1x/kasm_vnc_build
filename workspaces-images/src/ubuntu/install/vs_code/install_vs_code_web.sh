#!/usr/bin/env bash
set -ex


# cd /usr/share
wget -O /tmp/code.deb https://github.com/coder/code-server/releases/download/v4.93.1/code-server_4.93.1_amd64.deb
apt install -y /tmp/code.deb
rm -rf /tmp/code.deb

for plugin in ms-python.python ms-toolsai.jupyter ms-toolsai.jupyter-renderers ms-python.debugpy alefragnani.project-manager PKief.material-icon-theme redhat.vscode-yaml cweijan.vscode-mysql-client2    ms-kubernetes-tools.vscode-kubernetes-tools cweijan.dbclient-jdbc ipedrazas.kubernetes-snippets  hediet.vscode-drawio;do
code-server   --install-extension $plugin
done



mkdir -p $HOME/Desktop
mv $INST_SCRIPTS/vs_code/VSCode.desktop $HOME/Desktop/




