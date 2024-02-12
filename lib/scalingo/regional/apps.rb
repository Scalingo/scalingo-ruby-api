require "scalingo/api/endpoint"

module Scalingo
  class Regional::Apps < API::Endpoint
    def all(headers = nil, &block)
      data = nil

      connection.get(
        "apps",
        data,
        headers,
        &block
      )
    end

    def find(id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{id}",
        data,
        headers,
        &block
      )
    end

    def create(payload = {}, headers = nil, &block)
      data = {app: payload}

      dry_run = !!(payload[:dry_run] || payload["dry_run"])

      request_headers = {}
      request_headers["X-Dry-Run"] = "true" if dry_run
      request_headers.update(headers) if headers

      connection.post(
        "apps",
        data,
        request_headers,
        &block
      )
    end

    def update(id, payload = {}, headers = nil, &block)
      data = {app: payload}

      connection.patch(
        "apps/#{id}",
        data,
        headers,
        &block
      )
    end

    def logs_url(id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{id}/logs",
        data,
        headers,
        &block
      )
    end

    def destroy(id, payload = {}, headers = nil, &block)
      connection.delete(
        "apps/#{id}",
        payload,
        headers,
        &block
      )
    end

    def rename(id, payload = {}, headers = nil, &block)
      connection.post(
        "apps/#{id}/rename",
        payload,
        headers,
        &block
      )
    end

    def transfer(id, payload = {}, headers = nil, &block)
      connection.patch(
        "apps/#{id}",
        payload,
        headers,
        &block
      )
    end
  end
end
