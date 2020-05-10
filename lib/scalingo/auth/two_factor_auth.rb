require "scalingo/api/endpoint"

module Scalingo
  class Auth::TwoFactorAuth < API::Endpoint
    TOTP_PROVIDER = "totp"
    DEFAULT_PROVIDER = TOTP_PROVIDER
    SUPPORTED_PROVIDERS = [TOTP_PROVIDER]

    def status
      response = connection.get("client/tfa")

      unpack(response, key: :tfa)
    end

    def initiate(provider = DEFAULT_PROVIDER)
      data = {tfa: {provider: provider}}

      response = connection.post('client/tfa', data)

      unpack(response, key: :tfa)
    end

    def validate(attempt)
      data = {tfa: {attempt: attempt}}

      response = connection.get("client/tfa/validate", data)

      unpack(response, key: :tfa)
    end

    def disable
      response = connection.delete('client/tfa')

      unpack(response)
    end
  end
end
