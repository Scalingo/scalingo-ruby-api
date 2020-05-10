require "scalingo/api/endpoint"

module Scalingo
  class Auth::Keys < API::Endpoint
    def all
      response = connection.get("keys")

      unpack(response, key: :keys)
    end

    def show(id)
      response = connection.get("keys/#{id}")

      unpack(response, key: :key)
    end

    def create(name:, content:)
      response = connection.post("keys", {name: name, content: content})

      unpack(response, key: :key)
    end

    def destroy(id)
      response = connection.delete("keys/#{id}")

      unpack(response)
    end
  end
end
