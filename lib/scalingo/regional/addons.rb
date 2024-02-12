require "scalingo/api/endpoint"

module Scalingo
  class Regional::Addons < API::Endpoint
    get :for, "apps/{app_id}/addons"
    get :find, "apps/{app_id}/addons/{id}"
    post :provision, "apps/{app_id}/addons", root_key: :addon
    patch :update, "apps/{app_id}/addons/{id}", root_key: :addon
    delete :destroy, "apps/{app_id}/addons/{id}"
    get :sso, "apps/{app_id}/addons/{id}/sso"
    post :token, "apps/{app_id}/addons/{id}/token"
    get :categories, "addon_categories", connected: false
    get :providers, "addon_providers", connected: false

    def authenticate!(**params, &block)
      response = token(**params, &block)
      return response unless response.status == 200

      client.token_holder.authenticate_database_with_bearer_token(
        params[:id],
        response.body[:token],
        expires_at: Time.now + 1.hour,
        raise_on_expired_token: client.config.raise_on_expired_token
      )

      response
    end
  end
end
