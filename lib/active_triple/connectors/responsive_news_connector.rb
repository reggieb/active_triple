require_relative 'triple_store_connector'
require 'typhoeus'
require 'hashie'

class ActiveTriple
  module Connectors
    class ResponsiveNewsConnector < TripleStoreConnector
      attr_reader :url_variables, :triples
      
    
      def self.send_data(args)
        connector = new
        connector.send_by_post(args)
        return connector
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
      
      def send_by_post(args)
        @triples = args.delete(:triples)
        set_url_variables(args)
      end
      
      def path
        @path = 'http://juicer.responsivenews.co.uk/api/articles.json'  
      end      
      
      def set_url_variables(variables = {})
        @url_variables = build_varible_string(variables)
      end

      def url
        [path, url_variables].join
      end
      
      private
      def by_post
        Typhoeus::Request.post(url, {
          :headers => { 'Content-Type' => 'text/plain' },
          :body    => triples
        })
      end      
      
      def build_varible_string(variables)
        parts = variables.to_a.collect{|v| v.join("=")}
        "?#{parts.join('&')}"
      end
    end
  end
end
