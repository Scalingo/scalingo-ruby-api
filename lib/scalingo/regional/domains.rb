require "scalingo/api/endpoint"

module Scalingo
  class Regional::Domains < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/domains",
        data,
        headers,
        &block
      )

      unpack(response, key: :domains)
    end

    def find(app_id, domain_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/domains/#{domain_id}",
        data,
        headers,
        &block
      )

      unpack(response, key: :domain)
    end

    def create(app_id, payload = {}, headers = nil, &block)
      data = {domain: payload}

      response = connection.post(
        "apps/#{app_id}/domains",
        data,
        headers,
        &block
      )

      unpack(response, key: :domain)
    end

    def update(app_id, domain_id, payload = {}, headers = nil, &block)
      data = {domain: payload}

      response = connection.patch(
        "apps/#{app_id}/domains/#{domain_id}",
        data,
        headers,
        &block
      )

      unpack(response, key: :domain)
    end

    def destroy(app_id, domain_id, headers = nil, &block)
      data = nil

      response = connection.delete(
        "apps/#{app_id}/domains/#{domain_id}",
        data,
        headers,
        &block
      )

      unpack(response)
    end
  end
end
