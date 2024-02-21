# rock4se-image-builder
#####################################################################################
# This script builds SD-Card images for the Radxa Rock 4 SE as it follows:
    - Building the rootfile system inside a docker container.
    - Installing the Kernel.
    - Flash the u-boot bootloader and the root filesystem to create a bootable SD-Card image.

# Installation:
----------------------
    git clone https://github.com/byte4RR4Y/rock4se-builder
    cd rock4se-builder
    chmod +x ./*
    sudo ./install.sh
----------------------

# To build an SD-Card image:
    sudo ./build.sh

You will find your image in the output folder.

(If you want to conntrol the build by the commandline type './build.sh -h' for further information)

# Adding custom packages to install
    -If you want to add packages to install, append it to config/apt-packages.txt
     instead of modifying the Dockerfile

# Required Host system:
  - Debian/amd64 (bullseye, bookworm, MX 21 and MX23 are tested)
  - maybe Ubuntu works too, but the depencies are slightly different

# What you can build?
##DEBIAN:
  - Testing
  - Experimental
  - Trixie
  - Sid
  - Bookworm
  - Bullseye

##Currently supported desktops:
  - none(Command line interface/tested)
  - xfce(tested)
  - gnome
  - mate
  - cinnamon
  - lxqt
  - lxde
  - unity
  - budgie
  - kde plasma

---------------------------------------------------
 # Contact to the developer: byte4rr4y@gmail.com #
---------------------------------------------------
