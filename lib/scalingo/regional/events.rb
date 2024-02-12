module Scalingo
  class Regional::Events < API::Endpoint
    def all(payload = {}, headers = nil, &block)
      data = payload.compact

      connection.get(
        "events",
        data,
        headers,
        &block
      )
    end

    def for(app_id, payload = {}, headers = nil, &block)
      data = payload.compact

      connection.get(
        "apps/#{app_id}/events",
        data,
        headers,
        &block
      )
    end

    def types(headers = nil, &block)
      data = nil

      connection(fallback_to_guest: true).get(
        "event_types",
        data,
        headers,
        &block
      )
    end

    def categories(headers = nil, &block)
      data = nil

      connection(fallback_to_guest: true).get(
        "event_categories",
        data,
        headers,
        &block
      )
    end
  end
end
