require 'ostruct'

module Scalingo
  module Endpoint
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def resources(name, opts = {})
        name = name.to_s

        endpoint_opts = { auth_api: opts[:auth_api], always_json: opts[:always_json] }

        define_method(name.pluralize.underscore) do
          Scalingo::Endpoint.const_get(
            name.pluralize.camelize,
          ).new(self, nil, endpoint_opts)
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
    resources :regions,          collection_only: true, auth_api: true, always_json: true

    module Base
      attr_accessor :api
      attr_accessor :prefix
      attr_accessor :auth_api
      attr_accessor :always_json

      def initialize(api, prefix = nil, opts = {})
        self.api = api
        self.auth_api = opts.fetch(:auth_api, false)
        self.always_json = opts.fetch(:always_json, false)
        self.prefix = prefix || self.class.name.split('::').last.underscore.pluralize
      end

      Request::REQUEST_METHODS.each do |method|
        define_method(method) do |path = nil, options = {}|
          req_path = prefix
          req_path += "/#{path}" if !path.nil? && path != ''
          options.merge!(auth_api: auth_api) if auth_api
          options.merge!(always_json: always_json) if always_json
          api.send(method, req_path, options)
        end
      end
    end

    class Resource < OpenStruct
      include Base
      include Endpoint

      def initialize(api, prefix, opts = {}, data = {})
        Base.instance_method(:initialize).bind(self).call(api, prefix, opts)
        OpenStruct.instance_method(:initialize).bind(self).call(data)
      end
    end

    class Collection
      include Base
      include Endpoint
      include Enumerable

      def all
        get[collection_name].map { |r| resource_class.new(self, r[find_by], {}, r) }
      end
      alias to_a all

      def each
        block_given? ? all.each(&Proc.new) : all.each
      end

      def find(id)
        detect { |r| r[find_by] == id }
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

