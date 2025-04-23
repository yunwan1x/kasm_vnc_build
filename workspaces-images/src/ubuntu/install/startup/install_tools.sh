#!/usr/bin/env bash
set -e
apt update 
apt-get install -y nano zip  zsh wget curl  bash-completion  openssl git tini fonts-noto-color-emoji libnss3-tools

apt install -y iputils-ping dnsutils  telnet tcpdump  fuse3

BUILD_ARCH=$(uname -m)
arch=amd64
if [[  "$BUILD_ARCH" =~ ^aarch64$ ]] ; then
arch=arm64
# apt upgrade -y libc6

fi
wget -O /tmp/quarto.deb https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.28/quarto-1.7.28-linux-${arch}.deb
apt install /tmp/quarto.deb
rm -f /tmp/quarto.deb


wget -O /tmp/rclone.deb https://downloads.rclone.org/v1.68.2/rclone-v1.68.2-linux-${arch}.deb
apt install /tmp/rclone.deb
rm -f /tmp/rclone.deb

mkdir -p  /home/kasm-user/.cache/
mv $STARTUPDIR/rclone /home/kasm-user/.cache/

wget -O /tmp/k9s.deb https://github.com/derailed/k9s/releases/download/v0.50.4/k9s_linux_${arch}.deb
apt install /tmp/k9s.deb
rm -f /tmp/k9s.deb



echo install tools successful  

apt install -y python3-setuptools \
                   python3-venv \
                   python3-virtualenv \
                   python3-pip
pip3 install  ipykernel --no-cache-dir
pip3 install jinja2 fastapi pymysql mysql-connector-python redis s3cmd kubernetes paramiko scapy psutil dnspython
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
# 安装navi




