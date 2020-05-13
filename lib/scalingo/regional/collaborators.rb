require "scalingo/api/endpoint"

module Scalingo
  class Regional::Collaborators < API::Endpoint
    def for(app_id)
      response = connection.get("apps/#{app_id}/collaborators")

      unpack(response, key: :collaborators)
    end

    def destroy(app_id, collaborator_id)
      response = connection.delete("apps/#{app_id}/collaborators/#{collaborator_id}")

      unpack(response)
    end

    def invite(app_id, payload = {})
      data = { collaborator: payload }

      response = connection.post("apps/#{app_id}/collaborators", data)

      unpack(response, key: :collaborator)
    end

    def accept(token)
      response = connection.get("apps/collaboration", { token: token })

      unpack(response)
    end
  end
end
