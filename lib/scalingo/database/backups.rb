require "scalingo/api/endpoint"

module Scalingo
  class Database::Backups < API::Endpoint
    get :list, "databases/{addon_id}/backups"
    post :create, "databases/{addon_id}/backups"
    get :archive, "databases/{addon_id}/backups/{id}/archive"
  end
end
