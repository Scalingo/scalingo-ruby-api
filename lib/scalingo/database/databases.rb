require "scalingo/api/endpoint"

module Scalingo
  class Database::Databases < API::Endpoint
    get :find, "databases/{id}"
    post :upgrade, "databases/{id}/upgrade"
  end
end
