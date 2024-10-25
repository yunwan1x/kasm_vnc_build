#!/usr/bin/env bash
# https://github.com/denisidoro/navi?tab=readme-ov-file#installation

wget  -O /tmp/navi.tgz https://github.com/denisidoro/navi/releases/download/v2.23.0/navi-v2.23.0-x86_64-unknown-linux-musl.tar.gz
tar xvzf /tmp/navi.tgz -C /usr/local/bin && rm -rf /tmp/navi.tgz

wget -O /tmp/fzf.tgz https://github.com/junegunn/fzf/releases/download/v0.55.0/fzf-0.55.0-linux_amd64.tar.gz
tar xvzf /tmp/fzf.tgz -C /usr/local/bin && rm -rf /tmp/fzf.tgz

