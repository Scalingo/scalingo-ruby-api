module Scalingo
  module Request
    REQUEST_METHODS = [
      :get,
      :post,
      :patch,
      :put,
      :delete,
    ].freeze

    REQUEST_METHODS.each do |method|
      define_method(method) do |path, options = {}|
        request(method, path, options)
      end
    end

    protected

    def request(method, path, options)
      auth_api = options.delete(:auth_api)
      endpoint = options.delete(:endpoint)

      connection = build_connection

      if auth_api
        connection.url_prefix = URI(auth_endpoint)
      elsif endpoint
        connection.url_prefix = endpoint
      else
        raise MissingRegion if !region

        connection.url_prefix = URI(region_api_endpoint(region))
      end

      response = connection.send(method) do |request|
        request.headers['Authorization'] = "Bearer #{current_jwt}"

        case method
        when :get, :delete
          request.url(path, options)
        when :post, :patch, :put
          request.path = path
          request.body = options if !options.empty?
        end
      end
      return response.body
    end
  end
end

