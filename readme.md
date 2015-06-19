# The Bio-Virtuoso docker container package

# How to use

## start a docker container
```
$ sudo docker run -it -p 1111:1111 -p 8890:8890 -p 4567:4567 virtuoso-goloso 
```

## impote datasets

```bash
#!/bin/bash
url="http://localhost:4567/rdfxml"
file="rdfxml.rdf"
graph="http://misshie.jp/rdf/test-rdfxml"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     url
```

```bash
#!/bin/bash
url="http://localhost:4567/turtle"
graph="http://misshie.jp/rdf/test-turtle"
file="turtle.ttl"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     url
```

# import datassets using uploader container
```
$ sudo docker run -it bio-virtuoso-go
$ sudo docker run -it bio-virtuoso-hpo
$ sudo docker run -it bio-virtuoso-hpa
$ sudo docker run -it bio-vitruoso-omim
$ sudo docker run -it bio-virtuoso-omim-ja
```

# access virtuoso
You can access Virtuoso at <http://localhost:8890/>. The SPARQL endpoint is at <http://localhost:8890/sparql>.

# License
**Copyright**: (c) 2015; MISHIMA, Hiroyuki
hmishima at nagasaki-u.ac.jp, twitter:@mishima_eng (en_US), @mishimahryk (ja_JP)
**License**: The Mit license. See LICENSE.txt for further details.
