#!/usr/bin/env bash
set -ex
mkdir -p $HOME/.local/share/code-server/User/
chown 1000:0 $STARTUPDIR/settings.json
mv  $STARTUPDIR/settings.json  $HOME/.local/share/code-server/User/
mkdir -p /usr/share/cheat/
chown -R 1000:0 $STARTUPDIR/cheat
chown -R 1000:0 $STARTUPDIR/examples
mv $STARTUPDIR/cheat/others /usr/share/cheat/
mv $STARTUPDIR/cheat $HOME/Uploads/
mv $STARTUPDIR/examples $HOME/Uploads/

