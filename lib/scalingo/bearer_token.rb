require "jwt"

module Scalingo
  class BearerToken
    attr_reader :expires_at
    attr_writer :raise_on_expired

    def initialize(value, raise_on_expired: false)
      @value = value
      @raise_on_expired = raise_on_expired

      read_expiration!
    end

    # :nocov:
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
    # :nocov:

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

    private

    def read_expiration!
      payload, _ = JWT.decode(@value, nil, false)

      @expires_at = Time.at(payload["exp"]) if payload["exp"]
    end
  end
end
