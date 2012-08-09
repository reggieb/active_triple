
class ActiveTriple
  module Search
    
    # At the moment, I think this is the only search method that is working.
    def self.location(place_name, radius = '5mi')
      statements = [
        %Q{<http://dbpedia.org/resource/#{place_name}> geo-pos:lat ?Latitude .},
        %Q{<http://dbpedia.org/resource/#{place_name}> geo-pos:long ?Longitude .},
        %Q{?location omgeo:nearby(?Latitude ?Longitude "#{radius}") .},
        %Q{#{ActiveTriple.binding_variable} <http://data.press.net/ontology/tag/about> ?location .}
      ]
    end
    
    def self.about(text)
      %Q{#{ActiveTriple.binding_variable} <http://data.press.net/ontology/tag/about> <http://dbpedia.org/resource/#{text}> .}
    end
    
    def self.mentions(text)
      %Q{#{ActiveTriple.binding_variable} <http://data.press.net/ontology/tag/mentions> <http://dbpedia.org/resource/#{text}> .}
    end
    
    def self.subject(text)
      %Q{#{ActiveTriple.binding_variable} <http://purl.org/dc/terms/subject> <http://dbpedia.org/resource/#{text}> .}
    end
    
    def self.title(text)
      %Q{#{ActiveTriple.binding_variable} <http://purl.org/dc/terms/title> "#{text}@en" .}
    end    
  end
end
