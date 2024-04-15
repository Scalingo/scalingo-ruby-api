require "scalingo/api/endpoint"

module Scalingo
  class Regional::Addons < API::Endpoint
    get :list, "apps/{app_id}/addons"
    get :find, "apps/{app_id}/addons/{id}"
    post :create, "apps/{app_id}/addons", root_key: :addon
    put :update, "apps/{app_id}/addons/{id}", root_key: :addon
    delete :delete, "apps/{app_id}/addons/{id}"
    get :sso, "apps/{app_id}/addons/{id}/sso"
    post :token, "apps/{app_id}/addons/{id}/token"
    get :categories, "addon_categories", connected: false
    get :providers, "addon_providers", connected: false

    def database_client_for(app_id:, id:)
      response = token(app_id: app_id, id: id)

      db_url = Scalingo::Client::URLS.fetch(:database).fetch(client.region)

      db_client = Scalingo::Database.new(db_url, region: client.region)
      db_client.token = response.body.fetch(:token)
      db_client
    end
  end
end
