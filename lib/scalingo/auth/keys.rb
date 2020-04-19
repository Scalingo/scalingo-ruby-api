require "scalingo/api/endpoint"

module Scalingo
  class Auth::Keys < API::Endpoint
    def all
      response = client.connection.get("keys")

      unpack(response, key: :keys)
    end

    def show(id)
      response = client.connection.get("keys/#{id}")

      unpack(response, key: :key)
    end

    def create(name:, content:)
      response = client.connection.post("keys", {name: name, content: content})

      unpack(response, key: :key)
    end

    def destroy(id)
      response = client.connection.delete("keys/#{id}")

      unpack(response)
    end
  end
end
