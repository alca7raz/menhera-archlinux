#!/bin/bash

if [[ $(whoami) = 'root' ]]; then exit 2; fi

mkdir /tmp/menhera/mnt/old


modprobe btrfs

mount --make-rprivate /
pivot_root /tmp/menhera /tmp/menhera/mnt/old

mount --move /mnt/old/dev /dev
mount --move /mnt/old/run /run
mount --move /mnt/old/sys /sys
mount --move /mnt/old/proc /proc

mount -t tmpfs -o size=100% tmpfs /tmp

swapoff -a
systemctl daemon-reload
systemctl daemon-reexec
fuser -kvm /mnt/old -15
