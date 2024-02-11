require "scalingo/api/endpoint"

module Scalingo
  class Regional::Containers < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/containers",
        data,
        headers,
        &block
      )
    end

    def scale(app_id, formation, headers = nil, &block)
      data = {containers: formation}

      connection.post(
        "apps/#{app_id}/scale",
        data,
        headers,
        &block
      )
    end

    def restart(app_id, scope = [], headers = nil, &block)
      data = {scope: scope}

      connection.post(
        "apps/#{app_id}/restart",
        data,
        headers,
        &block
      )
    end

    def sizes(headers = nil, &block)
      data = nil

      connection(fallback_to_guest: true).get(
        "features/container_sizes",
        data,
        headers,
        &block
      )
    end
  end
end
