# ubuntu:18.04
ARG BASE_IMAGE=ubuntu:ubuntu@sha256:122f506735a26c0a1aff2363335412cfc4f84de38326356d31ee00c2cbe52171
FROM ${BASE_IMAGE}
LABEL maintainer="Brazil Data Cube Team <brazildatacube@inpe.br>"

USER root

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        'curl' \
        'gdal-bin' \
        'python-dev' \
        'python-gdal' \
        'libxmu6' \
        'openjdk-11-jdk' \
        'unzip' \
        'wget' \
        'xserver-xorg' && \
    rm -rf /var/lib/apt/lists/*


# Set the working directory to /app
WORKDIR /app

# Install Sen2cor Version 2.5.5
RUN wget http://step.esa.int/thirdparties/sen2cor/2.5.5/Sen2Cor-02.05.05-Linux64.run

RUN chmod +x Sen2Cor-02.05.05-Linux64.run && \
    bash /app/Sen2Cor-02.05.05-Linux64.run --target /home && \
    rm /app/Sen2Cor-02.05.05-Linux64.run

ENV PATH $PATH:/home/bin/

# Setting environment variables
ENV PYTHONUNBUFFERED 1

COPY 2.5.5/run_sen2cor.sh /usr/local/bin/run_sen2cor.sh
RUN chmod +x /usr/local/bin/run_sen2cor.sh

COPY change-sen2cor-meta.py /usr/local/bin/change-sen2cor-meta.py

WORKDIR /mnt/work-dir

ENTRYPOINT ["/usr/local/bin/run_sen2cor.sh"]
CMD ["--help"]
