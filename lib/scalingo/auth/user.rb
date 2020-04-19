require "scalingo/api/endpoint"

module Scalingo
  class Auth::User < API::Endpoint
    def self
      response = client.connection.get("users/self")

      unpack(response, key: :user)
    end

    def update(payload)
      response = client.connection.put("users/account", {user: payload})

      unpack(response, key: :user)
    end
  end
end
