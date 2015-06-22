#!/bin/bash

echo ">>> Convert phenotype_annotation_hpoteam.tab to Turtle"
ruby hpa2rdf/hpa2rdf.rb phenotype_annotation_hpoteam.tab > phenotype_annotation_hpoteam.ttl

echo ">>> Convert phenotype_annotation.tab to Turtle"
ruby hpa2rdf/hpa2rdf.rb phenotype_annotation.tab > phenotype_annotation.ttl

echo ">>> Convert negative_phenotype_annotation.tab to Turtle"
ruby hpa2rdf/hpa2rdf.rb negative_phenotype_annotation.tab > negative_phenotype_annotation.ttl
