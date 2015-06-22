#
# Upload Human Phenotype Ontology (HPO) to virtuoso-goloso
#
# version 0.1

# Pull base image.
FROM ruby:2

MAINTAINER MISHIMA, Hiroyuki <missy@be.to>

# Run downloder script
ADD scripts /opt/bio-virtuoso/hpo/
WORKDIR /opt/bio-virtuoso/hpo/
RUN ./downloader.sh

CMD ["/bin/bash", "-C", "uploader.sh"]
