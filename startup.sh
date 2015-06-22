#!/bin/bash

docker run \
    -i -t \
    -p 1111:1111 \
    -p 8890:8890 \
    -p 4567:4567 \
    --name virtuoso-goloso \
    misshie/virtuoso-goloso

docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-hpo

