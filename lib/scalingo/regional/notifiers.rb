require "scalingo/api/endpoint"

module Scalingo
  class Regional::Notifiers < API::Endpoint
    def for(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/notifiers",
        data,
        headers,
        &block
      )

      unpack(response, key: :notifiers)
    end

    def find(app_id, notifier_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/notifiers/#{notifier_id}",
        data,
        headers,
        &block
      )

      unpack(response, key: :notifier)
    end

    def create(app_id, payload = {}, headers = nil, &block)
      data = {notifier: payload}

      response = connection.post(
        "apps/#{app_id}/notifiers",
        data,
        headers,
        &block
      )

      unpack(response, key: :notifier)
    end

    def update(app_id, notifier_id, payload = {}, headers = nil, &block)
      data = {notifier: payload}

      response = connection.patch(
        "apps/#{app_id}/notifiers/#{notifier_id}",
        data,
        headers,
        &block
      )

      unpack(response, key: :notifier)
    end

    def destroy(app_id, notifier_id, headers = nil, &block)
      data = nil

      response = connection.delete(
        "apps/#{app_id}/notifiers/#{notifier_id}",
        data,
        headers,
        &block
      )

      unpack(response)
    end

    def test(app_id, notifier_id, headers = nil, &block)
      data = nil

      response = connection.post(
        "apps/#{app_id}/notifiers/#{notifier_id}/test",
        data,
        headers,
        &block
      )

      unpack(response)
    end

    def platforms(headers = nil, &block)
      data = nil

      response = connection(allow_guest: true).get(
        "notification_platforms",
        data,
        headers,
        &block
      )

      unpack(response, key: :notification_platforms)
    end
  end
end
