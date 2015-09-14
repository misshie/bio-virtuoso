#!/bin/bash
curl \
    http://data.monarchinitiative.org/ttl/hpoa_dataset.ttl \
    -o hpoa_dataset.ttl

curl \
    http://data.monarchinitative.org/ttl/hpoa.ttl \
    -o hpoa.ttl
