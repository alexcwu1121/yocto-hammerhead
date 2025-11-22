#!/bin/bash

# Only argument is the desired Yocto working directory
WORKDIR=$1

# Build environment image
podman build . -f Dockerfile.yocto-env-ubuntu-22 -t yocto-env-ubuntu-22

# Open an interactive terminal
podman run --userns=keep-id --rm -it -v ${WORKDIR}:${WORKDIR}:Z -w ${WORKDIR} yocto-env-ubuntu-22:latest
