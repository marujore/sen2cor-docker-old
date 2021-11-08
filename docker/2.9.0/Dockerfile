#
# Base image
#
ARG BASE_IMAGE=ubuntu:20.04
FROM ${BASE_IMAGE}

#
# Image metadata
#
LABEL "org.brazildatacube.maintainer"="Brazil Data Cube <brazildatacube@inpe.br>"
LABEL "org.brazildatacube.title"="Docker image for Sen2Cor"
LABEL "org.brazildatacube.description"="Software environment \
for Sentinel-2 Level 2A product generation and formatting."


#
# Build arguments
#
ARG SEN2COR_VERSION="2.9.0"
ARG SEN2COR_INSTALLER_NAME="Sen2Cor-02.09.00-Linux64.run"
ARG SEN2COR_INSTALLER_URL="http://step.esa.int/thirdparties/sen2cor/${SEN2COR_VERSION}/${SEN2COR_INSTALLER_NAME}"
ARG SEN2COR_INSTALLER_DIR="/tmp/"
ARG SEN2COR_INSTALL_PATH="/opt/sen2cor/${SEN2COR_VERSION}"


#
# Update package list and install required packages
#
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y python-dev unzip && \
    rm -rf /var/lib/apt/lists/*


#
# Copy Sen2Cor installer to a temporary directory
#
ADD ${SEN2COR_INSTALLER_URL} ${SEN2COR_INSTALLER_DIR}


#
# Make Sen2Cor installer's directory the current one
#
WORKDIR ${SEN2COR_INSTALLER_DIR}


#
# Make sure Sen2Cor installer has execute permission
#
RUN chmod +x ${SEN2COR_INSTALLER_NAME}


#
# Install Sen2Cor
#
RUN bash ./${SEN2COR_INSTALLER_NAME} --target ${SEN2COR_INSTALL_PATH} --nox11 && \
    mkdir ${SEN2COR_INSTALL_PATH}/cfg && \
    cp /root/sen2cor/2.9/cfg/L2A_GIPP.xml ${SEN2COR_INSTALL_PATH}/cfg/ && \
    rm ${SEN2COR_INSTALLER_NAME}


#
# Make Sen2Cor directory the current one
#
WORKDIR ${SEN2COR_INSTALL_PATH}


#
# Environment Variables
#

# Mandatorio
ENV SEN2COR_INPUT_DIR /mnt/input_dir
ENV SEN2COR_OUTPUT_DIR /mnt/output_dir
ENV SEN2COR_WORK_DIR /mnt/work_dir

# opcional
ENV SEN2COR_CCI4SEN2COR ${SEN2COR_INSTALL_PATH}/lib/python2.7/site-packages/sen2cor/aux_data

# Opcional
ENV SEN2COR_GIP_L2A ${SEN2COR_INSTALL_PATH}/cfg/L2A_GIPP.xml

# opcional
ENV SEN2COR_SRTM /root/sen2cor/2.9/dem/srtm


#
# Copy and install Docker entry point
#
ADD run-sen2cor.sh ${SEN2COR_INSTALL_PATH}/bin/run-sen2cor.sh

ENTRYPOINT ["${SEN2COR_INSTALL_PATH}/bin/run-sen2cor.sh"]

CMD ["--help"]