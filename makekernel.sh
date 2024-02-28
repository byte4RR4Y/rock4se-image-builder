#! /bin/bash

CWD=$PWD
OUTDIR=${CWD}
CPUS=$(($(nproc)))
CONFIG_FILE="arch/arm64/configs/defconfig"
CONFIG_VARS=(
    CONFIG_ARCH_ACTIONS
    CONFIG_ARCH_SUNXI
    CONFIG_ARCH_ALPINE
    CONFIG_ARCH_APPLE
    CONFIG_ARCH_BCM
    CONFIG_ARCH_BCM2835
    CONFIG_ARCH_BCM_IPROC
    CONFIG_ARCH_BCMBCA
    CONFIG_ARCH_BRCMSTB
    CONFIG_ARCH_BERLIN
    CONFIG_ARCH_EXYNOS
    CONFIG_ARCH_SPARX5
    CONFIG_ARCH_K3
    CONFIG_ARCH_LG1K
    CONFIG_ARCH_HISI
    CONFIG_ARCH_KEEMBAY
    CONFIG_ARCH_MEDIATEK
    CONFIG_ARCH_MESON
    CONFIG_ARCH_MVEBU
    CONFIG_ARCH_NXP
    CONFIG_ARCH_LAYERSCAPE
    CONFIG_ARCH_MXC
    CONFIG_ARCH_S32
    CONFIG_ARCH_MA35
    CONFIG_ARCH_NPCM
    CONFIG_ARCH_QCOM
    CONFIG_ARCH_REALTEK
    CONFIG_ARCH_RENESAS
    CONFIG_ARCH_SEATTLE
    CONFIG_ARCH_INTEL_SOCFPGA
    CONFIG_ARCH_STM32
    CONFIG_ARCH_SYNQUACER
    CONFIG_ARCH_TEGRA
    CONFIG_ARCH_TESLA_FSD
    CONFIG_ARCH_SPRD
    CONFIG_ARCH_THUNDER
    CONFIG_ARCH_THUNDER2
    CONFIG_ARCH_UNIPHIER
    CONFIG_ARCH_VEXPRESS
    CONFIG_ARCH_VISCONTI
    CONFIG_ARCH_XGENE
    CONFIG_ARCH_ZYNQMP
)

git clone --depth=1 https://github.com/torvalds/linux
cd linux

for var in "${CONFIG_VARS[@]}"; do
    sed -i "s/^${var}=y$/${var}=n/" "$CONFIG_FILE"
done

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

BUILD="$(sed -n 's|^.*\s\+\(\S\+\.\S\+\.\S\+\)\s\+Kernel Configuration$|\1|p' .config)"
KERNELDIR="KERNEL-${BUILD}"
mkdir -p "${KERNELDIR}"

make -j ${CPUS} KERNELRELEASE="${BUILD}" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image.gz modules dtbs
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
