#!/bin/sh
check-zone-expiration `cat all.rollrec | grep "^roll" | sed "s/\"//g" | sed "s/^roll.//g"` | grep "will expire"

