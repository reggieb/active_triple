class ActiveTriple
  module Search
    
    # At the moment, I think this is the only search method that is working.
    def self.location(place_name, radius = '8km')
      [
        %Q{resource:#{place_name} geo-pos:lat ?Latitude .},
        %Q{resource:#{place_name} geo-pos:long ?Longitude .},
        %Q{?location omgeo:nearby(?Latitude ?Longitude "#{radius}") .},
        %Q{#{ActiveTriple.binding_variable} ontology:about ?location .}
      ]
    end
    
    def self.about(text)
      %Q{#{ActiveTriple.binding_variable} ontology:about resource:#{underscore_spaces(text)} .}
    end
    
    def self.mentions(text)
      %Q{#{ActiveTriple.binding_variable} ontology:mentions resource:#{underscore_spaces(text)} .}
    end
    
    def self.subject(text)
      %Q{#{ActiveTriple.binding_variable} dc:terms:subject resource:#{text} .}
    end
    
    # ActiveTriple.where('dc:terms:subject' => 'resource:London') is equivalent to ActiveTriple.subject('London')
    def self.where(hash)
      statements = Array.new
      hash.each{|predicate, object| statements << %Q{#{ActiveTriple.binding_variable} #{predicate} #{object} .}}
      return statements
    end
    
    def self.title(text)
      %Q{#{ActiveTriple.binding_variable} dc:terms:title text:en:"#{text}" .}
    end  
    
    def self.underscore_spaces(text)
      text.gsub(/\s+/, "_")
    end
  end
end
