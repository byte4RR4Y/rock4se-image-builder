# rock4se-image-builder v2.5  >!UPDATED!<

## On first boot of the builds the device reboots after resizing root filesystem

### You can choose the latest availible Linux Kernel!!!

For questions or suggestions use the Discussions forum or Email.

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
    - !!! ADDED EMULATION OF CUSTOM KERNELS WITH GRAPHICS SUPPORT !!!
    - Removed QEMU scripts because they misconfigure the displaymanager of custom Kernels
    - Removed the gui
    - Added 'autoinstaller.sh' to install Radxa Metapackage for Rock4SE on first inet-connection
    - Improved 'rc.local', 'Dockerfile' and 'build.sh'
    - Improved 'makekernel.sh'
    - Replace '/etc/init.d/resize2fs' and 'resizeroot' script with 'rootresize.service'
    - Created 'rock-emulator.sh' to emulate builds; start it with:
      'sudo ./rock-emulator.sh IMAGEFILE.img'
      for more information about ro and rw mode.
## INFO: I to add installation of Headers for custom Kernels
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

# To build an SD-Card image, just simply type:
    sudo ./build.sh

You will find your image in the output folder.

# Adding custom packages to install
    -If you want to add packages to install, append it to config/apt-packages.txt
     instead of modifying the Dockerfile, For each package add a new line.

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
  - none     (Command line interface/tested)
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
    -H, --headers yes/no            Install Kernelheaders (only with standard Kernel)
    -d, --desktop DESKTOP           Choose the desktop environment (e.g., xfce4, kde, none)
    -i, --interactive yes/no        Start an interactive shell in the docker container (yes/no)
                                    Standard is set to 'no'.
                                    This only has an effect in kombination with -d or --desktop
    -u, --username USERNAME         Enter the username for the sudo user
    -p, --password PASSWORD         Enter the password for the sudo user
    -b                              Build the image with the specified configuration without asking
---------------------------------------------------

For example to build Debian testing with XFCE with latest Kernel, no Headers and creaating a sudo user with username debian and password 123456:
---------------------------------------------------
     ./build -s testing -d xfce4 -k latest -H no -u debian -p 123456 -b
---------------------------------------------------


---------------------------------------------------
 # Contact to the developer: byte4rr4y@gmail.com #
---------------------------------------------------
