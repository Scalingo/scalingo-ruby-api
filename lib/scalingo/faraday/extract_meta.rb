require "faraday"

module Scalingo
  class ExtractMeta < Faraday::Middleware
    def on_complete(env)
      return unless env.body.is_a?(Hash)

      extract_metadata(env)
      extract_cursor_metadata(env)
    end

    private

    def extract_metadata(env)
      return unless env.body[:meta]

      env[:response_meta] = env.body.delete(:meta)
    end

    def extract_cursor_metadata(env)
      return unless env.body.key?(:next_cursor)

      env[:response_meta] = {
        cursor_pagination: {
          next_cursor: env.body.delete(:next_cursor),
          has_more: env.body.delete(:has_more)
        }.compact
      }
    end
  end
end

Faraday::Response.register_middleware(extract_meta: Scalingo::ExtractMeta)
