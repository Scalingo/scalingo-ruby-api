require "scalingo/api/endpoint"

module Scalingo
  class Regional::Apps < API::Endpoint
    def all
      response = connection.get("apps")

      unpack(response, key: :apps)
    end

    def find(id)
      response = connection.get("apps/#{id}")

      unpack(response, key: :app)
    end

    def create(payload = {})
      dry_run = !!(payload[:dry_run] || payload["dry_run"])

      response = connection.post("apps") do |req|
        req.body = { app: payload }
        req.headers["X-Dry-Run"] = "true" if dry_run
      end

      unpack(response, key: :app)
    end

    def update(id, payload = {})
      data = { app: payload }

      response = connection.patch("apps/#{id}", data)

      unpack(response, key: :app)
    end

    def logs_url(id)
      response = connection.get("apps/#{id}/logs")

      unpack(response, key: :logs_url)
    end

    def destroy(id, payload = {})
      response = connection.delete("apps/#{id}") { |req| req.params.update(payload) }

      unpack(response)
    end

    def rename(id, payload = {})
      response = connection.post("apps/#{id}/rename", payload)

      unpack(response, key: :app)
    end

    def transfer(id, payload = {})
      response = connection.patch("apps/#{id}", payload)

      unpack(response, key: :app)
    end
  end
end
