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

    # :nocov:
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
    # :nocov:

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

    ## Authentication helpers / Token management
    def authenticate_with(access_token: nil, bearer_token: nil)
      if !access_token && !bearer_token
        raise ArgumentError, "You must supply one of `access_token` or `bearer_token`"
      end

      if access_token && bearer_token
        raise ArgumentError, "You cannot supply both `access_token` and `bearer_token`"
      end

      if access_token
        response = auth.tokens.exchange(basic: {password: access_token})

        self.token = response.body if response.success?

        return response.success?
      end

      if bearer_token
        self.token = bearer_token

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
  end
end
