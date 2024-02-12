require "scalingo/api/endpoint"

module Scalingo
  class Auth::Keys < API::Endpoint
    get :all, "keys"
    get :show, "keys/{id}"
    post :create, "keys", root_key: :key
    delete :destroy, "keys/{id}"
  end
end
