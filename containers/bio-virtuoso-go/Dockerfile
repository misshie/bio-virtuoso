#
# Upload Gene Ontology (GO) to virtuoso-goloso
# version 0.1
#
# copyright (c) 2015, MISHIMA, Hiroyuki
# license: the MIT license

# Pull base image.
FROM ruby:2

MAINTAINER MISHIMA, Hiroyuki <missy@be.to>

# Set UTF-8 locale 
RUN apt-get update && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Run downloder script
ADD scripts /opt/bio-virtuoso/go/
WORKDIR /opt/bio-virtuoso/go/
RUN ./downloader.sh
CMD ["/bin/bash", "-C", "uploader.sh"]
