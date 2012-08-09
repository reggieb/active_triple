# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'active_triple'

class ActiveTripleTest < Test::Unit::TestCase
  def test_limit
    assert_not_equal(1, ActiveTriple.location('London').length)
    assert_equal(1, ActiveTriple.location('London').limit(1).length)
    assert_equal(1, ActiveTriple.limit(1).location('London').length)
  end
end
