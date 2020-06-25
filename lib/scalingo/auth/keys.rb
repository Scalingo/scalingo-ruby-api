require "scalingo/api/endpoint"

module Scalingo
  class Auth::Keys < API::Endpoint
    def all(headers = nil, &block)
      data = nil

      response = connection.get(
        "keys",
        data,
        headers,
        &block
      )

      unpack(:keys) { response }
    end

    def show(id, headers = nil, &block)
      data = nil

      response = connection.get(
        "keys/#{id}",
        data,
        headers,
        &block
      )

      unpack(:key) { response }
    end

    def create(payload, headers = nil, &block)
      data = {key: payload}

      response = connection.post(
        "keys",
        data,
        headers,
        &block
      )

      unpack(:key) { response }
    end

    def destroy(id, headers = nil, &block)
      data = nil
      response = connection.delete(
        "keys/#{id}",
        data,
        headers,
        &block
      )

      unpack { response }
    end
  end
end
