require "scalingo/core_client"
require "scalingo/auth"
require "scalingo/billing"
require "scalingo/regional"
require "scalingo/database"

module Scalingo
  class Client < CoreClient
    URLS = {
      auth: "https://auth.scalingo.com/v1",
      billing: "https://cashmachine.scalingo.com",
      regional: {
        osc_fr1: "https://api.osc-fr1.scalingo.com/v1",
        osc_secnum_fr1: "https://api.osc-secnum-fr1.scalingo.com/v1"
      },
      database: {
        osc_fr1: "https://db-api.osc-fr1.scalingo.com/api",
        osc_secnum_fr1: "https://db-api.osc-secnum-fr1.scalingo.com/api"
      }
    }

    ## API clients
    def auth
      @auth ||= Auth.new(URLS[:auth], scalingo: self)
    end

    def billing
      @billing ||= Billing.new(URLS[:billing], scalingo: self)
    end

    def osc_fr1
      @osc_fr1 ||= Regional.new(URLS[:regional][:osc_fr1], scalingo: self, region: :osc_fr1)
    end

    def osc_secnum_fr1
      @osc_secnum_fr1 ||= Regional.new(URLS[:regional][:osc_secnum_fr1], scalingo: self, region: :osc_secnum_fr1)
    end

    ## Helpers
    def self
      auth.user.find
    end
  end
end
