require "scalingo/api/endpoint"
require "active_support/core_ext/hash/indifferent_access"

module Scalingo
  class Regional::Metrics < API::Endpoint
    def for(app_id, payload = {}, headers = nil, &block)
      payload = payload.with_indifferent_access
      data = payload.except(:metric, :container_type, :container_index).compact

      metric = payload[:metric]
      url = "apps/#{app_id}/stats/#{metric}"

      if payload[:container_type]
        url = "#{url}/#{payload[:container_type]}"
        url = "#{url}/#{payload[:container_index]}" if payload[:container_index]
      end

      response = connection.get(
        url,
        data,
        headers,
        &block
      )

      unpack { response }
    end

    def types(headers = nil, &block)
      data = nil

      response = connection(fallback_to_guest: true).get(
        "features/metrics",
        data,
        headers,
        &block
      )

      unpack(:metrics) { response }
    end
  end
end
