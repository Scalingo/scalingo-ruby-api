require "scalingo/api/endpoint"

module Scalingo
  class Auth::ScmIntegrations < API::Endpoint
    get :list, "scm_integrations"
    get :find, "scm_integrations/{id}"
    post :create, "scm_integrations", root_key: :scm_integration
    delete :delete, "scm_integrations/{id}"
  end
end
