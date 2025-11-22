#!/bin/bash

# Use directory of this script as workspace
WORKDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Build environment image
podman build . -f Dockerfile.yocto-env-ubuntu-22 -t yocto-env-ubuntu-22

# Open an interactive terminal
podman run --userns=keep-id --rm -it -v ${WORKDIR}:${WORKDIR}:Z -w ${WORKDIR} yocto-env-ubuntu-22:latest
