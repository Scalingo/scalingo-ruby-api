require "scalingo/api/client"

module Scalingo
  class Auth < API::Client
    require "scalingo/auth/keys"
    require "scalingo/auth/scm_integrations"
    require "scalingo/auth/tokens"
    require "scalingo/auth/two_factor_auth"
    require "scalingo/auth/user"

    register_handlers!(
      keys: Keys,
      scm_integrations: ScmIntegrations,
      tokens: Tokens,
      two_factor_auth: TwoFactorAuth,
      user: User,
    )

    alias_method :tfa, :two_factor_auth
  end
end
