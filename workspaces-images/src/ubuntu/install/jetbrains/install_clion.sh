#!/usr/bin/env bash
set -ex

DST_DIR=/usr/share


mv $DST_DIR/clion-*  $DST_DIR/clion

mv $INST_SCRIPTS/jetbra $DST_DIR/
mv $INST_SCRIPTS/clion/clion64.vmoptions $DST_DIR/clion/bin
mv $INST_SCRIPTS/clion/clion.desktop $HOME/Desktop
mv $INST_SCRIPTS/activate/activate\ page.desktop $HOME/Desktop
mv $INST_SCRIPTS/activate/activate.html $INST_SCRIPTS/activate/activate_files $DST_DIR
mkdir -p $HOME/.config/JetBrains
mv $INST_SCRIPTS/clion/CLion2024.1 $HOME/.config/JetBrains/
chown -R 1000:1000 $HOME/.config/JetBrains
chown -R 1000:1000 $HOME/Desktop/*.desktop

