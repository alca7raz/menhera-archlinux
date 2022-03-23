#!/bin/bash

if [[ $(whoami) = 'root' ]]; then exit 2; fi

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

export MIRROR=${MIRROR}

bash ./01-download-image.sh

bash ./02-deploy-ram-sys-and-copy-config.sh

bash ./03-config-ram-sys.sh
