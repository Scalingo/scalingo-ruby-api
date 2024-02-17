module Scalingo
  class Regional::Logs < API::Endpoint
    get :archives, "apps/{app_id}/logs_archives"

    def get(url, **params, &block)
      request(:get, url, **params) do |req|
        block&.call(req, params)
        req.params[:n] = params[:n] if params[:n].present?
      end
    end

    ## Helper method to avoid having to manually chain two operations
    def for(**params, &block)
      params[:id] = params.delete(:app_id) if params[:app_id].present?
      logs_response = client.apps.logs_url(**params)

      return logs_response unless logs_response.success?

      get(logs_response.body, **params, &block)
    end
  end
end
