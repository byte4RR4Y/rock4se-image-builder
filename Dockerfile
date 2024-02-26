ARG SUITE
FROM --platform=arm64/v8 arm64v8/debian:${SUITE}
ARG DESKTOP
ARG ADDITIONAL
ARG USERNAME
ARG PASSWORD

ENV DESKTOP=$DESKTOP
ENV ADDITIONAL=$ADDITIONAL
ENV USERNAME=$USERNAME
ENV PASSWORD=$PASSWORD
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i '/^Components:/ s/$/ contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources
SHELL ["/bin/bash", "-c"]
RUN apt update -y

RUN apt update -y && apt upgrade -y && apt install -y apt-utils dialog aptitude
RUN aptitude install -y '?priority(required)' '?priority(important)' '?priority(standard)' nano wget curl sudo gpg gpg-agent network-manager zip unzip e2fsprogs git zsh zsh-autosuggestions zsh-syntax-highlighting

COPY config/apt-packages.txt /root
RUN apt update -y
RUN xargs apt install -y < /root/apt-packages.txt

RUN if [[ $DESKTOP == "xfce4" ]]; then \
    apt install -y xfce4 lightdm xorg firefox-esr network-manager-gnome gvfs-backends pulseaudio pulseaudio-module-bluetooth blueman \
        && if [[ $ADDITIONAL == "yes" ]]; then \
    apt install --install-suggests -y xfce4 lightdm xorg firefox-esr xfce4-goodies lightdm-gtk-greeter-settings network-manager-gnome gvfs-backends pulseaudio pulseaudio-module-bluetooth blueman \
        ; fi \
    ; fi
RUN if [[ $DESKTOP == "gnome" ]]; then \
    apt install -y gdm* gnome-shell \
        && if [[ $ADDITIONAL == "yes" ]]; then \
    apt install --install-suggests -y gnome-shell-extensions gnome-tweaks gnome-software gnome-contacts gnome-screenshot gnome-software \
        ; fi \
    ; fi
RUN if [[ $DESKTOP == "mate" ]]; then \
    apt install -y mate-desktop-environment-core lightdm xorg firefox-esr \
        && if [[ $ADDITIONAL == "yes" ]]; then \
    apt install --install-suggests -y mate-desktop-environment-core lightdm xorg firefox-esr \
        ; fi \
    ; fi
RUN if [[ $DESKTOP == "cinnamon" ]]; then \
    apt install -y cinnamon-common cinnamon-desktop-environment lightdm xorg firefox-esr \
        && if [[ $ADDITIONAL == "yes" ]]; then \
    apt install --install-suggests -y cinnamon-common cinnamon-desktop-environment lightdm xorg firefox-esr \
        ; fi \
    ; fi
RUN if [[ $DESKTOP == "lxqt" ]]; then \
    apt install -y lightdm xorg lxqt-core  \
        && if [[ $ADDITIONAL == "yes" ]]; then \
    apt install --install-suggests -y lightdm xorg lxqt-core  \
        ; fi \
    ; fi
RUN if [[ $DESKTOP == "lxde" ]]; then \
    apt install -y lxde* lightdm xorg firefox-esr mintstick gimp transmission winff libreoffice ufw gufw synaptic gnome-software \
        && if [[ $ADDITIONAL == "yes" ]]; then \
    apt install --install-suggests -y lxde* lightdm xorg firefox-esr mintstick gimp transmission winff libreoffice ufw gufw synaptic gnome-software \
        ; fi \
    ; fi
RUN if [[ $DESKTOP == "unity" ]]; then \
    wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null && sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list' && apt update && apt-get install unityhub mintstick gimp transmission winff libreoffice ufw gufw synaptic gnome-software -y \
    ; fi
RUN if [[ $DESKTOP == "budgie" ]]; then \
    apt install -y budgie-desktop \
        && if [[ $ADDITIONAL == "yes" ]]; then \
    apt install --install-suggests -y budgie-desktop \
        ; fi \
    ; fi
RUN if [[ $DESKTOP == "kde" ]]; then \
    apt install -y sddm kde-plasma-desktop xorg \
        && if [[ $ADDITIONAL == "yes" ]]; then \
    apt install --install-suggests -y sddm kde-full xorg \
        ; fi \
    ; fi


RUN bash -c 'curl -L --output deb.deb "https://github.com/radxa-pkg/radxa-archive-keyring/releases/latest/download/radxa-archive-keyring_$(curl -L https://github.com/radxa-pkg/radxa-archive-keyring/releases/latest/download/VERSION)_all.deb"'
RUN dpkg -i deb.deb
RUN rm -f deb.deb
RUN bash -c 'source /etc/os-release'
RUN bash -c 'tee /etc/apt/sources.list.d/radxa.list <<< "deb [signed-by=/usr/share/keyrings/radxa-archive-keyring.gpg] https://radxa-repo.github.io/bookworm/ bookworm main"'
RUN apt update -y

RUN useradd -m -s /bin/bash ${USERNAME}
RUN echo "${PASSWORD}:${PASSWORD}" | chpasswd
RUN usermod -aG sudo ${USERNAME}
COPY config/.zshrc /home/${USERNAME}

COPY config/.zshrc /home/${USERNAME}
RUN chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.zshrc
RUN cp /home/${USERNAME}/.zshrc /root
RUN chown root:root /root/.zshrc
RUN chsh -s /bin/zsh ${USERNAME}
RUN chsh -s /bin/zsh root

RUN echo "root=LABEL=rootfs rw splash" > /etc/kernel/cmdline

RUN apt install -y wireless-tools net-tools inetutils* initramfs-tools radxa-firmware firmware-brcm80211 network-manager tar zip unzip bzip2 binutils u-boot-menu firmware-linux firmware-linux-nonfree radxa-firmware pulseaudio pulseaudio-module-bluetooth ntpsec locales

RUN apt install -y linux-image-arm64 linux-headers-arm64
RUN touch /etc/configboot

COPY config/rc.local /etc

RUN chmod +x /etc/rc.local

RUN apt autoremove -y && apt autoclean

RUN echo $(($(du -s -m --exclude=/proc --exclude=/sys --exclude=/dev / | awk '{print $1}'))) > /rootfs_size.txt