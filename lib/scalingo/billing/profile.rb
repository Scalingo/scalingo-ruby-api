require "scalingo/api/endpoint"

module Scalingo
  class Billing::Profile < API::Endpoint
    get :find, "profile"
    post :create, "profiles", root_key: :profile
    put :update, "profiles/{id}", root_key: :profile

    alias_method :self, :show
  end
end
