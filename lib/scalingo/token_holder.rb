require "scalingo/bearer_token"

module Scalingo
  module TokenHolder
    def self.included(base)
      base.attr_reader :token
    end

    def token=(input)
      @token = bearer_token(input)
    end

    def authenticated?
      token.present? && !token.expired?
    end

    def authenticate_with_bearer_token(bearer_token, expires_at:, raise_on_expired_token:)
      self.token = build_bearer_token(bearer_token, expires_at: expires_at, raise_on_expired_token: raise_on_expired_token)
    end

    private

    def bearer_token(token)
      token.is_a?(BearerToken) ? token : BearerToken.new(token.to_s, raise_on_expired: config.raise_on_expired_token)
    end

    def build_bearer_token(bearer_token, expires_at:, raise_on_expired_token:)
      return bearer_token unless expires_at

      token = bearer_token.is_a?(BearerToken) ? bearer_token.value : bearer_token.to_s

      BearerToken.new(
        token,
        expires_at: expires_at,
        raise_on_expired: raise_on_expired_token
      )
    end
  end
end
