# Sen2cor

Sentinel-2 Sen2cor (2.8.0) atmospheric correction.

## Dependencies

- Docker


## Sen2cor 2.8.0 Parameters
Sen2cor parameters can be changed by modifing the 2.8.0/2.8/cfg/L2A_GIPP.xml file and mounting it (-v /path/to/2.8/cfg:/root/sen2cor/2.8/cfg).
If you wish to use sen2cor default parameters, don't mount the parameters folder.

More info regarding Sen2Cor can be found on its Configuration and User Manual (http://step.esa.int/thirdparties/sen2cor/2.8.0/docs/S2-PDGS-MPC-L2A-SRN-V2.8.pdf).


## Downloading Sen2cor auxiliarie files:
  Download from http://maps.elie.ucl.ac.be/CCI/viewer/download.php (fill info on the right and download "ESACCI-LC for Sen2Cor data package")
  extract the downloaded file and the files within. It will contain two files and one directory:

  Example on Ubuntu (Linux) installation:

    $ ls home/user/sen2cor/CCI4SEN2COR

  ESACCI-LC-L4-LCCS-Map-300m-P1Y-2015-v2.0.7.tif

  ESACCI-LC-L4-Snow-Cond-500m-P13Y7D-2000-2012-v2.0

  ESACCI-LC-L4-WB-Map-150m-P13Y-2000-v4.0.tif


## Installation

1. Run

   ```bash
   $ docker build -t sen2cor:2.8.0 .
   ```

   from the root of this repository.

## Usage


To process a Sentinel-2 scene run

```bash
    $ docker run --rm \
    -v /path/to/CCI4SEN2COR:/home/lib/python2.7/site-packages/sen2cor/aux_data \
    -v /path/to/sen2cor/2.8/cfg:/root/sen2cor/2.8/cfg \
    -v /path/to/folder/containing/.SAFEfile:/mnt/input-dir \
    -v /path/to/output:/mnt/output-dir:rw \
    sen2cor:2.8.0 yourFile.SAFE
```

Results are written on mounted `/mnt/output-dir/`.
