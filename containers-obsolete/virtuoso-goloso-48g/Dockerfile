#
# dockerfile:virtuoso-goloso
# the Virtuoso database engine 
# with a web server importing data using the isql command
#
# This Dockerfile is based on inutano/virtioso 
# MAINTAINER Tazro Inutano Ohta, inutano@gmail.com
#
# copyright (c) 2015, MISHIMA, Hiroyuki
# license: the MIT license

# Pull base image.
FROM misshie/ubuntu-ruby:14.04-2.2.2

MAINTAINER MISHIMA, Hiroyuki <missy@be.to>

# Install virtuoso
ENV VIRTUOSO_VERSION develop/7
RUN \
  cd /tmp && \
  git clone https://github.com/openlink/virtuoso-opensource.git && \
  cd virtuoso-opensource && \
  git checkout $VIRTUOSO_VERSION && \
  ./autogen.sh && \
  export CFLAGS="-O2 -m64" && \
  ./configure && \
  make && \
  make install && \
  rm -fr /tmp/virtuoso-opensource

# Expose ports.
#   - 8890: HTTP of Virtuoso
#   - 4567: HTTP of Sinatra/Thin
#   - 1111: isql of Virtuoso
EXPOSE 8890
EXPOSE 4567
EXPOSE 1111

# Start Virtuoso to import downloaded and converted data
ADD app_root /opt/virtuoso-goloso/app_root

CMD ["thin", "-C", "/opt/virtuoso-goloso/app_root/thin.yml", "-R", "/opt/virtuoso-goloso/app_root/config.ru", "start"]
