# Sen2cor

Sentinel-2 Sen2cor (2.9.0) atmospheric correction.

## Dependencies

- Docker


## Sen2cor 2.9.0 Parameters
Sen2cor parameters can be changing by modifing the /sen2cor_2.9.0/2.9/cfg/L2A_GIPP.xml file and mounting it.
This repository changes the default DEM_Terrain_Correction to FALSE (at L2A_GIPP.xml).
If you wish to use sen2cor default parameters, don't mount the parameters folder (-v /path/to/sen2cor_2.9.0/2.9:/root/sen2cor/2.9).

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

1. Run

   ```bash
   $ docker build -t sen2cor:2.9.0 .
   ```

   from the root of this repository.

## Usage


To process a Sentinel-2 scene, using Sen2cor default parameters, run:

```bash
    $ docker run --rm \
    -v /path/to/CCI4SEN2COR:/home/lib/python2.7/site-packages/sen2cor/aux_data \
    -v /path/to/folder/containing/.SAFEfile:/mnt/input-dir \
    -v /path/to/output:/mnt/output-dir:rw \
    sen2cor:2.9.0 yourFile.SAFE
```

To process a Sentinel-2 scene, changing Sen2cor parameters, e.g. disable terrain correction, configure the /2.9/L2A_GIPP.xml and run mounting it as:

```bash
    $ docker run --rm \
    -v /path/to/CCI4SEN2COR:/home/lib/python2.7/site-packages/sen2cor/aux_data \
    -v /path/to/sen2cor/2.9:/root/sen2cor/2.9 \
    -v /path/to/folder/containing/.SAFEfile:/mnt/input-dir \
    -v /path/to/output:/mnt/output-dir:rw \
    sen2cor:2.9.0 yourFile.SAFE
```

Results are written on mounted `/mnt/output-dir/`.
