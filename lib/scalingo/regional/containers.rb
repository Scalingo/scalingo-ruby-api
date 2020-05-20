require "scalingo/api/endpoint"

module Scalingo
  class Regional::Containers < API::Endpoint
    def for(app_id)
      response = connection.get("apps/#{app_id}/containers")

      unpack(response, key: :containers)
    end

    def scale(app_id, formation)
      response = connection.post("apps/#{app_id}/scale", {containers: formation})

      unpack(response, key: :containers)
    end

    def restart(app_id, scope = [])
      response = connection.post("apps/#{app_id}/restart", {scope: scope})

      unpack(response)
    end

    def sizes
      response = connection(allow_guest: true).get("features/container_sizes")

      unpack(response, key: :container_sizes)
    end
  end
end
