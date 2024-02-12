require "scalingo/api/endpoint"

module Scalingo
  class RegionalDatabase::Backups < API::Endpoint
    get :for, "databases/{addon_id}/backups"
    get :archive, "databases/{addon_id}/backups/{id}/archive"
    post :create, "databases/{addon_id}/backups"
  end
end
