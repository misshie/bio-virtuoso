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
FROM dockerfile/ubuntu

MAINTAINER MISHIMA, Hiroyuki <missy@be.to>

# Set UTF-8 locale 
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install APT packages.
RUN apt-get update && \
    apt-get install -y automake gperf libtool flex bison libssl-dev \
    build-essential \
    curl \
    git-core \
    libcurl4-openssl-dev \
    libreadline-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    zlib1g-dev \
    nkf && \
    rm -rf /var/lib/apt/lists/*

# Install ruby-2.2.2
# based on http://qiita.com/k-shogo/items/592e243f9763d0c3b10a
RUN \
    curl -O http://ftp.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz && \
    tar -zxvf ruby-2.2.2.tar.gz && \
    cd ruby-2.2.2 && \
    ./configure --disable-install-doc && \
    make && \
    make install && \
    cd .. && \
    rm -r ruby-2.2.2 ruby-2.2.2.tar.gz && \
    echo 'gem: --no-document' > /usr/local/etc/gemrc && \
    gem install sinatra && \
    gem install thin && \
    gem install haml

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

CMD ["/usr/local/bin/ruby", "/opt/virtuoso-goloso/app_root/app.rb"]
