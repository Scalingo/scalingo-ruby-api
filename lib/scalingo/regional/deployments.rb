require "scalingo/api/endpoint"

module Scalingo
  class Regional::Deployments < API::Endpoint
    get :list, "apps/{app_id}/deployments{?query*}", optional: [:query]
    get :find, "apps/{app_id}/deployments/{id}"
    get :logs, "apps/{app_id}/deployments/{id}/output"
  end
end
