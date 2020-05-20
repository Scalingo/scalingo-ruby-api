module Scalingo
  module API
    class BaseClient
      attr_reader :client, :url

      def initialize(client, url)
        @client = client
        @url = url
      end

      def self.register_handlers!(handlers)
        handlers.each do |method_name, klass|
          define_method(method_name) do
            value = instance_variable_get("@#{method_name}")

            if value.nil?
              value = klass.new(self)
              instance_variable_set("@#{method_name}", value)
            end

            value
          end
        end
      end

      ## Faraday objects
      def connection_options
        {
          url: url,
          headers: {
            "User-Agent" => Scalingo.config.user_agent
          }
        }
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
          conn.response :json, content_type: /\bjson$/, parser_options: { symbolize_names: true }
        end
      end

      def authenticated_connection
        return @connection if @connection

        if Scalingo.config.raise_on_missing_authentication && !client.token&.value
          raise Error::Unauthenticated
        end

        @connection = Faraday.new(connection_options) do |conn|
          conn.response :json, content_type: /\bjson$/, parser_options: { symbolize_names: true }
          conn.request :json

          if client.token&.value
            auth_header = Faraday::Request::Authorization.header "Bearer", client.token.value
            conn.headers[Faraday::Request::Authorization::KEY] = auth_header
          end
        end
      end
    end
  end
end
