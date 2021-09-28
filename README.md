# Docker support for Sen2Cor


Sen2Cor is a processor for Sentinel-2 Level 2A product generation and formatting


## Dependencies

- Docker


## Sen2cor Parameters
Sen2cor parameters can be changed by modifing the 2.9.0/2.9/cfg/L2A_GIPP.xml file (for version 2.9.9) and mounting it while running the docker (-v /path/to/sen2cor/2.9/cfg:/root/sen2cor/2.9/cfg).
If you wish to use sen2cor default parameters, don't mount the parameters folder.

More info regarding Sen2Cor can be found on its Configuration and User Manual (http://step.esa.int/thirdparties/sen2cor/2.9.0/docs/S2-PDGS-MPC-L2A-SRN-V2.9.0.pdf).


## Downloading Sen2cor auxiliarie files:
  Download from http://maps.elie.ucl.ac.be/CCI/viewer/download.php (fill info on the right and download "ESACCI-LC for Sen2Cor data package")
  extract the downloaded file and the files within. It will contain two files and one directory:

  Example on Ubuntu (Linux) installation:

    $ ls home/user/sen2cor/CCI4SEN2COR

  ESACCI-LC-L4-LCCS-Map-300m-P1Y-2015-v2.0.7.tif

  ESACCI-LC-L4-Snow-Cond-500m-P13Y7D-2000-2012-v2.0

  ESACCI-LC-L4-WB-Map-150m-P13Y-2000-v4.0.tif


## Installation

To build sen2cor version 2.9.0 (you can change to the other versions in this repository) run:

   ```bash
   $ docker build -t sen2cor:2.9.0 ./2.9.0
   ```

   from the root of this repository to install version 2.9.0.

## Usage

To process a Sentinel-2 scene, using Sen2cor default parameters, run:

```bash
    $ docker run --rm \
    -v /path/to/CCI4SEN2COR:/home/lib/python2.7/site-packages/sen2cor/aux_data \
    -v /path/to/folder/containing/.SAFEfile:/mnt/input-dir \
    -v /path/to/output:/mnt/output-dir:rw \
    sen2cor:2.9.0 yourFile.SAFE
```

To process a Sentinel-2 scene, changing Sen2cor parameters, e.g. disable terrain correction, configure the 2.9.0/2.9/cfg/L2A_GIPP.xml and run mounting it as:

```bash
    $ docker run --rm \
    -v /path/to/CCI4SEN2COR:/home/lib/python2.7/site-packages/sen2cor/aux_data \
    -v /path/to/sen2cor/2.9/cfg:/root/sen2cor/2.9/cfg \
    -v /path/to/folder/containing/.SAFEfile:/mnt/input-dir \
    -v /path/to/output:/mnt/output-dir:rw \
    sen2cor:2.9.0 yourFile.SAFE
```

Results are written on mounted `/mnt/output-dir/`.
