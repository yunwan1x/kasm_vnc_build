# 功能列表（20241024）

1. 集成了navi命令行，NAVI_PATH="$HOME/Uploads/cheat:/usr/share/cheat"
2. ```bash
   ## CA签署证书指令
   cat <<EOF > ${HOME}/.vnc/certificate.cfg
   authorityKeyIdentifier=keyid,issuer
   basicConstraints=CA:FALSE
   keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
   subjectAltName = @alt_names

   [alt_names]
   DNS.1 = ${DOMAIN_NAME-mydomain.com}
   DNS.2 = *.${DOMAIN_NAME-mydomain.com}
   IP.1 = ${IP1}
   IP.2 = ${IP2}
   EOF


   openssl genrsa -out ${HOME}/.vnc/self.key 2048
   openssl req -new -sha256 -key ${HOME}/.vnc/self.key -subj "/CN=*.${DOMAIN_NAME-mydomain.com}" -out server.csr 
   openssl x509 -req -in server.csr -CA /usr/share/cert/ca.crt -CAkey /usr/share/cert/ca.key -CAcreateserial -out ${HOME}/.vnc/self.crt -days 3650 -sha256 -extfile ${HOME}/.vnc/certificate.cfg 
   rm server.csr
   cat ${HOME}/.vnc/self.crt ${HOME}/.vnc/self.key > ${HOME}/.vnc/self.pem



   ```
3. 运行本镜像 `docker run --rm --shm-size=512m -v HOSTPATH:/home/kasm-user/  -e DEBUG=true -e USER_NAME=admin -e VNC_PW=admin  -e DOMAIN_NAME=wy.aliyuncs.com -e IP1=xx.xx.xx.xx  --name  vscodedesktop -p 6905:443 changhui/ubuntu:20.04`
4. 集成了drawio
5. 集成了excel编辑器
6. 集成了sample.http功能
7. 集成了quarto 文档写作工具。参考 [galleray](https://quarto.org/docs/gallery/)
