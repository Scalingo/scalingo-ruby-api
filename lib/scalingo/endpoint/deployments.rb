module Scalingo
  module Endpoint
    class Deployments < Collection
    end
    class Deployment < Resource
      def output
        get('output')
      end
    end
  end
end

