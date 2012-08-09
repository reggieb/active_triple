# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'active_triple'

class SearchTest < Test::Unit::TestCase
  
  def test_location_returns_articles_with_places_including_location
    article = ActiveTriple.location('Birmingham').first
    assert(article['places'].select{|p| p['name'] == 'Birmingham'}.length > 0)
  end
  
end
