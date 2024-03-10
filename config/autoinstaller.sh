#!/bin/bash

check_internet_connection() {
    ping -c 1 8.8.8.8 > /dev/null 2>&1
}

while true; do
    if check_internet_connection; then
        # Wait for first internet connection and install Radxa Metapackage for Rock4SE
        apt update -y && yes "y" | apt install -y task-rock-4se
        rm /etc/autoinstall
    fi
    sleep 5
done

