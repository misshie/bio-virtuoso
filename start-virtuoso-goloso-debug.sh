#!/bin/bash

echo "try to stop/rm misshie:virtuoso-goloso" 
docker stop misshie/virtuoso-goloso
docker rm misshie/virtuoso-goloso
echo "CMD: thin -C /opt/virtuoso-goloso/app_root/thin.yml -R /opt/virtuoso-goloso/app_root/config.ru start"
docker run \
    --rm \
    -i -t \
    -p 1111:1111 \
    -p 8890:8890 \
    -p 4567:4567 \
    --name virtuoso-goloso \
    -e MaxQueryExecutionTime="21600" \
    -e NumberOfBuffers="85000" \
    -e MaxDirtyBuffers="65000" \
    -e SQL_PREFETCH_ROWS="10000" \
    -e SQL_PREFETCH_BYTES="160000" \
    misshie/virtuoso-goloso \
    /bin/bash
# 1) default is undefined
#    MaxQueryCostEstimationTime
# 2) default values
#    MaxQueryExecutionTime: 21600 # 6hrs
#    NumberOfBuffers = 85000 # 4000000 for 48Gb RAM
#    MaxDirtyBuffers = 65000 # 3000000 for 48Gb RAM
#    SQL_PREFETCH_ROWS = 10000
#    SQL_PREFETCH_BYTES = 160000
