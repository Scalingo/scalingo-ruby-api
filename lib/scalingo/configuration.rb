require "active_support/core_ext/numeric/time"
require "scalingo/version"
require "ostruct"

module Scalingo
  class Configuration
    ATTRIBUTES = [
      # URL to the authentication API
      :auth,

      # URL to the billing API
      :billing,

      # List of regions under the form {"region_id": root_url}
      :regions,

      # Default region. Must match a key in `regions`
      :default_region,

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

      # Specify an adapter for faraday. Leave nil for the default one (Net::HTTP)
      :faraday_adapter,
    ]

    ATTRIBUTES.each { |attr| attr_accessor(attr) }

    def self.default
      new(
        auth: "https://auth.scalingo.com/v1",
        billing: "https://cashmachine.scalingo.com",
        regions: {
          agora_fr1: "https://api.agora-fr1.scalingo.com/v1",
          osc_fr1: "https://api.osc-fr1.scalingo.com/v1",
          osc_secnum_fr1: "https://api.osc-secnum-fr1.scalingo.com/v1",
        },
        default_region: :osc_fr1,
        user_agent: "Scalingo Ruby Client v#{Scalingo::VERSION}",
        exchanged_token_validity: 1.hour,
        raise_on_missing_authentication: true,
        raise_on_expired_token: false,
        additional_headers: {},
      )
    end

    def initialize(attributes = {}, parent = nil)
      ATTRIBUTES.each do |name|
        public_send("#{name}=", attributes.fetch(name, parent&.public_send(name)))
      end
    end

    def regions=(input)
      if input.is_a?(OpenStruct)
        @regions = input
        return
      end

      if input.is_a?(Hash)
        @regions = OpenStruct.new(input)
        return
      end

      raise ArgumentError, "wrong type for argument"
    end

    def default_region=(input)
      input = input.to_sym

      raise ArgumentError, "No regions named `#{input}`" unless regions.respond_to?(input)

      @default_region = input
    end
  end

  def self.config
    @config ||= Configuration.default
  end

  def self.configure
    yield config
  end
end
