require "forwardable"

require "faraday"
require "faraday_middleware"

require "scalingo/api/bearer_token"
require "scalingo/errors"

module Scalingo
  class BasicClient
    extend Forwardable

    attr_reader :token

    ## Authentication helpers
    def authenticated?
      @token.present? && !@token.expired?
    end

    def authenticate_with(access_token: nil, bearer_token: nil, expires_in: nil)
      if !access_token && !bearer_token
        raise ArgumentError, "You must supply one of `access_token` or `bearer_token`"
      end

      if access_token && bearer_token
        raise ArgumentError, "You cannot supply both `access_token` and `bearer_token`"
      end

      if expires_in && !bearer_token
        raise ArgumentError, "`expires_in` can only be used with `bearer_token`. `access_token` have a 1 hour expiration."
      end

      if access_token
        expiration = Time.now + Scalingo.config.exchanged_token_validity
        response = auth.tokens.exchange(token: access_token)

        if response.successful?
          @token = API::BearerToken.new(
            response.data[:token],
            expires_in: expiration
          )
        end

        return response.successful?
      end

      if bearer_token
        if bearer_token.is_a?(API::BearerToken)
          @token = bearer_token
        else
          @token = API::BearerToken.new(bearer_token.to_s, expires_in: expires_in)
        end
      end
    end
  end
end
