require "scalingo/api/endpoint"

module Scalingo
  class Regional::Notifiers < API::Endpoint
    get :platforms, "/notification_platforms"
    get :for, "/apps/{app_id}/notifiers"
    get :find, "/apps/{app_id}/notifiers/{id}"
    post :create, "/apps/{app_id}/notifiers", root_key: :notifier
    post :test, "/apps/{app_id}/notifiers/{id}/test"
    patch :update, "/apps/{app_id}/notifiers/{id}", root_key: :notifier
    delete :destroy, "/apps/{app_id}/notifiers/{id}"
  end
end
