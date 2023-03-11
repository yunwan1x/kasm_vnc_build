#!/usr/bin/env bash
set -ex
rm -rf /etc/nginx/sites-enabled/default
rm -rf $HOME/jsmpeg
mv $STARTUPDIR/jsmpeg $HOME/
mv $HOME/jsmpeg/index.html /usr/share/kasmvnc/www
mv $HOME/jsmpeg/main.bundle.js  /usr/share/kasmvnc/www/dist
mv $HOME/jsmpeg/jsmpeg.min.js /usr/share/kasmvnc/www/dist
mv $HOME/jsmpeg/style.bundle.css /usr/share/kasmvnc/www/dist
mkdir -p /etc/nginx/conf.d
mv $HOME/jsmpeg/websocket.conf /etc/nginx/conf.d

