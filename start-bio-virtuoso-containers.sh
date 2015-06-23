#!/bin/bash

# docker run \
#     -i -t \
#     --link virtuoso-goloso:virtuoso-goloso \
#     misshie/bio-virtuoso-hpo

# docker run \
#     -i -t \
#     --link virtuoso-goloso:virtuoso-goloso \
#     misshie/bio-virtuoso-hpo-annotation

docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-go
