require "scalingo/api/endpoint"

module Scalingo
  class Auth::Tokens < API::Endpoint
    def exchange(token:)
      response = client.unauthenticated_connection.post("tokens/exchange") do |req|
        req.headers[Faraday::Request::Authorization::KEY] =
          Faraday::Request::BasicAuthentication.header('', token)
      end

      unpack(response)
    end

    def all
      response = connection.get("tokens")

      unpack(response, key: :tokens)
    end

    def create(payload)
      response = connection.post("tokens", {token: payload})

      unpack(response, key: :token)
    end

    def renew(id)
      response = connection.patch("tokens/#{id}/renew")

      unpack(response, key: :token)
    end

    def destroy(id)
      response = connection.delete("tokens/#{id}")

      unpack(response)
    end
  end
end
