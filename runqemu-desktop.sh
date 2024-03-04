#! /bin/bash

SDCARD=$1
SCREEN=$2

available_cpus=$(nproc)
max_cpus=8

if ((available_cpus > max_cpus)); then
    CPUS=$max_cpus
else
    CPUS=$available_cpus
fi



mkdir -p /tmp/mytpm1
swtpm socket --tpmstate dir=/tmp/mytpm1 --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock --tpm2 --log level=0 &

if [ "$SCREEN" == "" ]; then
sudo qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a72 -smp $CPUS \
  -m 2048 \
  -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
  -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
  -drive if=none,file=${SDCARD},format=raw,id=disk \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
  -tpmdev emulator,id=tpm0,chardev=chrtpm \
  -append "root=LABEL=rootfs ro" \
  -device qemu-xhci -display gtk,gl=on,show-cursor=on,full-screen=on \
  -device virtio-gpu-pci -device virtio-mouse-pci \
  -device virtio-blk-device,drive=disk \
  -device virtio-keyboard-pci \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 -no-reboot

  elif [ "$SCREEN" == "nofullscreen" ]; then
  sudo qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a72 -smp $CPUS \
  -m 2048 \
  -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
  -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
  -drive if=none,file=${SDCARD},format=raw,id=disk \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
  -tpmdev emulator,id=tpm0,chardev=chrtpm \
  -append "root=LABEL=rootfs ro" \
  -device virtio-blk-device,drive=disk \
  -device virtio-keyboard-pci \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -device qemu-xhci -display gtk,gl=on,show-cursor=on \
  -device virtio-gpu-pci -device virtio-mouse-pci -no-reboot
elif [ "$SCREEN" == "rw" ]; then
  sudo qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a72 -smp $CPUS \
  -m 2048 \
  -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
  -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
  -drive if=none,file=${SDCARD},format=raw,id=disk \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
  -tpmdev emulator,id=tpm0,chardev=chrtpm \
  -append "root=LABEL=rootfs rw" \
  -device virtio-blk-device,drive=disk \
  -device virtio-keyboard-pci \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -device qemu-xhci -display gtk,gl=on,show-cursor=on,show-tabs=on \
  -device virtio-gpu-pci -device virtio-mouse-pci -no-reboot
fi
pkill swtpm
