#!/bin/bash

echo run misshie/bio-virtuoso-orphanet-monarch
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-orphanet-monarch
