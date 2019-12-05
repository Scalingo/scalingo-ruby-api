module Scalingo
  module Endpoint
    class Addons < Collection
      def create(addon_provider_id, plan_id)
        post(nil, addon: { addon_provider_id: addon_provider_id, plan_id: plan_id })
      end
    end
    class Addon < Resource
      def update(plan_id)
        patch(nil, addon: { plan_id: plan_id })
      end

      def destroy
        delete
      end
    end
  end
end
