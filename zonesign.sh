#!/bin/sh
if [ -f /etc/bind/$3 ]; then
	zonesigner -genkeys -usensec3 -zone $1 $3
	rollinit -zonefile /etc/bind/$3.signed -keyrec /etc/bind/$1.krf -admin $2 $1 >> all.rollrec
	echo "\nDNSKEYs:"
	cat Kmaserservis.cz.*.key | grep DNSKEY
else
	echo "cd /etc/bind"
	echo "zonesign.sh [name] [email] [file]"
	echo "zonesign.sh pdostal.cz zonemaster@pdostal.cz db.pdostal.cz"
fi

