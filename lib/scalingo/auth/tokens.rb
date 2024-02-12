require "scalingo/api/endpoint"

module Scalingo
  class Auth::Tokens < API::Endpoint
    post :exchange, "tokens/exchange", connected: false
    get :all, "tokens"
    post :create, "tokens", root_key: :token
    patch :renew, "tokens/{id}/renew"
    delete :destroy, "tokens/{id}"
  end
end
