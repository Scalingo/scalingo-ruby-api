require "scalingo/api/base_client"

module Scalingo
  class Auth < API::BaseClient
    require "scalingo/auth/keys"
    require "scalingo/auth/scm_integrations"
    require "scalingo/auth/tokens"
    require "scalingo/auth/user"

    def keys
      @keys ||= Keys.new(self)
    end

    def scm_integrations
      @scm_integrations ||= ScmIntegrations.new(self)
    end

    def tokens
      @tokens ||= Tokens.new(self)
    end

    def user
      @user ||= User.new(self)
    end
  end
end
