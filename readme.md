# The Bio-Virtuoso docker container package

## virtuoso-goloso
#### Purpose
Docker containers for easy deployment of the Virtuoso database engine with preloaded multiple biodatabases expressed by RDF.

The virtuoso-gloso container runs a instance of Virtuoso. Sinatra receives Turtle, RDF/XML, or OWL files via the HTTP POST method and put them into Virtuoso speedy using the isql command.

Dataset feeding containers download data from sources, if necessary, convert them into RDF, and send them to virtuoso-gloso. You can combine multiple feeding containers.

#### Start a docker container
The misshie/virtuoso-goloso container is stored in DockerHub at https://hub.docker.com/r/misshie/virtuoso-goloso/ .

```
$ sudo docker run -it -p 1111:1111 -p 8890:8890 -p 4567:4567 --name virtuoso-goloso misshie/virtuoso-goloso 
```

If you have much RAM in your machine, try misshie/virtuoso-goloso-48g

## Dataset-feeding docker containers
You have to build dataset-feeding containers to ensure the dataset is up-to-date.

```
$ git clone git://github.com/misshie/bio-virtuoso.git
$ cd bio-virtuoso/containers/bio-virtuoso-hpo
$ sudo docker build -t misshie/bio-virtuso-hpo .
```

A commandline to run a dataset-feeding container:

```
$ sudo docker run -it --link virtuoso-goloso:virtuoso-goloso misshie/bio-virtuoso-hpo
```

These containers exits after uploading datasets to virtuoso-goloso. If you want to see downloaded dataset, try `sudo docker run -it misshie/bio-virtuoso-hpo /bin/bash` and check files under `/opt/bio-virtuoso`.

#### list of dataset feeding containers (misshie/bio-virtuoso-*)

|container               |graph URL|description|
|:-----------------------|:----------------------------------------------------------|:-------------------------------------------|
|hpo                     |http://purl.obolibrary.org/obo/hp.owl                      |Human Phenotype Ontology (HPO)              |
|hpo-annotation-monarch  |http://data.monarchinitiative.org/ttl/hpoa.ttl             |HPO annotations RDFied by Monarch Initiative |
|                        |http://data.monarchinitiative.org/ttl/hpoa_dataset.ttl     |HPO annotations dataset description          |
|omim-monarch            |http://data.monarchinitiative.org/ttl/omim.ttl             |OMIM data RDFied by Monarch Initiative           |
|                        |http://data.monarchinitiative.org/ttl/omim_dataset.ttl     |OMIM dataset description                    |
|orphanet-monarch        |http://data.monarchinitiative.org/ttl/orphanet.ttl         |Orphanet data RDFied by Monarch Initiative       |
|                        |http://data.monarchinitiative.org/ttl/orphanet_dataset.ttl |Orphanet dataset description                |
|hgnc-monarch            |http://data.monarchinitiative.org/ttl/hgnc.ttl             |Human Genome Nomenclature Comittee (HGNC) data RDFied by Monarch Initiative       |
|                        |http://data.monarchinitiative.org/ttl/hgnc_dataset.ttl     |HGNC dataset description                    |
|go                      |http://purl.obolibrary.org/obo/go.owl                      |Gene Ontology (GO)                          |
|omim-gendoo-ja          |http://misshie.jp/rdf/omim2ja.ttl                          |Gendoo's ja_JP translation of OMIM entries  |

## access virtuoso
You can access Virtuoso at <http://localhost:8890/>. The SPARQL endpoint is at <http://localhost:8890/sparql>.

Accessing the SPARQL endpoint from command-line:
```bash
#!/bin/bash
url="http://localhost:8890/sparql"
format="text/tab-separated-values"
#format="text/turtle"

query=`cat <<EOF
SELECT DISTINCT ?property
FROM <http://purl.obolibrary.org/obo/hp.owl> 
WHERE { ?s ?property ?o . }
LIMIT 20
EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
```

## How to feed datasets
Dataset feeding containers use the following way to feed RDF files to virtuoso-goloso

For RDF/XML files:
```bash
#!/bin/bash
url="http://localhost:4567/rdfxml"
file="rdfxml.rdf"
graph="http://misshie.jp/rdf/test-rdfxml"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
```
For Turtle/N3 files:
```bash
#!/bin/bash
url="http://localhost:4567/turtle"
graph="http://misshie.jp/rdf/test-turtle"
file="turtle.ttl"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
```

For N-Quad files:
```bash
#!/bin/bash
url="http://localhost:4567/n-quad"
file="N-Quad.nq"
curl \
     -X POST \
     -F file=@${file} \
     ${url}
```

## License
**Copyright**: (c) 2015; MISHIMA, Hiroyuki

hmishima at nagasaki-u.ac.jp, twitter:@mishima_eng (en_US), @mishimahryk (ja_JP)

**License**: The Mit license. See LICENSE.txt for further details.
