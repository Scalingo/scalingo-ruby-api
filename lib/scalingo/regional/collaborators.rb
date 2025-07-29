require "scalingo/api/endpoint"

module Scalingo
  class Regional::Collaborators < API::Endpoint
    get :list, "apps/{app_id}/collaborators"
    post :create, "apps/{app_id}/collaborators", root_key: "collaborator"
    delete :delete, "apps/{app_id}/collaborators/{id}"
    get :accept, "apps/collaboration?token={token}"
    patch :update, "apps/{app_id}/collaborators/{id}", root_key: "collaborator"
  end
end
