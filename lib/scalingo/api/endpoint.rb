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

      private

      def unpack(*args)
        Response.unpack(*args)
      end
    end
  end
end
