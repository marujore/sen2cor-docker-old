# Sen2cor-Docker

Sentinel-2 Sen2cor atmospheric correction processor Dockers.

Detailed information regarding Sen2Cor can be found on its Configuration and User Manual (http://step.esa.int/thirdparties/sen2cor/2.9.0/docs/S2-PDGS-MPC-L2A-SRN-V2.9.0.pdf).

## Dependencies

- Docker

## Downloading Sen2cor auxiliarie files:
  Download from http://maps.elie.ucl.ac.be/CCI/viewer/download.php (fill info on the right and download "ESACCI-LC for Sen2Cor data package")
  extract the downloaded file and the files within. It will contain two files and one directory:

  Example on Ubuntu (Linux) installation:

    $ ls home/user/sen2cor/CCI4SEN2COR

  ESACCI-LC-L4-LCCS-Map-300m-P1Y-2015-v2.0.7.tif

  ESACCI-LC-L4-Snow-Cond-500m-P13Y7D-2000-2012-v2.0

  ESACCI-LC-L4-WB-Map-150m-P13Y-2000-v4.0.tif


## Installation

To build sen2cor version 2.9.0 (you can change to the other versions in this repository) run from the root of this repository:

   ```bash
   $ ./build.sh
   ```

A specific version can be build by providing `-v <version>`; --no-cache option can be activated by providing `-n` flag; docker base image can be change by providing `-b <baseimage>`. For instance, to build a Sen2cor 2.5.5 image one can run from the root of this repository:

   ```bash
   $ ./build.sh -n -v 2.5.5
   ```

## Usage

To process a Sentinel-2 scene, using Sen2cor default parameters, run:

```bash
    $ docker run --rm \
    -v /path/to/CCI4SEN2COR:/home/lib/python2.7/site-packages/sen2cor/aux_data \
    -v /path/to/folder/containing/.SAFEfile:/mnt/input-dir \
    -v /path/to/output:/mnt/output-dir:rw \
    sen2cor:2.9.0 <yourFile.SAFE>
```

To process a Sentinel-2 scene, changing Sen2cor parameters, e.g. define the number of threads, run as:

```bash
    $ docker run --rm \
    -v /path/to/CCI4SEN2COR:/home/lib/python2.7/site-packages/sen2cor/aux_data \
    -v /path/to/folder/containing/.SAFEfile:/mnt/input-dir \
    -v /path/to/output:/mnt/output-dir:rw \
    sen2cor:2.9.0 <yourFile.SAFE> Nr_Threads=2
```

The sen2cor parameters that can be changed can be seen at L2A_GIPP.xml file.

Results are written on mounted `/mnt/output-dir/`.
