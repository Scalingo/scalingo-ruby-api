require "scalingo/api/endpoint"

module Scalingo
  class Regional::AddonCategories < API::Endpoint
    def all
      response = client.connection(allow_guest: true).get("addon_categories")

      unpack(response, key: :addon_categories)
    end
  end
end
