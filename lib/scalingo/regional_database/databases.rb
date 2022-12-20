require "scalingo/api/endpoint"

module Scalingo
  class RegionalDatabase::Databases < API::Endpoint
    def find(id, headers = nil, &block)
      data = nil

      response = connection.get(
        "databases/#{id}",
        data,
        headers,
        &block
      )

      unpack(:database) { response }
    end
  end
end
