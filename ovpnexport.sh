#!/bin/sh

path="/etc/openvpn/"
rsa="easy-rsa/keys/"
pwd=`pwd`

echo "Starting..."
echo "* ${path}"
echo "* ${path}${rsa}"
if [ ! -f ${path}${rsa}ca.crt ]; then
  echo "### ${path}${rsa}ca.crt doesn't exist"
  exit
elif [ ! -f ${path}${rsa}${1}.crt ]; then
  echo "### ${path}${rsa}${1}.crt doesn't exist"
else
  echo "- Creating ${1}/"
  mkdir $1
  echo "- ca.crt -> ${1}/ca.crt"
  cp ${path}easy-rsa/keys/ca.crt ${1}/ca.crt
  echo "- ${1}.crt -> ${1}/crt.crt"
  cp ${path}easy-rsa/keys/${1}.crt ${1}/crt.crt
  echo "- ${1}.key -> ${1}/key.key"
  cp ${path}easy-rsa/keys/${1}.key ${1}/key.key
  echo "- client.ovpn -> ${1}/client.conf"
  cp ${path}client.ovpn ${1}/client.conf
  echo "- ${1}/ -> ${1}.zip"
  zip -rq /tmp/${1}.zip ${1}/*
  echo "- Removing ${1}/"
  rm -rf ${1}/
  echo "- Setting 755 for ${1}.zip"
  chmod 775 /tmp/${1}.zip
  echo "* /tmp/${1}.zip"
  echo "Finishing..."
fi

