require "scalingo/api/endpoint"

module Scalingo
  class Regional::Domains < API::Endpoint
    def for(app_id, payload = {})
      response = connection.get("apps/#{app_id}/domains", payload.compact)

      unpack(response, key: :domains)
    end

    def find(app_id, domain_id)
      response = connection.get("apps/#{app_id}/domains/#{domain_id}")

      unpack(response, key: :domain)
    end

    def create(app_id, payload = {})
      response = connection.post("apps/#{app_id}/domains", {domain: payload})

      unpack(response, key: :domain)
    end

    def update(app_id, domain_id, payload = {})
      response = connection.patch("apps/#{app_id}/domains/#{domain_id}", {domain: payload})

      unpack(response, key: :domain)
    end

    def destroy(app_id, domain_id)
      response = connection.delete("apps/#{app_id}/domains/#{domain_id}")

      unpack(response)
    end
  end
end
