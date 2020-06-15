module Scalingo
  class BearerToken
    attr_reader :expires_at
    attr_writer :raise_on_expired

    def initialize(value, expires_at: nil, raise_on_expired: false)
      @value = value
      @expires_at = expires_at if expires_at
      @raise_on_expired = raise_on_expired
    end

    def raise_on_expired?
      @raise_on_expired
    end

    def expired?
      expires_at && expires_at <= Time.now
    end

    def value
      raise Error::ExpiredToken if expired? && raise_on_expired?

      @value
    end
  end
end
