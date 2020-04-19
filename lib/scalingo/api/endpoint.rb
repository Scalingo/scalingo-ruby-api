require "scalingo/api/response"

module Scalingo
  module API
    class Endpoint
      attr_reader :client

      def initialize(client)
        @client = client
      end

      private

      def unpack(*args)
        Response.unpack(*args)
      end
    end
  end
end
