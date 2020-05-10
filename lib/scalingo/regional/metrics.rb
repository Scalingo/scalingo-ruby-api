require "scalingo/api/endpoint"

module Scalingo
  class Regional::Metrics < API::Endpoint
    def for(app_id, metric:, **query)
      params = query.slice(:since, :status_code, :statistics_type, :last).compact

      url = "apps/#{app_id}/stats/#{metric}"

      if query[:container_type]
        url = "#{url}/#{query[:container_type]}"
        url = "#{url}/#{query[:container_index]}" if query[:container_index]
      end

      response = connection.get(url, params)

      unpack(response)
    end

    def types
      response = connection(allow_guest: true).get("features/metrics")

      unpack(response, key: :metrics)
    end
  end
end
