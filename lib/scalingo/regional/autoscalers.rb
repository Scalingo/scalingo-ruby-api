require "scalingo/api/endpoint"

module Scalingo
  class Regional::Autoscalers < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/autoscalers",
        data,
        headers,
        &block
      )

      unpack(:autoscalers) { response }
    end

    def find(app_id, autoscaler_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/autoscalers/#{autoscaler_id}",
        data,
        headers,
        &block
      )

      unpack(:autoscaler) { response }
    end

    def create(app_id, payload = {}, headers = nil, &block)
      data = {autoscaler: payload}

      response = connection.post(
        "apps/#{app_id}/autoscalers",
        data,
        headers,
        &block
      )

      unpack(:autoscaler) { response }
    end

    def update(app_id, autoscaler_id, payload = {}, headers = nil, &block)
      data = {autoscaler: payload}

      response = connection.patch(
        "apps/#{app_id}/autoscalers/#{autoscaler_id}",
        data,
        headers,
        &block
      )

      unpack(:autoscaler) { response }
    end

    def destroy(app_id, autoscaler_id, headers = nil, &block)
      data = nil

      response = connection.delete(
        "apps/#{app_id}/autoscalers/#{autoscaler_id}",
        data,
        headers,
        &block
      )

      unpack { response }
    end
  end
end
