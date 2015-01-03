#!/bin/sh

ipt4() { iptables $*; }
ipt6() { ip6tables $*; }
ipt46() { iptables $*; ip6tables $*; }

## Flush
ipt46 -F
ipt4 -t nat -F
ipt46 -X
ipt4 -t nat -X

ipt46 -P INPUT DROP
ipt46 -P FORWARD DROP
ipt46 -P OUTPUT ACCEPT

## NAT
ipt46 -A FORWARD -i tun0 -o venet0 -j ACCEPT
ipt46 -A FORWARD -i venet0 -o tun0 -j ACCEPT
ipt4 -t nat -A POSTROUTING -o venet0 -j SNAT --to 37.205.10.143

## local network
ipt46 -A INPUT -i lo -j ACCEPT
ipt46 -A INPUT -i tun0 -j ACCEPT

### white list
# Fanatik's home
ipt4 -A INPUT -s 78.80.198.94 -j ACCEPT
# Pavel's home
ipt4 -A INPUT -s 212.4.143.171 -j ACCEPT
# Pavel's shark
ipt4 -A INPUT -s 162.243.228.224 -j ACCEPT
ipt6 -A INPUT -s 2002:a2f3:e4e0::1 -j ACCEPT
# VPS
ipt4 -A INPUT -s 37.205.10.143 -j ACCEPT
ipt6 -A INPUT -s 2a01:430:17:1::ffff:554 -j ACCEPT
# BlindeGerichtichkeit-HBf
ipt4 -A INPUT -s 194.228.20.42 -j ACCEPT
ipt6 -A INPUT -s 2a00:1028:8382:990a:3843:41e0:f19a:4eb2 -j ACCEPT

## services
# ICMP
ipt4 -A INPUT -p icmp -j ACCEPT
ipt6 -A INPUT -p icmpv6 -j ACCEPT
# IDENT
ipt46 -A INPUT -p tcp --dport 113 -j ACCEPT
# SSH
ipt46 -A INPUT -p tcp --dport 22 -j ACCEPT
# DNS
ipt46 -A INPUT -p udp --dport 53 -j ACCEPT
ipt46 -A INPUT -p tcp --dport 53 -j ACCEPT
# OpenVPN
ipt46 -A INPUT -p tcp --dport 443 -j ACCEPT
# HTTP
ipt46 -A INPUT -p tcp --dport 80 -j ACCEPT
# MAIL
ipt46 -A INPUT -p tcp --dport 25 -j ACCEPT
ipt46 -A INPUT -p tcp --dport 465 -j ACCEPT
ipt46 -A INPUT -p tcp --dport 587 -j ACCEPT
ipt46 -A INPUT -p tcp --dport 993 -j ACCEPT
# FTP
ipt46 -A INPUT -m helper --helper ftp -j ACCEPT
ipt46 -A INPUT -p tcp --dport 20 -j ACCEPT
ipt46 -A INPUT -p tcp --dport 21 -j ACCEPT
ipt46 -A INPUT -p tcp --dport 49152:65534 -j ACCEPT

## Established / Related
ipt46 -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables-save 1> /dev/null
ip6tables-save 1> /dev/null
