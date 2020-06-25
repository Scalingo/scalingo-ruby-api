require "scalingo/api/endpoint"

module Scalingo
  class Regional::Environment < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/variables",
        data,
        headers,
        &block
      )

      unpack(:variables) { response }
    end

    def create(app_id, payload = {}, headers = nil, &block)
      data = {variable: payload}

      response = connection.post(
        "apps/#{app_id}/variables",
        data,
        headers,
        &block
      )

      unpack(:variable) { response }
    end

    def update(app_id, variable_id, value, headers = nil, &block)
      data = {variable: {value: value}}

      response = connection.patch(
        "apps/#{app_id}/variables/#{variable_id}",
        data,
        headers,
        &block
      )

      unpack(:variable) { response }
    end

    def destroy(app_id, variable_id, headers = nil, &block)
      data = nil

      response = connection.delete(
        "apps/#{app_id}/variables/#{variable_id}",
        data,
        headers,
        &block
      )

      unpack { response }
    end

    def bulk_update(app_id, variables, headers = nil, &block)
      data = {variables: variables}

      response = connection.put(
        "apps/#{app_id}/variables",
        data,
        headers,
        &block
      )

      unpack(:variables) { response }
    end

    def bulk_destroy(app_id, variable_ids, headers = nil, &block)
      data = {variable_ids: variable_ids}

      response = connection.delete(
        "apps/#{app_id}/variables",
        data,
        headers,
        &block
      )

      unpack { response }
    end
  end
end
