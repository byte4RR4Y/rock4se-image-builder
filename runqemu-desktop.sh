 SDCARD=$1

sudo qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a76 \
  -m 2048 \
  -smp 4 \
  -kernel "$(dirname "$SDCARD")/.qemu/"vmlinuz \
  -initrd "$(dirname "$SDCARD")/.qemu/"initrd.img \
  -append "console=ttyAMA0 root=/dev/vda rw" \
  -drive if=none,file=${SDCARD},format=raw,id=disk \
  -bios /usr/lib/u-boot/qemu_arm64/u-boot.bin \
  -append "root=LABEL=rootfs rw" \
  -device virtio-blk-device,drive=disk \
  -device virtio-keyboard-pci \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -device qemu-xhci -display gtk,gl=on,show-cursor=on \
  -device virtio-gpu-pci -device virtio-mouse-pci