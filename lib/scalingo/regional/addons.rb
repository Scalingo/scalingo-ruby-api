require "scalingo/api/endpoint"

module Scalingo
  class Regional::Addons < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/addons",
        data,
        headers,
        &block
      )

      unpack(:addons) { response }
    end

    def find(app_id, addon_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/addons/#{addon_id}",
        data,
        headers,
        &block
      )

      unpack(:addon) { response }
    end

    def provision(app_id, payload = {}, headers = nil, &block)
      data = {addon: payload}

      response = connection.post(
        "apps/#{app_id}/addons",
        data,
        headers,
        &block
      )

      unpack(:addon) { response }
    end

    def update(app_id, addon_id, payload = {}, headers = nil, &block)
      data = {addon: payload}

      response = connection.patch(
        "apps/#{app_id}/addons/#{addon_id}",
        data,
        headers,
        &block
      )

      unpack(:addon) { response }
    end

    def destroy(app_id, addon_id, headers = nil, &block)
      data = nil

      response = connection.delete(
        "apps/#{app_id}/addons/#{addon_id}",
        data,
        headers,
        &block
      )

      unpack { response }
    end

    def sso(app_id, addon_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/addons/#{addon_id}/sso",
        data,
        headers,
        &block
      )

      unpack(:addon) { response }
    end

    def authenticate(app_id, addon_id, headers = nil, &block)
      response = token(app_id, addon_id, headers, &block)
      return response unless response.status == 200

      token = response.data[:token]
      client.token_holder.authenticate_database_with_bearer_token(
        addon_id,
        token,
        expires_at: Time.now + 1.hour,
        raise_on_expired_token: client.config.raise_on_expired_token,
      )

      response
    end

    def token(app_id, addon_id, headers = nil, &block)
      data = nil

      response = connection.post(
        "apps/#{app_id}/addons/#{addon_id}/token",
        data,
        headers,
        &block
      )

      unpack(:addon) { response }
    end

    def categories(headers = nil, &block)
      data = nil

      response = connection(fallback_to_guest: true).get(
        "addon_categories",
        data,
        headers,
        &block
      )

      unpack(:addon_categories) { response }
    end

    def providers(headers = nil, &block)
      data = nil

      response = connection(fallback_to_guest: true).get(
        "addon_providers",
        data,
        headers,
        &block
      )

      unpack(:addon_providers) { response }
    end
  end
end
