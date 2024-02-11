module Scalingo
  class Regional::Events < API::Endpoint
    get :all, "events{?query*}", optional: [:query]
    get :for, "apps/{app_id}/events{?query*}", optional: [:query]
    get :types, "event_types"
    get :categories, "event_categories"
  end
end
