require "scalingo/api/endpoint"

module Scalingo
  class Regional::Autoscalers < API::Endpoint
    get :for, "apps/{app_id}/autoscalers"
    get :find, "apps/{app_id}/autoscalers/{id}"
    post :create, "apps/{app_id}/autoscalers", root_key: :autoscaler
    patch :update, "apps/{app_id}/autoscalers/{id}", root_key: :autoscaler
    delete :destroy, "apps/{app_id}/autoscalers/{id}"
  end
end
