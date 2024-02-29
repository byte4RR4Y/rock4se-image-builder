#! /bin/bash

if [ "$UID" -ne 0 ]; then
    echo "This program needs sudo rights."
    echo "Run it with 'sudo $0'"
    exit 1
fi

CPUS=$(nproc)

apt update -y
apt install -y git bc bison flex libssl-dev make
git clone --depth=1 https://github.com/torvalds/linux
cd linux
make ARCH=arm64 defconfig
BUILD="$(sed -n 's|^.*\s\+\(\S\+\.\S\+\.\S\+\)\s\+Kernel Configuration$|\1|p' .config)"
make -j ${CPUS} KERNELRELEASE="${BUILD}" ARCH=arm64 CONFIG_WIRELESS=y CONFIG_BRCMUTIL=m CONFIG_BRCMFMAC=m CONFIG_ARCH_ROCKCHIP=y Image.gz modules dtbs
make modules_install
mkdir -p "/lib/linux-image-${BUILD}/rockchip/"
cp .config "/boot/config-${BUILD}"
cp arch/arm64/boot/Image.gz "/boot/vmlinuz-${BUILD}"
cp arch/arm64/boot/dts/rockchip/*.dtb "/lib/linux-image-${BUILD}/rockchip/"
update-initramfs -c -v -k ${BUILD}
u-boot-update

