
for plugin in ms-python.python ms-toolsai.jupyter ms-toolsai.jupyter-renderers ms-python.debugpy alefragnani.project-manager PKief.material-icon-theme redhat.vscode-yaml     ms-kubernetes-tools.vscode-kubernetes-tools  ipedrazas.kubernetes-snippets  hediet.vscode-drawio   ;do
code-server   --install-extension $plugin
done

for plugin in KevinRose.vsc-python-indent wholroyd.jinja cstrap.python-snippets njqdev.vscode-python-typehint quarto.quarto  ;do
code-server   --install-extension $plugin
done

for plugin in rangav.vscode-thunder-client johnpapa.vscode-peacock    moshfeu.compare-folders xyz.local-history zjffun.snippetsmanager ;do
code-server   --install-extension $plugin
echo install $plugin success
done

code-server   --install-extension $STARTUPDIR/vsix/ryu1kn.partial-diff-1.4.3.vsix
code-server   --install-extension $STARTUPDIR/vsix/okteto.kubernetes-context-0.1.0.vsix
code-server   --install-extension $STARTUPDIR/vsix/touchlab.touchlab-vscode-office-3.1.7.vsix
code-server   --install-extension $STARTUPDIR/vsix/rambit.highlight-counter-1.6.0.vsix
code-server   --install-extension $STARTUPDIR/vsix/ebicochineal.select-highlight-cochineal-color-0.2.4.vsix
code-server   --install-extension $STARTUPDIR/vsix/jry.airdb-1.2.3.vsix





