#!/bin/bash
curl \
    http://data.monarchinitiative.org/ttl/orphanet_dataset.ttl \
    -o orphanet_dataset.ttl

curl \
    http://data.monarchinitiative.org/ttl/orphanet.ttl \
    -o orphanet.ttl
