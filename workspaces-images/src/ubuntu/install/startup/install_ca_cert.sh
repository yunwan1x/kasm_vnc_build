#!/usr/bin/env bash
set -ex

apt-get install -y libnss3-tools

CERT_FILE="${STARTUPDIR}/cert/ca.crt"
CERT_NAME="Custom Root CA"
cp -rf ${STARTUPDIR}/cert/ /usr/share/
chmod -R a+rw /usr/share/cert/
# Install the cert into the system cert store
cp ${CERT_FILE} /usr/local/share/ca-certificates/
update-ca-certificates


# Create an empty cert9.db. This will be used by applications like Chrome
if [ ! -d $HOME/.pki/nssdb/ ]; then
    mkdir -p $HOME/.pki/nssdb/
    certutil -N -d sql:$HOME/.pki/nssdb/ --empty-password
    chown 1000:1000 $HOME/.pki/nssdb/
fi

# Update all cert9.db instances with the CA
for certDB in $(find / -name "cert9.db")
do
    certdir=$(dirname ${certDB});
    echo "Updating $certdir"
    certutil -A -n "${CERT_NAME}" -t "TCu,," -i ${CERT_FILE} -d sql:${certdir}
done

