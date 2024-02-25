#! /bin/bash

SDCARD=$1
SCREEN=$2
CPUS=$(nproc) 
CPUS=$((CPUS > 8 ? 8 : CPUS))

if [ "$SCREEN" == "" ]; then
sudo qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a72 \
  -m 2048 \
  -smp $CPUS \
  -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
  -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
  -drive if=none,file=${SDCARD},format=raw,id=disk \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -append "root=LABEL=rootfs rw" \
  -device qemu-xhci -display gtk,gl=on,show-cursor=on,full-screen=on \
  -device virtio-gpu-pci -device virtio-mouse-pci \
  -device virtio-blk-device,drive=disk \
  -device virtio-keyboard-pci \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0

  elif [ "$SCREEN" == "nofullscreen" ]; then
  sudo qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a72 \
  -m 2048 \
  -smp $CPUS \
  -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
  -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
  -drive if=none,file=${SDCARD},format=raw,id=disk \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -append "root=LABEL=rootfs rw" \
  -device virtio-blk-device,drive=disk \
  -device virtio-keyboard-pci \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -device qemu-xhci -display gtk,gl=on,show-cursor=on \
  -device virtio-gpu-pci -device virtio-mouse-pci
  fi