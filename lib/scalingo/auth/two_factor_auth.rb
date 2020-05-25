require "scalingo/api/endpoint"

module Scalingo
  class Auth::TwoFactorAuth < API::Endpoint
    TOTP_PROVIDER = "totp"
    DEFAULT_PROVIDER = TOTP_PROVIDER
    SUPPORTED_PROVIDERS = [TOTP_PROVIDER]

    def status(headers = nil)
      data = nil

      response = connection.get("client/tfa", data, headers)

      unpack(response, key: :tfa)
    end

    def initiate(provider = DEFAULT_PROVIDER, headers = nil)
      data = {tfa: {provider: provider}}

      response = connection.post("client/tfa", data, headers)

      unpack(response, key: :tfa)
    end

    def validate(attempt, headers = nil)
      data = {tfa: {attempt: attempt}}

      response = connection.post("client/tfa/validate", data, headers)

      unpack(response, key: :tfa)
    end

    def disable(headers = nil)
      data = nil

      response = connection.delete("client/tfa", data, headers)

      unpack(response)
    end
  end
end
