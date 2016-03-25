#!/bin/bash

docker stop virtuoso-goloso
docker rm virtuoso-goloso
docker run \
    -i -t \
    -p 1111:1111 \
    -p 8890:8890 \
    -p 4567:4567 \
    --name virtuoso-goloso \
    -e MaxQueryExecutionTime="21600" \
    -e NumberOfBuffers="4000000" \
    -e MaxDirtyBuffers="3000000" \
    -e SQL_PREFETCH_ROWS="10000" \
    -e SQL_PREFETCH_BYTES="160000" \
    misshie/virtuoso-goloso $1

# 1) default is undefined
#    MaxQueryCostEstimationTime
# 2) default values
#    MaxQueryExecutionTime: 21600 # 6hrs
#    NumberOfBuffers = 85000 # 4000000 for 48Gb RAM
#    MaxDirtyBuffers = 65000 # 3000000 for 48Gb RAM
#    SQL_PREFETCH_ROWS = 10000
#    SQL_PREFETCH_BYTES = 160000
