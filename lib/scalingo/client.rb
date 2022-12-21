require "scalingo/core_client"
require "scalingo/auth"
require "scalingo/billing"
require "scalingo/regional"
require "scalingo/regional_database"

module Scalingo
  class Client < CoreClient
    ## API clients
    def auth
      @auth ||= Auth.new(
        "https://auth.scalingo.com/v1",
        scalingo: self,
      )
    end

    def billing
      @billing ||= Billing.new(
        "https://cashmachine.scalingo.com",
        scalingo: self,
      )
    end

    def osc_fr1
      @osc_fr1 ||= Regional.new(
        "https://api.osc-fr1.scalingo.com/v1",
        scalingo: self,
      )
    end
    alias apps_api_osc_fr1 osc_fr1

    def osc_secnum_fr1
      @osc_secnum_fr1 ||= Regional.new(
        "https://api.osc-secnum-fr1.scalingo.com/v1",
        scalingo: self,
      )
    end
    alias apps_api_osc_secnum_fr1 osc_secnum_fr1

    def db_api_osc_fr1
      @db_api_osc_fr1 ||= RegionalDatabase.new(
        "https://db-api.osc-fr1.scalingo.com/api",
        scalingo: self,
      )
    end

    def db_api_osc_secnum_fr1
      @db_api_osc_secnum_fr1 ||= RegionalDatabase.new(
        "https://db-api.osc-fr1.scalingo.com/api",
        scalingo: self,
      )
    end
  end
end
