ARG SUITE
FROM arm64v8/debian:${SUITE}
ARG DESKTOP
ARG ADDITIONAL
ARG USERNAME
ARG PASSWORD

ENV DESKTOP=$DESKTOP
ENV ADDITIONAL=$ADDITIONAL
ENV USERNAME=$USERNAME
ENV PASSWORD=$PASSWORD
ENV DEBIAN_FRONTEND=noninteractive

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i '/^Components:/ s/$/ contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources
SHELL ["/bin/bash", "-c"]
RUN apt update -y

RUN apt update -y && apt upgrade -y && apt install -y apt-utils dialog aptitude
RUN aptitude install -y '?priority(required)' '?priority(important)' '?priority(standard)' nano wget curl sudo gpg gpg-agent network-manager zip unzip e2fsprogs

COPY config/apt-packages.txt /root
RUN apt update -y
RUN xargs apt install -y < /root/apt-packages.txt

RUN bash -c 'curl -L --output deb.deb "https://github.com/radxa-pkg/radxa-archive-keyring/releases/latest/download/radxa-archive-keyring_$(curl -L https://github.com/radxa-pkg/radxa-archive-keyring/releases/latest/download/VERSION)_all.deb"'
RUN dpkg -i deb.deb
RUN rm -f deb.deb
RUN bash -c 'source /etc/os-release'
RUN bash -c 'tee /etc/apt/sources.list.d/radxa.list <<< "deb [signed-by=/usr/share/keyrings/radxa-archive-keyring.gpg] https://radxa-repo.github.io/bookworm/ bookworm main"'
RUN apt update -y


RUN if [[ $DESKTOP == "xfce4" ]]; then \
    aptitude install -y xfce4 xorg lightdm network-manager-gnome \
        && if [[ $ADDITIONAL == "yes" ]]; then \
    aptitude install -y xfce4-goodies darkcold-gtk-theme firefox-esr synaptic pavucontrol pulseaudio pulseaudio-module-bluetooth vlc gimp menulibre xfce4-power-manager xfce4-settings alsa-utils \
        ; fi \
    ; fi

RUN if [[ $DESKTOP == "kde" ]]; then \
    aptitude install -y sddm kde-plasma \
        && if [[ $ADDITIONAL == "yes" ]]; then \
    aptitude install -y kde-full \
        ; fi \
    ; fi

    

RUN useradd -m -s /bin/bash ${USERNAME}
RUN echo "${PASSWORD}:${PASSWORD}" | chpasswd
RUN usermod -aG sudo ${USERNAME}


RUN echo "root=LABEL=rootfs rw quiet splash" > /etc/kernel/cmdline


RUN apt install -y wireless-tools net-tools inetutils* initramfs-tools radxa-firmware firmware-brcm80211 network-manager tar zip unzip bzip2 binutils u-boot-menu firmware-linux firmware-linux-nonfree radxa-firmware pulseaudio pulseaudio-module-bluetooth ntpsec locales
RUN apt install -y linux-image-arm64 linux-headers-arm64
RUN touch /etc/firstboot

RUN echo "#! /bin/bash" > /etc/rc.local && \
    echo "" >> /etc/rc.local && \
    echo "if [ -e /etc/firstboot ]; then" >> /etc/rc.local && \
    echo "  resize2fs /dev/mmcblk1p2" >> /etc/rc.local && \
    echo "	hostnamectl set-hostname rock4se" >> /etc/rc.local && \
    echo "	chmod u+s /usr/bin/sudo" >> /etc/rc.local && \
    echo "	dpkg-reconfigure lightdm" >> /etc/rc.local && \
    echo "	dpkg-reconfigure sddm" >> /etc/rc.local && \
    echo "	dpkg-reconfigure xorg" >> /etc/rc.local && \
    echo "	dpkg-reconfigure xinit" >> /etc/rc.local && \
    echo "	dpkg-reconfigure xfce4" >> /etc/rc.local && \
    echo "	dpkg-reconfigure kde" >> /etc/rc.local && \
    echo "	rm /etc/firstboot" >> /etc/rc.local && \
    echo "	reboot" >> /etc/rc.local && \
    echo "fi" >> /etc/rc.local && \
    echo "" >> /etc/rc.local && \
    echo "exit 0" >> /etc/rc.local
RUN chmod +x /etc/rc.local
RUN echo $(($(du -s -m --exclude=/proc / | awk '{print $1}'))) > /rootfs_size.txt
