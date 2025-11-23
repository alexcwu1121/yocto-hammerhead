# yocto-hammerhead

sudo rpiboot

sudo dd if=/dev/zero of=/dev/sda bs=4M count=10
sync

sudo bzcat core-image-hammerhead-hammerhead.rootfs.wic.bz2 | sudo dd of=/dev/sda bs=4M status=progress conv=fsync
sync