#!/bin/bash

# Use directory of this script as workspace
WORKDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Build environment image
podman build . -f Dockerfile.yocto-env-ubuntu-22 -t yocto-env-ubuntu-22

# Open an interactive terminal
podman run \
    --userns=keep-id \
    --privileged \
    --rm -it \
    -v ${WORKDIR}:${WORKDIR} \
    -v /dev/bus/usb:/dev/bus/usb \
    -w ${WORKDIR} yocto-env-ubuntu-22:latest
