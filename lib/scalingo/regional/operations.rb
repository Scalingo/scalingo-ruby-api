require "scalingo/api/endpoint"

module Scalingo
  class Regional::Operations < API::Endpoint
    def find(app_id, operation_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/operations/#{operation_id}",
        data,
        headers,
        &block
      )

      unpack(response, key: :operation)
    end
  end
end
