require "scalingo/api/endpoint"

module Scalingo
  class Regional::Addons < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/addons",
        data,
        headers,
        &block
      )
    end

    def find(app_id, addon_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/addons/#{addon_id}",
        data,
        headers,
        &block
      )
    end

    def provision(app_id, payload = {}, headers = nil, &block)
      data = {addon: payload}

      connection.post(
        "apps/#{app_id}/addons",
        data,
        headers,
        &block
      )
    end

    def update(app_id, addon_id, payload = {}, headers = nil, &block)
      data = {addon: payload}

      connection.patch(
        "apps/#{app_id}/addons/#{addon_id}",
        data,
        headers,
        &block
      )
    end

    def destroy(app_id, addon_id, headers = nil, &block)
      data = nil

      connection.delete(
        "apps/#{app_id}/addons/#{addon_id}",
        data,
        headers,
        &block
      )
    end

    def sso(app_id, addon_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/addons/#{addon_id}/sso",
        data,
        headers,
        &block
      )
    end

    def authenticate!(app_id, addon_id, headers = nil, &block)
      response = token(app_id, addon_id, headers, &block)
      return response unless response.status == 200

      token = response.body[:token]
      client.token_holder.authenticate_database_with_bearer_token(
        addon_id,
        token,
        expires_at: Time.now + 1.hour,
        raise_on_expired_token: client.config.raise_on_expired_token
      )

      response
    end

    def token(app_id, addon_id, headers = nil, &block)
      data = nil

      connection.post(
        "apps/#{app_id}/addons/#{addon_id}/token",
        data,
        headers,
        &block
      )
    end

    def categories(headers = nil, &block)
      data = nil

      connection(fallback_to_guest: true).get(
        "addon_categories",
        data,
        headers,
        &block
      )
    end

    def providers(headers = nil, &block)
      data = nil

      connection(fallback_to_guest: true).get(
        "addon_providers",
        data,
        headers,
        &block
      )
    end
  end
end
