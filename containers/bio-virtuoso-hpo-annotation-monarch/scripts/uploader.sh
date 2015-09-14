#!/bin/bash

url="http://virtuoso-goloso:4567/rdfxml"
graph="http://www.monarchinitiative.org/hpoa_dataset.ttl"
file="hpoa_dataset.ttl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

url="http://virtuoso-goloso:4567/rdfxml"
graph="http://www.monarchinitiative.org/hpoa.ttl"
file="hpoa.ttl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

