require 'jwt'

module Scalingo
  module JWT
    attr_reader :current_jwt

    private

    def current_jwt
      return @current_jwt if current_jwt_valid?

      @current_jwt = exchange_token_jwt
      return @current_jwt
    end

    def current_jwt_valid?
      return false if @current_jwt.nil?

      ::JWT.decode @current_jwt, nil, false

      return true
    rescue ::JWT::ExpiredSignature
      return false
    end

    def exchange_token_jwt
      jwt_connection = build_connection(always_json: true)
      jwt_connection.basic_auth('', token)
      jwt_connection.url_prefix = auth_endpoint

      response = jwt_connection.post do |request|
        request.path = '/v1/tokens/exchange'
      end
      return response.body['token']
    end
  end
end
