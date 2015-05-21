module Scalingo
  module Request
    REQUEST_METHODS = [
      :get,
      :post,
      :patch,
      :put,
      :delete
    ]

    REQUEST_METHODS.each do |method|
      define_method(method) do |path, options = {}|
        request(method, path, options)
      end
    end

    protected
    def request(method, path, options)
      response = connection.send(method) do |request|
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

