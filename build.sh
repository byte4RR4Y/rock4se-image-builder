#!/bin/bash

TIMESTAMP=$(date +%s)

usage() {
    echo "Usage: $0 [-h|--help] [-s|--suite SUITE] [-d|--desktop DESKTOP] [-a|--additional ADDITIONAL] [-u|--username USERNAME] [-p|--password PASSWORD] [-b]"
    echo "-------------------------------------------------------------------------------------------------"
    echo "Options:"
    echo "  -h, --help                      Show this help message and exit"
    echo "  -s, --suite SUITE               Choose the Debian suite (e.g., testing, experimental, trixie)"
    echo "  -d, --desktop DESKTOP           Choose the desktop environment."
    echo "                                  (none/xfce4/gnome/cinnamon/lxqt/lxde/unity/budgie/kde)"
    echo "  -a, --additional ADDITIONAL     Choose whether to install additional software (yes/no)"
    echo "                                  This only has an effect in kombination with -d or --desktop"
    echo "  -u, --username USERNAME         Enter the username for the sudo user"
    echo "  -p, --password PASSWORD         Enter the password for the sudo user"
    echo "  -b                              Build the image with the specified configuration without asking"
    echo "-------------------------------------------------------------------------------------------------"
    echo "For example: $0 -s sid -d none -a no -u USERNAME123 -p PASSWORD123 -b"
    exit 1
}

# Check if running with sudo
if [ "$UID" -ne 0 ]; then
    echo "This program needs sudo rights."
    echo "Run it with 'sudo $0'"
    exit 1
fi

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) usage;;
        -s|--suite) SUITE="$2"; shift ;;
        -d|--desktop) DESKTOP="$2"; shift ;;
        -a|--additional) ADDITIONAL="$2"; shift ;;
        -u|--username) USERNAME="$2"; shift ;;
        -p|--password) PASSWORD="$2"; shift ;;
        -b) BUILD="yes" ;;
        *) echo "Unknown parameter passed: $1"; usage ;;
    esac
    shift
done

echo "----------------------"
echo "cleaning build area..."
sleep 2
rm .config
rm .rootfs.img
rm .rootfs.tar
rm -rf .rootfs/
rm config/rootfs_size.txt
echo ""
clear
# Check if arguments are missing
if [ -z "$SUITE" ] || [ -z "$DESKTOP" ] || [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
clear
echo "Choose the Debian Suite:"
echo ""
echo "1. Testing"
echo "2. Experimental"
echo "3. Trixie"
echo "4. Sid"
echo "5. Bookworm"
echo "6. Bullseye"
echo ""
read -p "Enter the number of your choice: " choice
if [[ "$choice" -eq 1 ]]; then
    echo "SUITE=testing" > .config
elif [[ "$choice" -eq 2 ]]; then
    echo "SUITE=experimental" > .config
elif [[ "$choice" -eq 3 ]]; then
    echo "SUITE=trixie" > .config
elif [[ "$choice" -eq 4 ]]; then
    echo "SUITE=sid" > .config
elif [[ "$choice" -eq 5 ]]; then
    echo "SUITE=bookworm" > .config
elif [[ "$choice" -eq 6 ]]; then
    echo "SUITE=bullseye" > .config
else
	exit 1
fi

clear
echo "Choose the Desktop of your choice:"
echo ""
echo " 0. none"
echo " 1. xfce"
echo " 2. gnome"
echo " 3. mate"
echo " 4. cinnamon"
echo " 5. lxqt"
echo " 6. lxde"
echo " 7. unity"
echo " 8. budgie"
echo " 9. kde plasma"
echo ""
read -p "Enter the number of your choice: " choice
if [[ "$choice" -eq 0 ]]; then
    echo "DESKTOP=CLI" >> .config
elif [[ "$choice" -eq 1 ]]; then
    echo "DESKTOP=xfce4" >> .config
elif [[ "$choice" -eq 2 ]]; then
    echo "DESKTOP=gnome" >> .config
elif [[ "$choice" -eq 3 ]]; then
    echo "DESKTOP=mate" >> .config
elif [[ "$choice" -eq 4 ]]; then
    echo "DESKTOP=cinnamon" >> .config
elif [[ "$choice" -eq 5 ]]; then
    echo "DESKTOP=lxqt" >> .config
elif [[ "$choice" -eq 6 ]]; then
    echo "DESKTOP=lxde" >> .config
elif [[ "$choice" -eq 7 ]]; then
    echo "DESKTOP=unity" >> .config
elif [[ "$choice" -eq 8 ]]; then
    echo "DESKTOP=budgie" >> .config
elif [[ "$choice" -eq 9 ]]; then
    echo "DESKTOP=kde" >> .config
fi

if [[ "$choice" != 0 ]]; then
	clear
	echo "Do you want to install additional software?"
	echo ""
	echo "1. yes"
	echo "2. no"
	echo ""
	read -p "Enter the number of your choice: " choice2
	if [[ "$choice2" -eq 1 ]]; then
	    echo "ADDITIONAL=yes" >> .config
	else
	    echo "ADDITIONAL=no" >> .config
	fi
else
	echo "ADDITIONAL=no" >> .config
fi
clear
echo "Let's create a sudo user..."
echo ""
read -p "Enter Username: " choice

    echo "USERNAME=$choice" >> .config
echo ""
read -p "Enter Password: " choice

    echo "PASSWORD=$choice" >> .config
clear
echo "Writing '.config'..."
while IFS='=' read -r key value; do
    case "$key" in
    	SUITE)
    		SUITE="$value"
    		;;
        DESKTOP)
            DESKTOP="$value"
            ;;
        ADDITIONAL)
            ADDITIONAL="$value"
            ;;
        USERNAME)
            USERNAME="$value"
            ;;
        PASSWORD)
            PASSWORD="$value"
            ;;
        *)
            ;;
    esac
done < .config
fi


echo "------------------------------"
echo "SUITE="$SUITE
echo "DESKTOP="$DESKTOP
echo "ADDITIONAL="$ADDITIONAL
echo "USERNAME="$USERNAME
echo "PASSWORD="$PASSWORD
echo "------------------------------"
# Proceed with building image if -b option provided or ask for confirmation
if [[ "$BUILD" == "yes" ]]; then
    echo "Building image with the specified configuration..."
else
    echo ""
	echo "Do you want to build the image with this configuration?"
	echo ""
	echo "1. yes"
	echo "2. no"
	echo ""
	read -p "Enter the number of your choice: " choice2
	if [[ "$choice2" -eq 1 ]]; then
	    BUILD="yes"
	else
	    exit 1
	fi
fi

if [[ "$BUILD" == "yes" ]]; then
echo "---------------------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------------------"

echo "Reading .config file..."
while IFS='=' read -r key value; do
    case "$key" in
        DESKTOP)
            DESKTOP="$value"
            ;;
        ADDITIONAL)
            ADDITIONAL="$value"
            ;;
        USERNAME)
            USERNAME="$value"
            ;;
        PASSWORD)
            PASSWORD="$value"
            ;;
        *)
            ;;
    esac
done < .config

# Führe den Docker-Build-Befehl aus
echo "Building Docker image..."
sleep 1
docker build --build-arg "SUITE="$SUITE --build-arg "DESKTOP="$DESKTOP --build-arg "ADDITIONAL="$ADDITIONAL --build-arg "USERNAME="$USERNAME --build-arg "PASSWORD="$PASSWORD -t debian:finest -f config/Dockerfile .

echo "---------------------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------------------"

docker run --platform linux/arm64/v8 -dit --rm --name debiancontainer debian:finest /bin/bash
docker cp debiancontainer:/rootfs_size.txt config/

ROOTFS=.rootfs.img
rootfs_size=$(cat config/rootfs_size.txt)
echo "Creating an empty rootfs image..."
dd if=/dev/zero of=$ROOTFS bs=1M count=$((${rootfs_size} + 256)) status=progress
mkfs.ext4 -L rootfs $ROOTFS -F

mkfs.ext4 ${ROOTFS} -L rootfs -F

mkdir -p .loop/root
mount ${ROOTFS} .loop/root
docker export -o .rootfs.tar debiancontainer
tar -xvf .rootfs.tar -C .loop/root
docker kill debiancontainer
umount .loop/root
e2fsck -fyvC 0 ${ROOTFS}
resize2fs -M ${ROOTFS}
gzip ${ROOTFS}
mount ${ROOTFS} .loop/root
mkdir -p output/Debian-${SUITE}-${DESKTOP}-build-${TIMESTAMP}/.qemu
cp .loop/root/boot/vmlinuz* output/Debian-${SUITE}-${DESKTOP}-build-${TIMESTAMP}/.qemu/vmlinuz
cp .loop/root/boot/initrd* output/Debian-${SUITE}-${DESKTOP}-build-${TIMESTAMP}/.qemu/initrd.img
umount .loop/root
mv "${ROOTFS}.gz" output/Debian-${SUITE}-${DESKTOP}-build-${TIMESTAMP}/.qemu/
zcat config/boot-rock_pi_4se.bin.gz output/Debian-${SUITE}-${DESKTOP}-build-${TIMESTAMP}/.qemu/${ROOTFS}.gz > output/Debian-${SUITE}-${DESKTOP}-build-${TIMESTAMP}/.qemu/disk.raw
rm output/Debian-${SUITE}-${DESKTOP}-build-${TIMESTAMP}/.qemu/${ROOTFS}.gz
if [[ "$DESKTOP" == "none" ]]; then
    DESKTOP="CLI"
fi
zcat config/boot-rock_pi_4se.bin.gz ${ROOTFS}.gz > "output/Debian-${SUITE}-${DESKTOP}-build-${TIMESTAMP}/Debian-${SUITE}-${DESKTOP}-build.img"
rm -rf .loop/root .rootfs.img .rootfs.tar
fi

