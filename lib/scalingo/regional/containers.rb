require "scalingo/api/endpoint"

module Scalingo
  class Regional::Containers < API::Endpoint
    get :for, "apps/{app_id}/containers"
    post :scale, "apps/{app_id}/scale", root_key: :containers
    post :restart, "apps/{app_id}/restart", root_key: :scope
    get :sizes, "features/container_sizes"
  end
end
