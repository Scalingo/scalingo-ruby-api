module Scalingo
  module Endpoint
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def resources(name, opts = {})
        name = name.to_s
        define_method(name.pluralize.underscore) do
          Scalingo::Endpoint.const_get(name.pluralize.camelize).new(self)
        end

        return if opts[:collection_only]

        define_method(name.singularize.underscore) do |id|
          send(name.pluralize.underscore).find(id)
        end
      end
    end

    extend ClassMethods
    resources :apps
    resources :account_keys
    resources :addon_providers,  collection_only: true
    resources :addon_categories, collection_only: true

    module Base
      attr_accessor :api
      attr_accessor :prefix

      def initialize(api, prefix = nil)
        self.api = api
        self.prefix = prefix || self.class.name.split('::').last.underscore.pluralize
      end

      Request::REQUEST_METHODS.each do |method|
        define_method(method) do |path = nil, options = {}|
          api.send(method, "#{prefix}/#{path}", options)
        end
      end
    end

    class Resource < OpenStruct
      include Base
      include Endpoint

      def initialize(api, prefix, data = {})
        Base.instance_method(:initialize).bind(self).call(api, prefix)
        OpenStruct.instance_method(:initialize).bind(self).call(data)
      end
    end

    class Collection
      include Base
      include Endpoint
      include Enumerable

      def all
        get[collection_name].map{|r| resource_class.new(self, r[find_by], r)}
      end
      alias_method :to_a, :all

      def each
        block_given? ? all.each(&Proc.new) : all.each
      end

      def find(id)
        detect{|r| r[find_by] == id}
      end

      def collection_name
        @collection_name ||= self.class.name.underscore.split('/').last
      end

      def resource_class
        @resource_class ||= begin
                              Scalingo::Endpoint.const_get(self.class.name.singularize.split('::').last)
                            rescue
                              Resource
                            end
      end

      def find_by
        'id'
      end
    end
  end
end

Dir[File.join(File.dirname(__FILE__), 'endpoint', '*.rb')].each do |endpoint|
  require endpoint
end

