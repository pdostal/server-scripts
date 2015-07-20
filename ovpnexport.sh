#!/bin/sh

path="/etc/openvpn/"
rsa="tun_keys/keys/"
pwd=`pwd`

echo "Starting..."
echo "* ${path}"
echo "* ${path}${rsa}"

if [ ! -f ${path}${rsa}ca.crt ]; then
  echo "Error: ${path}${rsa}ca.crt doesn't exist"
  exit
elif [ ! -f ${path}${rsa}${1}.crt ]; then
  echo "Error: ${path}${rsa}${1}.crt doesn't exist"
  exit
else
  echo "- Creating ${1}/"
  mkdir $1

  echo "- ca.crt -> ${1}/ca.crt"
  cp ${path}${rsa}/ca.crt ${1}/ca.crt

  echo "- ${1}.crt -> ${1}/crt.crt"
  cp ${path}${rsa}/${1}.crt ${1}/crt.crt

  echo "- ${1}.key -> ${1}/key.key"
  cp ${path}${rsa}/${1}.key ${1}/key.key

  #echo "- client.ovpn -> ${1}/client.conf"
  #cp ${path}client.ovpn ${1}/client.conf

  echo "- ${1}/ -> ${1}.zip"
  zip -rq /tmp/${1}.zip ${1}/*

  echo "- Removing ${1}/"
  rm -rf ${1}/

  echo "- Setting 755 for ${1}.zip"
  chmod 775 /tmp/${1}.zip

  echo "* /tmp/${1}.zip"
fi

echo "Finishing..."

