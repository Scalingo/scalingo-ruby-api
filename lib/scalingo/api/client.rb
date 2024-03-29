require "scalingo/token_holder"
require "scalingo/faraday/response"
require "scalingo/faraday/extract_meta"
require "scalingo/faraday/extract_root_value"
require "active_support/core_ext/hash"

module Scalingo
  module API
    class Client
      include TokenHolder

      attr_reader :config, :token_holder, :url

      def initialize(url, scalingo: nil, config: {})
        @url = url
        parent_config = Scalingo.config

        if scalingo
          @token_holder = scalingo
          parent_config = scalingo.config
        else
          @token_holder = self
        end

        @config = Configuration.new(config, parent_config)
      end

      def self.register_handlers!(handlers)
        handlers.each do |method_name, klass|
          register_handler!(method_name, klass)
        end
      end

      def self.register_handler!(method_name, klass)
        define_method(method_name) do
          value = instance_variable_get(:"@#{method_name}")

          if value.nil?
            value = klass.new(self)
            instance_variable_set(:"@#{method_name}", value)
          end

          value
        end
      end

      # :nocov:
      def inspect
        str = %(<#{self.class}:0x#{object_id.to_s(16)} url:"#{@url}" methods:)

        str << self.class.instance_methods(false).to_s
        str << ">"
        str
      end
      # :nocov:

      ## Faraday objects
      def headers
        hash = {
          "User-Agent" => config.user_agent,
          "Accept" => "application/json"
        }

        if (extra = config.additional_headers).present?
          extra.respond_to?(:call) ? hash.update(extra.call) : hash.update(extra)
        end

        hash
      end

      def connection_options
        {
          url: url,
          headers: headers
        }
      end

      # Note: when `config.raise_on_missing_authentication` is set to false,
      # this method may return the unauthenticated connection
      # even with `fallback_to_guest: false`
      def connection(fallback_to_guest: false)
        authenticated_connection
      rescue Error::Unauthenticated
        raise unless fallback_to_guest

        unauthenticated_connection
      end

      def unauthenticated_connection
        @unauthenticated_conn ||= Faraday.new(connection_options) { |conn|
          conn.response :extract_root_value
          conn.response :extract_meta
          conn.response :json, content_type: /\bjson$/, parser_options: {symbolize_names: true}
          conn.request :json

          conn.adapter(config.faraday_adapter) if config.faraday_adapter
        }
      end

      def authenticated_connection
        return @connection if @connection

        # Missing token handling. Token expiration is handled in the `value` method.
        unless token_holder.token&.value
          if config.raise_on_missing_authentication
            raise Error::Unauthenticated
          else
            return unauthenticated_connection
          end
        end

        @connection = Faraday.new(connection_options) { |conn|
          conn.response :extract_root_value
          conn.response :extract_meta
          conn.response :json, content_type: /\bjson$/, parser_options: {symbolize_names: true}
          conn.request :json
          conn.request :authorization, "Bearer", -> { token_holder.token&.value }

          conn.adapter(config.faraday_adapter) if config.faraday_adapter
        }
      end

      def database_connection(database_id)
        raise Error::Unauthenticated unless token_holder.authenticated_for_database?(database_id)

        @database_connections ||= {}
        @database_connections[database_id] ||= Faraday.new(connection_options) { |conn|
          conn.response :extract_root_value
          conn.response :extract_meta
          conn.response :json, content_type: /\bjson$/, parser_options: {symbolize_names: true}
          conn.request :json
          conn.request :authorization, "Bearer", -> { token_holder.database_tokens[database_id]&.value }

          conn.adapter(config.faraday_adapter) if config.faraday_adapter
        }
      end
    end
  end
end
