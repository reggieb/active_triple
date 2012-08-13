# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'active_triple'

class SearchTest < Test::Unit::TestCase
  
  def test_location_returns_articles_with_places_including_location
    article = ActiveTriple.location('Birmingham').first
    assert_near_birmingam(article)
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
  
  def test_about
    assert(!ActiveTriple.about('United_Kingdom').empty?)
    assert_equal(ActiveTriple.about('United_Kingdom').all, ActiveTriple.about('United Kingdom').all)
  end
  
  def test_mentions
    assert(!ActiveTriple.mentions('United_Kingdom').empty?)
    assert_equal(ActiveTriple.mentions('United_Kingdom').all, ActiveTriple.mentions('United Kingdom').all)
    assert_not_equal(ActiveTriple.about('United_Kingdom').all, ActiveTriple.mentions('United Kingdom').all)
  end  
  
  def assert_near_birmingam(article)
    brum_box = {:N => 52.53, :E => -1.82, :S => 52.44, :W => -1.97}
    places = article.places.select do |p| 
      p.longitude.to_f < brum_box[:E].to_f &&
      p.latitude.to_f < brum_box[:N].to_f &&
      p.latitude.to_f > brum_box[:S].to_f &&
      p.longitude.to_f > brum_box[:W].to_f
    end
    assert(places.length > 0, "Location should be inside the brum box")
  end
  
end
