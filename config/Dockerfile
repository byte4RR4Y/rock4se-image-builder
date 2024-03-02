ARG SUITE
FROM --platform=aarch64 arm64v8/debian:${SUITE}
ARG DESKTOP
ARG ADDITIONAL
ARG USERNAME
ARG PASSWORD
ARG KERNEL
ARG HEADERS

ENV HEADERS=$HEADERS
ENV KERNEL=$KERNEL
ENV DESKTOP=$DESKTOP
ENV ADDITIONAL=$ADDITIONAL
ENV USERNAME=$USERNAME
ENV PASSWORD=$PASSWORD
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i '/^Components:/ s/$/ contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources
SHELL ["/bin/bash", "-c"]

RUN apt update -y && apt upgrade -y && apt install -y apt-utils dialog aptitude
RUN aptitude install -y '?priority(required)' '?priority(important)' '?priority(standard)' nano wget curl sudo gpg gpg-agent network-manager zip unzip e2fsprogs git zsh zsh-autosuggestions zsh-syntax-highlighting

COPY config/apt-packages.txt /root
RUN xargs apt install -y < /root/apt-packages.txt
RUN rm /root/apt-packages.txt

RUN if [[ $DESKTOP == "xfce4" ]]; then \
    apt install -y xfce4 lightdm xorg firefox-esr network-manager-gnome gvfs-backends pulseaudio pulseaudio-module-bluetooth blueman \
    ; fi
RUN if [[ $DESKTOP == "gnome" ]]; then \
    apt install -y gdm* gnome-shell \
    ; fi
RUN if [[ $DESKTOP == "mate" ]]; then \
    apt install -y mate-desktop-environment-core lightdm xorg firefox-esr \
    ; fi
RUN if [[ $DESKTOP == "cinnamon" ]]; then \
    apt install -y cinnamon-common cinnamon-desktop-environment lightdm xorg firefox-esr \
    ; fi
RUN if [[ $DESKTOP == "lxqt" ]]; then \
    apt install -y lightdm xorg lxqt-core  \
    ; fi
RUN if [[ $DESKTOP == "lxde" ]]; then \
    apt install -y lxde* lightdm xorg firefox-esr mintstick gimp transmission winff libreoffice ufw gufw synaptic gnome-software \
    ; fi
RUN if [[ $DESKTOP == "unity" ]]; then \
    wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null && sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list' && apt update && apt-get install unityhub mintstick gimp transmission winff libreoffice ufw gufw synaptic gnome-software -y \
    ; fi
RUN if [[ $DESKTOP == "budgie" ]]; then \
    apt install -y budgie-desktop \
    ; fi
RUN if [[ $DESKTOP == "kde" ]]; then \
    apt install -y sddm kde-plasma-desktop xorg \
    ; fi

RUN bash -c 'curl -L --output deb.deb "https://github.com/radxa-pkg/radxa-archive-keyring/releases/latest/download/radxa-archive-keyring_$(curl -L https://github.com/radxa-pkg/radxa-archive-keyring/releases/latest/download/VERSION)_all.deb"'
RUN dpkg -i deb.deb
RUN rm -f deb.deb
RUN bash -c 'source /etc/os-release'
RUN bash -c 'tee /etc/apt/sources.list.d/radxa.list <<< "deb [signed-by=/usr/share/keyrings/radxa-archive-keyring.gpg] https://radxa-repo.github.io/bookworm/ bookworm main"'
RUN apt update -y && apt install -y radxa-firmware

RUN useradd -m -s /bin/bash ${USERNAME}
RUN echo "${PASSWORD}:${PASSWORD}" | chpasswd
RUN usermod -aG sudo ${USERNAME}
COPY config/.zshrc /home/${USERNAME}

RUN chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.zshrc
RUN cp /home/${USERNAME}/.zshrc /root
RUN chown root:root /root/.zshrc
RUN chsh -s /bin/zsh ${USERNAME}
RUN chsh -s /bin/zsh root

RUN echo "root=LABEL=rootfs console=ttyFIQ0,1500000n8 quiet splash loglevel=1 rw earlycon consoleblank=0 console=tty1 coherent_pool=2M irqchip.gicv3_pseudo_nmi=0 cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory swapaccount=1" > /etc/kernel/cmdline

RUN apt install -y kmod wireless-tools net-tools inetutils* initramfs-tools network-manager usbutils tar zip unzip bzip2 u-boot-menu pulseaudio pulseaudio-module-bluetooth ntpsec locales parted util-linux u-boot-tools firmware-brcm80211 iw wireless-regdb

RUN if [ "$KERNEL" = "standard" ]; then \
        apt install -y linux-image-arm64 \
    ; fi
RUN if [ "$KERNEL" = "standard" -a "$HEADERS" = "yes" ]; then \
        apt install -y linux-headers-arm64 \
    ; fi

COPY config/resize2fs /etc/init.d/
RUN chmod +x /etc/init.d/resize2fs

RUN touch /etc/configboot

COPY config/rc.local /etc
COPY config/kernelupdater.sh /boot
RUN chmod +x /boot/kernelupdater.sh

RUN chmod +x /etc/rc.local

RUN apt autoremove -y && apt autoclean

RUN echo $(($(du -s -m --exclude=/proc --exclude=/sys --exclude=/dev / | awk '{print $1}'))) > /rootfs_size.txt
