#
# Upload Human Phenotype Ontology (HPO) to virtuoso-goloso
#
# version 0.1

# Pull base image.
FROM ruby:2

MAINTAINER MISHIMA, Hiroyuki <missy@be.to>

# Set UTF-8 locale 
RUN apt-get update && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Run downloder script
ADD scripts /opt/bio-virtuoso/hpo/
WORKDIR /opt/bio-virtuoso/hpo/
RUN ./downloader.sh
RUN ./converter.sh
CMD ["/bin/bash", "-C", "uploader.sh"]
