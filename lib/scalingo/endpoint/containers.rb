module Scalingo
  module Endpoint
    class Containers < Collection
      def find_by
        'name'
      end
    end

    class Container < Resource
    end
  end
end
