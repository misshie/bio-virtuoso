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
