#!/bin/sh
sh fw.sh
sleep 15

iptables -F
ip6tables -F
iptables -X
ip6tables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
ip6tables -t mangle -F
iptables -t mangle -X
ip6tables -t mangle -X

iptables -P INPUT ACCEPT
ip6tables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
ip6tables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
ip6tables -P OUTPUT ACCEPT

iptables-save 1> /dev/null
ip6tables-save 1> /dev/null

iptables -L -v --lin -n
echo "\n\n"
ip6tables -L -v --lin -n
echo "\n\n"
iptables -t nat -L -v -n
