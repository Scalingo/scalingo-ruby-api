require "scalingo/api/endpoint"

module Scalingo
  class Auth::Contracts < API::Endpoint
    def all(headers = nil, &block)
      data = nil

      response = connection.get(
        "contracts",
        data,
        headers,
        &block
      )

      unpack(:contracts) { response }
    end
  end
end
