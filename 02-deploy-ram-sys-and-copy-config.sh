#!/bin/bash

if [[ $(whoami) != 'root' ]]; then exit 2; fi

if [[ ! -f bootstrap.tar.gz ]]; then exit 3; fi

mkdir /tmp/menhera
mount -t tmpfs -o size=100% tmpfs /tmp/menhera
tar zxf bootstrap.tar.gz -C /tmp/menhera
mv /tmp/menhera/root.x86_64/* -t /tmp/menhera
rmdir /tmp/menhera/root.x86_64

cp -r /etc/resolv.conf /tmp/menhera/etc
cp -r /etc/passwd /tmp/menhera/etc
cp -r /etc/shadow /tmp/menhera/etc

mount -t proc /proc /tmp/menhera/proc
mount --make-rslave --rbind /sys /tmp/menhera/sys
mount --make-rslave --rbind /dev /tmp/menhera/dev
mount --make-rslave --rbind /run /tmp/menhera/run
