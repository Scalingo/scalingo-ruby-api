module Scalingo
  class Regional::Logs < API::Endpoint
    def for(app_id, count: nil)
      logs_response = client.apps.logs_url(app_id)

      return logs_response unless logs_response.successful?

      data = { n: count }.compact
      response = connection(allow_guest: true).get(logs_response.data, data)

      unpack(response)
    end

    def archives(app_id)
      response = connection.get("apps/#{app_id}/logs_archives")

      unpack(response, key: :archives)
    end
  end
end
