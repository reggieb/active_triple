require_relative 'active_triple/search'
require 'typhoeus'
require 'json'
require 'triple_parser'
require 'hashie'

class ActiveTriple
  def initialize
    
  end
  
  def method_missing(m, *args, &block)
    if Search.respond_to?(m)
      statements = Search.send(m, *args)
      add_triple(statements) 
    elsif Array.new.respond_to?(m)
      get_data.send(m, *args, &block)
    else  
      super
    end
  end
  
  def self.method_missing(m, *args)
    if Search.respond_to?(m) || m.to_sym == :limit
      active_triple = new
      active_triple.send(m, *args)
    else
      super
    end
  end
  
 
  def add_triple(statement)
    @triples ||= Array.new
    @triples << statement
    @triples.flatten!
    return self
  end

  def triples
    TripleParser.to_rdf(@triples).join("\n")
  end
  
  def self.binding_id
    "output"
  end
  
  def self.binding_variable
    "?#{binding_id}"
  end
  
  def limit(number_of_items)
    @number_of_items = number_of_items
    return self
  end
  
  def number_of_items
    @number_of_items || '10'
  end
  
  def all
    get_data
  end
  
  def get_data
    resp = by_post
    begin
      json = JSON.parse(resp.body)
      results = json.first[1]
      results.collect!{|a| Hashie::Mash.new(a)}
      return results
    rescue JSON::ParserError => e
      if /No stories found for query/ =~ e.message
        return Array.new
      else
        raise e
      end
    end
  end
  
  def by_post
    Typhoeus::Request.post(post_url, {
      :headers => { 'Content-Type' => 'text/plain' },
      :body    => triples
    })
  end
  
  
  def post_url
    "http://juicer.responsivenews.co.uk/api/articles.json?binding=#{self.class.binding_id}&limit=#{number_of_items}"
  end  
end
