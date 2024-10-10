#!/usr/bin/env bash
set -ex

if [ "$DISTRO" = centos ]; then
  yum install -y nano zip wget
  yum install epel-release -y
  yum install xdotool -y
else
  apt update 
  apt-get install -y nano zip  zsh
  apt install -y   fonts-noto-color-emoji

  apt-get clean -y
  rm -rf \
      /var/tmp/* \
      /tmp/*
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir -p /usr/lib/dconf && chown 1000:0  /usr/lib/dconf
strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
