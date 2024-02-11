require "forwardable"
require "faraday"
require "scalingo/token_holder"
require "scalingo/errors"

module Scalingo
  class CoreClient
    extend Forwardable
    include TokenHolder

    attr_reader :config

    def initialize(attributes = {})
      @config = Configuration.new(attributes, Scalingo.config)
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

    ## Sub-clients accessors
    def auth
      raise NotImplementedError
    end

    def billing
      raise NotImplementedError
    end

    def region(name = nil)
      public_send(name || config.default_region)
    end

    def database_region(name = nil)
      public_send(name || "db_api_#{config.default_region}")
    end

    ## Authentication helpers / Token management
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
        response = auth.tokens.exchange(basic: {password: access_token})

        if response.success?
          self.token = BearerToken.new(
            response.body,
            expires_at: expiration,
            raise_on_expired: config.raise_on_expired_token
          )
        end

        return response.success?
      end

      if bearer_token
        authenticate_with_bearer_token(
          bearer_token,
          expires_at: expires_at,
          raise_on_expired_token: config.raise_on_expired_token
        )

        true
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

    def_delegator :database_region, :databases
    def_delegator :database_region, :backups
  end
end
