require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module Scalingo
  module Connection
    private
    def connection
      raise MissingToken.new if !token

      options = {
        :headers => {
          'Accept' => 'application/json; charset=utf-8',
          'Content-Type' => 'application/json',
          'User-Agent' => user_agent,
        },
        :proxy => proxy,
        :url => endpoint,
      }

      Faraday::Connection.new(options) do |connection|
        connection.use Faraday::Request::Multipart
        connection.use Faraday::Request::UrlEncoded
        connection.use Faraday::Response::ParseJson if parse_json
        connection.use FaradayMiddleware::RaiseHttpException
        connection.adapter(adapter)
        connection.basic_auth('', token)
      end
    end
  end
end

