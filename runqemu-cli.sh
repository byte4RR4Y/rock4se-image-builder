#! /bin/bash

SDCARD=$1
RW=$2

CPUS=$(($(nproc) / 2 ))




mkdir -p /tmp/mytpm1
swtpm socket --tpmstate dir=/tmp/mytpm1 --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock --tpm2 --log level=0 &

if [ "$RW" == "" ]; then
  sudo qemu-system-aarch64  \
  -M virt \
  -cpu cortex-a72 -smp $CPUS \
  -cpu cortex-a53 -smp $CPUS \
  -m 2048 \
  -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
  -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
  -drive if=none,file=${SDCARD},format=raw,id=disk \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -append "root=LABEL=rootfs ro" \
  -device virtio-blk-device,drive=disk \
  -device virtio-keyboard-pci \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -device virtio-mouse-pci -nographic
elif [ "$RW" == "rw" ]; then
  sudo qemu-system-aarch64  \
  -M virt \
  -cpu cortex-a72 -smp $CPUS \
  -cpu cortex-a53 -smp $CPUS \
  -m 2048 \
  -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
  -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
  -drive if=none,file=${SDCARD},format=raw,id=disk \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -append "root=LABEL=rootfs rw" \
  -device virtio-blk-device,drive=disk \
  -device virtio-keyboard-pci \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -device virtio-mouse-pci -nographic
fi
pkill swtpm
