require "scalingo/api/endpoint"

module Scalingo
  class Regional::Deployments < API::Endpoint
    def for(app_id, payload = {}, headers = nil, &block)
      data = payload.compact

      response = connection.get(
        "apps/#{app_id}/deployments",
        data,
        headers,
        &block
      )

      unpack(response, key: :deployments)
    end

    def find(app_id, deployment_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/deployments/#{deployment_id}",
        data,
        headers,
        &block
      )

      unpack(response, key: :deployment)
    end

    def logs(app_id, deployment_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/deployments/#{deployment_id}/output",
        data,
        headers,
        &block
      )

      unpack(response, key: :deployment)
    end
  end
end
