require "scalingo/api/endpoint"
require "active_support"
require "active_support/core_ext/hash/indifferent_access"

module Scalingo
  class Regional::Metrics < API::Endpoint
    get :list, "/apps/{app_id}/stats/{metric}{/container_type}{/container_index}", optional: [:container_type, :container_index]
    get :types, "/features/metrics"
  end
end
