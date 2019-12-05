module Scalingo
  module Endpoint
    # - container_type: can be any container type of an application (e.g. web, clock…)
    # - limit: Any float value. For any resource consumption, please provide 0.1 if you need to be alerted when the consumption goes above 10%.
    # - metric: e.g. RPM per container, RAM consumption…
    # - notifiers: list of notifier ID that will receive the alerts (optional)
    # - send_when_below: will the alert be sent when the value goes above or below the limit (optional)
    # - duration_before_trigger: the alert is triggered if the value is above the limit for the specified duration. Duration is expressed in nanoseconds. (optional)
    # - remind_every: send the alert at regular interval when activated (optional)
    class Alerts < Collection
      def create(params)
        post(nil, alert: params)
      end
    end
    class Alert < Resource
      def update(params)
        patch(nil, alert: params)
      end

      def destroy
        delete
      end
    end
  end
end
