require "scalingo/api/endpoint"

module Scalingo
  class Regional::Autoscalers < API::Endpoint
    get :list, "apps/{app_id}/autoscalers"
    get :find, "apps/{app_id}/autoscalers/{id}"
    post :create, "apps/{app_id}/autoscalers", root_key: :autoscaler
    put :update, "apps/{app_id}/autoscalers/{id}", root_key: :autoscaler
    delete :delete, "apps/{app_id}/autoscalers/{id}"
  end
end
