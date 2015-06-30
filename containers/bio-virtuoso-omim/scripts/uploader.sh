#!/bin/bash

nquad="http://virtuoso-goloso:4567/n-quad"
gzfile="omim.nq.gz"
file="omim.nq"

zcat ${gzfile} > ${file}
curl \
    -X POST \
    -F file=@${file} \
    ${nquad}
rm ${file}
echo

rdfxml="http://virtuoso-goloso:4567/rdfxml"
file="omim.schema.owl"
graph="http://download.bio2rdf.org/release/3/omim/omim.schema.owl"

curl \
    -X POST \
    -F graph=${graph} \
    -F file=@${file} \
    ${rdfxml}
echo
