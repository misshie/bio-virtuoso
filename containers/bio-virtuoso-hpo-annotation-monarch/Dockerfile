#
# Upload Human Phenotype Ontology (HPO) annotation created by Monarch Initiatives to virtuoso-goloso
# copyright (c) 2015, MISHIMA, Hiroyuki
# license: the MIT license
# version 0.1
#
# copyright (c) 2015, MISHIMA, Hiroyuki
# license: the MIT license

# Pull base image.
FROM misshie/ubuntu-ruby:14.04-2.2.2

MAINTAINER MISHIMA, Hiroyuki <missy@be.to>

# Run downloder script
ADD scripts /opt/bio-virtuoso/hpo/
WORKDIR /opt/bio-virtuoso/hpo/
RUN ./downloader.sh
CMD ["/bin/bash", "-C", "uploader.sh"]
