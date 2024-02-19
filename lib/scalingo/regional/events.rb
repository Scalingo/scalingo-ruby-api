module Scalingo
  class Regional::Events < API::Endpoint
    get :list, "events{?query*}", optional: [:app_id, :query] do |req, params|
      # Can't rely on URI templates if we need a static part depending on a dynamic one
      req.path = "apps/#{params[:app_id]}/#{req.path}" if params[:app_id]
    end
    get :types, "event_types"
    get :categories, "event_categories"
  end
end
