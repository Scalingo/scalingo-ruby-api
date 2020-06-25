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

      unpack(:containers) { response }
    end

    def scale(app_id, formation, headers = nil, &block)
      data = {containers: formation}

      response = connection.post(
        "apps/#{app_id}/scale",
        data,
        headers,
        &block
      )

      unpack(:containers) { response }
    end

    def restart(app_id, scope = [], headers = nil, &block)
      data = {scope: scope}

      response = connection.post(
        "apps/#{app_id}/restart",
        data,
        headers,
        &block
      )

      unpack { response }
    end

    def sizes(headers = nil, &block)
      data = nil

      response = connection(fallback_to_guest: true).get(
        "features/container_sizes",
        data,
        headers,
        &block
      )

      unpack(:container_sizes) { response }
    end
  end
end
