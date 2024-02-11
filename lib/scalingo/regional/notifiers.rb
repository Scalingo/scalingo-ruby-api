require "scalingo/api/endpoint"

module Scalingo
  class Regional::Notifiers < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/notifiers",
        data,
        headers,
        &block
      )
    end

    def find(app_id, notifier_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/notifiers/#{notifier_id}",
        data,
        headers,
        &block
      )
    end

    def create(app_id, payload = {}, headers = nil, &block)
      data = {notifier: payload}

      connection.post(
        "apps/#{app_id}/notifiers",
        data,
        headers,
        &block
      )
    end

    def update(app_id, notifier_id, payload = {}, headers = nil, &block)
      data = {notifier: payload}

      connection.patch(
        "apps/#{app_id}/notifiers/#{notifier_id}",
        data,
        headers,
        &block
      )
    end

    def destroy(app_id, notifier_id, headers = nil, &block)
      data = nil

      connection.delete(
        "apps/#{app_id}/notifiers/#{notifier_id}",
        data,
        headers,
        &block
      )
    end

    def test(app_id, notifier_id, headers = nil, &block)
      data = nil

      connection.post(
        "apps/#{app_id}/notifiers/#{notifier_id}/test",
        data,
        headers,
        &block
      )
    end

    def platforms(headers = nil, &block)
      data = nil

      connection(fallback_to_guest: true).get(
        "notification_platforms",
        data,
        headers,
        &block
      )
    end
  end
end
