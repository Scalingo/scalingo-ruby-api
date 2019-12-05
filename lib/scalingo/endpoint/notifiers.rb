module Scalingo
  module Endpoint
    # - platform_id
    # - name
    # - send_all_alerts (optional)
    # - send_all_events (optional)
    # - type_data (optional)
    # - selected_event_ids (optional)
    # - active (optional)
    # https://developers.scalingo.com/notifiers
    #
    class Notifiers < Collection
      def create(params)
        post(nil, notifier: params)
      end
    end
    class Notifier < Resource
      # params: platform_id can't be changed
      def update(params)
        patch(nil, notifier: params)
      end

      def destroy
        delete
      end
    end
  end
end
