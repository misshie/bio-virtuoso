#
# Upload Annotations for Human Phenotype Ontology (HPO Annotation) to virtuoso-goloso
#
# version 0.1
#
# copyright (c) 2015, MISHIMA, Hiroyuki
# license: the MIT license

# Pull base image.
FROM misshie/ubuntu-ruby:14.04-2.2.2

MAINTAINER MISHIMA, Hiroyuki <missy@be.to>

# Run downloder script
ADD scripts /opt/bio-virtuoso/hpo-annotation/
WORKDIR /opt/bio-virtuoso/hpo-annotation
RUN ./downloader.sh
RUN ./converter.sh

CMD ["/bin/bash", "-C", "uploader.sh"]
