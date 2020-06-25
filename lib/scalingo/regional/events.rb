module Scalingo
  class Regional::Events < API::Endpoint
    def all(payload = {}, headers = nil, &block)
      data = payload.compact

      response = connection.get(
        "events",
        data,
        headers,
        &block
      )

      unpack(:events) { response }
    end

    def for(app_id, payload = {}, headers = nil, &block)
      data = payload.compact

      response = connection.get(
        "apps/#{app_id}/events",
        data,
        headers,
        &block
      )

      unpack(:events) { response }
    end

    def types(headers = nil, &block)
      data = nil

      response = connection(fallback_to_guest: true).get(
        "event_types",
        data,
        headers,
        &block
      )

      unpack(:event_types) { response }
    end

    def categories(headers = nil, &block)
      data = nil

      response = connection(fallback_to_guest: true).get(
        "event_categories",
        data,
        headers,
        &block
      )

      unpack(:event_categories) { response }
    end
  end
end
