#!/usr/bin/env bash
set -ex

DST_DIR=/usr/share

wget -O /tmp/clion.tgz https://download.jetbrains.com/cpp/CLion-2024.1.tar.gz 
tar xvzf /tmp/clion.tgz -C $DST_DIR
rm -rf /tmp/clion.tgz

