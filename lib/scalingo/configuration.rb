require "active_support/core_ext/numeric/time"
require "scalingo/version"
require "ostruct"

module Scalingo
  class Configuration
    ATTRIBUTES = [
      # Known regions. Each region should have a corresponding entry in the urls settings below
      :regions,

      # Default region
      :default_region,

      # Endpoints URLS
      :urls,

      # Configure the User Agent header
      :user_agent,

      # For how long is a bearer token considered valid (it will raise passed this delay).
      # Set to nil to never raise.
      :exchanged_token_validity,

      # Raise an exception when trying to use an authenticated connection without a bearer token set
      # Having this setting to true prevents performing requests that would fail due to lack of authentication headers.
      :raise_on_missing_authentication,

      # Raise an exception when the bearer token in use is supposed to be invalid
      :raise_on_expired_token,

      # These headers will be added to every request. Individual methods may override them.
      # This should be a hash or a callable object that returns a hash.
      :additional_headers,
    ]

    ATTRIBUTES.each { |attr| attr_accessor(attr) }

    def initialize(attributes = {}, parent = nil)
      ATTRIBUTES.each do |name|
        public_send("#{name}=", attributes.fetch(name, parent&.public_send(name)))
      end
    end

    def urls=(input)
      @urls = OpenStruct.new(input)
    end
  end

  def self.config
    @config ||= Configuration.new(
      regions: %i[osc_fr1 osc_secnum_fr1],
      default_region: :osc_fr1,
      urls: {
        auth: "https://auth.scalingo.com/v1",
        billing: "https://cashmachine.scalingo.com/",
        osc_fr1: "https://api.osc-fr1.scalingo.com/v1",
        osc_secnum_fr1: "https://api.osc-secnum-fr1.scalingo.com/v1",
      },
      user_agent: "Scalingo Ruby Client v#{Scalingo::VERSION}",
      exchanged_token_validity: 1.hour,
      raise_on_missing_authentication: true,
      raise_on_expired_token: false,
      additional_headers: {},
    )
  end

  def self.configure
    yield configuration
  end
end
