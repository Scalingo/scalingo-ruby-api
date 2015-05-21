module Scalingo
  module Endpoint
    class Variables < Collection
      def all(aliases = true)
        get(nil, {aliases: aliases})[collection_name]
      end

      def create(name, value)
        post(nil, {variable: {name: name, value: value}})
      end
    end
    class Variable < Resource
      def update(value)
        patch(nil, {variable: {value: value}})
      end

      def destroy
        delete
      end
    end
  end
end

