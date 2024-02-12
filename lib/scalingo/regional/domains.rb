require "scalingo/api/endpoint"

module Scalingo
  class Regional::Domains < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/domains",
        data,
        headers,
        &block
      )
    end

    def find(app_id, domain_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/domains/#{domain_id}",
        data,
        headers,
        &block
      )
    end

    def create(app_id, payload = {}, headers = nil, &block)
      data = {domain: payload}

      connection.post(
        "apps/#{app_id}/domains",
        data,
        headers,
        &block
      )
    end

    def update(app_id, domain_id, payload = {}, headers = nil, &block)
      data = {domain: payload}

      connection.patch(
        "apps/#{app_id}/domains/#{domain_id}",
        data,
        headers,
        &block
      )
    end

    def destroy(app_id, domain_id, headers = nil, &block)
      data = nil

      connection.delete(
        "apps/#{app_id}/domains/#{domain_id}",
        data,
        headers,
        &block
      )
    end
  end
end
