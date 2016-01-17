#!/bin/bash
echo run misshie/bio-virtuoso-hpo-annotation-monarch
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-hpo-annotation-monarch
