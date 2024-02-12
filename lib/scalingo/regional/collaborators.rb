require "scalingo/api/endpoint"

module Scalingo
  class Regional::Collaborators < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/collaborators",
        data,
        headers,
        &block
      )
    end

    def destroy(app_id, collaborator_id, headers = nil, &block)
      data = nil

      connection.delete(
        "apps/#{app_id}/collaborators/#{collaborator_id}",
        data,
        headers,
        &block
      )
    end

    def invite(app_id, payload = {}, headers = nil, &block)
      data = {collaborator: payload}

      connection.post(
        "apps/#{app_id}/collaborators",
        data,
        headers,
        &block
      )
    end

    def accept(token, headers = nil, &block)
      data = {token: token}

      connection.get(
        "apps/collaboration",
        data,
        headers,
        &block
      )
    end
  end
end
