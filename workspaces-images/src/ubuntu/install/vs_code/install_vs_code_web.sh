#!/usr/bin/env bash
set -ex


# cd /usr/share
wget -O /tmp/code.deb https://github.com/coder/code-server/releases/download/v4.93.1/code-server_4.93.1_amd64.deb
apt install -y /tmp/code.deb
rm -rf /tmp/code.deb

for plugin in ms-python.python ms-toolsai.jupyter ms-toolsai.jupyter-renderers ms-python.debugpy alefragnani.project-manager PKief.material-icon-theme redhat.vscode-yaml cweijan.vscode-mysql-client2    ms-kubernetes-tools.vscode-kubernetes-tools cweijan.dbclient-jdbc ipedrazas.kubernetes-snippets  hediet.vscode-drawio cweijan.vscode-office pomdtr.excalidraw-editor ;do
code-server   --install-extension $plugin
done

code-server   --install-extension $INST_SCRIPTS/vs_code/vsix/ryu1kn.partial-diff-1.4.3.vsix

mkdir -p $HOME/Desktop
mv $INST_SCRIPTS/vs_code/VSCode.desktop $HOME/Desktop/




