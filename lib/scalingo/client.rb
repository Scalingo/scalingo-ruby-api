require "scalingo/basic_client"
require "scalingo/auth"

module Scalingo
  class Client < BasicClient
    ## API clients
    def auth
      @auth ||= Auth.new(self, "https://auth.scalingo.com/v1")
    end

    ## Delegations
    def_delegator :auth, :keys
    def_delegator :auth, :scm_integrations
    def_delegator :auth, :tokens
    def_delegator :auth, :user
  end
end
