require "scalingo/api/endpoint"

module Scalingo
  class Regional::Collaborators < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/collaborators",
        data,
        headers,
        &block
      )

      unpack(response, key: :collaborators)
    end

    def destroy(app_id, collaborator_id, headers = nil, &block)
      data = nil

      response = connection.delete(
        "apps/#{app_id}/collaborators/#{collaborator_id}",
        data,
        headers,
        &block
      )

      unpack(response)
    end

    def invite(app_id, payload = {}, headers = nil, &block)
      data = {collaborator: payload}

      response = connection.post(
        "apps/#{app_id}/collaborators",
        data,
        headers,
        &block
      )

      unpack(response, key: :collaborator)
    end

    def accept(token, headers = nil, &block)
      data = {token: token}

      response = connection.get(
        "apps/collaboration",
        data,
        headers,
        &block
      )

      unpack(response)
    end
  end
end
