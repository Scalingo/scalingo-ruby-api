require "scalingo/basic_client"
require "scalingo/auth"
require "scalingo/regional"

module Scalingo
  class Client < BasicClient
    ## API clients
    def auth
      @auth ||= Auth.new(self, "https://auth.scalingo.com/v1")
    end

    def osc_fr1
      @osc_fr1 ||= Regional.new(self, "https://api.osc-fr1.scalingo.com/v1")
    end

    def osc_secnum_fr1
      @osc_secnum_fr1 ||= Regional.new(self, "https://api.osc-secnum-fr1.scalingo.com/v1")
    end

    ## Delegations
    def_delegator :auth, :keys
    def_delegator :auth, :scm_integrations
    def_delegator :auth, :tokens
    def_delegator :auth, :user
  end
end
