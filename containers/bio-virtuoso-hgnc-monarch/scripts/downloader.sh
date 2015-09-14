#!/bin/bash
curl \
    http://data.monarchinitiative.org/ttl/hgnc_dataset.ttl \
    -o hgnc_dataset.ttl

curl \
    http://data.monarchinitiative.org/ttl/hgnct.ttl \
    -o hgnc.ttl
