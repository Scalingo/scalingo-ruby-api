require "scalingo/api/endpoint"

module Scalingo
  class Regional::Apps < API::Endpoint
    def all
      response = client.connection.get("apps")

      unpack(response, key: :apps)
    end

    def find(id)
      response = client.connection.get("apps/#{id}")

      unpack(response, key: :app)
    end

    def create(name:, **opts)
      app = { name: name }
      app.update(opts.slice(:git_source, :parent_id, :stack_id))

      response = client.connection.post("apps") do |req|
        req.body = { app: app }
        req.headers["X-Dry-Run"] = "true" if opts[:dry_run]
      end

      unpack(response, key: :app)
    end

    def update(id, **settings)
      data = { app: settings }

      response = client.connection.patch("apps/#{id}", data)

      unpack(response, key: :app)
    end

    def logs_url(id)
      response = client.connection.get("apps/#{id}/logs")

      unpack(response, key: :logs_url)
    end

    def destroy(id, current_name:)
      data = { current_name: current_name }

      response = client.connection.delete("apps/#{id}", data)

      unpack(response)
    end

    def rename(id, current_name:, new_name:)
      data = { current_name: current_name, new_name: new_name }

      response = client.connection.post("apps/#{id}/rename", data)

      unpack(response, key: :app)
    end

    def transfer(id, current_name:, owner_email:)
      data = {
        current_name: current_name,
        app: {
          owner: owner_email,
        },
      }

      response = client.connection.patch("apps/#{id}", data)

      unpack(response, key: :app)
    end
  end
end
