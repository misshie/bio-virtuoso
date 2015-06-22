#
# Upload Human Phenotype Ontology (HPO) to virtuoso-goloso
#
# version 0.1

# Pull base image.
FROM ruby:2

MAINTAINER MISHIMA, Hiroyuki <missy@be.to>

# Set UTF-8 locale 
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Add scripts
ADD scripts /opt/Ontologies/

RUN \
  /usr/local/bin/ruby downloader.rb && \
  /usr/local/bin/ruby comverter.rb

CMD ["/bin/bash", "-C", "uploader.sh"]
