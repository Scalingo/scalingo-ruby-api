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

    attr_reader :config

    def initialize(attributes = {})
      @config = Configuration.new(attributes, Scalingo.config)

      define_regions!
    end

    def inspect
      str = %(<#{self.class}:0x#{object_id.to_s(16)} version:"#{Scalingo::VERSION}" authenticated:)

      str << if token.present?
        (token.expired? ? "expired" : "true")
      else
        "false"
      end

      str << ">"
      str
    end

    ## Authentication helpers / Token management
    attr_reader :token

    def token=(input)
      @token = input.is_a?(BearerToken) ? input : BearerToken.new(input.to_s, raise_on_expired: config.raise_on_expired_token)
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
        expiration = Time.now + config.exchanged_token_validity
        response = auth.tokens.exchange(access_token)

        if response.successful?
          self.token = BearerToken.new(
            response.data[:token],
            expires_at: expiration,
            raise_on_expired: config.raise_on_expired_token,
          )
        end

        return response.successful?
      end

      if bearer_token
        self.token = if expires_at
          token = bearer_token.is_a?(BearerToken) ? bearer_token.value : bearer_token.to_s

          BearerToken.new(
            token,
            expires_at: expires_at,
            raise_on_expired: config.raise_on_expired_token,
          )
        else
          bearer_token
        end

        true
      end
    end

    ## API clients
    def auth
      @auth ||= Auth.new(self, config.auth)
    end

    def billing
      @billing ||= Billing.new(self, config.billing)
    end

    def region(name = nil)
      public_send(name || config.default_region)
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

    private

    def define_regions!
      config.regions.each_pair do |region, _|
        define_singleton_method(region) do
          region_client = instance_variable_get :"@#{region}"

          unless region_client
            region_client = Regional.new(self, config.regions.public_send(region))

            instance_variable_set :"@#{region}", region_client
          end

          region_client
        end
      end
    end
  end
end
