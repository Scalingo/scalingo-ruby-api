require "scalingo/api/endpoint"

module Scalingo
  class Regional::Apps < API::Endpoint
    get :list, "apps"
    get :find, "apps/{id}"
    post :create, "apps", root_key: :app do |req, params|
      req.headers["X-Dry-Run"] = "true" if params[:dry_run]
    end
    put :update, "apps/{id}", root_key: :app
    delete :delete, "apps/{id}"
    get :logs_url, "apps/{id}/logs"
    post :rename, "apps/{id}/rename"
    put :transfer, "apps/{id}"
  end
end
