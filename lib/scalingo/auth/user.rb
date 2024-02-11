require "scalingo/api/endpoint"

module Scalingo
  class Auth::User < API::Endpoint
    def self(headers = nil, &block)
      data = nil

      connection.get(
        "users/self",
        data,
        headers,
        &block
      )
    end

    def update(payload, headers = nil, &block)
      data = {user: payload}

      connection.put(
        "users/account",
        data,
        headers,
        &block
      )
    end

    def stop_free_trial(headers = nil, &block)
      data = nil

      connection.post(
        "users/stop_free_trial",
        data,
        headers,
        &block
      )
    end
  end
end
