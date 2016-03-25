#
# Upload OMIM's official non-redistoributable tables to virtuoso-goloso
# copyright (c) 2015-2016, MISHIMA, Hiroyuki
# license: the MIT license
# version 0.1

# Pull base image.
FROM misshie/ubuntu-ruby:14.04-2.2.2

MAINTAINER MISHIMA, Hiroyuki <missy@be.to>

# Run downloder script
ADD scripts /opt/bio-virtuoso/omim-omimorg
WORKDIR /opt/bio-virtuoso/omim-omimorg
CMD ["/bin/bash", "-C", "uploader.sh"]
