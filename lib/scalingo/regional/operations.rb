require "scalingo/api/endpoint"

module Scalingo
  class Regional::Operations < API::Endpoint
    def find(app_id, operation_id, headers = nil, &block)
      get(
        "apps/#{app_id}/operations/#{operation_id}",
        headers,
        &block
      )
    end

    def get(url, headers = nil, &block)
      data = nil

      connection.get(
        url,
        data,
        headers,
        &block
      )
    end
  end
end
