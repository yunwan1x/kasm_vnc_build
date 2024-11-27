# 功能列表（20241024）

1. 集成了navi命令行，NAVI_PATH="$HOME/Uploads/cheat:/usr/share/cheat"
2. CA签署证书指令

   ```bash
   DIR=/tmp
   DOMAIN_NAME=vs2010wy.top
   IP1=127.0.0.1
   IP2=127.0.0.2
   cat <<EOF > ${DIR}/certificate.cfg
   authorityKeyIdentifier=keyid,issuer
   basicConstraints=CA:FALSE
   keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
   subjectAltName = @alt_names

   [alt_names]
   DNS.1 = ${DOMAIN_NAME}
   DNS.2 = *.${DOMAIN_NAME}
   IP.1 = ${IP1}
   IP.2 = ${IP2}
   EOF

   cat <<EOF > ${DIR}/server.cnf
   [req]
   default_bits = 2048
   prompt = no
   default_md = sha256
   req_extensions = req_ext
   distinguished_name = dn

   [dn]
   C = CN
   ST = YourState
   L = YourCity
   O = YourOrganization
   OU = YourUnit
   CN = ${DOMAIN_NAME-mydomain.com}   

   [req_ext]
   subjectAltName = @alt_names

   [alt_names]
   DNS.1 = ${DOMAIN_NAME-mydomain.com}
   DNS.2 = *.${DOMAIN_NAME-mydomain.com}  
   DNS.3 = localhost  
   IP.1 = ${IP1}  
   IP.2 = ${IP2}
   EOF

   openssl genrsa -out ${DIR}/self.key 2048
   openssl req -new -sha256 -key ${DIR}/self.key -config ${DIR}/server.cnf -out server.csr 
   openssl x509 -req -in server.csr -CA /usr/share/cert/ca.crt -CAkey /usr/share/cert/ca.key -CAcreateserial -out ${DIR}/self.crt -days 3650 -sha256 -extfile ${DIR}/certificate.cfg 
   rm server.csr
   cat ${DIR}/self.crt ${DIR}/self.key > ${DIR}/self.pem
   ```
3. 各系统安装证书

   ```bash
   # macos
   sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ca.crt
   sudo security delete-certificate -c ""

   # ubuntu,alpine,debian
   sudo cp ca.crt /usr/local/share/ca-certificates
   sudo update-ca-certificates

   # centos
   sudo cp ca.crt  /etc/ssl/certs/ca.crt
   sudo update-ca-trust
   ```
4. 运行本镜像

   ```bash
   docker run --rm --shm-size=512m -v HOSTPATH:/home/kasm-user/  -e DEBUG=true -e USER_NAME=admin -e VNC_PW=admin  -e DOMAIN_NAME=wy.aliyuncs.com -e IP1=xx.xx.xx.xx  --name  vscodedesktop -p 6905:443 changhui/ubuntu:20.04
   ```
5. 集成了drawio
6. 集成了excel编辑器
7. 集成了sample.http功能
8. 集成了quarto 文档写作工具。参考 [galleray](https://quarto.org/docs/gallery/)
9. 集成了[termscp](https://github.com/veeso/termscp)
