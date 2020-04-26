require "forwardable"

require "active_support/configurable"
require "faraday"
require "faraday_middleware"

require "scalingo/api/bearer_token"
require "scalingo/auth"
require "scalingo/errors"

module Scalingo
  class Client
    extend Forwardable
    include ActiveSupport::Configurable

    config_accessor :response_parser_options do
      { symbolize_names: true }
    end

    config_accessor :request_headers do
      {
        "User-Agent" => "Scalingo Ruby Client v#{Scalingo::VERSION}",
      }
    end

    attr_reader :token

    ## Authentication helpers
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
        expiration = Time.now + API::BearerToken::EXCHANGED_TOKEN_DURATION
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

    ## API clients
    def auth
      @auth ||= Auth.new(self)
    end

    ## Delegations
    def_delegator :auth, :keys
    def_delegator :auth, :scm_integrations
    def_delegator :auth, :tokens
    def_delegator :auth, :user
  end
end
