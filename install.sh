#! /bin/bash

if [ "$UID" -ne 0 ]; then 
    echo "This program needs sudo rights."
    echo "Run it with 'sudo $0'"
    exit 1
fi

apt update -y && apt install -y git docker.io apparmor qemu-user-static binfmt-support qemu-user qemu-utils qemu-system-aarch64 u-boot-qemu golang
go mod init Image-builder-GUI_amd64.go
go mod tidy
GOOS=linux GOARCH=amd64 go build -o Image-builder-GUI_amd64 Image-builder-GUI_amd64.go

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
 
