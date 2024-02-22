#!/bin/bash


if [ $# -eq 0 ]; then
    echo "Usage: $0 SDCARD.img"
    exit 1
fi

SDCARD=$1
RW=$2
CPUS=$(nproc) 
CPUS=$((CPUS > 8 ? 8 : CPUS))

if [ "$RW" == "rw" ]; then
  qemu-system-aarch64 -M virt -m 2048 -cpu cortex-a72 -smp $CPUS \
    -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
    -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
    -drive if=none,file=${SDCARD},format=raw,id=hd \
    -device virtio-blk-pci,drive=hd \
    -netdev user,id=mynet \
    -nographic \
    -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
    -append "root=LABEL=rootfs rw"
else
   qemu-system-aarch64 -M virt -m 2048 -cpu cortex-a72 -smp $CPUS \
    -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
    -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
    -drive if=none,file=${SDCARD},format=raw,id=hd \
    -device virtio-blk-pci,drive=hd \
    -netdev user,id=mynet \
    -nographic \
    -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
    -append "root=LABEL=rootfs ro"
fi
