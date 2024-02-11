require "scalingo/api/endpoint"

module Scalingo
  class Auth::ScmIntegrations < API::Endpoint
    def all(headers = nil, &block)
      data = nil

      connection.get(
        "scm_integrations",
        data,
        headers,
        &block
      )
    end

    def show(id, headers = nil, &block)
      data = nil

      connection.get(
        "scm_integrations/#{id}",
        data,
        headers,
        &block
      )
    end

    def create(payload, headers = nil, &block)
      data = {scm_integration: payload}

      connection.post(
        "scm_integrations",
        data,
        headers,
        &block
      )
    end

    def destroy(id, headers = nil, &block)
      data = nil

      connection.delete(
        "scm_integrations/#{id}",
        data,
        headers,
        &block
      )
    end
  end
end
