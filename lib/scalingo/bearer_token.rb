module Scalingo
  class BearerToken
    attr_reader :expires_at
    attr_writer :raise_on_expired

    def initialize(value, expires_at: nil, raise_on_expired: false)
      @value = value
      @expires_at = expires_at if expires_at
      @raise_on_expired = raise_on_expired
    end

    def inspect
      str = "<#{self.class}:0x#{object_id.to_s(16)} "

      str << if expired?
        "(expired) "
      elsif expires_at.present?
        "expires_at: #{expires_at} "
      else
        "(no expiration) "
      end

      str << %(value:"#{value}">)
      str
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
