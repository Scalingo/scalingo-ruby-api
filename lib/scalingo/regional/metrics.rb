require "scalingo/api/endpoint"
require "active_support/core_ext/hash/indifferent_access"

module Scalingo
  class Regional::Metrics < API::Endpoint
    def for(app_id, metric, payload = {})
      payload = payload.with_indifferent_access
      query = payload.except(:container_type, :container_index).compact

      url = "apps/#{app_id}/stats/#{metric}"

      if payload[:container_type]
        url = "#{url}/#{payload[:container_type]}"
        url = "#{url}/#{payload[:container_index]}" if payload[:container_index]
      end

      response = connection.get(url, query)

      unpack(response)
    end

    def types
      response = connection(allow_guest: true).get("features/metrics")

      unpack(response, key: :metrics)
    end
  end
end
