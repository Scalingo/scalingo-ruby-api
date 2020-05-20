require "scalingo/api/endpoint"

module Scalingo
  class Regional::Environment < API::Endpoint
    def for(app_id)
      response = connection.get("apps/#{app_id}/variables")

      unpack(response, key: :variables)
    end

    def create(app_id, payload = {})
      response = connection.post("apps/#{app_id}/variables", {variable: payload})

      unpack(response, key: :variable)
    end

    def update(app_id, variable_id, value)
      data = {variable: {value: value}}

      response = connection.patch("apps/#{app_id}/variables/#{variable_id}", data)

      unpack(response, key: :variable)
    end

    def destroy(app_id, variable_id)
      response = connection.destroy("apps/#{app_id}/variables/#{variable_id}")

      unpack(response)
    end

    def bulk_update(app_id, variables)
      data = {variables: variables}

      response = connection.put("apps/#{app_id}/variables", data)

      unpack(response, key: :variables)
    end

    def bulk_destroy(app_id, variable_ids)
      data = {variable_ids: variable_ids}

      response = connection.delete("apps/#{app_id}/variables", data)

      unpack(response)
    end
  end
end
