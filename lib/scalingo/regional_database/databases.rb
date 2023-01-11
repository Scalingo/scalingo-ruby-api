require "scalingo/api/endpoint"

module Scalingo
  class RegionalDatabase::Databases < API::Endpoint
    def find(id, headers = nil, &block)
      data = nil

      response = database_connection(id).get(
        "databases/#{id}",
        data,
        headers,
        &block
      )

      unpack(:database) { response }
    end

    def upgrade(id, headers = nil, &block)
      data = nil

      response = database_connection(id).post(
        "databases/#{id}/upgrade",
        data,
        headers,
        &block
      )

      unpack(:database) { response }
    end
  end
end
