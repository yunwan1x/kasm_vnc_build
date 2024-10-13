#!/usr/bin/env bash

chown -R 1000:0 /usr/share/tldr
mkdir -p /usr/lib/dconf && chown 1000:0  /usr/lib/dconf
chown -R 1000:0 /home/kasm-default-profile/
strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
