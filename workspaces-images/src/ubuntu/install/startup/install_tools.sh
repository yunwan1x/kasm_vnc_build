#!/usr/bin/env bash
set -ex

if [ "$DISTRO" = centos ]; then
  yum install -y nano zip wget
  yum install epel-release -y
  yum install xdotool -y
else
  apt-get update
  apt-get install -y nano zip   xdotool  synaptic
fi
rm -rf $HOME/jsmpeg
mv $STARTUPDIR/jsmpeg $HOME/
mv $HOME/jsmpeg/index.html /usr/share/kasmvnc/www
mv $HOME/jsmpeg/main.bundle.js  /usr/share/kasmvnc/www/dist
mv $HOME/jsmpeg/jsmpeg.min.js /usr/share/kasmvnc/www/dist
mv $HOME/jsmpeg/style.bundle.css /usr/share/kasmvnc/www/dist
mkdir -p /etc/nginx/conf.d
mv $HOME/jsmpeg/websocket.conf /etc/nginx/conf.d

