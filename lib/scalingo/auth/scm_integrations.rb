require "scalingo/api/endpoint"

module Scalingo
  class Auth::ScmIntegrations < API::Endpoint
    def all(headers = nil, &block)
      data = nil

      response = connection.get(
        "scm_integrations",
        data,
        headers,
        &block
      )

      unpack(:scm_integrations) { response }
    end

    def show(id, headers = nil, &block)
      data = nil

      response = connection.get(
        "scm_integrations/#{id}",
        data,
        headers,
        &block
      )

      unpack(:scm_integration) { response }
    end

    def create(payload, headers = nil, &block)
      data = {scm_integration: payload}

      response = connection.post(
        "scm_integrations",
        data,
        headers,
        &block
      )

      unpack(:scm_integration) { response }
    end

    def destroy(id, headers = nil, &block)
      data = nil

      response = connection.delete(
        "scm_integrations/#{id}",
        data,
        headers,
        &block
      )

      unpack { response }
    end
  end
end
