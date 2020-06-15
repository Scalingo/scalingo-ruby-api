module Scalingo
  class BearerToken
    attr_reader :expires_at

    def initialize(value, expires_at: nil)
      @value = value
      @expires_at = expires_at if expires_at
    end

    def expired?
      expires_at && expires_at <= Time.now
    end

    def value
      raise Error::ExpiredToken if expired? && Scalingo.config.raise_on_expired_token

      @value
    end
  end
end
