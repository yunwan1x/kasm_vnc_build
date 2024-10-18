#!/usr/bin/env bash
set -e
apt update 
apt-get install -y nano zip  zsh wget curl  bash-completion  openssl git tini fonts-noto-color-emoji libnss3-tools

echo install tools successful  

apt install -y python3-setuptools \
                   python3-venv \
                   python3-virtualenv \
                   python3-pip
pip3 install  ipykernel --no-cache-dir
ln -s /usr/bin/python3 /usr/bin/python
# pip3 install uv -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
# uv python install 3.12
apt-get autoclean
rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

apt-get clean -y

# 安装zsh和插件
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/zsh-syntax-highlighting/
echo "source /home/kasm-user/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
echo "source /home/kasm-user/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
sed -i   's#plugins=(git.*)#plugins=(git z aliases common-aliases)#g'  ${ZDOTDIR:-$HOME}/.zshrc
# 安装tldr
pip install tldr.py
git clone https://github.com/tldr-pages/tldr.git /usr/share/tldr
mv -f $STARTUPDIR/.tldrrc $HOME/

strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
