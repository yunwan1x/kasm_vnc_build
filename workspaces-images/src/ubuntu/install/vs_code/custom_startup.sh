#!/usr/bin/env bash
set -e
declare -A KASM_PROCS

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

if [ ! -f ${CERT_DIR}/self.pem ];then
    openssl genrsa -out ${CERT_DIR}/self.key 2048
    openssl req -new -sha256 -key ${CERT_DIR}/self.key -subj "/CN=*.${DOMAIN_NAME-mydomain.com}" -out ${CERT_DIR}/server.csr 
    openssl x509 -req -in ${CERT_DIR}/server.csr -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -CAcreateserial -out ${CERT_DIR}/self.crt -days 3650 -sha256 -extfile ${CERT_DIR}/certificate.cfg
    rm ${CERT_DIR}/server.csr
    cat ${CERT_DIR}/self.crt  ${CERT_DIR}/self.key > ${CERT_DIR}/self.pem
fi

function start_nginx (){
  nginx -g "daemon off;" &
  KASM_PROCS['nginx']=$!
}

function start_vscode() {
    mkdir -p /root/project
    /usr/share/vscode-server-linux-x64-web/bin/code-server --port 58000 --host 127.0.0.1  --without-connection-token --accept-server-license-terms  &
    KASM_PROCS['vscode']=$!
}
start_nginx
start_vscode
while :
do
	for process in "${!KASM_PROCS[@]}"; do
		if ! ps -p   "${KASM_PROCS[$process]}" > /dev/null ; then
			case $process in
		
        nginx)
          echo "Restarting nginx Service"
          start_nginx
          ;;
        vscode)
          echo "Restarting nginx Service"
          start_vscode
          ;;
        *)
            echo "Unknown Service: $process"
            ;;
			esac
		fi
	done
	sleep 5
done


echo "Exiting Kasm container"