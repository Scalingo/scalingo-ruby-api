require "scalingo/api/endpoint"

module Scalingo
  class Regional::Addons < API::Endpoint
    def for(app_id)
      response = connection.get("apps/#{app_id}/addons")

      unpack(response, key: :addons)
    end

    def find(app_id, addon_id)
      response = connection.get("apps/#{app_id}/addons/#{addon_id}")

      unpack(response, key: :addon)
    end

    def provision(app_id, plan_id:, addon_provider_id:)
      data = {
        addon: {
          plan_id: plan_id,
          addon_provider_id: addon_provider_id,
        },
      }

      response = connection.post("apps/#{app_id}/addons", data)

      unpack(response, key: :addon)
    end

    def update(app_id, addon_id, **opts)
      response = connection.patch(
        "apps/#{app_id}/addons/#{addon_id}",
        { addon: opts }
      )

      unpack(response, key: :addon)
    end

    def destroy(app_id, addon_id)
      response = connection.delete("apps/#{app_id}/addons/#{addon_id}")

      unpack(response)
    end

    def sso(app_id, addon_id)
      response = connection.get("apps/#{app_id}/addons/#{addon_id}/sso")

      unpack(response, key: :addon)
    end

    def categories
      response = connection(allow_guest: true).get("addon_categories")

      unpack(response, key: :addon_categories)
    end

    def providers
      response = connection(allow_guest: true).get("addon_providers")

      unpack(response, key: :addon_providers)
    end
  end
end
