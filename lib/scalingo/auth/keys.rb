require "scalingo/api/endpoint"

module Scalingo
  class Auth::Keys < API::Endpoint
    get :list, "keys"
    get :find, "keys/{id}"
    post :create, "keys", root_key: :key
    delete :delete, "keys/{id}"
  end
end
