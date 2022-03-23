#!/bin/bash

if [[ $(whoami) != 'root' ]]; then exit 2; fi

if [[ ${MIRROR} ]]; then
    echo -e "Choose your favorite repository mirror:"
    echo -e " 1 ) Aliyun (China)"
    echo -e " 2 ) Tencent Cloud (China)"
    echo -e " 3 ) Tsinghua (Cernet)"
    echo -e " 4 ) PKGBUILD Asia (Hong Kong)"
    echo -e " 5 ) Rackspace (Global)"
    read -p "Your choice: " -a CHOICE

    case $CHOICE in
        1) MIRROR="https://mirrors.aliyun.com/archlinux" ;;
        2) MIRROR="https://mirrors.cloud.tencent.com/archlinux" ;;
        3) MIRROR="https://mirrors.tuna.tsinghua.edu.cn/archlinux" ;;
        4) MIRROR="https://asia.mirror.pkgbuild.com" ;;
        5) MIRROR="https://mirror.rackspace.com/archlinux" ;;
        *) exit 1 ;;
    esac
    MIRROR="${MIRROR}/iso/latest"
fi

echo "Server = ${MIRROR}/\$repo/os/\$arch" > /tmp/menhera/etc/pacman.d/mirrorlist
chroot /tmp/menhera pacman-key --init
chroot /tmp/menhera pacman-key --populate archlinux
