# rock4se-image-builder >> FINAL VERSION WITH GUI <<

I'm currently testing all the builds(a lot of work!) PLEASE report any issues!
#####################################################################################
# This script builds SD-Card images for the Radxa Rock 4 SE as it follows:
    - Building the root-filesystem inside a docker container.
    - Installing the Kernel.
    - Flash the u-boot bootloader and the root filesystem to the SD-Card image.

# Installation:
----------------------
    git clone https://github.com/byte4RR4Y/rock4se-builder
    cd rock4se-image-builder
    chmod +x install.sh
    sudo ./install.sh
----------------------

# To build an SD-Card image:
    sudo ./build.sh
OR START Image-builder-GUI_amd64

You will find your image in the output folder.

If you prefer a graphical interface you can download Image-builder2(NOT UPDATED!):

https://drive.google.com/file/d/1h_ni_BUCPj5Ob7wUyk_nTow3XgTlLGUF/view?usp=sharing

# Run qemu emulation of your  build

## For example:
---------------------------------------------------
    ./runqemu-desktop.sh output/Debian-experimental-xfce4-build-1708569271/Debian-experimental-xfce4.img
    ./runqemu-desktop.sh output/Debian-experimental-xfce4-build-1708569271/Debian-experimental-xfce4.img nofullscreen
---------------------------------------------------
'./runqemu-desktop.sh IMAGENAME' boots automaticly 'rw', because it configures the display correctly.

'./runqemu-desktop.sh IMAGENAME nofullscreen' is booting the image in window-mode

# Adding custom packages to install
    -If you want to add packages to install, append it to config/apt-packages.txt
     instead of modifying the Dockerfile

# Required Host system:
  - Debian/amd64 (bullseye, bookworm, MX 21 and MX23 are tested)
  - maybe Ubuntu works too, but the depencies are slightly different(install.sh is not working)

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
  - unity(did not work at the moment)
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
