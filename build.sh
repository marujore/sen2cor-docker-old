#!/bin/bash
#
# This file is part of Sen2cor Docker.
# Copyright (C) 2021 INPE.
#
# Sen2cor Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

set -eou pipefail

#
# General functions
#
usage() {
    echo "Usage: $0 [-n] [-v <2.9.0>] [-b ubuntu:18.04]" 1>&2;

    exit 1;
}

#
# General variables
#
BASE_IMAGE="ubuntu:ubuntu@sha256:122f506735a26c0a1aff2363335412cfc4f84de38326356d31ee00c2cbe52171" # ubuntu:18.04
BUILD_MODE=""
SEN2COR_VERSION="2.9.0"

#
# Get build options
#
while getopts "b:nv:h" o; do
    case "${o}" in
        b)
            BASE_IMAGE=${OPTARG}
            ;;
        n)
            BUILD_MODE="--no-cache"
            ;;
        v)
            SEN2COR_VERSION=${OPTARG}
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done

#
# Build a Linux Ubuntu image with all the dependencies already installed
#
echo "Building Sen2cor Image"

# Ensure that directory exists
if [ -d "${SEN2COR_VERSION}" ]; then
    cd ${SEN2COR_VERSION}
else
    echo "Error: Sen2cor version ${SEN2COR_VERSION} directory not found"
    exit 1
fi

docker build ${BUILD_MODE} \
       --build-arg ${BASE_IMAGE} \
       -t "sen2cor:"${SEN2COR_VERSION} .