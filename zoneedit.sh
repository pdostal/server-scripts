#!/bin/sh
if [ -f /etc/bind/db.$1 ]; then
	vim db.$1
	echo "Press any key when you want to reload bind"
	if read response; then
		echo "Stopping rollerd"
		service rollerd stop
		zonesigner -zone $1 db.$1
		service rollerd start
		echo "Starting rollerd\n"
		donuts --level 9 -v -v db.$1.signed $1
		echo ""
		service bind9 reload
	else
		exit
	fi
else
	echo "cd /etc/bind"
	echo "zoneedit.sh [name]"
	echo "zoneedit.sh pdostal.cz"
fi

