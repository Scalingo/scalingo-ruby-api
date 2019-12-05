module Scalingo
  module Endpoint
    class Autoscalers < Collection
      # - container_type: can be any container type of an application (e.g. web, clock…)
      # - min_containers: lower limit of containers
      # - max_containers: upper limit of containers
      # - metric: e.g. RPM per container, RAM consumption. The list of available metrics is here.
      # - target: the autoscaler will keep the metric value as close to the target as possible by scaling the application
      # https://developers.scalingo.com/autoscalers
      def create(params)
        post(nil, autoscaler: params)
      end
    end
    class Autoscaler < Resource
      # - container_type can't be changed
      # Additional fields
      # - disabled: if true, autoscaler will stop manipulating container formation
      def update(params)
        patch(nil, autoscaler: params)
      end

      def destroy
        delete
      end
    end
  end
end
