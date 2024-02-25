require "scalingo/api/endpoint"

module Scalingo
  class Regional::Notifiers < API::Endpoint
    get :list, "/apps/{app_id}/notifiers"
    get :find, "/apps/{app_id}/notifiers/{id}"
    post :create, "/apps/{app_id}/notifiers", root_key: :notifier
    put :update, "/apps/{app_id}/notifiers/{id}", root_key: :notifier
    delete :delete, "/apps/{app_id}/notifiers/{id}"
    get :platforms, "/notification_platforms"
    post :test, "/apps/{app_id}/notifiers/{id}/test"
  end
end
