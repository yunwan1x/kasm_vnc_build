#!/usr/bin/env bash
set -ex
rm -rf /etc/nginx/sites-enabled/default
mv -f  $STARTUPDIR/jsmpeg $HOME/
mv -f  $HOME/jsmpeg/index.html /usr/share/kasmvnc/www
mv -f  $HOME/jsmpeg/main.bundle.js  /usr/share/kasmvnc/www/dist
mv -f  $HOME/jsmpeg/jsmpeg.min.js /usr/share/kasmvnc/www/dist
mv -f  $HOME/jsmpeg/style.bundle.css /usr/share/kasmvnc/www/dist
mkdir -p /etc/nginx/conf.d
mv -f  $HOME/jsmpeg/websocket.conf /etc/nginx/conf.d
mv -f  $HOME/jsmpeg/nginx.conf /etc/nginx
mv $HOME/jsmpeg /usr/share
chmod a+w /usr/share/jsmpeg/cert

# 修复新立得安装包以root权限运行
mv -f $STARTUPDIR/synaptic.desktop /usr/share/applications && chown 1000:0 $STARTUPDIR/synaptic.desktop /usr/share/applications && chmod +x $STARTUPDIR/synaptic.desktop /usr/share/applications/synaptic.desktop
rm -f /usr/share/kasmvnc/www/dist/images/782e6b34fd46a00744786246a454ed11.png





