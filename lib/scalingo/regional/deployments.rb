require "scalingo/api/endpoint"

module Scalingo
  class Regional::Deployments < API::Endpoint
    def for(app_id, page: nil, per_page: nil)
      data = { page: page, per_page: per_page }.compact

      response = connection.get("apps/#{app_id}/deployments", data)

      unpack(response, key: :deployments)
    end

    def find(app_id, deployment_id)
      response = connection.get("apps/#{app_id}/deployments/#{deployment_id}")

      unpack(response, key: :deployment)
    end

    def logs(app_id, deployment_id)
      response = connection.get("apps/#{app_id}/deployments/#{deployment_id}/output")

      unpack(response, key: :deployment)
    end
  end
end
