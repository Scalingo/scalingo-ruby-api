require "faraday"

module Scalingo
  class ExtractMeta < Faraday::Middleware
    def on_complete(env)
      # Only hash-like objects are relevant
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
    end
  end
end

Faraday::Response.register_middleware(extract_meta: Scalingo::ExtractMeta)
