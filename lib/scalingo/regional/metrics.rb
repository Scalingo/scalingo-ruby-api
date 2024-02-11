require "scalingo/api/endpoint"
require "active_support"
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

      connection.get(
        url,
        data,
        headers,
        &block
      )
    end

    def types(headers = nil, &block)
      data = nil

      connection(fallback_to_guest: true).get(
        "features/metrics",
        data,
        headers,
        &block
      )
    end
  end
end
