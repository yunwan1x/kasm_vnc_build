
for plugin in ms-python.python ms-toolsai.jupyter ms-toolsai.jupyter-renderers ms-python.debugpy alefragnani.project-manager PKief.material-icon-theme redhat.vscode-yaml cweijan.vscode-mysql-client2    ms-kubernetes-tools.vscode-kubernetes-tools cweijan.dbclient-jdbc ipedrazas.kubernetes-snippets  hediet.vscode-drawio cweijan.vscode-office  Kelvin.vscode-sshfs;do
code-server   --install-extension $plugin
done

code-server   --install-extension $STARTUPDIR/vsix/ryu1kn.partial-diff-1.4.3.vsix
