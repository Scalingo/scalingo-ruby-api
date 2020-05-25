require "scalingo/api/endpoint"

module Scalingo
  class Auth::ScmIntegrations < API::Endpoint
    def all(headers = nil)
      data = nil

      response = connection.get("scm_integrations", data, headers)

      unpack(response, key: :scm_integrations)
    end

    def show(id, headers = nil)
      data = nil

      response = connection.get("scm_integrations/#{id}", data, headers)

      unpack(response, key: :key)
    end

    def create(payload, headers = nil)
      data = {scm_integration: payload}

      response = connection.post("scm_integrations", data, headers)

      unpack(response, key: :key)
    end

    def destroy(id, headers = nil)
      data = nil

      response = connection.delete("scm_integrations/#{id}", data, headers)

      unpack(response)
    end
  end
end
