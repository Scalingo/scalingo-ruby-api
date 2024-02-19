require "scalingo/api/endpoint"

module Scalingo
  class Regional::Operations < API::Endpoint
    get :find, "/apps/{app_id}/operations/{id}"

    def fetch(url, **params, &block)
      request(:get, url, **params) do |req|
        block&.call(req, params)
      end
    end
  end
end
