#! /bin/bash

HEADERS=$1
CWD=$PWD
OUTDIR=${CWD}
CPUS=$(nproc)

git clone --depth=1 https://github.com/torvalds/linux
cd linux

yes "" | make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

BUILD="$(sed -n 's|^.*\s\+\(\S\+\.\S\+\.\S\+\)\s\+Kernel Configuration$|\1|p' .config)"
echo "${BUILD}" > ${CWD}/config/release
KERNELDIR="KERNEL-${BUILD}"
mkdir -p "${KERNELDIR}"

scripts/config -e CONFIG_MACVLAN
scripts/config -e CONFIG_VIRTIO_NET
scripts/config -e CONFIG_NLMON
scripts/config -d CONFIG_VT_HW_CONSOLE_BINDING
scripts/config -e CONFIG_SERIAL_AMBA_PL011
scripts/config -e CONFIG_SERIAL_AMBA_PL011_CONSOLE
scripts/config -e CONFIG_VIRTIO_CONSOLE
scripts/config -e CONFIG_HW_RANDOM
scripts/config -e CONFIG_HW_RANDOM_VIRTIO
scripts/config -e CONFIG_DRM
scripts/config -e CONFIG_DRM_VIRTIO_GPU
scripts/config -e CONFIG_RTC_CLASS
scripts/config -e CONFIG_RTC_DRV_PL031
scripts/config -e CONFIG_VIRTIO_PCI
scripts/config -e CONFIG_VIRTIO_MMIO
scripts/config -e CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES
scripts/config -e CONFIG_MAILBOX
scripts/config -e CONFIG_AHCI
scripts/config -e CONFIG_PCIEPORT
scripts/config -e CONFIG_VIRTIO_INPUT
scripts/config -e CONFIG_VIRT_DRIVERS
scripts/config -e CONFIG_VIRTIO_MEM

yes "" | make -j ${CPUS} ARCH=arm64 KERNELRELEASE="${BUILD}" CROSS_COMPILE=aarch64-linux-gnu- Image.gz modules dtbs


env PATH=$PATH make KERNELRELEASE="${BUILD}" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=${KERNELDIR} modules_install

mkdir -p "${KERNELDIR}/boot/" "${KERNELDIR}/lib/linux-image-${BUILD}/"rockchip/
echo "ffffffffffffffff B The real System.map is in the linux-image-<version>-dbg package" > "${KERNELDIR}/boot/System.map-${BUILD}"
cp .config "${KERNELDIR}/boot/config-${BUILD}"
cp arch/arm64/boot/Image.gz "${KERNELDIR}/boot/vmlinuz-${BUILD}"
cp -r arch/arm64/boot/dts/rockchip/*.dtb "${KERNELDIR}/lib/linux-image-${BUILD}/"rockchip/
ARCHIVE="kernel-$(sed -n 's|^.*\s\+\(\S\+\.\S\+\.\S\+\)\s\+Kernel Configuration$|\1|p' .config)$(sed -n 's|^CONFIG_LOCALVERSION=\"\(.*\)\"$|\1|p' .config).zip"
cd "${KERNELDIR}"
find lib -type l -exec rm {} \;
zip -q -r "${ARCHIVE}" *
if [ "${OUTDIR}" != "" ]; then
  if [ "${OUTDIR: -1}" != "/" ]; then
      OUTDIR+="/"
  fi
else
  if [ "${REALUSER}" = "root" ]; then
      OUTDIR="/root/"
  else
      OUTDIR="/home/${REALUSER}/"
  fi
fi
chown "${REALUSER}:${REALUSER}" "${ARCHIVE}"
cd ${CWD}/linux
mv "${KERNELDIR}/${ARCHIVE}" "${OUTDIR}"
rm -rf "${KERNELDIR}"
cd ${CWD}
rm -rf linux

echo "1" > ${CWD}/config/kernel_status
