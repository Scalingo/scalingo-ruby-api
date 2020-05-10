module Scalingo
  class Regional::Events < API::Endpoint
    def all(**params)
      params = params.slice(:page, :per_page, :from).compact

      response = connection.get("events", params)

      unpack(response)
    end

    def for(app_id, **params)
      params = params.slice(:page, :per_page, :from).compact

      response = connection.get("apps/#{app_id}/events", params)

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
