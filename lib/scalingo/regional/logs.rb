module Scalingo
  class Regional::Logs < API::Endpoint
    def get(url, payload = {})
      data = payload.compact

      response = connection(allow_guest: true).get(url, data)

      unpack(response)
    end

    def archives(app_id)
      response = connection.get("apps/#{app_id}/logs_archives")

      unpack(response, key: :archives)
    end

    ## Helper method to avoid having to manually chain two operations
    def for(app_id, payload = {})
      logs_response = scalingo.apps.logs_url(app_id)

      return logs_response unless logs_response.successful?

      get(logs_response.data, payload)
    end
  end
end
