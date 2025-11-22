#!/bin/bash

# Hammerhead environment setup script

# Find the directory of this script
# Assumes a directory structure of
#   ${ROOT_DIR}
#       |- sources/
#       |- ${ROOT_DIR}-build
#       |- <this script>
#   repo tool should automatically move this script to the sources/ dir level
#   when resolving any of my manifests
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Build directory
BUILD_DIR=${ROOT_DIR}/build

# Meta layer sources directory
SOURCES_DIR=${ROOT_DIR}/sources

# Create build dir if missing
if [ ! -d ${BUILD_DIR} ]; then
    mkdir -p ${BUILD_DIR}/conf
fi

# Populate build directory and template confs
cp -n ${SOURCES_DIR}/meta-hammerhead/conf/templates/local.conf.sample ${BUILD_DIR}/conf/local.conf
cp -n ${SOURCES_DIR}/meta-hammerhead/conf/templates/bblayers.conf.sample ${BUILD_DIR}/conf/bblayers.conf

# Source OE build environment environment script
source ${SOURCES_DIR}/poky/oe-init-build-env ${BUILD_DIR}
