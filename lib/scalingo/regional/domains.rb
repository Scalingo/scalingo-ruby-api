require "scalingo/api/endpoint"

module Scalingo
  class Regional::Domains < API::Endpoint
    get :list, "apps/{app_id}/domains"
    get :find, "apps/{app_id}/domains/{id}"
    post :create, "apps/{app_id}/domains", root_key: :domain
    put :update, "apps/{app_id}/domains/{id}", root_key: :domain
    delete :delete, "apps/{app_id}/domains/{id}"
  end
end
