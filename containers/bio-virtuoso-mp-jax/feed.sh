#!/bin/sh
echo run misshie/bio-virtuoso-mp-jax
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-mp-jax

