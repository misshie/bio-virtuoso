#!/bin/bash

# EDIT HERE TO INDICATE
# A DIRECTORY CONTAINING FILES DOWNLOADED FROM OMIM.ORG
# (use a full path)
dldir="/peta/top/genetics/Mishima/Docker/bio-virtuoso/tmp/Omim"

echo run misshie/bio-virtuoso-omim-omimorg
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    --volume=${dldir}:/opt/bio-virtuoso/omim-omimorg/downloads:ro \
    misshie/bio-virtuoso-omim-omimorg $1

