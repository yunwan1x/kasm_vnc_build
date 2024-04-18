#!/usr/bin/env bash
set -ex

DST_DIR=/usr/share

wget -O /tmp/idea.tgz https://download-cdn.jetbrains.com.cn/idea/ideaIU-2024.1.tar.gz 
tar xvzf /tmp/idea.tgz -C $DST_DIR
rm -rf /tmp/idea.tgz

