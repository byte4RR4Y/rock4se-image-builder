#! /bin/bash

HEADERS=$1
CWD=$PWD
OUTDIR=${CWD}
CPUS=$(($(nproc)))

# Kernel configuration
export CONFIG_ARCH_ACTIONS=n
export CONFIG_ARCH_SUNXI=n
export CONFIG_ARCH_ALPINE=n
export CONFIG_ARCH_APPLE=n
export CONFIG_ARCH_BCM=n
export CONFIG_ARCH_BERLIN=n
export CONFIG_ARCH_BITMAIN=n
export CONFIG_ARCH_EXYNOS=n
export CONFIG_ARCH_SPARX5=n
export CONFIG_ARCH_K3=n
export CONFIG_ARCH_LG1K=n
export CONFIG_ARCH_HISI=n
export CONFIG_ARCH_KEEMBAY=n
export CONFIG_ARCH_MEDIATEK=n
export CONFIG_ARCH_MESON=n
export CONFIG_ARCH_MVEBU=n
export CONFIG_ARCH_NXP=n
export CONFIG_ARCH_MA35=n
export CONFIG_ARCH_NPCM=n
export CONFIG_ARCH_PENSANDO=n
export CONFIG_ARCH_QCOM=n
export CONFIG_ARCH_REALTEK=n
export CONFIG_ARCH_RENESAS=n
export CONFIG_ARCH_ROCKCHIP=y
export CONFIG_ARCH_SEATTLE=n
export CONFIG_ARCH_INTEL_SOCFPGA=n
export CONFIG_ARCH_STM32=n
export CONFIG_ARCH_SYNQUACER=n
export CONFIG_ARCH_TEGRA=n
export CONFIG_ARCH_SPRD=n
export CONFIG_ARCH_THUNDER=n
export CONFIG_ARCH_THUNDER2=n
export CONFIG_ARCH_UNIPHIER=n
export CONFIG_ARCH_VEXPRESS=n
export CONFIG_ARCH_VISCONTI=n
export CONFIG_ARCH_XGENE=n
export CONFIG_ARCH_ZYNQMP=n
export CONFIG_DEBUG_INFO=y
export CONFIG_DEBUG_FS=y
export CONFIG_NET_9P=y        
export CONFIG_QRTR=m             
export CONFIG_AES_CE_BLK=m       
export CONFIG_AES_CE_CIPHER=m    
export CONFIG_POLYVAL_CE=m       
export CONFIG_POLYVAL_GENERIC=m  
export CONFIG_EVDEV=m            
export CONFIG_GHASH_CE=m         
export CONFIG_GF128MUL=m         
export CONFIG_SHA2_CE=m          
export CONFIG_SHA256_ARM64=m     
export CONFIG_SHA1_CE=m   
export CONFIG_LOOP=m             
export CONFIG_DM_MOD=m           
export CONFIG_EFI_PSTORE=m    
export CONFIG_CONFIGFS=m         
export CONFIG_NFNETLINK=m            
export CONFIG_IP_TABLES=m        
export CONFIG_X_TABLES=m         
export CONFIG_AUTOFS4=m          
export CONFIG_EXT4=m             
export CONFIG_CRC16=m            
export CONFIG_MBCACHE=m          
export CONFIG_JBD2=m             
export CONFIG_CRC32C_GENERIC=m
export CONFIG_USBCORE=m      
export CONFIG_NET_FAILOVER=m     
export CONFIG_FAILOVER=m         
export CONFIG_USB_COMMON=m
export CONFIG_CRCT10DIF_CE=m   
export CONFIG_CRCT10DIF_COMMON=m 
export CONFIG_QEMU_FW_CFG=m 
export CONFIG_XHCI_PCI=m         
export CONFIG_DRM_KMS_HELPER=y   
export CONFIG_XHCI_HCD=m         
export CONFIG_VIRTIO_NET=m
export CONFIG_VIRTIO_INPUT=m   
export CONFIG_VIRTIO_BLK=m       
export CONFIG_VIRTIO_GPU=m     
export CONFIG_VIRTIO_DMA_BUF=m
export CONFIG_SHMEM_HELPER=m
export CONFIG_VIRTIO_RING=m
export CONFIG_VIRTIO_BALLON=m
export CONFIG_DRM=y
export CONFIG_HAS_IOMEM=m
export CONFIG_MMU=m          
export CONFIG_VIRTIO_MMIO=m
export CONFIG_DRM_SHMEM_HELPER=y
export CONFIG_VIRTIO_MEM=m
export CONFIG_VIRTIO_PCI=m
export CONFIG_VIRTIO_PCI_LEGACY_DEV=m
export CONFIG_VIRTIO_PCI_MODERN_DEV=m
export CONFIG_VIRTIO_PMEM=m
export CONFIG_VIRTIO_SCSI=m
export CONFIG_KVM=m
export CONFIG_KVM_GUEST=y
export CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
export CONFIG_DRM_FBDEV_EMULATION=n
export CONFIG_INPUT_EVDEV=y
export CONFIG_DRM_PANEL=m
export CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
export CONFIG_DRM_BOCHS=n
export CONFIG_DRM_QXL=n
export CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
export CONFIG_FB_SIMPLE=n
export CONFIG_FB_BOOT_VESA_SUPPORT=n
export CONFIG_FRAMEBUFFER_CONSOLE=y
export CONFIG_FONT_8x8=y
export CONFIG_FONT_8x16=y
export CONFIG_FONTS=y
export CONFIG_FONT_TER16x32=y
export CONFIG_FONT_SUPPORT=y
export CONFIG_DRM_VIRTIO_GPU=m
export CONFIG_DRM_FBDEV_EMULATION=n
export CONFIG_FB_VESA=n
export CONFIG_HAS_DMA=m
export CONFIG_VIRT=m
export CONFIG_VIRTIO_MENU=m
export CONFIG_DRM_MALI=m
export CONFIG_DRM_MIPI_DBI=m
export CONFIG_DRM_MIPI_DSI=y
export CONFIG_DRM_DEBUG_MODESET_LOCK=y
export CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=n
export CONFIG_DRM_DISPLAY_HELPER=m
export CONFIG_DRM_DISPLAY_HDCP_HELPER=y
export CONFIG_DRM_DISPLAY_HDMI_HELPER=y
export CONFIG_DRM_EXEC=m
export CONFIG_DRM_GPUVM=m
export CONFIG_DRM_BUDDY=m
export CONFIG_DRM_VRAM_HELPER=m
export CONFIG_DRM_TTM_HELPER=m
#######################################
export CONFIG_DRM_GEM_DMA_HELPER=m
export CONFIG_DRM_GEM_SHMEM_HELPER=m
#######################################
export CONFIG_DRM_SUBALLOC_HELPER=m
export CONFIG_DRM_SCHED=m
export CONFIG_DRM_VKMS=m
export CONFIG_DRM_VIRTIO_GPU_KMS=y
export CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
export CONFIG_PSTORE_BLK_KMSG_SIZE=64
export CONFIG_DRM_HDLCD=m
export CONFIG_DRM_HDLCD_SHOW_UNDERRUN=y
export CONFIG_DRM_MALI_DISPLAY=m
export CONFIG_DRM_KOMEDA=m
export CONFIG_DRM_I2C_CH7006=m
export CONFIG_DRM_I2C_SIL164=m
export CONFIG_DRM_I2C_NXP_TDA998X=m
export CONFIG_DRM_I2C_NXP_TDA9950=m
export CONFIG_DRM_ROCKCHIP=m
export CONFIG_ROCKCHIP_VOP=y
export CONFIG_ROCKCHIP_VOP2=y
export CONFIG_ROCKCHIP_ANALOGIX_DP=y
export CONFIG_ROCKCHIP_CDN_DP=y
export CONFIG_ROCKCHIP_DW_HDMI=y
export CONFIG_ROCKCHIP_DW_MIPI_DSI=y
export CONFIG_ROCKCHIP_INNO_HDMI=y
export CONFIG_ROCKCHIP_LVDS=y
export CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
export CONFIG_DRM_IMX_TVE=m
export CONFIG_DRM_IMX_LDB=m
export CONFIG_DRM_IMX_HDMI=m
export CONFIG_DRM_IMX_LCDC=m
export CONFIG_DRM_INGENIC=m
export CONFIG_DRM_INGENIC_IPU=y
export CONFIG_DRM_V3D=m
export CONFIG_DRM_LOONGSON=m
export CONFIG_DRM_ETNAVIV=m
export CONFIG_DRM_ETNAVIV_THERMAL=y
export CONFIG_DRM_HISI_HIBMC=m
export CONFIG_DRM_HISI_KIRIN=m
export CONFIG_DRM_LOGICVC=m
export CONFIG_DRM_MEDIATEK=m
export CONFIG_DRM_MEDIATEK_DP=m
export CONFIG_DRM_MEDIATEK_HDMI=m
export CONFIG_DRM_MXS=y
export CONFIG_DRM_MXSFB=n
export CONFIG_DRM_IMX_LCDIF=m
export CONFIG_DRM_MESON=m
export CONFIG_DRM_MESON_DW_HDMI=m
export CONFIG_DRM_MESON_DW_MIPI_DSI=m
export CONFIG_DRM_ARCPGU=m
export CONFIG_DRM_BOCHS=m
export CONFIG_DRM_CIRRUS_QEMU=m
export CONFIG_DRM_GM12U320=m
export CONFIG_DRM_OFDRM=m
export CONFIG_DRM_PANEL_MIPI_DBI=m
export CONFIG_DRM_SIMPLEDRM=m
export CONFIG_TINYDRM_HX8357D=m
export CONFIG_TINYDRM_ILI9163=m
export CONFIG_TINYDRM_ILI9225=m
export CONFIG_TINYDRM_ILI9341=m
export CONFIG_TINYDRM_ILI9486=m
export CONFIG_TINYDRM_MI0283QT=m
export CONFIG_TINYDRM_REPAPER=m
export CONFIG_TINYDRM_ST7586=m
export CONFIG_TINYDRM_ST7735R=m
export CONFIG_DRM_PL111=m
export CONFIG_DRM_TVE200=m
export CONFIG_DRM_LIMA=m
export CONFIG_DRM_PANFROST=m
export CONFIG_DRM_ASPEED_GFX=m
export CONFIG_DRM_MCDE=m
export CONFIG_DRM_TIDSS=m
export CONFIG_DRM_ZYNQMP_DPSUB=m
export CONFIG_DRM_SSD130X=m
export CONFIG_DRM_SSD130X_I2C=m
export CONFIG_DRM_SSD130X_SPI=m
export CONFIG_DRM_SPRD=m
export CONFIG_DRM_POWERVR=m
export CONFIG_DRM_EXPORT_FOR_TESTS=y
export CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
export CONFIG_DRM_LIB_RANDOM=y
export CONFIG_DUMMY_CONSOLE=y
export CONFIG_DUMMY_CONSOLE_COLUMNS=80
export CONFIG_DUMMY_CONSOLE_ROWS=25
export CONFIG_FRAMEBUFFER_CONSOLE=n
export CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=n
export CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=n
export CONFIG_DRM_AMD_DC=y
export CONFIG_DRM_AMD_DC_FP=y
export CONFIG_DRM_AMD_DC_SI=y
export CONFIG_DEBUG_KERNEL_DC=y
export CONFIG_DRM_AMD_SECURE_DISPLAY=y
export CONFIG_DRM_NOUVEAU=m
export CONFIG_DRM_NOUVEAU_BACKLIGHT=y
export CONFIG_DRM_NOUVEAU_GSP_DEFAULT=y
export CONFIG_DRM_PANEL_JDI_LPM102A188A=m
########################################################
export CONFIG_DRM_KMB_DISPLAY=m
export CONFIG_DRM_VGEM=m
export CONFIG_DRM_TTM=m
export CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
export CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
export CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=n


git clone --depth=1 https://github.com/torvalds/linux
cd linux

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

BUILD="$(sed -n 's|^.*\s\+\(\S\+\.\S\+\.\S\+\)\s\+Kernel Configuration$|\1|p' .config)"
echo "${BUILD}" > ${CWD}/config/release
KERNELDIR="KERNEL-${BUILD}"
mkdir -p "${KERNELDIR}"
echo "${BUILD}" ${CWD}/config/release.txt
yes "" | make -j ${CPUS} ARCH=arm64 KERNELRELEASE="${BUILD}" CROSS_COMPILE=aarch64-linux-gnu- Image.gz modules dtbs
env PATH=$PATH make KERNELRELEASE="${BUILD}" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=${KERNELDIR} modules_install

if [ "$HEADERS" == "yes" ]; then
  make headers_install INSTALL_HDR_PATH=${KERNELDIR}
fi

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
#rm -rf "${KERNELDIR}"
cd ${CWD}
#rm -rf linux

echo "1" > ${CWD}/config/kernel_status
