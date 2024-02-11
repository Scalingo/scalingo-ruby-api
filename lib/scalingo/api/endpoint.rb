require "forwardable"

module Scalingo
  module API
    class Endpoint
      extend Forwardable
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def_delegator :client, :connection
      def_delegator :client, :database_connection

      def inspect
        str = %(<#{self.class}:0x#{object_id.to_s(16)} base_url:"#{@client.url}" endpoints:)

        str << self.class.instance_methods(false).to_s
        str << ">"
        str
      end
    end
  end
end
