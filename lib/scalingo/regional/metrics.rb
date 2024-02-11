require "scalingo/api/endpoint"
require "active_support"
require "active_support/core_ext/hash/indifferent_access"

module Scalingo
  class Regional::Metrics < API::Endpoint
    get :types, "/features/metrics"
    get :for, "/apps/{app_id}/stats/{metric}{/container_type}{/container_index}", optional: [:container_type, :container_index]
  end
end
