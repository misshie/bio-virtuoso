#!/bin/bash
curl \
    http://data.monarchinitiative.org/ttl/omim_dataset.ttl \
    -o omim_dataset.ttl

curl \
    http://data.monarchinitiative.org/ttl/omim.ttl \
    -o omim.ttl
