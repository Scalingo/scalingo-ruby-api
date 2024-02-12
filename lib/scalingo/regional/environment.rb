require "scalingo/api/endpoint"

module Scalingo
  class Regional::Environment < API::Endpoint
    get :for, "apps/{app_id}/variables"
    post :create, "apps/{app_id}/variables", root_key: :variable
    patch :update, "apps/{app_id}/variables/{id}", root_key: :variable
    put :bulk_update, "apps/{app_id}/variables", root_key: :variables
    delete :destroy, "apps/{app_id}/variables/{id}"
    delete :bulk_destroy, "apps/{app_id}/variables", root_key: :variable_ids
  end
end
