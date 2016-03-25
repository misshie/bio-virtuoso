#!/bin/bash
dldir="../../tmp/OMIM"
echo run misshie/bio-virtuoso-omim-monarch
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    -e Mim2Gene=${dldir}/mim2gene.txt \
    -e MimTitles=${dldir}/mimTitles.txt \
    -e GeneMap=${dldir}/genemap.txt \
    -e MorbidMap=${dldir}/morbidmap.txt \
    -e GeneMap2=${dldir}/genemap2.txt \
    misshie/bio-virtuoso-omim-monarch
