require "active_support"
require "active_support/core_ext/numeric/time"
require "scalingo/version"

module Scalingo
  class Configuration
    ATTRIBUTES = [
      # Default region. Must match a key in `regions`
      :default_region,

      # Configure the User Agent header
      :user_agent,

      # These headers will be added to every request. Individual methods may override them.
      # This should be a hash or a callable object that returns a hash.
      :additional_headers,

      # Specify an adapter for faraday. Leave nil for the default one (Net::HTTP)
      :faraday_adapter
    ]

    ATTRIBUTES.each { |attr| attr_accessor(attr) }

    def self.default
      new(
        default_region: :osc_fr1,
        user_agent: "Scalingo Ruby Client v#{Scalingo::VERSION}",
        additional_headers: {}
      )
    end

    def initialize(attributes = {}, parent = nil)
      ATTRIBUTES.each do |name|
        public_send(:"#{name}=", attributes.fetch(name, parent&.public_send(name)))
      end
    end
  end

  def self.config
    @config ||= Configuration.default
  end

  def self.configure
    yield config
  end
end
