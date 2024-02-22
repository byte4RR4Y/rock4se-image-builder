#!/bin/bash

# Überprüfen, ob keine Argumente übergeben wurden
if [ $# -eq 0 ]; then
    echo "Usage: $0 SDCARD.img"
    exit 1
fi

SDCARD=$1
CPUS=$(nproc) # Ermittelt die Anzahl der CPUs des Hostsystems
CPUS=$((CPUS > 8 ? 8 : CPUS)) # Begrenzt die Anzahl der CPUs auf maximal 8

# Ausführen des QEMU-Befehls
qemu-system-aarch64 -M virt -m 2048 -cpu cortex-a72 -smp $CPUS \
  -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
  -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
  -drive if=none,file=${SDCARD},format=raw,id=hd \
  -device virtio-blk-pci,drive=hd \
  -netdev user,id=mynet \
  -device virtio-net-pci,netdev=mynet \
  -nographic \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -append "root=LABEL=rootfs ro"

