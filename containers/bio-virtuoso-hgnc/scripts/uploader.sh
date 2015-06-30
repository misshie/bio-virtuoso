#!/bin/bash

nquad="http://virtuoso-goloso:4567/n-quad"
gzfile="hgnc_complete_set.nq.gz"
file="hgnc_complete_set.nq"

zcat ${gzfile} > ${file}
curl \
    -X POST \
    -F file=@${file} \
    ${nquad}
rm ${file}
echo

rdfxml="http://virtuoso-goloso:4567/rdfxml"
file="hgnc.schema.owl"
graph="http://download.bio2rdf.org/release/3/hgnc/hgnc.schema.owl"

curl \
    -X POST \
    -F graph=${graph} \
    -F file=@${file} \
    ${rdfxml}
echo
