#!/bin/bash

echo  misshie/bio-virtuoso-hpo
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-hpo

echo  misshie/bio-virtuoso-hpo-annotation-monarch
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-hpo-annotation-monarch

echo misshie/bio-virtuoso-go
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-go

echo misshie/bio-virtuoso-omim-gendoo-ja
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-omim-gendoo-ja

echo misshie/bio-virtuoso-omim-monarch
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-omim-monarch

echo misshie/bio-virtuoso-hgnc
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-hgnc

echo misshie/bio-virtuoso-orphanet
docker run \
    -i -t \
    --link virtuoso-goloso:virtuoso-goloso \
    misshie/bio-virtuoso-orphanet
