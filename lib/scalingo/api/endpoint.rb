require "forwardable"
require "scalingo/api/response"

module Scalingo
  module API
    class Endpoint
      extend Forwardable
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def_delegator :client, :connection

      def inspect
        str = %(<#{self.class}:0x#{object_id.to_s(16)} base_url:"#{@client.url}" endpoints:)

        methods = self.class.instance_methods - Scalingo::API::Endpoint.instance_methods

        str << methods.to_s
        str << ">"
        str
      end

      private

      def unpack(*args)
        Response.unpack(client, *args)
      end
    end
  end
end
