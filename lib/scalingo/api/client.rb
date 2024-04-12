require "scalingo/token_holder"
require "scalingo/faraday/response"
require "scalingo/faraday/extract_meta"
require "scalingo/faraday/extract_root_value"
require "active_support/core_ext/hash"

module Scalingo
  module API
    class Client
      include TokenHolder

      attr_reader :config, :token_holder, :url, :region

      def initialize(url, scalingo: nil, region: nil, config: {})
        @url = url
        @region = region

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

      def guest_connection
        @guest_connection ||= Faraday.new(connection_options) { |conn|
          conn.response :extract_root_value
          conn.response :extract_meta
          conn.response :json, content_type: /\bjson$/, parser_options: {symbolize_names: true}
          conn.request :json

          conn.adapter(config.faraday_adapter) if config.faraday_adapter
        }
      end

      def connection
        return @connection if @connection

        # Missing token handling. Token expiration is handled in the `value` method.
        raise Error::Unauthenticated unless token_holder.token&.value&.present?

        @connection = Faraday.new(connection_options) { |conn|
          conn.response :extract_root_value
          conn.response :extract_meta
          conn.response :json, content_type: /\bjson$/, parser_options: {symbolize_names: true}
          conn.request :json
          conn.request :authorization, "Bearer", -> { token_holder.token&.value }

          conn.adapter(config.faraday_adapter) if config.faraday_adapter
        }
      end
    end
  end
end
