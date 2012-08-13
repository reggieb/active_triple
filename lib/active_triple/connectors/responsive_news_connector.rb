require_relative 'triple_store_connector'
require 'typhoeus'
require 'hashie'

class ActiveTriple
  module Connectors
    class ResponsiveNewsConnector < TripleStoreConnector
      def path
        @path = 'http://juicer.responsivenews.co.uk/api/articles.json'  
      end
      
      def self.send_data(args)
        connector = new
        connector.send_by_post(args)
        return connector
      end
      
      def send_by_post(args)
        @triples = args.delete(:triples)
        set_url_variables(args)
      end
      
      def response
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
        Typhoeus::Request.post(url, {
          :headers => { 'Content-Type' => 'text/plain' },
          :body    => triples
        })
      end
    end
  end
end
