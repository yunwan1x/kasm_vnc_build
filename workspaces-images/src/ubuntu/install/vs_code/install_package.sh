set -e
apt-get install -y wget curl  openssl git tini
echo install tools successful  
apt install -y python3-setuptools \
                   python3-venv \
                   python3-virtualenv \
                   python3-pip
pip3 install  ipykernel --no-cache-dir
ln -s /usr/bin/python3 /usr/bin/python
apt-get autoclean
rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

