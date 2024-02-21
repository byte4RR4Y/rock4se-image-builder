
    if [ "$DESKTOP" == "xfce4" ]; then
        echo "Installing xfce..."
        sleep 3
        if [ "$ADDITIONAL" == "yes" ]; then
	    apt install --install-suggests -y xfce4 lightdm xorg firefox-esr xfce4-goodies mintstick code gimp transmission winff deb-installer libreoffice ufw gufw synaptic mx-packageinstaller gnome-software lightdm-gtk-greeter-settings network-manager-gnome
	    else
	    apt install -y xfce4 lightdm xorg firefox-esr network-manager-gnome
        fi
    fi


    if [ "$DESKTOP" == "gnome" ]; then
        echo "Installing gnome..."
        apt install -y gdm* gnome-shell
        if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y gnome-shell-extensions gnome-tweaks gnome-software gnome-contacts gnome-screenshot mintstick code gimp transmission winff deb-installer libreoffice ufw gufw synaptic mx-packageinstaller gnome-software
        fi
    fi


    if [ "$DESKTOP" == "mate" ]; then
        echo "Installing mate..."
	    if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y mate-desktop-environment-core lightdm xorg firefox-esr mintstick code gimp transmission winff deb-installer libreoffice ufw gufw synaptic mx-packageinstaller gnome-software
        else
            apt install -y apt install -y mate-desktop-environment-core lightdm xorg firefox-esr
        fi
    fi


    if [ "$DESKTOP" == "cinnamon" ]; then
        echo "Installing cinnamon..."
	    if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y cinnamon* lightdm xorg firefox-esr mintstick code gimp transmission winff deb-installer libreoffice ufw gufw synaptic mx-packageinstaller gnome-software
        else
            apt install -y cinnamon* lightdm xorg firefox-esr
        fi
    fi


    if [ "$DESKTOP" == "lxqt" ]; then
        echo "Installing lxqt..."
	    if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y lightdm xorg lxqt-core mintstick code gimp transmission winff deb-installer libreoffice ufw gufw synaptic mx-packageinstaller gnome-software
        else
            apt install -y apt install -y lightdm xorg lxqt-core mintstick code gimp transmission winff deb-installer libreoffice ufw gufw synaptic mx-packageinstaller gnome-software
        fi
    fi



    if [ "$DESKTOP" == "lxde" ]; then
        echo "Installing lxde..."
        apt install -y lxde* lightdm xorg firefox-esr mintstick code gimp transmission winff deb-installer libreoffice ufw gufw synaptic mx-packageinstaller gnome-software
    fi
   
   
    if [ "$DESKTOP" == "unity" ]; then
        echo "Installing unity..."
        wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null
        sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
        apt update && apt-get install unityhub mintstick code gimp transmission winff deb-installer libreoffice ufw gufw synaptic mx-packageinstaller gnome-software -y
    fi


    if [ "$DESKTOP" == "budgie" ]; then
        echo "Installing budgie..."
        apt upgrade -y
        if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y budgie-desktop mintstick code gimp transmission winff deb-installer libreoffice ufw gufw synaptic mx-packageinstaller gnome-software
        else
            apt install -y budgie-desktop
        fi
    fi
    
    
    if [ "$DESKTOP" == "kde" ]; then
        echo "Installing kde plasma..."
        apt upgrade -y
        if [ "$ADDITIONAL" == "yes" ]; then
            apt install --install-suggests -y sddm sddm-theme* kde-full kde-plasma-desktop xorg mintstick code gimp transmission winff deb-installer libreoffice ufw gufw synaptic mx-packageinstaller gnome-software
        else
            apt install -y sddm sddm-theme* kde-plasma-desktop xorg
        fi
    fi

