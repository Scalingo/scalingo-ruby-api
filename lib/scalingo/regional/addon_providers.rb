require "scalingo/api/endpoint"

module Scalingo
  class Regional::AddonProviders < API::Endpoint
    def all
      response = client.connection(allow_guest: true).get("addon_providers")

      unpack(response, key: :addon_providers)
    end
  end
end
