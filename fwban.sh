#!/bin/sh

BLOCKDB="block.txt"
cd /tmp

ipset --create openbl iphash 2> /dev/null
ipset --flush openbl

wget -q -c --output-document=$BLOCKDB http://www.openbl.org/lists/base.txt
if [ -f $BLOCKDB ]; then
    IPList=$(grep -Ev "^#" $BLOCKDB)
    for i in $IPList
    do
        ipset --add openbl $i 2> /dev/null
    done
fi
rm $BLOCKDB

ipset --create my iphash 2> /dev/null
ipset --flush my

BLOCKDB="/var/www/ban.txt"
touch $BLOCKDB
if [ -f $BLOCKDB ]; then
	IPList=$(grep -Ev "^#" $BLOCKDB)
	for i in $IPList
	do
		ipset --add my $i 2> /dev/null
	done
fi

sh /root/bin/fw.sh
iptables -A BLACK -m set --match-set openbl src -j DROP
iptables -A BLACK -m set --match-set my src -j DROP
ip6tables -A BLACK -m set --match-set openbl src -j DROP
ip6tables -A BLACK -m set --match-set my src -j DROP
iptables-save 1> /dev/null
ip6tables-save 1> /dev/null

