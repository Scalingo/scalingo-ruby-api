require "scalingo/api/endpoint"

module Scalingo
  class Auth::User < API::Endpoint
    def self(headers = nil)
      data = nil

      response = connection.get("users/self", data, headers)

      unpack(response, key: :user)
    end

    def update(payload, headers = nil)
      data = {user: payload}

      response = connection.put("users/account", data, headers)

      unpack(response, key: :user)
    end
  end
end
