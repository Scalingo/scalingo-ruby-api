require "scalingo/api/endpoint"

module Scalingo
  class Auth::User < API::Endpoint
    get :self, "users/self"
    put :update, "users/account", root_key: :user
    post :stop_free_trial, "users/stop_free_trial"
  end
end
