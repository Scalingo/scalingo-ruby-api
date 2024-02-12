require "scalingo/api/endpoint"

module Scalingo
  class Auth::TwoFactorAuth < API::Endpoint
    get :status, "client/tfa"
    post :initiate, "client/tfa", root_key: :tfa
    post :validate, "client/tfa/validate", root_key: :tfa
    delete :disable, "client/tfa"
  end
end
