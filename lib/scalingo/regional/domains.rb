require "scalingo/api/endpoint"

module Scalingo
  class Regional::Domains < API::Endpoint
    get :for, "apps/{app_id}/domains"
    get :find, "apps/{app_id}/domains/{id}"
    post :create, "apps/{app_id}/domains", root_key: :domain
    patch :update, "apps/{app_id}/domains/{id}", root_key: :domain
    delete :destroy, "apps/{app_id}/domains/{id}"
  end
end
