# rock4se-image-builder v1.3
## With Linux Kernel 6.6.x (works great)
### I'm working on compilation of latest linux kernel
### but i still have some driver problems, pleas be patient

### PLEASE report any issues!
#####################################################################################
## Changes
    - Fixed some issues with the Dockerfile
    - Added isntallation of ZSH with features
    - RW mode for qemu only to configure the display(standard is ro)
    - Added an option for an interactive shell inside the build container
    - Fixed issues with some Desktop installations
    - Removed installing otion for additional software(because of the image size)
    - Added qemu TPM emulation
    - Uploaded .zshrc file (Sorry I forgot it)
    - Updated the gui
    - Compile and install latest Kernel(!!!) CURRENTLY DISABLED BECAUSE OF MISSING WIFI/BT DRIVERS
#####################################################################################
# This script builds SD-Card images for the Radxa Rock 4 SE as it follows:
    - Building the root-filesystem inside a docker container.
    - Installing the Kernel.
    - Flash the u-boot bootloader(2024-01) and the root filesystem to the SD-Card image.

# Installation: Clone this repository and...
----------------------
    cd rock4se-image-builder
    chmod +x install.sh
    sudo ./install.sh
----------------------

# To build an SD-Card image:
    sudo ./build.sh
OR START Image-builder-GUI_amd64

You will find your image in the output folder.

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#      DO NOT RUN QEMU IN RW MODE OTHERWISE THE
# AUTO RESIZE ROOT FILESYSTEM ON FIRST BOOT WILL FAIL
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Run qemu emulation of your  build

## For example:
---------------------------------------------------
    ./runqemu-cli.sh output/Debian-experimental-CLI-build-1708557914/Debian-experimental-CLI.img
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
  - unity
  - budgie
  - kde plasma

# Automating the build process by using the commandline is possible
Type './build.sh -h'
---------------------------------------------------
    -h, --help                      Show this help message and exit
    -s, --suite SUITE               Choose the Debian suite (e.g., testing, experimental, trixie)
    -d, --desktop DESKTOP           Choose the desktop environment (e.g., xfce4, kde, none)
    -i, --interactive yes/no        Start an interactive shell in the docker container (yes/no)
                                    This only has an effect in kombination with -d or --desktop
    -u, --username USERNAME         Enter the username for the sudo user
    -p, --password PASSWORD         Enter the password for the sudo user
    -b                              Build the image with the specified configuration without asking
---------------------------------------------------

For example to build Debian testing with XFCE without additional software:
---------------------------------------------------
     ./build -s testing -d xfce4 -a no -u debian -p 123456 -i no -b
---------------------------------------------------


---------------------------------------------------
 # Contact to the developer: byte4rr4y@gmail.com #
---------------------------------------------------
