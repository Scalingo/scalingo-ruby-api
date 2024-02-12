require "scalingo/api/endpoint"

module Scalingo
  class Regional::Autoscalers < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/autoscalers",
        data,
        headers,
        &block
      )
    end

    def find(app_id, autoscaler_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/autoscalers/#{autoscaler_id}",
        data,
        headers,
        &block
      )
    end

    def create(app_id, payload = {}, headers = nil, &block)
      data = {autoscaler: payload}

      connection.post(
        "apps/#{app_id}/autoscalers",
        data,
        headers,
        &block
      )
    end

    def update(app_id, autoscaler_id, payload = {}, headers = nil, &block)
      data = {autoscaler: payload}

      connection.patch(
        "apps/#{app_id}/autoscalers/#{autoscaler_id}",
        data,
        headers,
        &block
      )
    end

    def destroy(app_id, autoscaler_id, headers = nil, &block)
      data = nil

      connection.delete(
        "apps/#{app_id}/autoscalers/#{autoscaler_id}",
        data,
        headers,
        &block
      )
    end
  end
end
