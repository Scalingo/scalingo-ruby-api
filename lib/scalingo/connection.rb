require 'faraday_middleware'
Dir[File.expand_path('../faraday/*.rb', __dir__)].each { |f| require f }

module Scalingo
  module Connection
    private

    def build_connection(opts = {})
      raise MissingToken if !token

      Faraday::Connection.new(connection_options) do |connection|
        connection.use Faraday::Request::Multipart
        connection.use Faraday::Request::UrlEncoded
        connection.use FaradayMiddleware::RaiseHttpException
        connection.response :json, :content_type => /\bjson$/
        connection.adapter(adapter)
      end
    end

    def connection_options
      return {
        headers: {
          'Accept' => 'application/json; charset=utf-8',
          'Content-Type' => 'application/json',
          'User-Agent' => user_agent,
        },
        proxy: proxy,
      }
    end
  end
end

