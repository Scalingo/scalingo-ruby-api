require "scalingo/api/endpoint"

module Scalingo
  class Auth::Keys < API::Endpoint
    def all(headers = nil)
      data = nil

      response = connection.get("keys", data, headers)

      unpack(response, key: :keys)
    end

    def show(id, headers = nil)
      data = nil

      response = connection.get("keys/#{id}", data, headers)

      unpack(response, key: :key)
    end

    def create(payload, headers = nil)
      data = {key: payload}

      response = connection.post("keys", data, headers)

      unpack(response, key: :key)
    end

    def destroy(id, headers = nil)
      data = nil
      response = connection.delete("keys/#{id}", data, headers)

      unpack(response)
    end
  end
end
