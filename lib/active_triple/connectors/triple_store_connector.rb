class ActiveTriple
  module Connectors

    class TripleStoreConnector

      attr_reader :url_variables, :triples

      def initialize

      end

      def path
        raise "Connection target url not set"
      end

      def set_url_variables(variables = {})
        @url_variables = build_varible_string(variables)
      end

      def url
        [path, url_variables].join
      end
      
      def self.send_data(args = {})
        raise "Need to define how connector sends data to server"
      end

      def response
        raise "Need to define how connector handles response"
      end

      private
      def build_varible_string(variables)
        variables[:limit] = 10 unless variables[:limit]
        parts = variables.to_a.collect{|v| v.join("=")}
        "?#{parts.join('&')}"
      end
    end

  end
end
