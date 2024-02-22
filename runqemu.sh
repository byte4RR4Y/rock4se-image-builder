#!/bin/bash

# Überprüfen, ob keine Argumente übergeben wurden
if [ $# -eq 0 ]; then
    echo "Usage: $0 SDCARD.img"
    exit 1
fi

SDCARD=$1
CPUS=$(nproc) # Ermittelt die Anzahl der CPUs des Hostsystems
CPUS=$((CPUS > 8 ? 8 : CPUS)) # Begrenzt die Anzahl der CPUs auf maximal 8

# Wechseln zum .qemu-Verzeichnis
cd "$(dirname "$SDCARD")/.qemu" || exit 1

# Ausführen des QEMU-Befehls
qemu-system-aarch64 -M virt -m 1024 -cpu cortex-a53 -smp $CPUS \
  -kernel vmlinuz \
  -initrd initrd.img \
  -drive if=none,file=disk.raw,format=raw,id=hd \
  -device virtio-blk-pci,drive=hd \
  -netdev user,id=mynet \
  -device virtio-net-pci,netdev=mynet \
  -nographic \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -append "root=LABEL=rootfs rw"

