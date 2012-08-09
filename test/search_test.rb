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
  
  def test_text
    article = ActiveTriple.location('London').first
    search = ActiveTriple.title(article['title'])
    assert_equal(1, search.length)
    assert_equal(article, search.first)
  end
  
  def test_where
    title = ActiveTriple.location('London').first['title']
    assert_equal(ActiveTriple.title(title).first, ActiveTriple.where('dc:terms:title' => "text:en:\"#{title}\"").first)
  end
  
end
