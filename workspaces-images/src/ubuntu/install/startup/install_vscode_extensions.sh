
for plugin in ms-python.python ms-toolsai.jupyter ms-toolsai.jupyter-renderers ms-python.debugpy alefragnani.project-manager PKief.material-icon-theme redhat.vscode-yaml cweijan.vscode-mysql-client2    ms-kubernetes-tools.vscode-kubernetes-tools cweijan.dbclient-jdbc ipedrazas.kubernetes-snippets  hediet.vscode-drawio cweijan.vscode-office  ;do
code-server   --install-extension $plugin
done

for plugin in KevinRose.vsc-python-indent wholroyd.jinja cstrap.python-snippets njqdev.vscode-python-typehint  ;do
code-server   --install-extension $plugin
done

for plugin in rangav.vscode-thunder-client johnpapa.vscode-peacock  ;do
code-server   --install-extension $plugin
done

code-server   --install-extension $STARTUPDIR/vsix/ryu1kn.partial-diff-1.4.3.vsix
code-server   --install-extension $STARTUPDIR/vsix/okteto.kubernetes-context-0.1.0.vsix
code-server   --install-extension $STARTUPDIR/vsix/seepine.md-editor-0.0.5.vsix