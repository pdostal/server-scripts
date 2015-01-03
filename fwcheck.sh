#!/bin/sh
while test $# -gt 0; do
	case "$1" in
		-h|--help)
			echo "Usage: -4 -6 -nat"
			shift
			;;
		-4)
			iptables -nvL | sed -E "s/ ALGO.+//g"
			shift
			;;
		-6)
			ip6tables -nvL | sed -E "s/ ALGO.+//g"
			shift
			;;
		-nat|--nat)
			iptables -t nat -nvL | sed -E "s/ ALGO.+//g"
			shift
			;;		
		*)
			break
			;;
	esac
done

