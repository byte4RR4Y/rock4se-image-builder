#! /bin/bash

if [ "$UID" -ne 0 ]; then 
    echo "This program needs sudo rights."
    echo "Run it with 'sudo $0'"
    exit 1
fi

apt update -y && apt install -y git docker.io apparmor qemu-user-static binfmt-support qemu-user qemu-utils qemu-system-aarch64 u-boot-qemu

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
