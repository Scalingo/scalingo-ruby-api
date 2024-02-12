require "scalingo/api/endpoint"

module Scalingo
  class Regional::Apps < API::Endpoint
    get :all, "apps"
    get :find, "apps/{id}"
    get :logs_url, "apps/{id}/logs"
    post :rename, "apps/{id}/rename"
    patch :update, "apps/{id}", root_key: :app
    patch :transfer, "apps/{id}"
    delete :destroy, "apps/{id}"

    post :create, "apps", root_key: :app do |req, params|
      req.headers["X-Dry-Run"] = "true" if params[:dry_run]
    end
  end
end
