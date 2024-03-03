# rock4se-image-builder v1.7
## With the latest Linux Kernel !!!
For questions or suggestions use the Discussions forum
### PLEASE report any issues!
When you start your build just type 'sudo resizeroot' to expand root filesystem
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
    - Compile and install latest Kernel !!! At the moment it's 6.8.0-rc6 (2024-02-29)
    - Added a kernelupdater.sh script to the boot folder of the builds
    - Added option to install latest or standard Kernel
    - Added installation of kernel headers.
    _ !!! ADDED EMULATION OF CUSTOM KERNELS WITH GRAPHICS SUPPORT !!!
#####################################################################################
# This script builds SD-Card images for Radxa Rock 4 SE as it follows:
    - Building the root-filesystem inside a docker container.
    - Installing standard Kernel or compiling and installing the latest Linux Kernel.
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
# Run qemu emulation of your build

## For example:
---------------------------------------------------
    ./runqemu-cli.sh output/Debian-experimental-CLI-build-1708557914/Debian-experimental-CLI.img
    ./runqemu-desktop.sh output/Debian-experimental-xfce4-build-1708557914/Debian-experimental-xfce4-build-standard.img
    ./runqemu-desktop.sh output/Debian-experimental-xfce4-build-1708557914/Debian-experimental-xfce4-build-standard.img nofullscreen
---------------------------------------------------

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
  - xfce     (tested)
  - gnome    (tested)
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
    -k, --kernel latest/standard    Choose which kernel to install
    -H, --headers yes/no            Install Kernelheaders
    -d, --desktop DESKTOP           Choose the desktop environment (e.g., xfce4, kde, none)
    -i, --interactive yes/no        Start an interactive shell in the docker container (yes/no)
                                    This only has an effect in kombination with -d or --desktop
    -u, --username USERNAME         Enter the username for the sudo user
    -p, --password PASSWORD         Enter the password for the sudo user
    -b                              Build the image with the specified configuration without asking
---------------------------------------------------

For example to build Debian testing with XFCE with latest Kernel:
---------------------------------------------------
     ./build -s testing -d xfce4 -k latest -H no -u debian -p 123456 -i no -b
---------------------------------------------------


---------------------------------------------------
 # Contact to the developer: byte4rr4y@gmail.com #
---------------------------------------------------
