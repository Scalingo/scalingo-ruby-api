module Scalingo
  class Regional::Logs < API::Endpoint
    def get(url, payload = {}, headers = nil, &block)
      data = payload.compact

      response = connection(fallback_to_guest: true).get(
        url,
        data,
        headers,
        &block
      )

      unpack { response }
    end

    def archives(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/logs_archives",
        data,
        headers,
        &block
      )

      unpack(:archives) { response }
    end

    ## Helper method to avoid having to manually chain two operations
    def for(app_id, payload = {}, headers = nil, &block)
      logs_response = scalingo.apps.logs_url(app_id)

      return logs_response unless logs_response.successful?

      get(logs_response.data, payload, headers, &block)
    end
  end
end
