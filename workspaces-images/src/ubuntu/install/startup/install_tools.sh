#!/usr/bin/env bash
set -ex

if [ "$DISTRO" = centos ]; then
  yum install -y nano zip wget
  yum install epel-release -y
  yum install xdotool -y
else
  apt-get update
  apt-get install -y nano zip   xdotool  synaptic
  apt install -y   fonts-noto-color-emoji

  apt-get clean -y
  rm -rf \
      /var/tmp/* \
      /tmp/*
fi


