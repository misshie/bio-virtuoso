#!/bin/bash
curl \
    http://nif-crawler.neuinfo.org/monarch/ttl/hpoa_dataset.ttl \
    -o hpoa_dataset.ttl

curl \
    http://nif-crawler.neuinfo.org/monarch/ttl/hpoa.ttl \
    -o hpoa.ttl
