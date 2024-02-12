require "scalingo/api/endpoint"

module Scalingo
  class Regional::Collaborators < API::Endpoint
    get :for, "apps/{app_id}/collaborators"
    get :accept, "apps/collaboration", root_key: "token"
    post :invite, "apps/{app_id}/collaborators", root_key: "collaborator"
    delete :destroy, "apps/{app_id}/collaborators/{id}"
  end
end
