require "scalingo/core_client"
require "scalingo/auth"
require "scalingo/billing"
require "scalingo/regional"

module Scalingo
  class Client < CoreClient
    ## API clients
    def auth
      @auth ||= Auth.new(self, "https://auth.scalingo.com/v1")
    end

    def billing
      @billing ||= Billing.new(self, "https://cashmachine.scalingo.com")
    end

    def agora_fr1
      @agora_fr1 ||= "https://api.agora-fr1.scalingo.com/v1"
    end

    def osc_fr1
      @osc_fr1 ||= "https://api.osc-fr1.scalingo.com/v1"
    end

    def osc_secnum_fr1
      @osc_secnum_fr1 ||= "https://api.osc-secnum-fr1.scalingo.com/v1"
    end
  end
end
