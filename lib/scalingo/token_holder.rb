require "scalingo/bearer_token"

module Scalingo
  module TokenHolder
    def self.included(base)
      base.attr_reader :token
    end

    def token=(input)
      @token = input.is_a?(BearerToken) ? input : BearerToken.new(input.to_s)
    end

    def authenticated?
      token.present? && !token.expired?
    end
  end
end
