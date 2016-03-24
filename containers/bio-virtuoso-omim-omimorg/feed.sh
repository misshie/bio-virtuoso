#!/bin/bash
echo run misshie/bio-virtuoso-omim-monarch
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-omim-monarch
