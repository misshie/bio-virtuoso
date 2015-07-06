#!/bin/bash
curl \
    http://download.bio2rdf.org/release/3/orphanet/orphanet-d2s.nq.gz \
    -o orphanet-d2s.nq.gz

curl \
    http://download.bio2rdf.org/release/3/orphanet/orphanet-disease.nq.gz \
    -o orphanet-disease.nq.gz

curl \
    http://download.bio2rdf.org/release/3/orphanet/orphanet-epi.nq.gz \
    -o orphanet-epi.nq.gz

curl \
    http://download.bio2rdf.org/release/3/orphanet/orphanet-signs.nq.gz \
    -o orphanet-signs.nq.gz

curl \
    http://download.bio2rdf.org/release/3/orphanet/orphanet.schema.owl \
    -o orphanet.schema.owl
