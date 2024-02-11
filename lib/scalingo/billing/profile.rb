require "scalingo/api/endpoint"

module Scalingo
  class Billing::Profile < API::Endpoint
    def show(headers = nil, &block)
      data = nil

      connection.get(
        "profile",
        data,
        headers,
        &block
      )
    end

    def create(payload = {}, headers = nil, &block)
      data = {profile: payload}

      connection.post(
        "profiles",
        data,
        headers,
        &block
      )
    end

    def update(id, payload = {}, headers = nil, &block)
      data = {profile: payload}

      connection.put(
        "profiles/#{id}",
        data,
        headers,
        &block
      )
    end

    alias_method :self, :show
  end
end
