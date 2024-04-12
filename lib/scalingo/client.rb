require "scalingo/core_client"
require "scalingo/auth"
require "scalingo/billing"
require "scalingo/regional"
require "scalingo/database"

module Scalingo
  class Client < CoreClient
    ## API clients
    def auth
      @auth ||= Auth.new(
        "https://auth.scalingo.com/v1",
        scalingo: self
      )
    end

    def billing
      @billing ||= Billing.new(
        "https://cashmachine.scalingo.com",
        scalingo: self
      )
    end

    def osc_fr1
      @osc_fr1 ||= Regional.new(
        "https://api.osc-fr1.scalingo.com/v1",
        scalingo: self
      )
    end

    def osc_secnum_fr1
      @osc_secnum_fr1 ||= Regional.new(
        "https://api.osc-secnum-fr1.scalingo.com/v1",
        scalingo: self
      )
    end

    ## Helpers
    def self
      auth.user.find
    end
  end
end
