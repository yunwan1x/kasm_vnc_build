#!/usr/bin/env bash
set -ex

DST_DIR=/usr/share


mv $DST_DIR/idea-IU*  $DST_DIR/idea

mv $STARTUPDIR/jetbra $DST_DIR/
mv $STARTUPDIR/idea64.vmoptions $DST_DIR/idea/bin
mv $STARTUPDIR/IntelliJ\ IDEA.desktop $HOME/Desktop
mv $STARTUPDIR/activate\ page.desktop $HOME/Desktop
mv $STARTUPDIR/activate.html $DST_DIR

mkdir -p $HOME/.config/JetBrains/IntelliJIdea2023.3
mv $STARTUPDIR/IntelliJIdea2023.3/idea.key $HOME/.config/JetBrains/IntelliJIdea2023.3/
chown -R 1000:1000 $HOME/.config
