#!/bin/sh
du -hs /home | sort -h -r
du -hs /root | sort -h -r
du -hs /var | sort -h -r
du -hs /etc | sort -h -r
du -hs /usr | sort -h -r
du -hs /tmp | sort -h -r
du -hs /lib | sort -h -r
du -hs /boot | sort -h -r
echo ""
find /home/* -prune -exec du -hs '{}' \; | sort -h -r
echo ""
find /var/* -prune -exec du -hs '{}' \; | sort -h -r
echo ""
find /usr/* -prune -exec du -hs '{}' \; | sort -h -r

