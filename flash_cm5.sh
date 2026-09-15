#!/usr/bin/env bash
#
# flash_cm5.sh
#
# Usage:
#   sudo ./flash-cm5.sh IMAGE.wic.bz2 /dev/sdX

# You need to run this as root
if [[ $EUID -ne 0 ]]; then
    echo "Flashing script must be run as root."
    exit 1
fi

# Compressed WIC file path
WIC_PATH=$1
# Block device
BLOCK_DEVICE=$2

# Erase partition table
dd if=/dev/zero of=$BLOCK_DEVICE bs=4M count=10 conv=fsync

# Unmount partitions that may have been automounted
umount ${BLOCK_DEVICE}1
umount ${BLOCK_DEVICE}2

# Reprobe the device after partition table has been erased
partprobe $BLOCK_DEVICE -s

# Extract and flash image to device
bzcat $WIC_PATH | dd of=$BLOCK_DEVICE bs=4M status=progress conv=fsync
rc=$?

if [[ rc -ne 0 ]]; then
    echo "Flash failed."
    exit 1
fi

# Reprobe after flashing to ensure partitions have been created
partprobe $BLOCK_DEVICE -s

exit 0
