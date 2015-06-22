#!/bin/bash

hpa="http://compbio.charite.de/hudson/job/hpo.annotations/lastStableBuild/artifact/misc"
curl \
    ${hpa}/phenotype_annotation.tab \
    -o phenotype_annotation.tab
curl \
    ${hpa}/phenotype_annotation_hpoteam.tab \
    -o phenotype_annotation_hpoteam.tab
curl \
    ${hpa}/negative_phenotype_annotation.tab \
    -o negative_phenotype_annotation.tab
