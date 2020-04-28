require "scalingo/api/endpoint"

module Scalingo
  class Regional::ContainerSizes < API::Endpoint
    def all
      response = client.connection(allow_guest: true).get("features/container_sizes")

      unpack(response, key: :container_sizes)
    end
  end
end
