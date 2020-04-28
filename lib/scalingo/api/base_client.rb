module Scalingo
  module API
    class BaseClient
      include ActiveSupport::Configurable

      attr_reader :client

      config_accessor :url

      def initialize(client, url)
        @client = client
        config.url = url
      end

      ## Faraday objects
      def connection_options
        { url: url, headers: client.request_headers }
      end

      def connection(allow_guest: false)
        if allow_guest
          authenticated_connection rescue unauthenticated_connection
        else
          authenticated_connection
        end
      end

      def unauthenticated_connection
        @unauthenticated_conn ||= Faraday.new(connection_options) do |conn|
          conn.response :json, content_type: /\bjson$/, parser_options: client.response_parser_options
        end
      end

      def authenticated_connection
        return @connection if @connection

        if !client.token&.value
          raise Error::Unauthenticated
        end

        @connection = Faraday.new(connection_options) do |conn|
          conn.response :json, content_type: /\bjson$/, parser_options: client.response_parser_options
          conn.request :json

          auth_header = Faraday::Request::Authorization.header "Bearer", client.token.value
          conn.headers[Faraday::Request::Authorization::KEY] = auth_header
        end
      end
    end
  end
end
