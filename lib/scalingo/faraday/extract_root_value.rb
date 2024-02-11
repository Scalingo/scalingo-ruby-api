require "faraday"

module Scalingo
  class ExtractRootValue < Faraday::Middleware
    def on_complete(env)
      # We only want to unpack the response for successful responses
      return unless env.response.success?

      # Only hash-like objects are relevant to "unpack"
      return unless env.body.is_a?(Hash)

      # Dig the root key if it's the only remaining key in the body
      env.body = env.body.values.first if env.body.size == 1
    end
  end
end

Faraday::Response.register_middleware(extract_root_value: Scalingo::ExtractRootValue)
