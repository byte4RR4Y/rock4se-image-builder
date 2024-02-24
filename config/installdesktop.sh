#! /bin/bash

DESKTOP=$1

    if [ "$DESKTOP" == "xfce4" ]; then
        echo "Installing xfce..."
        sleep 3
        if [ "$ADDITIONAL" == "yes" ]; then
	    apt install --install-suggests -y xfce4 lightdm xorg firefox-esr xfce4-goodies lightdm-gtk-greeter-settings network-manager-gnome
	    fi
	    apt install -y xfce4 lightdm xorg firefox-esr network-manager-gnome
    fi


    if [ "$DESKTOP" == "gnome" ]; then
        echo "Installing gnome..."
        apt install -y gdm* gnome-shell
        if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y gnome-shell-extensions gnome-tweaks gnome-software gnome-contacts gnome-screenshot gnome-software
        fi
    fi


    if [ "$DESKTOP" == "mate" ]; then
        echo "Installing mate..."
	    if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y mate-desktop-environment-core lightdm xorg firefox-esr
        fi
            apt install -y mate-desktop-environment-core lightdm xorg firefox-esr
    fi


    if [ "$DESKTOP" == "cinnamon" ]; then
        echo "Installing cinnamon..."
	    if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y cinnamon-common cinnamon-desktop-environment lightdm xorg firefox-esr 
        fi
            apt install -y cinnamon-desktop-environment lightdm xorg firefox-esr
    fi


    if [ "$DESKTOP" == "lxqt" ]; then
        echo "Installing lxqt..."
	    if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y lightdm xorg lxqt-core 
        fi
            apt install -y lightdm xorg lxqt-core
    fi



    if [ "$DESKTOP" == "lxde" ]; then
        echo "Installing lxde..."
        apt install -y lxde* lightdm xorg firefox-esr mintstick gimp transmission winff libreoffice ufw gufw synaptic gnome-software
    fi
   
   
    if [ "$DESKTOP" == "unity" ]; then
        echo "Installing unity..."
        wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null
        sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
        apt update && apt-get install unityhub mintstick gimp transmission winff libreoffice ufw gufw synaptic gnome-software -y
    fi


    if [ "$DESKTOP" == "budgie" ]; then
        echo "Installing budgie..."
        apt upgrade -y
        if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y budgie-desktop
        fi
            apt install -y budgie-desktop
    fi
    
    
    if [ "$DESKTOP" == "kde" ]; then
        echo "Installing kde plasma..."
        apt upgrade -y
        if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y sddm kde-full xorg
        fi
            apt install -y sddm kde-plasma-desktop xorg
    fi

