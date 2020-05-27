require "active_support/core_ext/numeric/time"
require "dry-configurable"
require "scalingo/version"

module Scalingo
  extend Dry::Configurable

  # Known regions. Each region should have a corresponding entry in the urls settings below
  setting :regions, %i[osc_fr1 osc_secnum_fr1]

  # Default region
  setting :default_region, :osc_fr1

  # Endpoints URLS
  setting :urls do
    setting :auth, "https://auth.scalingo.com/v1"
    setting :osc_fr1, "https://api.osc-fr1.scalingo.com/v1"
    setting :osc_secnum_fr1, "https://api.osc-secnum-fr1.scalingo.com/v1"
  end

  # Configure the User Agent header
  setting :user_agent, "Scalingo Ruby Client v#{Scalingo::VERSION}"

  # For how long is a bearer token considered valid (it will raise passed this delay).
  # Set to nil to never raise.
  setting :exchanged_token_validity, 1.hour

  # Raise an exception when trying to use an authenticated connection without a bearer token set
  # Having this setting to true prevents performing requests that would fail due to lack of authentication headers.
  setting :raise_on_missing_authentication, true

  # These headers will be added to every request. Individual methods may override them.
  # This should be a hash or a callable object that returns a hash.
  setting :additional_headers, {}
end
