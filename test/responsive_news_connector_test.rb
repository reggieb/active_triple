$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'active_triple'

class ActiveTriple
  module Connectors
    
    class ResponsiveNewsConnectorTest < Test::Unit::TestCase
      def setup
        @connection = ResponsiveNewsConnector.new
        @target_path = 'http://juicer.responsivenews.co.uk/api/articles.json'
      end
      
      def test_path
        assert_equal(@target_path, @connection.path)
      end
      
      def test_url_variables
        @connection.set_url_variables(:binding => 'test', :limit => 8)
        assert_equal('?binding=test&limit=8', @connection.url_variables)
      end
      
      def test_url_variable_without_limit
        @connection.set_url_variables(:binding => 'test')
        assert_equal('?binding=test&limit=10', @connection.url_variables)
      end
      
      def test_send_by_post
        triples = ActiveTriple.location('London').triples
        binding = ActiveTriple.binding_id
        limit = 8
        connection = (
          ResponsiveNewsConnector.send_data(
            :binding => binding,
            :limit => limit,
            :triples => triples           
          )
        )
        expected_url = "#{@target_path}?binding=#{binding}&limit=#{limit}"
        assert_equal(expected_url, connection.url)
        assert_equal(triples, connection.triples)
        assert(connection.response.kind_of?(Array), "Response should be an array")
      end
      
    end
    
  end
end
