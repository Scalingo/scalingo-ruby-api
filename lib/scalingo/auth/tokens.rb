require "scalingo/api/endpoint"

module Scalingo
  class Auth::Tokens < API::Endpoint
    def exchange(token, headers = nil, &block)
      data = nil

      authorization = Faraday::Utils.basic_header_from("", token)

      request_headers = {
        Faraday::Request::Authorization::KEY => authorization
      }

      request_headers.update(headers) if headers

      response = client.unauthenticated_connection.post(
        "tokens/exchange",
        data,
        request_headers,
        &block
      )

      unpack { response }
    end

    def all(headers = nil, &block)
      data = nil

      response = connection.get(
        "tokens",
        data,
        headers,
        &block
      )

      unpack(:tokens) { response }
    end

    def create(payload, headers = nil, &block)
      data = {token: payload}

      response = connection.post(
        "tokens",
        data,
        headers,
        &block
      )

      unpack(:token) { response }
    end

    def renew(id, headers = nil, &block)
      data = nil

      response = connection.patch(
        "tokens/#{id}/renew",
        data,
        headers,
        &block
      )

      unpack(:token) { response }
    end

    def destroy(id, headers = nil, &block)
      data = nil

      response = connection.delete(
        "tokens/#{id}",
        data,
        headers,
        &block
      )

      unpack { response }
    end
  end
end
