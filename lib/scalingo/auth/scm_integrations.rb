require "scalingo/api/endpoint"

module Scalingo
  class Auth::ScmIntegrations < API::Endpoint
    get :all, "scm_integrations"
    get :show, "scm_integrations/{id}"
    post :create, "scm_integrations", root_key: :scm_integration
    delete :destroy, "scm_integrations/{id}"
  end
end
