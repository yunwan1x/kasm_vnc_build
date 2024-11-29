#!/usr/bin/env bash
# https://github.com/denisidoro/navi?tab=readme-ov-file#installation

BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
arch=arm64
fi

if [ arm64 = "$arch" ];then

wget  -O /tmp/navi.tgz https://github.com/denisidoro/navi/releases/download/v2.23.0/navi-v2.23.0-aarch64-unknown-linux-gnu.tar.gz

else
wget  -O /tmp/navi.tgz https://github.com/denisidoro/navi/releases/download/v2.23.0/navi-v2.23.0-$(uname -m)-unknown-linux-musl.tar.gz

fi

tar xvzf /tmp/navi.tgz -C /usr/local/bin && rm -rf /tmp/navi.tgz

wget -O /tmp/fzf.tgz https://github.com/junegunn/fzf/releases/download/v0.55.0/fzf-0.55.0-linux_${arch}.tar.gz
tar xvzf /tmp/fzf.tgz -C /usr/local/bin && rm -rf /tmp/fzf.tgz

