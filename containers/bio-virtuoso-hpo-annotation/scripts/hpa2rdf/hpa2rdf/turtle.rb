require 'securerandom'

module Hpa2rdf

  # This class is based on an achievement of the 1st RDF Summit in 2014: 
  # https://github.com/dbcls/rdfsummit/blob/master/insdc2ttl/insdc2ttl.rb
  class Turtle    

    def self.default_prefix 
      [
       triple("@prefix", "rdf:", "<http://www.w3.org/1999/02/22-rdf-syntax-ns#>"),
       triple("@prefix", "rdfs:", "<http://www.w3.org/2000/01/rdf-schema#>"),
       triple("@prefix", "obo:", "<http://purl.obolibrary.org/obo/>"),
       #triple("@prefix", "dcterms:", "<http://purl.org/dc/terms/>"),
       #triple("@prefix", "xsd:", "<http://www.w3.org/2001/XMLSchema#>"),
       #triple("@prefix", "skos:", "<http://www.w3.org/2004/02/skos/core#>"),
       #triple("@prefix", "sio:", "<http://semanticscience.org/resource/>"),
       #triple("@prefix", "so:", "<http://purl.org/obo/owl/SO#>"),
       #triple("@prefix", "faldo:", "<http://biohackathon.org/resource/faldo#>"),
       triple("@prefix", "hpa:", "<http://misshie.jp/rdf/>"),
      ]
    end

    def self.property_definitions
      [
       triple("hpa:db",            "rdfs:label", '"databse name like OMIM,OHPHANET,DECIPER.."'),
       triple("hpa:db_object_id",  "rdfs:label", '"id within the db"',),
       triple("hpa:db_name",       "rdfs:label", '"entry name within the db"',),
       triple("hpa:qualifier",     "rdfs:label", '"HPO-annotation qualifier"',),
       triple("hpa:hpo_id",        "rdfs:label", '"HPO ID like HP:9999999"',),
       triple("hpa:db_reference",  "rdfs:label", '"DB ID like OMIM:9999999"',),
       triple("hpa:evidence_code", "rdfs:label", '"evidence code"',),
       triple("hpa:onset",         "rdfs:label", '"optional HPO-annotation onset"',),
       triple("hpa:frequency",     "rdfs:label", '"optional HPO-annotation frequenct"',),
       triple("hpa:with",          "rdfs:label", '"optional HPO-annotation with"',),
       triple("hpa:aspect",        "rdfs:label", '"HPO annotation aspect"',),
       triple("hpa:synomym",       "rdfs:label", '"optional HPO annot synonym"',),
       triple("hpa:date",          "rdfs:label", '"HPO-annotation data"',),
       triple("hpa:assigned_by",   "rdfs:label", '"HPO-annotation assignment"',),
      ]
    end                         

    def self.triple(s, p, o)
      [s, p, o].join("\t") + ' .'
    end

    def self.puts_triple(s, p, o)
      unless [s, p, o].any?{|x| x.empty?}
        puts self.triple(s, p, o)
      end
    end

    def self.puts_triple_q(s, p, o, lang="")
      unless [s, p, o].any?{|x| x.empty?}
        qo = '"' + o.gsub(/\A\"|\"\z/,'').gsub(/\"/, '\"') + '"'          
        self.puts_triple(s, p, "#{qo}#{lang}")      
      end
    end

    def self.new_uuid
      "<urn:uuid:#{SecureRandom.uuid}>"
    end

  end # class
  
end # module
