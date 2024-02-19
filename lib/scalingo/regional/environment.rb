require "scalingo/api/endpoint"

module Scalingo
  class Regional::Environment < API::Endpoint
    get :list, "apps/{app_id}/variables"
    post :create, "apps/{app_id}/variables", root_key: :variable
    put :update, "apps/{app_id}/variables/{id}", root_key: :variable
    delete :delete, "apps/{app_id}/variables/{id}"
    put :bulk_update, "apps/{app_id}/variables", root_key: :variables
    delete :bulk_destroy, "apps/{app_id}/variables", root_key: :variable_ids, params_as_body: true
  end
end
