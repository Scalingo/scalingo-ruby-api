require "scalingo/api/endpoint"

module Scalingo
  class Billing::Profile < API::Endpoint
    def show(headers = nil, &block)
      data = nil

      response = connection.get(
        "profile",
        data,
        headers,
        &block
      )

      unpack(:profile) { response }
    end

    def create(payload = {}, headers = nil, &block)
      data = {profile: payload}

      response = connection.post(
        "profiles",
        data,
        headers,
        &block
      )

      unpack(:profile) { response }
    end

    def update(id, payload = {}, headers = nil, &block)
      data = {profile: payload}

      response = connection.put(
        "profiles/#{id}",
        data,
        headers,
        &block
      )

      unpack(:profile) { response }
    end

    alias_method :self, :show
  end
end
