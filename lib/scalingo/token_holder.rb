require "scalingo/bearer_token"

module Scalingo
  module TokenHolder
    def self.included(base)
      base.attr_reader :token
    end

    def token=(input)
      @token = input.is_a?(BearerToken) ? input : BearerToken.new(input.to_s, raise_on_expired: config.raise_on_expired_token)
    end

    def authenticated?
      token.present? && !token.expired?
    end

    def authenticate_with_bearer_token(bearer_token, expires_at:, raise_on_expired_token:)
      self.token = if expires_at
        token = bearer_token.is_a?(BearerToken) ? bearer_token.value : bearer_token.to_s

        BearerToken.new(
          token,
          expires_at: expires_at,
          raise_on_expired: raise_on_expired_token,
        )
      else
        bearer_token
      end
    end
  end
end
