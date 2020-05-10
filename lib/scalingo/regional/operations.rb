require "scalingo/api/endpoint"

module Scalingo
  class Regional::Operations < API::Endpoint
    def find(app_id, operation_id)
      response = connection.get("apps/#{app_id}/operations/#{operation_id}")

      unpack(response, key: :operation)
    end
  end
end
