apt-get update
apt-get install -y wget curl  python3-setuptools \
                   python3-venv \
                   python3-virtualenv \
                   python3-pip
pip3 install  ipykernel --no-cache-dir

apt-get autoclean
rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*