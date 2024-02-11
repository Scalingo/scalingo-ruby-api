require "faraday"

module Scalingo
  class UnpackMiddleware < Faraday::Middleware
    def on_complete(env)
      # We only want to unpack the response for successful responses
      return unless env.response.success?

      # Only hash-like objects are relevant to "unpack"
      return unless env.body.is_a?(Hash)

      # Extract meta from response
      if env.body[:meta]
        env[:response_meta] = env.body.delete(:meta)
      end

      # Extract cursor-based pagination
      if env.body.key?(:next_cursor)
        env[:response_meta] = {
          cursor_pagination: {
            next_cursor: env.body.delete(:next_cursor),
            has_more: env.body.delete(:has_more)
          }.compact
        }
      end

      # Dig the root key if it's the only remaining key in the body
      env.body = env.body.values.first if env.body.size == 1
    end
  end
end

Faraday::Response.register_middleware(unpack: Scalingo::UnpackMiddleware)
