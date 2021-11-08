#!/bin/bash

set -e
shopt -s nullglob

if [ ${1} == "--help" ]; then
    echo "Usage: \
    docker run --rm \
    -v /path/to/input_dir/:/mnt/input_dir \
    -v /path/to/output_dir:/mnt/output_dir \
    -v /path/to/work_dir:/mnt/work_dir \
    -v /path/to/CCI4SEN2COR:${SEN2COR_INSTALL_PATH}/lib/python2.7/site-packages/sen2cor/aux_data \
    -v /path/to/sen2cor_2.9.0/2.9/cfg:/root/sen2cor/2.9/cfg \
    -t sen2cor_2.9.0 <SENTINEL-2.SAFE>"
    exit 0
fi

mkdir -p ${SEN2COR_OUTPUT_DIR} ${SEN2COR_WORK_DIR}

SAFENAME_L1C=$1
SAFEDIR_L1C=${SEN2COR_INPUT_DIR}/${SAFENAME_L1C}

if [ "${SAFENAME_L1C}" != "*.SAFE" ] && [ ${SAFENAME_L1C:4:6} != 'MSIL1C' ]; then
    echo "ERROR: Not valid Sentinel-2 L1C"
    exit 1
fi

# Ensure that workdir/sceneid is clean
if [ -d "${SEN2COR_WORK_DIR}/${SAFENAME_L1C}" ]; then
    rm -r ${SEN2COR_WORK_DIR}/${SAFENAME_L1C}
fi

cp -r ${SAFEDIR_L1C} ${SEN2COR_WORK_DIR}

# Process Sen2cor
cd ${SEN2COR_WORK_DIR}

source ${SEN2COR_INSTALL_PATH}/L2A_Bashrc
L2A_Process --resolution 10 \
            --GIP_L2A ${SEN2COR_GIP_L2A} \
            ${SAFEDIR_L1C}

# SENTINEL-2
SAFENAME_L2A=${SAFENAME_L1C//L1C/L2A}
SAFENAME_L2A=${SAFENAME_L2A//_N*_R/_N9999_R}
SAFENAME_L2A=${SAFENAME_L2A::45}

for entry in `ls ${SEN2COR_WORK_DIR}`; do
    if [[ ${entry} == "${SAFENAME_L2A}"* ]]; then
        SAFENAME_L2A=${entry}
    fi
done

cp -r ${SEN2COR_WORK_DIR}/${SAFENAME_L2A} ${SEN2COR_OUTPUT_DIR}
rm -r ${SEN2COR_WORK_DIR}/${SAFENAME_L2A}
rm -r ${SEN2COR_WORK_DIR}/${SAFENAME_L1C}
exit 0