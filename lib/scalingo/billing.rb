require "scalingo/api/client"

module Scalingo
  class Billing < API::Client
    require "scalingo/billing/profile"

    register_handlers!(
      profile: Profile
    )
  end
end
