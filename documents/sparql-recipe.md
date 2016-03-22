# SPARQL Samples
## 1) Graph
```SQL
SELECT DISTINCT ?g
  WHERE {
    GRAPH ?g {
      ?s ?p ?o .
  }
}
```
```
g
http://www.openlinksw.com/schemas/virtrdf#
http://www.w3.org/ns/ldp#
http://localhost:8890/sparql
http://localhost:8890/DAV/
http://www.w3.org/2002/07/owl#
http://misshie.jp/rdf/omim2ja.ttl
http://purl.obolibrary.org/obo/hp.owl
http://data.monarchinitiative.org/ttl/hpoa.ttl
http://data.monarchinitiative.org/ttl/hpoa_dataset.ttl
http://data.monarchinitiative.org/ttl/omim.ttl
http://purl.obolibrary.org/obo/mp.owl
http://data.monarchinitiative.org/ttl/omim_dataset.ttl
http://data.monarchinitiative.org/ttl/orphanet_dataset.ttl
http://data.monarchinitiative.org/ttl/orphanet.ttl
```
## 2) First 5 triples in HPO
```SQL
SELECT *
WHERE {
  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
  ?s ?p ?o .
  }
}
LIMIT 5
```
```
s 	p 	o
http://www.w3.org/2000/01/rdf-schema#label 	http://www.w3.org/1999/02/22-rdf-syntax-ns#type 	http://www.w3.org/2002/07/owl#AnnotationProperty
http://www.w3.org/2000/01/rdf-schema#comment 	http://www.w3.org/1999/02/22-rdf-syntax-ns#type 	http://www.w3.org/2002/07/owl#AnnotationProperty
http://purl.obolibrary.org/obo/hp#secondary_consequence 	http://www.w3.org/1999/02/22-rdf-syntax-ns#type 	http://www.w3.org/2002/07/owl#AnnotationProperty
http://purl.obolibrary.org/obo/hp/hp-logical-definitions-subq#results_in 	http://www.w3.org/1999/02/22-rdf-syntax-ns#type 	http://www.w3.org/2002/07/owl#ObjectProperty
http://www.geneontology.org/formats/oboInOwl#date 	http://www.w3.org/1999/02/22-rdf-syntax-ns#type 	http://www.w3.org/2002/07/owl#AnnotationProperty
```

## 3) Count number of triples in a graph
```SQL
SELECT COUNT(?s)
WHERE {
  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
  ?s ?p ?o .
  }
}
```
```
callret-0
687677
```

## 4) Select all triples which have HP_0001903 (label=Anemia) as a subject.
```SQL
PREFIX hp: <http://purl.obolibrary.org/obo/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?s ?label2 ?p ?labelp2 ?o2
WHERE {

  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
    hp:HP_0001903 rdfs:label ?label .
    hp:HP_0001903 ?p ?o .
    OPTIONAL {?p rdfs:label ?labelp . }
    BIND (hp:HP_0001903 AS ?s)
    BIND (str(?label) AS ?label2)
    BIND (str(?labelp) AS ?labelp2)
    BIND (if(isLiteral(?o), str(?o), ?o) AS ?o2)
   }
 }
```
```
s 	label2 	p 	labelp2 	o2
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.geneontology.org/formats/oboInOwl#hasAlternativeId 	has_alternative_id 	"HP:0005509"
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.geneontology.org/formats/oboInOwl#hasAlternativeId 	has_alternative_id 	"HP:0001926"
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.geneontology.org/formats/oboInOwl#hasAlternativeId 	has_alternative_id 	"HP:0003136"
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.geneontology.org/formats/oboInOwl#hasDbXref 	database_cross_reference 	"UMLS:C0162119"
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.geneontology.org/formats/oboInOwl#hasDbXref 	database_cross_reference 	"MeSH:D000740"
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.geneontology.org/formats/oboInOwl#hasDbXref 	database_cross_reference 	"UMLS:C1000483"
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.geneontology.org/formats/oboInOwl#hasExactSynonym 	has_exact_synonym 	"Anaemia"
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.geneontology.org/formats/oboInOwl#hasOBONamespace 	has_obo_namespace 	"human_phenotype"
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.geneontology.org/formats/oboInOwl#hasRelatedSynonym 	has_related_synonym 	"Decreased hemoglobin"
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://purl.obolibrary.org/obo/HP_0040005 	semi_formal_definition 	"A reduction in `erythrocytes` (CL:0000232) volume or hemoglobin concentration."
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://purl.obolibrary.org/obo/IAO_0000115 	definition 	"A reduction in erythrocytes volume or hemoglobin concentration."
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.w3.org/2002/07/owl#equivalentClass 		nodeID://b142326
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.w3.org/2002/07/owl#equivalentClass 		nodeID://b19770
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.w3.org/2000/01/rdf-schema#comment 		"Anemia is not a specific entity but can result from many underlying pathologic processes. The three main causes of anemia are blood loss, decreased or faulty red blood cell production, and increased destruction of red blood cells. Various classifications are in clinical use including a classification according to the mean corpuscular volume (MCV) of the erythrocytes: microcytic, macrocytic, or normocytic. Anemias can also be classified according to variations in cell size and shape, as reflected by the red-cell distribution width (RDW). Additionally, anemias can be classified into those of inadequate production and hemolytic anemias."
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.w3.org/1999/02/22-rdf-syntax-ns#type 		http://www.w3.org/2002/07/owl#Class
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.w3.org/2000/01/rdf-schema#label 		"Anemia"
http://purl.obolibrary.org/obo/HP_0001903 	Anemia 	http://www.geneontology.org/formats/oboInOwl#id 		"HP:0001903"
http://purl.obolibrary.org/obo/HP_0001903 	0 	http://www.w3.org/2000/01/rdf-schema#subClassOf 		http://purl.obolibrary.org/obo/HP_0001877
http://purl.obolibrary.org/obo/HP_0001903 	0 	http://www.w3.org/2002/07/owl#equivalentClass 		nodeID://b81048
```

## 5) Select all subjects which are subclasses of Anemia HP_0001903 

```SQL
PREFIX hp: <http://purl.obolibrary.org/obo/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?sub ?label2
WHERE {
  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
    ?sub rdfs:subClassOf* hp:HP_0001903 .
    ?sub rdfs:label ?label .
    ?p rdfs:label ?labelp .
    BIND (str(?label) AS ?label2)
   }
 }
```
```
sub 	label2
http://purl.obolibrary.org/obo/HP_0001878 	Hemolytic anemia
http://purl.obolibrary.org/obo/HP_0001889 	Megaloblastic anemia
http://purl.obolibrary.org/obo/HP_0001890 	Autoimmune hemolytic anemia
http://purl.obolibrary.org/obo/HP_0001891 	Iron deficiency anemia
http://purl.obolibrary.org/obo/HP_0001895 	Normochromic anemia
http://purl.obolibrary.org/obo/HP_0001897 	Normocytic anemia
http://purl.obolibrary.org/obo/HP_0001903 	Anemia
http://purl.obolibrary.org/obo/HP_0001908 	Hypoplastic anemia
http://purl.obolibrary.org/obo/HP_0001924 	Sideroblastic anemia
http://purl.obolibrary.org/obo/HP_0001930 	Nonspherocytic hemolytic anemia
http://purl.obolibrary.org/obo/HP_0001931 	Hypochromic anemia
http://purl.obolibrary.org/obo/HP_0001935 	Microcytic anemia
http://purl.obolibrary.org/obo/HP_0001937 	Microangiopathic hemolytic anemia
http://purl.obolibrary.org/obo/HP_0001972 	Macrocytic anemia
http://purl.obolibrary.org/obo/HP_0003339 	Pyrimidine-responsive megaloblastic anemia
http://purl.obolibrary.org/obo/HP_0004802 	Episodic hemolytic anemia
http://purl.obolibrary.org/obo/HP_0004804 	Congenital hemolytic anemia
http://purl.obolibrary.org/obo/HP_0004810 	Congenital hypoplastic anemia
http://purl.obolibrary.org/obo/HP_0004814 	Fava bean-induced hemolytic anemia
http://purl.obolibrary.org/obo/HP_0004817 	Drug-sensitive hemolytic anemia
http://purl.obolibrary.org/obo/HP_0004819 	Normocytic hypoplastic anemia
http://purl.obolibrary.org/obo/HP_0004826 	Folate-unresponsive megaloblastic anemia
http://purl.obolibrary.org/obo/HP_0004840 	Hypochromic microcytic anemia
http://purl.obolibrary.org/obo/HP_0004844 	Coombs-positive hemolytic anemia
http://purl.obolibrary.org/obo/HP_0004851 	Folate-responsive megaloblastic anemia
http://purl.obolibrary.org/obo/HP_0004856 	Normochromic microcytic anemia
http://purl.obolibrary.org/obo/HP_0004857 	Hyperchromic macrocytic anemia
http://purl.obolibrary.org/obo/HP_0004860 	Thiamine-responsive megaloblastic anemia
http://purl.obolibrary.org/obo/HP_0004861 	Refractory macrocytic anemia
http://purl.obolibrary.org/obo/HP_0004863 	Compensated hemolytic anemia
http://purl.obolibrary.org/obo/HP_0004864 	Refractory sideroblastic anemia
http://purl.obolibrary.org/obo/HP_0004870 	Chronic hemolytic anemia
http://purl.obolibrary.org/obo/HP_0005505 	Refractory anemia
http://purl.obolibrary.org/obo/HP_0005510 	Transient erythroblastopenia
http://purl.obolibrary.org/obo/HP_0005511 	Heinz body anemia
http://purl.obolibrary.org/obo/HP_0005522 	Pyridoxine-responsive sideroblastic anemia
http://purl.obolibrary.org/obo/HP_0005524 	Macrocytic hemolytic disease
http://purl.obolibrary.org/obo/HP_0005525 	Spontaneous hemolytic crises
http://purl.obolibrary.org/obo/HP_0005532 	Macrocytic dyserythropoietic anemia
http://purl.obolibrary.org/obo/HP_0005535 	Exercise-induced hemolysis
http://purl.obolibrary.org/obo/HP_0008269 	Increased red cell hemolysis by shear stress
http://purl.obolibrary.org/obo/HP_0008346 	Increased red cell sickling tendency
http://purl.obolibrary.org/obo/HP_0010972 	Anemia of inadequate production
http://purl.obolibrary.org/obo/HP_0011895 	Anemia due to reduced life span of red cells
```

## 6) Show syndromes which are related to sub classes of Anemia using ORPHANET gene information

```SQL
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>

SELECT DISTINCT  ?phenotype ?dbid ?orphalabel
WHERE {
    GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
      ?pheno rdfs:subClassOf* obo:HP_0001903 .
      ?pheno rdfs:label ?lpheno .
      BIND (str(?lpheno) AS ?phenotype)
    }
    GRAPH <http://data.monarchinitiative.org/ttl/hpoa.ttl> {
      ?dbid obo:RO_0002200 ?pheno  .
    }
    GRAPH <http://data.monarchinitiative.org/ttl/orphanet.ttl> { 
      ?node obo:RO_0002200 ?dbid .
      ?node rdfs:label ?orphalabel  .
    }
}
```
```
phenotype 	dbid 	orphalabel
Anemia 	http://www.orpha.net/ORDO/Orphanet_1775 	"some variant of NHP2 that is a disease-causing germline mutation(s) in Dyskeratosis congenita"
Anemia 	http://www.orpha.net/ORDO/Orphanet_221016 	"some variant of RECQL4 that is a disease-causing germline mutation(s) in Rothmund-Thomson syndrome type 2"
Anemia 	http://www.orpha.net/ORDO/Orphanet_667 	"some variant of SNX10 that is a disease-causing germline mutation(s) in Autosomal recessive malignant osteopetrosis"
Microcytic anemia 	http://www.orpha.net/ORDO/Orphanet_79278 	"some variant of ALAS2 that is a disease-causing germline mutation(s) (gain of function) in Erythropoietic protoporphyria"
Anemia 	http://www.orpha.net/ORDO/Orphanet_201 	"some variant of SDHC that is a disease-causing germline mutation(s) in Cowden syndrome"
Anemia 	http://www.orpha.net/ORDO/Orphanet_3322 	"some variant of DKC1 that is a disease-causing germline mutation(s) in Hoyeraal-Hreidarsson syndrome"
Macrocytic anemia 	http://www.orpha.net/ORDO/Orphanet_124 	"some variant of RPS24 that is a disease-causing germline mutation(s) in Blackfan-Diamond anemia"
Anemia 	http://www.orpha.net/ORDO/Orphanet_2908 	"some variant of FERMT1 that is a disease-causing germline mutation(s) (loss of function) in Kindler syndrome"
Anemia 	http://www.orpha.net/ORDO/Orphanet_144 	"some variant of MSH6 that is a disease-causing germline mutation(s) in Hereditary nonpolyposis colon cancer"
Anemia 	http://www.orpha.net/ORDO/Orphanet_2785 	"some variant of CA2 that is a disease-causing germline mutation(s) in Osteopetrosis with renal tubular acidosis"
```



-----







# グラフ情報
## どのようなグラフがあるか？
### クエリ
```SQL
SELECT DISTINCT ?g
  WHERE {
    GRAPH ?g {
      ?s ?p ?o .
  }
}
```
### 結果
```
g
http://www.openlinksw.com/schemas/virtrdf#
http://www.w3.org/ns/ldp#
http://localhost:8890/sparql
http://localhost:8890/DAV/
http://www.w3.org/2002/07/owl#
http://misshie.jp/rdf/omim2ja.ttl
http://purl.obolibrary.org/obo/hp.owl
http://data.monarchinitiative.org/ttl/hpoa.ttl
http://data.monarchinitiative.org/ttl/hpoa_dataset.ttl
http://data.monarchinitiative.org/ttl/omim.ttl
http://purl.obolibrary.org/obo/mp.owl
http://data.monarchinitiative.org/ttl/omim_dataset.ttl
http://data.monarchinitiative.org/ttl/orphanet_dataset.ttl
http://data.monarchinitiative.org/ttl/orphanet.ttl
```

![](https://image.docbase.io/uploads/78b7a9e8-bb1d-4b9b-9005-95a9f69a1999.png)

# HPO
##  HPO first 5 triples
### query
```
SELECT *
WHERE {
  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
  ?s ?p ?o .
  }
}
LIMIT 5

```

##  Count number of triples in a graph
### query
```
SELECT COUNT(?s)
WHERE {
  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
  ?s ?p ?o .
  }
}

```

```
PREFIX hp: <http://purl.obolibrary.org/obo/>

SELECT *
WHERE {
  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
    hp:HP_0000739 ?p ?o .
    }
}
```

## Select all triples which have HP_0000175 (label=Cleft Plalate) as a subject. 
```
PREFIX hp: <http://purl.obolibrary.org/obo/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?s ?label2 ?p ?o
WHERE {

  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
    hp:HP_0000175 rdfs:label ?label .
    hp:HP_0000175 ?p ?o .
   }
  BIND (hp:HP_0000175 AS ?s)
  BIND (str(?label) AS ?label2
 }
```

## Select all triples which have HP_0000175 (label=Cleft Plalate) as a subject. Show labels for predicates.
```
PREFIX hp: <http://purl.obolibrary.org/obo/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?s ?label2 ?p ?labelp2 ?o
WHERE {

  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
    hp:HP_0000175 rdfs:label ?label .
    hp:HP_0000175 ?p ?o .
    OPTIONAL {?p rdfs:label ?labelp . }
   }
  BIND (hp:HP_0000175 AS ?s)
  BIND (str(?label) AS ?label2)
  BIND (str(?labelp) AS ?labelp2)
 }
```

```
PREFIX hp: <http://purl.obolibrary.org/obo/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?s ?label2 ?p ?labelp2 ?o2
WHERE {
  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
    hp:HP_0000175 ?p ?o .
    hp:HP_0000175 rdfs:label ?label .
    OPTIONAL {?p rdfs:label ?labelp . }
   }
  BIND (hp:HP_0000175 AS ?s)
  BIND (str(?label) AS ?label2)
  BIND (str(?labelp) AS ?labelp2)
  BIND (IF (isLiteral(?o), str(?o), ?o) AS ?o2)
 }
```



## Find all triples in sub-claases of HP_0000175 <<<<<<<<<<<<

```
PREFIX hp: <http://purl.obolibrary.org/obo/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?sub ?phenotype
WHERE {
  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
   ?sub rdfs:subClassOf* hp:HP_0000175 .
   ?sub rdfs:label ?labels .
   BIND (str(?labels) AS ?phenotype)
 }
}
```

## 
```
PREFIX hp: <http://purl.obolibrary.org/obo/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?sub str(?labels)
WHERE {
  GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
   hp:HP_0000175 rdfs:subClassOf ?super .
   ?sub rdfs:subClassOf* ?super .
   ?sub rdfs:label ?labels .
 }
}
```

#HPO Annotation
## Show all properties
```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
SELECT DISTINCT ?p
WHERE {
  GRAPH <http://data.monarchinitiative.org/ttl/hpoa.ttl> {
  ?s ?p ?o .
  }
}
```
![](https://image.docbase.io/uploads/87f5dbc9-de4d-46ae-8a69-bddd5470c38d.png)
## Metadata of HPO annotation
```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
SELECT DISTINCT ?p
WHERE {
  GRAPH <http://data.monarchinitiative.org/ttl/hpoa_dataset.ttl> {
  ?s ?p ?o .
  }
}
```

## HPO to OMIM
```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>

SELECT *
WHERE {
  GRAPH <http://data.monarchinitiative.org/ttl/hpoa.ttl> {
  ?omim <http://purl.obolibrary.org/obo/GENO_0000208> ?hpo .
  }
}
LIMIT 50
```

```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX hp: <http://purl.obolibrary.org/obo/>

SELECT *
WHERE {
  GRAPH <http://data.monarchinitiative.org/ttl/hpoa.ttl> {
    hp:HP_0000175 ?p ?o .
  }
}
```

### Show main properties
```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>

SELECT *
WHERE {
    GRAPH <http://data.monarchinitiative.org/ttl/hpoa.ttl> { 
      {?s obo:GENO_0000208 ?o1 .}
      UNION
      {?s obo:RO_0002200 ?o2 .}
      UNION
      {?s obo:RO_0002558 ?o3 .}
    }
}
LIMIT 10000
```

* GENO_0000208 = inheritance model ???
* RO_0002200 = has_phenotype
* RO_0002558 = has_evidence


### Show syndromes which have cleft palates HP_0000175 (search only OMIM)
```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>

SELECT DISTINCT ?s ?label
WHERE {
    GRAPH <http://data.monarchinitiative.org/ttl/hpoa.ttl> {
      ?pheno rdfs:subClassOf* obo:HP_0000175 .
      ?s obo:RO_0002200 ?pheno  .
    }
    GRAPH <http://data.monarchinitiative.org/ttl/omim.ttl> { 
      ?s rdfs:label ?label .
    }
}
```

### Show syndromes which are related to sub classes of "congenital heart defects HP_0002564"


```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>

SELECT DISTINCT str(?lpheno) ?s ?slabel 
WHERE {
    GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
      ?pheno rdfs:subClassOf* obo:HP_0002564 .
      ?pheno rdfs:label ?lpheno .
    }
    GRAPH <http://data.monarchinitiative.org/ttl/hpoa.ttl> {
      ?s obo:RO_0002200 ?pheno  .
    }
    GRAPH <http://data.monarchinitiative.org/ttl/omim.ttl> { 
      ?s rdfs:label ?slabel .
    }
}
```

### Show syndromes which are related to sub classes of "congenital heart defects HP_0002564" using ORPHANET gene information


```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>

SELECT DISTINCT  ?phenotype ?dbid ?orphalabel
WHERE {
    GRAPH <http://purl.obolibrary.org/obo/hp.owl> {
      ?pheno rdfs:subClassOf* obo:HP_0002564 .
      ?pheno rdfs:label ?lpheno .
      BIND (str(?lpheno) AS ?phenotype)
    }
    GRAPH <http://data.monarchinitiative.org/ttl/hpoa.ttl> {
      ?dbid obo:RO_0002200 ?pheno  .
    }
    GRAPH <http://data.monarchinitiative.org/ttl/orphanet.ttl> { 
      ?node obo:RO_0002200 ?dbid .
      ?node rdfs:label ?orphalabel  .
    }
}
```

```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>

SELECT DISTINCT str(?lpheno) ?orphalabel
WHERE {
    GRAPH <http://data.monarchinitiative.org/ttl/orphanet.ttl> { 
      ?node obo:GENO_0000408 ?orphaid .
    }
}
```


###check OMIM entories: Sotos Syndrome OMIM_117550
```
PREFIX obo: <http://purl.obolibrary.org/obo/>

SELECT DISTINCT ?p
WHERE {
    GRAPH <http://data.monarchinitiative.org/ttl/omim.ttl> { 
      ?s ?p obo:OMIM_117550 .
    }
}
http://www.monarchinitiative.org/MONARCH_862c31841b0b2d4721832d801ff31ad6
```