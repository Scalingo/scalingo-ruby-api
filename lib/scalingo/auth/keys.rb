require "scalingo/api/endpoint"

module Scalingo
  class Auth::Keys < API::Endpoint
    def all(headers = nil, &block)
      data = nil

      connection.get(
        "keys",
        data,
        headers,
        &block
      )
    end

    def show(id, headers = nil, &block)
      data = nil

      connection.get(
        "keys/#{id}",
        data,
        headers,
        &block
      )
    end

    def create(payload, headers = nil, &block)
      data = {key: payload}

      connection.post(
        "keys",
        data,
        headers,
        &block
      )
    end

    def destroy(id, headers = nil, &block)
      data = nil

      connection.delete(
        "keys/#{id}",
        data,
        headers,
        &block
      )
    end
  end
end
