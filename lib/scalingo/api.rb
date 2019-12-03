require_relative 'connection'
require_relative 'jwt'
require_relative 'request'
require_relative 'configuration'
require_relative 'endpoint'
require_relative 'regions_cache'

module Scalingo
  class Api
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Scalingo.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Connection
    include JWT
    include Request
    include Endpoint
    include RegionsCache
  end
end

