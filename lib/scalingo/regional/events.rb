module Scalingo
  class Regional::Events < API::Endpoint
    def all(payload = {})
      response = connection.get("events", payload.compact)

      unpack(response)
    end

    def for(app_id, payload = {})
      response = connection.get("apps/#{app_id}/events", payload.compact)

      unpack(response)
    end

    def types
      response = connection(allow_guest: true).get("event_types")

      unpack(response, key: :event_types)
    end

    def categories
      response = connection(allow_guest: true).get("event_categories")

      unpack(response, key: :event_categories)
    end
  end
end
