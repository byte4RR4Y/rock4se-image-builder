#! /bin/bash

CWD=$PWD
OUTDIR=${CWD}
CPUS=$(($(nproc)))

git clone --depth=1 https://github.com/torvalds/linux
cd linux

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

BUILD="$(sed -n 's|^.*\s\+\(\S\+\.\S\+\.\S\+\)\s\+Kernel Configuration$|\1|p' .config)"
echo "${BUILD}" > ${CWD}/config/release
KERNELDIR="KERNEL-${BUILD}"
mkdir -p "${KERNELDIR}"
echo "${BUILD}" ${CWD}/config/release.txt
make -j ${CPUS} KERNELRELEASE="${BUILD}" ARCH=arm64 CONFIG_BRCMUTIL=m CONFIG_BRCMFMAC=m CONFIG_ARCH_ROCKCHIP=y CONFIG_WIRELESS=y CONFIG_DRM_VIRTIO_GPU=y DRM_VIRTIO_GPU_KMS=y CONFIG_DRM=y CROSS_COMPILE=aarch64-linux-gnu- Image.gz modules dtbs
env PATH=$PATH make KERNELRELEASE="${BUILD}" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=${KERNELDIR} modules_install
mkdir -p "${KERNELDIR}/boot/" "${KERNELDIR}/lib/linux-image-${BUILD}/rockchip/"
echo "ffffffffffffffff B The real System.map is in the linux-image-<version>-dbg package" > "${KERNELDIR}/boot/System.map-${BUILD}"
cp .config "${KERNELDIR}/boot/config-${BUILD}"
cp arch/arm64/boot/Image.gz "${KERNELDIR}/boot/vmlinuz-${BUILD}"
cp arch/arm64/boot/dts/rockchip/*.dtb "${KERNELDIR}/lib/linux-image-${BUILD}/rockchip/"
   
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
