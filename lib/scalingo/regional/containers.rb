require "scalingo/api/endpoint"

module Scalingo
  class Regional::Containers < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/containers",
        data,
        headers,
        &block
      )

      unpack(response, key: :containers)
    end

    def scale(app_id, formation, headers = nil, &block)
      data = {containers: formation}

      response = connection.post(
        "apps/#{app_id}/scale",
        data,
        headers,
        &block
      )

      unpack(response, key: :containers)
    end

    def restart(app_id, scope = [], headers = nil, &block)
      data = {scope: scope}

      response = connection.post(
        "apps/#{app_id}/restart",
        data,
        headers,
        &block
      )

      unpack(response)
    end

    def sizes(headers = nil, &block)
      data = nil

      response = connection(allow_guest: true).get(
        "features/container_sizes",
        data,
        headers,
        &block
      )

      unpack(response, key: :container_sizes)
    end
  end
end