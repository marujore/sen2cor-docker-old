#!/bin/bash
#
# This file is part of Sen2Cor Docker.
# Copyright (C) 2021 INPE.
#
# Sen2cor Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

set -e
shopt -s nullglob

if [ ${1} == "--help" ]; then
    echo "Usage: \
    docker run --rm \
    -v /path/to/input_dir/:/mnt/input_dir \
    -v /path/to/output_dir:/mnt/output_dir \
    -v /path/to/CCI4SEN2COR:${SEN2COR_INSTALL_PATH}/lib/python2.7/site-packages/sen2cor/aux_data \
    -v /path/to/L2A_GIPP.xml:${SEN2COR_INSTALL_PATH}/cfg/L2A_GIPP.xml \
    -t sen2cor:2.9.0 <SENTINEL-2_L1C.SAFE>"
    exit 0
fi

mkdir -p ${SEN2COR_OUTPUT_DIR}

SAFENAME_L1C=$1
SAFEDIR_L1C=${SEN2COR_INPUT_DIR}/${SAFENAME_L1C}

if [ "${SAFENAME_L1C}" != "*.SAFE" ] && [ ${SAFENAME_L1C:4:6} != 'MSIL1C' ]; then
    echo "ERROR: Not valid Sentinel-2 L1C"
    exit 1
fi

# load Sen2Cor environment variables
source ${SEN2COR_INSTALL_PATH}/L2A_Bashrc

L2A_Process --resolution 10 \
            --output_dir ${SEN2COR_OUTPUT_DIR} \
            --GIP_L2A ${SEN2COR_GIP_L2A} \
            ${SAFEDIR_L1C}

exit 0