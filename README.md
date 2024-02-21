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

# Automating the build process by using the commandline is possible
Type './build.sh -h'
---------------------------------------------------
    -h, --help                      Show this help message and exit
    -s, --suite SUITE               Choose the Debian suite (e.g., testing, experimental, trixie)
    -d, --desktop DESKTOP           Choose the desktop environment (e.g., xfce4, kde, none)
    -a, --additional ADDITIONAL     Choose whether to install additional software (yes/no)
                                  This only has an effect in kombination with -d or --desktop
    -u, --username USERNAME         Enter the username for the sudo user
    -p, --password PASSWORD         Enter the password for the sudo user
    -b                              Build the image with the specified configuration without asking
---------------------------------------------------

For example to build Debian testing with XFCE without additional software:
---------------------------------------------------
     ./build -s testing -d xfce4 -a no -u debian -p 123456 -b
---------------------------------------------------


---------------------------------------------------
 # Contact to the developer: byte4rr4y@gmail.com #
---------------------------------------------------
