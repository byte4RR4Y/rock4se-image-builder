#!/bin/bash

ARCHIVE=$1

BUILD="$(unzip -l ${ARCHIVE} boot/vmlinuz-* | sed -n 's|^.*boot/vmlinuz-\(.*\)$|\1|p')"
unzip -o "${ARCHIVE}" -d /
update-initramfs -c -v -k "${BUILD}"

