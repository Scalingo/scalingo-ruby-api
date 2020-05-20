require "scalingo/basic_client"
require "scalingo/auth"
require "scalingo/regional"

module Scalingo
  class Client < BasicClient
    ## API clients
    def auth
      @auth ||= Auth.new(self, "https://auth.scalingo.com/v1")
    end

    Scalingo.config.regions.each do |region|
      if Scalingo.config.urls[region].blank?
        raise ArgumentError, "Scalingo: no url configured for region #{region}"
      end

      define_method(region) do
        region_client = instance_variable_get :"@#{region}"

        if !region_client
          region_client = Regional.new(self, Scalingo.config.urls[region])

          instance_variable_set :"@#{region}", region_client
        end

        region_client
      end
    end

    ## Delegations
    def_delegator :auth, :keys
    def_delegator :auth, :scm_integrations
    def_delegator :auth, :tokens
    def_delegator :auth, :two_factor_auth
    def_delegator :auth, :tfa
    def_delegator :auth, :user
  end
end
