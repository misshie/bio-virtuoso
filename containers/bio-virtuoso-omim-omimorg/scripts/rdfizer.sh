#!/bin/bash
scr=omim2rdf/omim2rdf.rb
echo ">>> Convert OMIM official tables to Turtle files"
ruby ${scr} \
     --Mim2Gene ${Mim2Gene} \
     --MimTitles ${MimTitles} \
     --GeneMap ${GeneMap} \
     --MorbidMap ${MorbidMap} \
     --GeneMap2 ${GeneMap2}
