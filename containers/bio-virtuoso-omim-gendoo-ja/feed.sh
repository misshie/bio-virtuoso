#!/bin/bash
echo run misshie/bio-virtuoso-omim-gendoo-ja
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-omim-gendoo-ja
