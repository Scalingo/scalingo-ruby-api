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

      client.unauthenticated_connection.post(
        "tokens/exchange",
        data,
        request_headers,
        &block
      )
    end

    def all(headers = nil, &block)
      data = nil

      connection.get(
        "tokens",
        data,
        headers,
        &block
      )
    end

    def create(payload, headers = nil, &block)
      data = {token: payload}

      connection.post(
        "tokens",
        data,
        headers,
        &block
      )
    end

    def renew(id, headers = nil, &block)
      data = nil

      connection.patch(
        "tokens/#{id}/renew",
        data,
        headers,
        &block
      )
    end

    def destroy(id, headers = nil, &block)
      data = nil

      connection.delete(
        "tokens/#{id}",
        data,
        headers,
        &block
      )
    end
  end
end
