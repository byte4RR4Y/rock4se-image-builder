#!/bin/bash

MODE=$1

if [ "$UID" -ne 0 ]; then 
    echo "This program needs sudo rights."
    echo "Run it with 'sudo $0'"
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Usage:   $0 <image_file> [ro|rw]"
    echo "         ro=readonly (Standard)"
    echo "         rw=read/write mode"
    echo ""
    echo "WARNING: After rw mode the image will not longer boot on Rock4SE!"
    echo "         This is just for emulation or developing on a x86 host."
    echo ""
    exit 1
fi

if [ "$MODE"  == "rw" ]; then
    echo "WARNING RUNNING IN READ/WRITE MODE!"
else
    MODE=ro
fi

SDCARD=$1
loop_device=$(sudo losetup -f)
available_cpus=$(nproc)
max_cpus=8
if ((available_cpus > max_cpus)); then
    CPUS=$max_cpus
else
    CPUS=$available_cpus
fi
losetup -P "$loop_device" "$SDCARD"
sleep 1
mkdir -p loop .qemu
sleep 1
sudo mount "${loop_device}p2" loop
sleep 1
cp loop/boot/vmlinuz* .qemu/vmlinuz
cp loop/boot/initrd* .qemu/initrd.img
umount loop/
rmdir loop/
losetup -d $loop_device
chown -R ${SUDO_USER}:${SUDO_USER} .qemu
mkdir -p /tmp/mytpm1
swtpm socket --tpmstate dir=/tmp/mytpm1 --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock --tpm2 --log level=0 &
qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a72 -smp $CPUS \
  -m 2048 \
  -kernel "${PWD}/.qemu/"vmlinuz \
  -initrd "${PWD}/.qemu/"initrd.img \
  -drive if=none,file=${SDCARD},format=raw,id=disk \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
  -tpmdev emulator,id=tpm0,chardev=chrtpm \
  -append "root=LABEL=rootfs ${MODE}" \
  -device virtio-blk-device,drive=disk \
  -device virtio-keyboard-pci \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -device virtio-gpu-pci -device qemu-xhci -device virtio-mouse-pci \
  -display gtk,gl=on,show-cursor=on,show-tabs=on

rm -rf .qemu
pkill swtpm
