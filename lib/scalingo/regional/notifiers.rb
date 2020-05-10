require "scalingo/api/endpoint"

module Scalingo
  class Regional::Notifiers < API::Endpoint
    def for(app_id)
      response = connection.get("apps/#{app_id}/notifiers")

      unpack(response, key: :notifiers)
    end

    def find(app_id, notifier_id)
      response = connection.get("apps/#{app_id}/notifiers/#{notifier_id}")

      unpack(response, key: :notifier)
    end

    def create(app_id, notifier = {})
      data = { notifier: notifier }

      response = connection.post("apps/#{app_id}/notifiers", data)

      unpack(response, key: :notifier)
    end

    def update(app_id, notifier_id, notifier = {})
      data = { notifier: notifier }

      response = connection.patch("apps/#{app_id}/notifiers/#{notifier_id}", data)

      unpack(response, key: :notifier)
    end

    def destroy(app_id, notifier_id)
      response = connection.delete("apps/#{app_id}/notifiers/#{notifier_id}")

      unpack(response)
    end

    def test(app_id, notifier_id)
      response = connection.post("apps/#{app_id}/notifiers/#{notifier_id}/test")

      unpack(response)
    end

    def platforms
      response = connection(allow_guest: true).get("notification_platforms")

      unpack(response, key: :notification_platforms)
    end
  end
end
