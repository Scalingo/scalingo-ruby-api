require "scalingo/bearer_token"

module Scalingo
  module TokenHolder
    def self.included(base)
      base.attr_reader :token
      base.attr_reader :database_tokens
    end

    def token=(input)
      @token = bearer_token(input)
    end

    def add_database_token(database_id, token)
      @database_tokens ||= {}
      @database_tokens[database_id] = bearer_token(token)
    end

    def authenticated?(database_id: "")
      valid?(token)
    end

    def authenticated_for_database?(database_id)
      return false if database_tokens.nil?
      return false unless database_tokens.has_key?(database_id)

      valid?(database_tokens[database_id])
    end

    def authenticate_with_bearer_token(bearer_token, expires_at:, raise_on_expired_token:)
      self.token = build_bearer_token(bearer_token, expires_at: expires_at, raise_on_expired_token: raise_on_expired_token)
    end

    def authenticate_database_with_bearer_token(database_id, bearer_token, expires_at:, raise_on_expired_token:)
      bearer_token = build_bearer_token(bearer_token, expires_at: expires_at, raise_on_expired_token: raise_on_expired_token)

      add_database_token(database_id, bearer_token)
    end

    private

    def valid?(token)
      token.present? && !token.expired?
    end

    def bearer_token(token)
      token.is_a?(BearerToken) ? token : BearerToken.new(token.to_s, raise_on_expired: config.raise_on_expired_token)
    end

    def build_bearer_token(bearer_token, expires_at:, raise_on_expired_token:)
      return bearer_token unless expires_at

      token = bearer_token.is_a?(BearerToken) ? bearer_token.value : bearer_token.to_s

      BearerToken.new(
        token,
        expires_at: expires_at,
        raise_on_expired: raise_on_expired_token,
      )
    end
  end
end
