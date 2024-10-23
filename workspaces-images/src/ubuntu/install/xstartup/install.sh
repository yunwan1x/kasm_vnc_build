#!/usr/bin/env bash
set -ex
mkdir -p $HOME/.local/share/code-server/User/
chown 1000:0 $STARTUPDIR/settings.json
mv  $STARTUPDIR/settings.json  $HOME/.local/share/code-server/User/

