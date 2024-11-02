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
mkdir -p $HOME/Uploads/
BUILD_ARCH=$(uname -m)
chrome=chrome
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
chrome=chromium
fi
mv -f $STARTUPDIR/desktop/google-${chrome}-unsafe.desktop $HOME/Desktop






