#!/bin/sh
for j in `cat all.rollrec | grep "^roll" | sed "s/\"//g" | sed "s/^roll.//g"`; do
	touch db.$j
	zonesigner -zone $j db.$j 1> /dev/null
done
service bind9 reload 1> /dev/null

