require "scalingo/api/endpoint"

module Scalingo
  class Regional::Domains < API::Endpoint
    def for(app_id, page: nil, per_page: nil)
      data = { page: page, per_page: per_page }.compact

      response = connection.get("apps/#{app_id}/domains", data)

      unpack(response, key: :domains)
    end

    def find(app_id, domain_id)
      response = connection.get("apps/#{app_id}/domains/#{domain_id}")

      unpack(response, key: :domain)
    end

    def create(app_id, **domain)
      response = connection.post("apps/#{app_id}/domains", { domain: domain })

      unpack(response, key: :domain)
    end

    def update(app_id, domain_id, **domain)

      response = connection.patch("apps/#{app_id}/domains/#{domain_id}", { domain: domain })

      unpack(response, key: :domain)
    end

    def destroy(app_id, domain_id)
      response = connection.delete("apps/#{app_id}/domains/#{domain_id}")

      unpack(response)
    end
  end
end
