require "forwardable"
require "faraday"
require "faraday_middleware"
require "scalingo/bearer_token"
require "scalingo/errors"
require "scalingo/auth"
require "scalingo/billing"
require "scalingo/regional"

module Scalingo
  class Client
    extend Forwardable

    ## Authentication helpers / Token management
    attr_reader :token

    def token=(input)
      @token = input.is_a?(BearerToken) ? input : BearerToken.new(input.to_s)
    end

    def authenticated?
      token.present? && !token.expired?
    end

    def authenticate_with(access_token: nil, bearer_token: nil, expires_at: nil)
      if !access_token && !bearer_token
        raise ArgumentError, "You must supply one of `access_token` or `bearer_token`"
      end

      if access_token && bearer_token
        raise ArgumentError, "You cannot supply both `access_token` and `bearer_token`"
      end

      if expires_at && !bearer_token
        raise ArgumentError, "`expires_at` can only be used with `bearer_token`. `access_token` have a 1 hour expiration."
      end

      if access_token
        expiration = Time.now + Scalingo.config.exchanged_token_validity
        response = auth.tokens.exchange(access_token)

        if response.successful?
          self.token = BearerToken.new(
            response.data[:token],
            expires_at: expiration,
          )
        end

        return response.successful?
      end

      if bearer_token
        self.token = expires_at ? BearerToken.new(bearer_token.to_s, expires_at: expires_at) : bearer_token

        true
      end
    end

    ## API clients
    def auth
      @auth ||= Auth.new(self, Scalingo.config.urls.auth)
    end

    def billing
      @billing ||= Billing.new(self, Scalingo.config.urls.billing)
    end

    def region
      public_send(Scalingo.config.default_region)
    end

    Scalingo.config.regions.each do |region|
      if Scalingo.config.urls[region].blank?
        raise ArgumentError, "Scalingo: no url configured for region #{region}"
      end

      define_method(region) do
        region_client = instance_variable_get :"@#{region}"

        unless region_client
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

    def_delegator :region, :addons
    def_delegator :region, :apps
    def_delegator :region, :collaborators
    def_delegator :region, :containers
    def_delegator :region, :deployments
    def_delegator :region, :domains
    def_delegator :region, :environment
    def_delegator :region, :events
    def_delegator :region, :logs
    def_delegator :region, :metrics
    def_delegator :region, :notifiers
    def_delegator :region, :operations
    def_delegator :region, :scm_repo_links
  end
end
