require "scalingo/api/endpoint"

module Scalingo
  class Auth::Tokens < API::Endpoint
    get :list, "tokens"
    post :create, "tokens", root_key: :token
    delete :delete, "tokens/{id}"
    post :exchange, "tokens/exchange", connected: false
    put :renew, "tokens/{id}/renew"
  end
end
