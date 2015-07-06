#!/bin/bash

nquad="http://virtuoso-goloso:4567/n-quad"
gzfile="orphanet-d2s.nq.gz"
file="orphanet-d2s.nq"
zcat ${gzfile} > ${file}
curl \
    -X POST \
    -F file=@${file} \
    ${nquad}
rm ${file}
echo

nquad="http://virtuoso-goloso:4567/n-quad"
gzfile="orphanet-disease.nq.gz"
file="orphanet-disease.nq"
zcat ${gzfile} > ${file}
curl \
    -X POST \
    -F file=@${file} \
    ${nquad}
rm ${file}
echo

nquad="http://virtuoso-goloso:4567/n-quad"
gzfile="orphanet-epi.nq.gz"
file="orphanet-epi.nq"
zcat ${gzfile} > ${file}
curl \
    -X POST \
    -F file=@${file} \
    ${nquad}
rm ${file}
echo

nquad="http://virtuoso-goloso:4567/n-quad"
gzfile="orphanet-signs.nq.gz"
file="orphanet-signs.nq"
zcat ${gzfile} > ${file}
curl \
    -X POST \
    -F file=@${file} \
    ${nquad}
rm ${file}
echo

rdfxml="http://virtuoso-goloso:4567/rdfxml"
file="orphanet.schema.owl"
graph="http://download.bio2rdf.org/release/3/orphanet/orphanet.schema.owl"
curl \
    -X POST \
    -F graph=${graph} \
    -F file=@${file} \
    ${rdfxml}
echo
