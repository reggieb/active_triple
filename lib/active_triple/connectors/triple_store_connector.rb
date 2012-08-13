class ActiveTriple
  module Connectors

    class TripleStoreConnector

      def initialize

      end
     
      # Method used to initial a connection and send data.
      def self.send_data(args = {})
        required_arguments.each{|arg| raise "args must include :#{arg}" unless args.keys.include?(arg.to_sym)}
        raise "Need to define how connector sends data to server"
      end

      # Response should be an array of objects holding the data returned by the server
      # or an empty array
      def response
        raise "Need to define how connector handles response"
      end
      
      private
      def self.required_arguments
        %w{triples binding limit}
      end

      
    end

  end
end
