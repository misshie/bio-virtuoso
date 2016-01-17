# The Bio-Virtuoso docker container package

## virtuoso-goloso
#### Purpose
Docker containers for easy deployment of the Virtuoso database engine with preloaded multiple biodatabases expressed by RDF.

The virtuoso-gloso container runs a instance of Virtuoso. Sinatra receives Turtle, RDF/XML, or OWL files via the HTTP POST method and put them into Virtuoso speedy using the isql command.

Dataset feeding containers download data from sources, if necessary, convert them into RDF, and send them to virtuoso-gloso. You can combine multiple feeding containers.

#### Clone Bio-Virtuoso
To use sample shell scripts, run 
```bash
$ git clone git://github.com/misshie/bio-virtuoso.git
$ cd bio-virtuoso
```

#### Start a docker container
The misshie/virtuoso-goloso container is stored in DockerHub at https://hub.docker.com/r/misshie/virtuoso-goloso/ .

A sample script to invoke virtuoso-goloso is the following. See also `sudo ./start-virtuoso-goloso.sh` or `sudo ./start-virtuoso-goloso-largemem.sh`.

```
#!/bin/bash
docker stop virtuoso-goloso
docker rm virtuoso-goloso
docker run \
    -i -t \
    -p 1111:1111 \
    -p 8890:8890 \
    -p 4567:4567 \
    --name virtuoso-goloso \
    -e MaxQueryExecutionTime="21600" \
    -e NumberOfBuffers="85000" \
    -e MaxDirtyBuffers="65000" \
    -e SQL_PREFETCH_ROWS="10000" \
    -e SQL_PREFETCH_BYTES="160000" \
    misshie/virtuoso-goloso
```
Virtuoso-goloso supports the following environmental viriables given with the '-e' option:

|environment variable      |default value|comment|
|:-------------------------|:------------|:------------|
|MaxQueryCostEstimationTime|undefined    ||
|MaxQueryExecutionTime     |21600        |6hrs|
|NumberOfBuffers           |85000        |4000000 is good for 48Gb RAM machines|
|MaxDirtyBuffers           |65000        |3000000 is good for 48Gb RAM machines|
|SQL_PREFETCH_ROWS         |10000        ||
|SQL_PREFETCH_BYTES        |160000       ||

## Dataset-feeding docker containers
### Build a container
You have to build dataset-feeding containers to ensure the dataset is up-to-date. This step does not download any datasets.
Run `sudo ./containers/<FEEDING_CONTAINER>/build.sh`. The following is an example for building the bio-birtuoso-hpo container.

```bash
$ cd containers/bio-virtuoso-hpo
$ sudo docker build -t misshie/bio-virtuoso-hpo .
```
### Run a dataset-feeding container
Run `sudo ./containers/<FEEDING_CONTAINER>/feed.sh`. To feed bigger datasets, larger RAM and bigger, larger NumerOfBuffers, or larger MaxDirtyBuffers may be required. Duration to download datasets and convert to RDF may vary. Downloading and The following is a commandline to run the bio-virtuoso-hpo dataset-feeding container:
```bash
$ sudo docker run -it --link virtuoso-goloso:virtuoso-goloso misshie/bio-virtuoso-hpo
```

These containers exits after uploading datasets to virtuoso-goloso. If you want to check downloaded dataset, try `sudo docker run -it misshie/bio-virtuoso-hpo /bin/bash` and seel files under `/opt/bio-virtuoso`.

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
|omim-gendoo-ja          |http://misshie.jp/rdf/omim2ja.ttl                          |Gendoo's ja_JP translation of OMIM entries. See also http://gendoo.dbcls.jp developped by Takeru Nakazato|
|mp-jax                  |http://purl.obolibrary.org/obo/mp.owl                      |Mammalian Phenotype ontology (MP) of Jax    |

## Access the SPARQL endpoint
You can access Virtuoso at <http://localhost:8890/>. The SPARQL endpoint is at <http://localhost:8890/sparql>. You may need to open port 8890  to allow accessing the SPARQL endpoint from the Internet. For instance, you have to run `sudo ufw allow 8890/tcp` on Ubuntu 14.04 LTS.

### Simple SPARQL sample
#### Show graphs fed by dataset-feeding containers
```
SELECT DISTINCT ?g WHERE {GRAPH ?g {?s ?p ?o}}
```

### Accessing the SPARQL endpoint from the command-line
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

### Inside data-feeding containerHow to feed datasets
Dataset feeding containers use the following ways to feed RDF files to virtuoso-goloso

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
**Copyright**: (c) 2015-2016; MISHIMA, Hiroyuki

hmishima at nagasaki-u.ac.jp, twitter:@mishima_eng (en_US), @mishimahryk (ja_JP)

**License**: The Mit license. See LICENSE.txt for further details.
