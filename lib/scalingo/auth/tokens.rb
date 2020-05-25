require "scalingo/api/endpoint"

module Scalingo
  class Auth::Tokens < API::Endpoint
    def exchange(token, headers = nil)
      data = nil

      request_headers = {
        Faraday::Request::Authorization::KEY => Faraday::Request::BasicAuthentication.header("", token)
      }

      request_headers.update(headers) if headers

      response = client.unauthenticated_connection.post("tokens/exchange", data, request_headers)

      unpack(response)
    end

    def all(headers = nil)
      data = nil

      response = connection.get("tokens", data, headers)

      unpack(response, key: :tokens)
    end

    def create(payload, headers = nil)
      data = {token: payload}

      response = connection.post("tokens", data, headers)

      unpack(response, key: :token)
    end

    def renew(id, headers = nil)
      data = nil

      response = connection.patch("tokens/#{id}/renew", data, headers)

      unpack(response, key: :token)
    end

    def destroy(id, headers = nil)
      data = nil

      response = connection.delete("tokens/#{id}", data, headers)

      unpack(response)
    end
  end
end
