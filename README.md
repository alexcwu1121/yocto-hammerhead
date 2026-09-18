# yocto-hammerhead

Linux build scripts for the Hammerhead Sensor Module, a Raspberry Pi CM5 carrier board.

To build:
1. `git submodule update --init --recursive`
2. Build and exec into development container: `./setup_env.sh`
3. Once in development container initialize BitBake environment, `source bb_init.sh`
4. Build: `bitbake <what bb_init suggests>`

To first-time flash to eMMC:
1. Build submoduled usbboot under `sources/usbboot` and build/install either system wide or (preferably) locally. See usbboot documentation.
2. With board depowered, set Boot DIP switch position 1 to ON
3. Plug in usb-c power and debugging cable
4. Run `sudo rpiboot` or `sudo ./sources/usbboot/rpiboot`
5. Wait for CM5 to appear as a USB storage device
6. Identify the USB storage device node `eg. /dev/sda`
7. Run flashing script: `sudo ./flash_cm5.sh <my_image.wic.bz> <storage device name>`

To build a SWupdate image and perform an OTA update:
1. 

To enable wifi on target:
1. Populate /etc/wpa_supplicant.conf with network ssid and passkey
2. `ifconfig wlan0 up`
3. `wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf`
4. `udhcpc -i wlan0`

To test a camera:
1. Install VLC player
2. Enable wifi on target
3. Run on target:
    - Camera 0: `rpicam-vid -t 0 --camera 0 -n --codec libav --libav-format mpegts -o tcp://0.0.0.0:5000?listen=1`
    - Camera 1: `rpicam-vid -t 0 --camera 1 -n --codec libav --libav-format mpegts -o tcp://0.0.0.0:5000?listen=1`
4. In VLC, `Media -> Open Network Stream -> tcp://<target ip>:5000`
