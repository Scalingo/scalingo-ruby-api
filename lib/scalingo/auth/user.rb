require "scalingo/api/endpoint"

module Scalingo
  class Auth::User < API::Endpoint
    def self(headers = nil, &block)
      data = nil

      response = connection.get(
        "users/self",
        data,
        headers,
        &block
      )

      unpack(:user) { response }
    end

    def update(payload, headers = nil, &block)
      data = {user: payload}

      response = connection.put(
        "users/account",
        data,
        headers,
        &block
      )

      unpack(:user) { response }
    end

    def stop_free_trial(headers = nil, &block)
      data = nil

      response = connection.post(
        "users/stop_free_trial",
        data,
        headers,
        &block
      )

      unpack { response }
    end
  end
end
