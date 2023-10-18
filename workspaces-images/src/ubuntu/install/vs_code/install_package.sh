apt-get update
apt-get install -y wget curl openssl  python3-setuptools \
                   python3-venv \
                   python3-virtualenv \
                   python3-pip
pip3 install  ipykernel --no-cache-dir

apt-get autoclean
rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# 生成证书
CERT_DIR=${CERT_DIR:=/root/.cert}
mkdir -p ${CERT_DIR}
cat <<EOF > ${CERT_DIR}/certificate.cfg
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${DOMAIN_NAME-mydomain.com}
DNS.2 = *.${DOMAIN_NAME-mydomain.com}
IP.1 = ${IP1:=10.10.10.1}
IP.2 = ${IP2:=10.10.10.255}
EOF

test -f ${CERT_DIR}/self.pem  ||  (openssl genrsa -out ${CERT_DIR}/self.key 2048;openssl req -new -sha256 -key ${CERT_DIR}/self.key -subj "/CN=*.${DOMAIN_NAME-mydomain.com}" -out ${CERT_DIR}/server.csr ; openssl x509 -req -in server.csr -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -CAcreateserial -out ${CERT_DIR}/self.crt -days 3650 -sha256 -extfile ${CERT_DIR}/certificate.cfg) && rm ${CERT_DIR}/server.csr && cat ${CERT_DIR}/self.crt  ${CERT_DIR}/self.key > ${CERT_DIR}/self.pem
